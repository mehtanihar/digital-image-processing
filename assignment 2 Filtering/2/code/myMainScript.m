%% MyMainScript

tic;
%% Your code here
a=load('../data/barbara.mat');
orig_image=a.imageOrig;
orig_image=orig_image/255.0;

s_best=2;
r_best=0.11;

[new_image,blurred_image,rmsd]=myBilateralFiltering(orig_image,s_best,r_best);
subplot(1,3,1),imshow(orig_image);
subplot(1,3,2),imshow(blurred_image);
subplot(1,3,3),imshow(new_image);
toc;
