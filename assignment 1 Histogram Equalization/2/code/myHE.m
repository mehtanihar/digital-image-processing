function new_image = myHE(old_image_path,save_path)
    figure
    hold on
    old_image=imread(old_image_path);
     
    [old_rows,old_cols,dim]=size(old_image);
    
    new_image=zeros(old_rows,old_cols,dim);
    
    num_elem=old_rows*old_cols;
    
    for d=1:dim
        unravel_image=reshape(old_image(:,:,d),[num_elem,1]);

        stack=zeros(256,1);

        for i=1:num_elem
           stack(unravel_image(i)+1)=stack(unravel_image(i)+1)+1; 
        end
        total=0;
        for i=1:256
            total=total+stack(i);
            stack(i)=total;
        end

        min_cdf=stack(min(unravel_image)+1);

        for i=1:old_rows
            for j=1:old_cols
                new_image(i,j,d)=round((stack(old_image(i,j,d)+1)-min_cdf)/(num_elem-1)*255);
            end
        end
    end
    save(save_path,'new_image');
    for i=1:dim
        myNumOfColors = 254;
        myColorScale = [ [0:1/(myNumOfColors):1]' , [0:1/(myNumOfColors):1]' , [0:1/(myNumOfColors):1]' ];
        imagesc (single (new_image(:,:,i)));
        colormap (myColorScale);
    
        daspect ([1 1 1]);
        axis tight
        colorbar
    end
    
    hold off

end