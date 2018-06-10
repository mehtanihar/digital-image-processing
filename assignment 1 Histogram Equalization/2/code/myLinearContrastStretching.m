function new_image = myLinearContrastStretching(old_image_path, save_path)
     figure
     hold on
     old_image=imread(old_image_path);
     
    [old_rows,old_cols,dim]=size(old_image);
    
    new_image=zeros(old_rows,old_cols,dim);
    for i=1:dim
        dn_min=min(min(old_image(:,:,i)));
        dn_max=max(max(old_image(:,:,i)));
       
       
        new_image(:,:,i)=(old_image(:,:,i)-dn_min)./((dn_max-dn_min)/255);
    end
    imshow(new_image)
    save(save_path,'new_image');
    for i=1:dim
        myNumOfColors = 254;
        myColorScale = [ [0:1/(myNumOfColors):1]' , [0:1/(myNumOfColors):1]' , [0:1/(myNumOfColors):1]' ];
        imagesc (single (new_image(:,:,i))); % phantom is a popular test image
        colormap (myColorScale);
        colormap gray
        daspect ([1 1 1]);
        axis tight
        colorbar
    end
    hold off
end