%% MyMainScript

tic;
%% Your code here
ideal_dft('../data/barbara256.png',40);
ideal_dft('../data/barbara256.png',80);
gaussian_dft('../data/barbara256.png',40);
gaussian_dft('../data/barbara256.png',80);

toc;
