SEQ_DIR = 'data/sequence/';
% get names of image sequences
imgseq = dir(SEQ_DIR);
imgfiles = cell(length(imgseq)-2,1);
for i=1:length(imgseq)-2
    imgfiles{i} = imgseq(i+2).name;
end
% show 1st imagename
disp(imgfiles{1});
% show selected region
img = imread(strcat(SEQ_DIR,imgfiles{1}));
figure(1);
imshow(img(308:347, 506:555,:)); % INITIAL MANUAL RECTANGULAR REGION
% show hue histogram
bin = colorHist(img(308:347, 506:555,:));
figure(2);
showColorHist(bin);
% show probability map
dist = probMap(img(308:347, 506:555,:), bin);
figure(3);
showProbMap(dist);
