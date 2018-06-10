function new_image = myShrinkImageByFactorD(old_image_path,save_path,shrink_factor)
    figure
    hold on
    old_image=imread(old_image_path);
    [rows,cols]=size(old_image);
    
    %Shrink the image
    new_image=old_image(1:shrink_factor:rows,1:shrink_factor:cols);
    
    save(save_path,'new_image');
    
    %Display the shrinked image
    myNumOfColors = 199;
    myColorScale = [ [0:1/(myNumOfColors):1]' , [0:1/(myNumOfColors):1]' , [0:1/(myNumOfColors):1]' ];
    imagesc (single (new_image));
    colormap (myColorScale);
    colormap jet
    daspect ([1 1 1]);
    axis tight
    colorbar
    hold off
end