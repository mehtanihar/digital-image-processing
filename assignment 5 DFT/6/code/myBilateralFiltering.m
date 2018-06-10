function [spaceGaussian,outputImage]=myBilateralFiltering(origImage,sigma_s,sigma_r,window)

[x,y] = meshgrid(-window:window,-window:window);
spaceGaussian = exp(-(x.^2+y.^2)/(2*sigma_s^2));
orig_size = size(origImage);

for i = 1:orig_size(1)
    for j = 1:orig_size(2)
        min_x = max(i-window,1);
        max_x = min(i+window,orig_size(1));
        min_y = max(j-window,1);
        max_y = min(j+window,orig_size(2));
        final_window = origImage(min_x:max_x,min_y:max_y);
        intensityGaussian = exp(-(final_window-origImage(i,j)).^2/(2*sigma_r^2));
        tempMatrix = intensityGaussian.*spaceGaussian((min_x:max_x)-i+window+1,(min_y:max_y)-j+window+1);
        outputImage(i,j) = sum(tempMatrix(:).*final_window(:))/sum(tempMatrix(:));
    end
end


