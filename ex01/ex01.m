% main script for ex01
%% excercise 1

% apply mean filter to lena.gif

% get image and mean kernel
K = 1/9*ones(3,3);
img = imread('lena.gif');
dimg = double(img);
% show original image
figure('Name','original');
imshow(img);
% show image after convolution with clamp
figure('Name','mean_conv(clamp)');
imshow(uint8(convolution(dimg,K,'clamp')));
% show image after convolution with mirror
figure('Name','mean_conv(mirror)');
imshow(uint8(convolution(dimg,K,'mirror')));
%% exercise 2

%% exercise 3

% calculate and visualize gradient magnitudes and orientations

% define kernels
Dx = [-1,0,1;-1,0,1;-1,0,1];
Dy = [-1,-1,-1;0,0,0;1,1,1];
% perform convolutions
dimg_x = convolution(dimg,Dx,'clamp');
dimg_y = convolution(dimg,Dy,'clamp');
% display gradient norm and direction
figure('Name','gradient x direction');
imshow(uint8(dimg_x));
figure('Name','gradient y direction');
imshow(uint8(dimg_y));
% calculate gradient norm and direction
grad_n = (dimg_x.^2+dimg_y.^2).^0.5;
grad_d = atan2(dimg_y, dimg_x);
% display gradient norm and direction
figure('Name','gradient magnitude');
imshow(uint8(grad_n));
figure('Name','gradient orientation');
imshow(uint8((grad_d+pi)*(255/(2*pi))));