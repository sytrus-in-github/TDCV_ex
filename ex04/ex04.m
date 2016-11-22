% Read the forest
num_files = 10;
forest(1).internal_nodes = [];
forest(1).leaves = [];
for i = 1:num_files
    forest = ReadTree(forest, strcat('data/Tree',int2str(i-1),'.txt'), i);
end

%forest(1).internal_nodes(1:10,:)

% Load image and compute integral image
rgb = double(imread('data/2007_000032.jpg'))/255.;
irgb = IntegralImage(rgb);

figure(1);
imshow(uint8(rgb*255.));