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
% show image after applying Gaussian mask with s = 1.0
g1 = gaussian(1);
figure('Name','gaussian_mask(1.0)');
disp('gaussian_mask(1.0):             ');
tic
out = conv2(dimg,g1);
toc
tic
out = convolution(dimg,g1,'clamp');
toc
%imshow(uint8(convolution(dimg,g1,'clamp')));
imshow(uint8(out));
% show image after applying Gaussian mask with s = 3.0
g3 = gaussian(3);
figure('Name','gaussian_mask(3.0)');
disp('gaussian_mask(3.0):             ');
tic
out = conv2(dimg,g3);
toc
tic
out = convolution(dimg,g3,'clamp');
toc
imshow(uint8(out));
% show image after successively applying horizontal and vertical Gaussian mask with s = 1.0
figure('Name','successive_gaussian_masks(1.0)');
disp('successive_gaussian_masks(1.0): ');
gh1 = horizontal_gaussian(1);
gv1 = vertical_gaussian(1);
tic
out = conv2(conv2(dimg,gh1,'same'),gv1,'same');
toc
tic
out = convolution(convolution(dimg,gh1,'clamp'),gv1,'clamp');
toc
imshow(uint8(out));
% show image after successively applying horizontal and vertical Gaussian mask with s = 3.0
figure('Name','successive_gaussian_masks(3.0)');
disp('successive_gaussian_masks(3.0): ');
gh3 = horizontal_gaussian(3);
gv3 = vertical_gaussian(3);
tic
out = conv2(conv2(dimg,gh3,'same'),gv3,'same');
toc
tic
out = convolution(convolution(dimg,gh3,'clamp'),gv3,'clamp');
toc
imshow(uint8(out));
% One test run:
% gaussian_mask(1.0):             
% Elapsed time is 0.007031 seconds.
% Elapsed time is 1.783926 seconds.
% gaussian_mask(3.0):             
% Elapsed time is 0.012088 seconds.
% Elapsed time is 1.807946 seconds.
% successive_gaussian_masks(1.0): 
% Elapsed time is 0.008371 seconds.
% Elapsed time is 2.629134 seconds.
% successive_gaussian_masks(3.0): 
% Elapsed time is 0.011113 seconds.
% Elapsed time is 2.313589 seconds.
% The acceleratation of successive 1D gaussian convolution is masked in
% practice by the additional overhead of applying a second convolution, 
% which is amplified in the case of our implementation by the usage of for
% loops, etc. However, even with the implementation given by Matlab (conv2)
% we see no speed-up for small kernel (3X3 for sigma=1) and only a slight
% spped-up for the bigger kernel (9X9 for sigma=3), which also shows the
% effect of the cancellation of the speed-up by the overhead of the 
% additional convolution.
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