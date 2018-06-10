%% MyMainScript

tic;
%% Your code here
mat_file=load('../data/boat.mat');
orig_image=mat_file.imageOrig;
myHarrisCornerDetector(orig_image,0.05,10,10);
toc;
