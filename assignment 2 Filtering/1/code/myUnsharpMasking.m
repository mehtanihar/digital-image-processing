function new_image=myUnsharpMasking(old_image_path,s,sigma,save_path)


    a=load(old_image_path);
    image=a.imageOrig;
    old_image=myLinearContrastStretching(image);
    H = fspecial('gaussian',3,sigma);
    blurred = imfilter(image,H,'replicate'); 
    final_image=image+s*(image-blurred);
    new_image=myLinearContrastStretching(final_image);
    max(max(new_image-old_image))
    %imwrite(new_image,save_path);

end

