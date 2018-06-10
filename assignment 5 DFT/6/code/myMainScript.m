%% MyMainScript

tic;
%% Your code here
image = double(imread('../data/barbara256.png'));
myPCADenoising1(image);

% %% Part 2
 myPCADenoising2(image,25);
 myPCADenoising2(image,200);
%% Part 3
% Add Noise to Input Image
[ new_x, new_y ] = size(image);
noise = 0.05*max(max(image))*randn([new_x new_y]);
corrupt_image = image + noise;

% Optimum Parameters for Bilateral Filtering
[ sp_gaussian output_image ] = myBilateralFiltering(corrupt_image,1.3,4,5);

%Display original vs Bilaterally filtered image
figure;%('units','normalized','outerposition',[0 0 1 1]);
subplot(1, 2, 1), imshow(mat2gray(corrupt_image));
title('Original Image');
subplot(1, 2, 2), imshow(mat2gray(output_image));
title('Bilaterally filtered Image');


toc;
