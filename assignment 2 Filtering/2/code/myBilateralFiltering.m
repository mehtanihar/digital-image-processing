function [final_image,blurred_image,rmsd]=myBilateralFiltering(orig_image,sigma_s,sigma_r)


%imwrite(orig_image,'../images/original_image.png');
[row,col]=size(orig_image);

image = imnoise(orig_image,'gaussian',0.0004);

%imwrite(image,'../images/blurred_image.png');


%Parameters

window=9;

[row,col]=size(image);
[x_val y_val]=meshgrid(-window:window,-window:window);

space_filter=exp(-(x_val.^2+y_val.^2)/(2*sigma_s^2));
imshow(space_filter)
final_image=image;

for i=1:row
    for j=1:col
        
        row_min=max(i-window,1);
        col_min=max(j-window,1);
        row_max=min(i+window,row);
        col_max=min(j+window,col);
        cropped_image=image(row_min:row_max,col_min:col_max);
        range_filter=exp(-double(cropped_image-image(i,j)).^2/(2*sigma_r^2)); 
       
        filter_matrix=range_filter.*space_filter((row_min:row_max)+window+1-i, ...
        (col_min:col_max)+window+1-j);
        
        W=sum(filter_matrix(:));
        
        final_image(i,j)=sum(sum(filter_matrix.*double(cropped_image)))/W;
        
        
      
    end
end
blurred_image=image;
rmsd=sqrt(norm(final_image-orig_image)^2/(row*col));

%imwrite(final_image,'../images/final_image.png');
