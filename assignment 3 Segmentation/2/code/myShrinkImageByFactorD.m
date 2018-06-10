function new_image = myShrinkImageByFactorD(old_image,shrink_factor)

    [rows,cols,dim]=size(old_image);
    
    %Shrink the image
    new_image(:,:,:)=old_image(1:shrink_factor:rows,1:shrink_factor:cols,:);
    

end