%% MyMainScript

tic;
%% Your code here
figure
hold on

% %Linear contrast stretching
% imshow('../data/barbara.png');
% myLinearContrastStretching('../data/barbara.png','../images/barbara_linear_stretch.mat');
% imshow('../data/TEM.png');
% myLinearContrastStretching('../data/TEM.png','../images/TEM_linear_stretch.mat');
% imshow('../data/canyon.png');
% myLinearContrastStretching('../data/canyon.png','../images/canyon_linear_stretch.mat');
% 

% %HE
% imshow('../data/barbara.png');
% myHE('../data/barbara.png','../images/barbara_HE.mat');
% imshow('../data/TEM.png');
% myHE('../data/TEM.png','../images/TEM_HE.mat');
% imshow('../data/canyon.png');
% myHE('../data/canyon.png','../images/canyon_HE.mat');


%AHE on entire image/ large window size
imshow('../data/barbara.png');
myAHE('../data/barbara.png',511,'../images/barbara_AHE_large.mat');
imshow('../data/TEM.png');
myAHE('../data/TEM.png',545,'../images/TEM_AHE_large.mat');
imshow('../data/canyon.png');
myAHE('../data/canyon.png',347,'../images/canyon_AHE_large.mat');

% %AHE with small window size
% imshow('../data/barbara.png');
% myAHE('../data/barbara.png',13,'../images/barbara_AHE_small.mat');
% imshow('../data/TEM.png');
% myAHE('../data/TEM.png',13,'../images/TEM_AHE_small.mat');
% imshow('../data/canyon.png');
% myAHE('../data/canyon.png',13,'../images/canyon_AHE_small.mat');


%CLAHE on entire image/ large window size
imshow('../data/barbara.png');
myCLAHE('../data/barbara.png',511,0.7,'../images/barbara_CLAHE_large.mat');
imshow('../data/TEM.png');
myCLAHE('../data/TEM.png',545,0.7,'../images/TEM_CLAHE_large.mat');
imshow('../data/canyon.png');
myCLAHE('../data/canyon.png',347,0.7,'../images/canyon_CLAHE_large.mat');

% %CLAHE with small window size
% imshow('../data/barbara.png');
% myCLAHE('../data/barbara.png',13,0.7,'../images/barbara_CLAHE_small.mat');
% imshow('../data/TEM.png');
% myCLAHE('../data/TEM.png',13,0.7,'../images/TEM_CLAHE_small.mat');
% imshow('../data/canyon.png');
% myCLAHE('../data/canyon.png',13,0.7,'../images/canyon_CLAHE_small.mat');
% 
% 
% %CLAHE on entire image/ large window size, low threshold
% imshow('../data/barbara.png');
% myCLAHE('../data/barbara.png',511,0.35,'../images/barbara_CLAHE_large_low.mat');
% imshow('../data/TEM.png');
% myCLAHE('../data/TEM.png',545,0.35,'../images/TEM_CLAHE_large_low.mat');
% imshow('../data/canyon.png');
% myCLAHE('../data/canyon.png',347,0.35,'../images/canyon_CLAHE_large_low.mat');
% 
% %CLAHE with small window size, low threshold
% imshow('../data/barbara.png');
% myCLAHE('../data/barbara.png',13,0.35,'../images/barbara_CLAHE_small_low.mat');
% imshow('../data/TEM.png');
% myCLAHE('../data/TEM.png',13,0.35,'../images/TEM_CLAHE_small_low.mat');
% imshow('../data/canyon.png');
% myCLAHE('../data/canyon.png',13,0.35,'../images/canyon_CLAHE_small_low.mat');

hold off
toc;
