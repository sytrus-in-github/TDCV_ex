%% test function Harris
img = imread('sample2.jpg');
disp(size(img));
dimg = double(img);
figure('Name','original');
imshow(img);
sig_d = 2.5;
sig_i = 3;
alpha = 0.04;
threshold = 0.15;
dout = Harris(dimg(:,:,1), sig_d, sig_i, alpha, threshold, true);
dout = dout*255;
dout = imdilate(dout,ones(3,3));
dimg(:,:,2) = dimg(:,:,2).*(255-dout)/255;  % necessary, otherwise red points in white region will not show ! (saturation)
dimg(:,:,3) = dimg(:,:,3).*(255-dout)/255;
dimg(:,:,1) = dimg(:,:,1)+dout;
figure('Name','response');
imshow(uint8(dimg));

%% test function Harris multiscale
dimg = double(img);
s_init = 1;
sig_d = 2.5;
sig_i = 3;
alpha = 0.04;
n = 3;
threshold = 0.15;
k = 4;
dout = Harris_multiscale(dimg(:,:,1), s_init, sig_d, sig_i, alpha, threshold, n, k);
for l=1:n
    for i=1:k
        resimg = dimg;
        dout(:,:,i*l) = dout(:,:,i*l)*255;
        dout(:,:,i*l) = imdilate(dout(:,:,i*l),ones(3,3));
        resimg(:,:,2) = resimg(:,:,2).*(255-dout(:,:,i*l))/255; % necessary, otherwise red points in white region will not show ! (saturation)
        resimg(:,:,3) = resimg(:,:,3).*(255-dout(:,:,i*l))/255;
        resimg(:,:,1) = resimg(:,:,1)+dout(:,:,i*l);
        figure('Name',strcat(strcat(strcat('response : scale ',num2str(l)),', image '), num2str(i)));
        imshow(uint8(resimg));
    end
end