function new_image = myNearestNeighborInterpolation(old_image_path,save_path)
    figure
    hold on
    old_image=imread(old_image_path);
    [old_rows,old_cols]=size(old_image);
    rows=3*old_rows-2;
    cols=2*old_cols-1;
    
    rowscale=(old_rows-1)/rows;
    colscale=(old_cols-1)/cols;
    new_image=zeros(rows,cols);
    
    for row=0:rows-1
        for col=0:cols-1
            new_image(row+1,col+1)=old_image(1+round(row*rowscale),1+round(col*colscale));
            
        end
    end
    new_image1=new_image
    for i=1:rows
        new_image(i,:)=new_image1(rows-i+1,:);
        
    end
    save(save_path,'new_image')
    
    myNumOfColors = 199;
    myColorScale = [ [0:1/(myNumOfColors):1]' , [0:1/(myNumOfColors):1]' , [0:1/(myNumOfColors):1]' ];
    imagesc (single (new_image)); 
    colormap (myColorScale);
    colormap gray
    daspect ([1 1 1]);
    axis tight
    colorbar
    hold off
end