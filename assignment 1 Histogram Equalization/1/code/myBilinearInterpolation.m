function new_image =myBilinearInterpolation(old_image_path, save_path)
    figure
    hold on
    old_image=imread(old_image_path);
    [old_rows,old_cols]=size(old_image);
    
    rows=3*old_rows-2;
    cols=2*old_cols-1;
    
    rowscale=old_rows/rows;
    colscale=old_cols/cols;
    new_image=zeros(rows,cols);
    
    for row=1:rows
        for col=1:cols
            
            r=floor(rowscale*row)+1;
            c=floor(colscale*col)+1;
            dr=rowscale*row-r;
            dc=colscale*col-c;
            
            %Boundary check
            if(r<1)
                r=1;
            end
            if(c<1)
                c=1;
            end
            if(r>(old_rows-1))
                r=old_rows-1;
            end
            
            if(c>(old_cols-1))
                c=old_cols-1;
            end
           
            
            new_image(row,col)=old_image(r,c)*(1-dr)*(1-dc)+ ...
            old_image(r+1,c)*(dr)*(1-dc)+old_image(r,c+1)*(1-dr)*(dc)+ ...
            old_image(r+1,c+1)*(dr)*(dc);
           
          
        end
        
        
    end
    
    new_image1=new_image
    
    for i=1:rows
        new_image(i,:)=new_image1(rows-i+1,:);
        
    end
    
    
    save(save_path,'new_image')
    
    %Display image
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

