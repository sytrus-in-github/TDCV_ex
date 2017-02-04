% load image
image = imread('data/munich.png');
figure('Name','Image');
imshow(image);

% select template
templatePos = [200,250];
templateSize = [200,250];
template = image(templatePos(1):templatePos(1)+templateSize(1),templatePos(2):templatePos(2)+templateSize(2),:);
figure('Name','Template');
imshow(template);

% gray versions
grayImage = mat2gray(rgb2gray(image));
grayTemplate = grayImage(templatePos(1):templatePos(1)+templateSize(1),templatePos(2):templatePos(2)+templateSize(2),:);

disp('Original template position:');
disp(templatePos);

threshold = 0.035;
intermediateScales = [16];

%% gray image direct matching response with sum squared difference
% computation time : ~257 seconds
% found template position : 200 250 (correct)

% tic;
% disp('Compute: Gray-SSD-DirectComputation-Map...');
% map = MatchingResponseMap( grayImage, grayTemplate, @SumSquaredDifferences );
% toc;
% figure('Name','Gray-SSD-DirectComputation-Map');
% map = mat2gray(map);
% imshow(1-map);
% disp('Found template position:');
% disp(Argmin(map));


%% gray image pyramidal matching response with sum squared difference

% tic;
% disp('Compute: Gray-SSD-PyramidalComputation-Map...');
% map = PyramidalMatchingResponseMap( grayImage, grayTemplate, intermediateScales, threshold, @SumSquaredDifferences, @MatchingResponseMap );
% toc;
% figure('Name','Gray-SSD-PyramidalComputation-Map');
% map = mat2gray(map);
% imshow(1-map);
% disp('Found template position:');
% disp(Argmin(map));

%% edge-based template matching
grad_threshold = 20;
val_threshold = 0.15;
[dir_i,msk_i] = getGradientOrientation(image, grad_threshold);
[dir_t,msk_t] = getGradientOrientation(template, grad_threshold);

i = 200;
j = 250;
disp(AbsoluteCosineDifferences(dir_i, dir_t, i, j, and(msk_t, msk_i(i:i+200, j:j+250))))
% show gradient mask
figure(3);
imshow(255*msk_t);

tic;
disp('Compute: Grad-ACD-PyramidalComputation-Map...');
% this works much faster
map = PyramidalMatchingResponseMap(dir_i, dir_t, intermediateScales, val_threshold, @AbsoluteCosineDifferences, @MatchingResponseMap, msk_i, msk_t);
% this works but slow
% map = MatchingResponseMap(dir_i, dir_t, @SumSquaredDifferences,true(size(dir_i)),msk_i, msk_t);
toc;
figure('Name','Grad-ACD-PyramidalComputation-Map');
map = mat2gray(map);
imshow(1-map);
disp('Found template position:');
disp(Argmin(map));
