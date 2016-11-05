%% test function Harris
img = imread('sample2.jpg');
disp(size(img));
dimg = double(img);
figure('Name','original');
imshow(img);
sig_d = 2.5;
sig_i = 3;
alpha = 0.04;
threshold = 0;
dout = Harris(dimg(:,:,1), sig_d, sig_i, alpha, threshold, true);
dout = dout*255;
dout = imdilate(dout,ones(3,3));
%dimg = dimg.*(255-dout)/255;
dimg(:,:,1) = dimg(:,:,1)+dout;
figure('Name','response');
imshow(uint8(dimg));

%% test function Harris multiscale
dimg = double(img);
sigma = 1;
alpha = 0.04;
n = 3;
threshold = 0.15;
k = 1.5;
c = 0.8;
dout = Harris_multiscale(dimg(:,:,1), sigma, alpha, threshold, n, k, c);
for i=1:n
    resimg = dimg;
    dout(:,:,i) = dout(:,:,i)*255;
    dout(:,:,i) = imdilate(dout(:,:,i),ones(3,3));
    resimg(:,:,1) = resimg(:,:,1)+dout(:,:,i);
    figure('Name',strcat('response : scale ',num2str(i)));
    imshow(uint8(resimg));
end