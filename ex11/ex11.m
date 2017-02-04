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

tic;
disp('Compute: Gray-SSD-DirectComputation-Map...');
map = MatchingResponseMap( grayImage, grayTemplate, @SumSquaredDifferences );
toc;
figure('Name','Gray-SSD-DirectComputation-Map');
map = mat2gray(map);
imshow(1-map);
disp('Found template position:');
disp(Argmin(map));


%% gray image pyramidal matching response with sum squared difference

tic;
disp('Compute: Gray-SSD-PyramidalComputation-Map...');
map = PyramidalMatchingResponseMap( grayImage, grayTemplate, intermediateScales, threshold, @SumSquaredDifferences, @MatchingResponseMap );
toc;
figure('Name','Gray-SSD-PyramidalComputation-Map');
map = mat2gray(map);
imshow(1-map);
disp('Found template position:');
disp(Argmin(map));