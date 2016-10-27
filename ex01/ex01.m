% main script for ex01
%% excercise 1
% mean filter will be allied to lena.gif

% get image and mean kernel
K = 1/9*ones(3,3);
img = imread('lena.gif');
% show original image
figure('Name','original');
imshow(img);
% show image after convolution with clamp
figure('Name','mean_conv(clamp)');
imshow(uint8(convolution(double(img),K,'clamp')));
% show image after convolution with mirror
figure('Name','mean_conv(mirror)');
imshow(uint8(convolution(double(img),K,'mirror')));
%% exercise 2