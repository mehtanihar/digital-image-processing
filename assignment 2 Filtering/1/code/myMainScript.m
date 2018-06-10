%% MyMainScript

tic;

image=a.imageOrig;%% Your code here
a=load('../data/lionCrop.mat');
image=a.imageOrig;
old_image=myLinearContrastStretching(image);

%imwrite(old_image,'../images/lion_original.png');

% new_image=myUnsharpMasking('../data/lionCrop.mat',1,0.5,'../images/lion_unsharp_scale_1.png');

new_image=myUnsharpMasking('../data/lionCrop.mat',10,0.5,'../images/lion_unsharp_scale_10.png');
subplot(1,2,1),imshow(old_image);
subplot(1,2,2),imshow(new_image);

% myUnsharpMasking('../data/lionCrop.mat',20,0.5,'../images/lion_unsharp_scale_20.png');
%  
% myUnsharpMasking('../data/lionCrop.mat',10,0.1,'../images/lion_unsharp_sigma_0.1.png');
% myUnsharpMasking('../data/lionCrop.mat',10,0.5,'../images/lion_unsharp_sigma_0.5.png');
% myUnsharpMasking('../data/lionCrop.mat',10,0.9,'../images/lion_unsharp_sigma_0.9.png');
% 
% a=load('../data/superMoonCrop.mat');
% image=a.imageOrig;
% old_image=myLinearContrastStretching(image);
% imwrite(old_image,'../images/moon_original.png');
% 
% myUnsharpMasking('../data/superMoonCrop.mat',1,0.5,'../images/moon_unsharp_scale_1.png');
% myUnsharpMasking('../data/superMoonCrop.mat',10,0.5,'../images/moon_unsharp_scale_10.png');
% 
% myUnsharpMasking('../data/superMoonCrop.mat',20,0.5,'../images/moon_unsharp_scale_20.png');
%  
% myUnsharpMasking('../data/superMoonCrop.mat',10,0.1,'../images/moon_unsharp_sigma_0.1.png');
% myUnsharpMasking('../data/superMoonCrop.mat',10,0.5,'../images/moon_unsharp_sigma_0.5.png');
% myUnsharpMasking('../data/superMoonCrop.mat',10,0.9,'../images/moon_unsharp_sigma_0.9.png');

toc;
