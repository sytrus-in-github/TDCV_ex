SEQ_DIR = 'data/sequence/';
img = imread(strcat(SEQ_DIR,'2043_000140.jpeg'));
bin = colorHist(img(300:345, 500:555,:));
% imshow(img(307:348, 505:556,:));
% length(bin)
% max(bin)
% min(bin)
% bin'