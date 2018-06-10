%% MyMainScript

tic;
%% Your code here
a=load('../data/barbara.mat');
orig_image=a.imageOrig;
orig_image=orig_image/255.0;
h=0.1;
[new_image,blurred_image,changed_orig_image,rmsd]=myPatchBasedFiltering(orig_image,h);

subplot(1,3,1),imshow(changed_orig_image);
subplot(1,3,2),imshow(blurred_image);
subplot(1,3,3),imshow(new_image);

toc;
