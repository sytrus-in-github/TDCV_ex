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
xReg = 308;
yReg = 506;
hReg = 39;
wReg = 49;
img = imread(strcat(SEQ_DIR,imgfiles{1}));
figure(1);
imshow(img(xReg:xReg+hReg, yReg:yReg+wReg,:)); % INITIAL MANUAL RECTANGULAR REGION
% show hue histogram
bin = colorHist(img(xReg:xReg+hReg, yReg:yReg+wReg,:));
figure(2);
showColorHist(bin);
% show probability map
dist = probMap(img(xReg:xReg+hReg, yReg:yReg+wReg,:), bin);
figure(3);
showProbMap(dist);

% mean-shift tracking
figure(4);
showTracking(img,xReg,yReg,hReg,wReg);
for i = 2:length(imgfiles)
   pause(0.1);
   img = imread(strcat(SEQ_DIR,imgfiles{i}));
   imshow(img);
   [xReg, yReg] = meanShift(img, xReg, yReg, hReg, wReg, bin);
   figure(4);
   showTracking(img,xReg,yReg,hReg,wReg);
end
