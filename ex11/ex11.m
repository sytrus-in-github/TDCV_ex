% load image
image = imread('data/munich.png');
imageSize = size(image);
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

percentage = 20;
intermediateScales = [16;8;4;2];

%% gray image direct matching response with sum squared difference
% computation time : ~85 seconds
% found template position : 200 250 (correct)

% tic;
% disp('Compute: Gray-SSD-DirectComputation-Map...');
% map = MatchingResponseMap( grayImage, grayTemplate, @SumSquaredDifferences );
% toc;
% figure('Name','Gray-SSD-DirectComputation-Map');
% map = mat2gray(map);
% imshow(map);
% disp('Found template position:');
% disp(Argmax(map));
% % imwrite(map,'Gray-SSD-Map.png');

%% gray image direct matching response with normalized cross correlation
% computation time : ~162 seconds
% found template position : 200 250 (correct)

% tic;
% disp('Compute: Gray-NCC-DirectComputation-Map...');
% map = MatchingResponseMap( grayImage, grayTemplate, @NormalizedCrossCorrelation );
% toc;
% figure('Name','Gray-NCC-DirectComputation-Map');
% map = mat2gray(map);
% imshow(map);
% disp('Found template position:');
% disp(Argmax(map));
% % imwrite(map,'Gray-NCC-Map.png');

%% gray image pyramidal matching response with sum squared difference

% tic;
% disp('Compute: Gray-SSD-PyramidalComputation-Map...');
% map = PyramidalMatchingResponseMap( grayImage, grayTemplate, intermediateScales, percentage, @SumSquaredDifferences, @MatchingResponseMap );
% toc;
% mapSize = size(map);
% figure('Name','Gray-SSD-PyramidalComputation-Map');
% map = mat2gray(map+min(map(map>0))*(map==0));
% imshow(map);
% disp('Found template position:');
% disp(Argmax(map));

%% gray image pyramidal matching response with normalized cross correlation

% tic;
% disp('Compute: Gray-NCC-PyramidalComputation-Map...');
% map = PyramidalMatchingResponseMap( grayImage, grayTemplate, intermediateScales, percentage, @NormalizedCrossCorrelation, @MatchingResponseMap );
% toc;
% figure('Name','Gray-NCC-PyramidalComputation-Map');
% map = mat2gray(map+min(map(map>0))*(map==0));
% imshow(map);
% disp('Found template position:');
% disp(Argmax(map));

%% color image pyramidal matching response with sum squared difference

% tic;
% disp('Compute: Color-SSD-PyramidalComputation-Map...');
% map = PyramidalMatchingResponseMap( image, template, intermediateScales, percentage, @SumSquaredDifferences, @ColorMatchingResponseMap );
% toc;
% mapSize = size(map);
% figure('Name','Color-SSD-PyramidalComputation-Map');
% map = mat2gray(map+min(map(map>0))*(map==0));
% imshow(map);
% disp('Found template position:');
% disp(Argmax(map));

%% gray image pyramidal matching response with normalized cross correlation

tic;
disp('Compute: Color-NCC-PyramidalComputation-Map...');
map = PyramidalMatchingResponseMap( image, template, intermediateScales, percentage, @NormalizedCrossCorrelation, @MatchingResponseMap );
toc;
figure('Name','Color-NCC-PyramidalComputation-Map');
map = mat2gray(map+min(map(map>0))*(map==0));
imshow(map);
disp('Found template position:');
disp(Argmax(map));