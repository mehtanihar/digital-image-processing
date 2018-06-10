
A=[1 2 3; 4 5 6; 7 8 9];
[U,S,V]=mySVD(A);
norm(A - U*S*transpose(V))
