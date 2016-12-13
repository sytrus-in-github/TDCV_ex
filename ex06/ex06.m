% initialize intrinsic / extrensic parameters
A = [472.3 0.64 329.0; 0 471.0 268.3; 0 0 1];
R0 = eye(3);
T0 = [0; 0; 0];
% Get the first image
I0 = getImage(0);
% extract SIFT interesting points
[f0, d0] = ComputeSIFT(I0);
[~,nbsift] = size(f0);
% get 3D points
m0 = [f0(1:2,:);ones([1,nbsift])];
M0 = A\m0;
disp(size(M0))