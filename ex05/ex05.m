% DLT test
% x = [1,1,1;2,1,1;1,3,1;5,4,1;8,9,1];
% y = [2,2,1;4,2,1;2,6,1;10,8,1;16,18,1];
% H = DLT(x,y);
% disp(H);
% x*H'

% Load images
img1 = imread('data/scene.pgm');
img2 = imread('data/box.pgm');
figure(1); clf;
imshow(img1);
axis image off;
figure(2); clf;
imshow(img2);
axis image off;

% Compute Keypoints and Descriptors
[ f1, d1, f2, d2 ] = ComputeSIFT(img1, img2);

% Compute Matches
[ matches, scores ] = ComputeMatches(d1, d2);

% Reorder matched keypoints and homogenize
[~, num_points] = size(matches);
X1 = ones(num_points, 3);
X2 = ones(num_points, 3);
X1(:,1:2) = f1(1:2,matches(1,:))';
X2(:,1:2) = f2(1:2,matches(2,:))';

disp(num_points);
s = 4;
t = 15;
T = 20;
N = 100;
p = 0.99;
%[X1_inline, X2_inline] = naiveRANSAC(X1, X2, @DLT, @EuclideanDistance, s, t, T, N);
[X1_inline, X2_inline] = adaptiveRANSAC(X1, X2, @DLT, @EuclideanDistance, s, t, p);
% draw match
[sx, sy] = size(img1);
[ox, oy] = size(img2);
canvas = zeros([sx, sy+oy]);
canvas(1:sx, 1:sy) = img1(:,:);
canvas(1:ox, sy+1:sy+oy) = img2(:,:);
figure(3);
imshow(uint8(canvas));
hold on;
[nin,~] = size(X1_inline);
for i=1:nin
    p1 = X1_inline(i,1:2);
    p2 = X2_inline(i,1:2)+[sy,0];
    h = line([p2(1);p1(1)], [p2(2);p1(2)]);
    set(h,'linewidth', 1, 'color', 'b');
end

H = DLT(X1_inline, X2_inline);
disp(H);
T = projective2d(H');
W = imwarp(img1,T);
[h0,w0] = size(W);
[h1,w1] = size(img1);
% fail save
if h0+w0 > 5*(h1+w1)
    error('failed transformation!');
end
% find cooridnates of the bounding box from the 4 corner
corners = [1 1 1; 1 w1 1; h1 1 1; h1 w1 1] * H';
corners_h = [corners(:,1)./corners(:,3), corners(:,2)./corners(:,3)];
offset = round(min(corners_h))-[1,1];

% draw the overlapping area and use 50% transparence fusion of the corresponding zone
[h2,w2] = size(img2);
W(1-offset(1):h2-offset(1),1-offset(2):w2-offset(2)) = (W(1-offset(1):h2-offset(1),1-offset(2):w2-offset(2))+img2(:,:))/2; 
% show final result
figure(4); clf;
imshow(W);