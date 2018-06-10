%% MyMainScript

tic;
%% Your code here
figure
hold on
imshow('../data/circles_concentric.png');

%Shrinking the image
myShrinkImageByFactorD('../data/circles_concentric.png','../images/shrink_by_2.mat',2);
myShrinkImageByFactorD('../data/circles_concentric.png','../images/shrink_by_3.mat',3);

%Bilinear interpolation
imshow('../data/barbaraSmall.png');
myBilinearInterpolation('../data/barbaraSmall.png','../images/bilinear.mat');


%Nearest Neighbours
myNearestNeighborInterpolation('../data/barbaraSmall.png','../images/nearest_neighbor.mat');

hold off
toc;
