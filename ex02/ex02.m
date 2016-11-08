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

% %% test function Harris multiscale
% dimg = double(img);
% s_init = 1.5;
% alpha = 0.04;
% n = 5;
% c = 0.7;
% threshold = 50000;
% k = 3;
% [dres,dout] = Harris_multiscale(dimg(:,:,1), s_init, c, alpha, threshold, n, k);
% for l=0:n-1
%     for i=0:k-1
%         resimg = dimg;
%         dout(:,:,l*k+i+1) = dout(:,:,l*k+i+1)*255;
%         dout(:,:,l*k+i+1) = imdilate(dout(:,:,l*k+i+1),[1,1,1;1,0,1;1,1,1]);
%         resimg(:,:,1) = resimg(:,:,1).*(255-dout(:,:,l*k+i+1))/255;
%         resimg(:,:,2) = resimg(:,:,2).*(255-dout(:,:,l*k+i+1))/255; % necessary, otherwise red points in white region will not show ! (saturation)
%         resimg(:,:,3) = resimg(:,:,3).*(255-dout(:,:,l*k+i+1))/255;
%         resimg(:,:,1) = resimg(:,:,1)+dout(:,:,l*k+i+1);
%         figure('Name',strcat(strcat(strcat('response : scale ',num2str(l)),', image '), num2str(i)));
%         imshow(uint8(resimg));
%     end
% end

%% test function Harris Laplace
dimg = double(img);
thresh_h = 50000;
thresh_l = 40;
alpha = 0.06;
c= 0.7;
s_init = 1.5;
k = 3;
n = 17;
[harris_res,harris_out] = Harris_multiscale(dimg(:,:,1), s_init, c, alpha, thresh_h, n, k);
laplace_res = HarrisLaplaceResponse( harris_res,  s_init, c, n, k);
pts = HarrisLaplacePoints( laplace_res, harris_out , thresh_l );
all_pts = pts(:,:,1);
for i=2:n*k
    all_pts = all_pts + pts(:,:,i);
end
all_pts = all_pts*255;
all_pts = imdilate(all_pts,ones(3,3));
dimg(:,:,2) = dimg(:,:,2).*(255-all_pts)/255;  % necessary, otherwise red points in white region will not show ! (saturation)
dimg(:,:,3) = dimg(:,:,3).*(255-all_pts)/255;
dimg(:,:,1) = dimg(:,:,1)+all_pts;
figure('Name','harris-laplace');
imshow(uint8(dimg));