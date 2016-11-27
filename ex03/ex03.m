%% SIFT extraction and matching
% load image
obj = imread('data/shell.jpg');
% load scene
scn = imread('data/test_shell2.jpg');
% resize image
obj = imresize(obj,size(scn,1)/size(obj,1));
% compute keypoints and descriptors
[fs, ds, fo, do] = ComputeSIFT(scn, obj);
size(ds)
% draw SIFT
DrawSIFT(scn,obj,fs,fo,1);
% compute matches
[matches, scores] = ComputeMatches(ds, do);
% draw matches with outliers
DrawMatches(scn, obj, matches, fs, fo, false, 2);
% draw matches without outliers
[xa, ya, ~, ~] =DrawMatches(scn, obj, matches, fs, fo, true, 3);
% draw bounding box
DrawBoundingBox(scn, xa, ya, 4);

%% HOG extraction and matching
% load image
obj = imread('data/pot.jpg');
% load scene
scn = imread('data/test_pot2.jpg');
% resize images the optimal speed and performance
obj = imresize(obj,1/8);
scn = imresize(scn,1/4);
% show original images
disp(size(obj));
figure(5);imshow(obj);
disp(size(scn));
figure(6);imshow(scn);
% compute HoG features for the scene and visualize
cellSize = 8;
hog = vl_hog(im2single(rgb2gray(scn)), cellSize);
imhog = vl_hog('render', hog) ;
figure(7);imshow(imhog);
% compute Hog features for the object at different scales, and perform convolution to get the best match
xm = 0; ym = 0; cm = 0; vm = -1;
for c=4:10  % will give reasonable result if c=7 or 8 and c<11
    [v,x,y] = hogConv(hog,obj,cellSize,c);
    if v > vm
       xm = x; ym = y; cm = c; vm = v; 
    end
end
disp([xm,ym,cm,vm])
% draw bounding box
figure(8);imagesc(scn);hold on;
[yy,xx,~]=size(obj);
dy = round(yy/2); dx = round(xx/2);
r = rectangle('Position', [ym-dy, xm-dx, xx, yy], 'EdgeColor', 'g', 'linewidth', 2);
axis image on;
hold off;