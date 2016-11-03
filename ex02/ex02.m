%% test function Harris
img = imread('sample2.jpg');
disp(size(img));
dimg = double(img);
figure('Name','original');
imshow(img);
sig_d = 1;
sig_i = 1;
alpha = 0.04;
threshold = 0.15;
dout = Harris(dimg(:,:,1), sig_d, sig_i, alpha, threshold, true);
dout = dout*255;
dout = imdilate(dout,[1,1,1;1,0,1;1,1,1]);
dimg = dimg.*(255-dout)/255;
dimg(:,:,1) = dimg(:,:,1)+dout;
figure('Name','response');
imshow(uint8(dimg));