function map = PyramidalMatchingResponseMap( image, template, intermediateScales, threshold, matchingFun, matchingResponseFun, imgmask, tmpmask)
    s = size(image);
    H = s(1);
    W = s(2);
    binaryMap = true(H,W);
    if ~exist('imgmask','var') || isempty(imgmask)
        imgmask = true(size(image)); 
    end
    if ~exist('tmpmask','var') || isempty(tmpmask)
        tmpmask = true(size(template)); 
    end
    for i = 1:size(intermediateScales)
       scale = intermediateScales(i);
       scaledImage = imresize(image, 1/scale);
       scaledTemplate = imresize(template, 1/scale);
       scaledImgmask = imresize(imgmask, 1/scale) > 0.1;
       scaledTmpmask = imresize(tmpmask, 1/scale) > 0.1;
       s = size(scaledImage);
       h = s(1);
       w = s(2);
       binaryMap = imresize(binaryMap, [h, w]);
       scaledMap = matchingResponseFun( scaledImage, scaledTemplate, @SumSquaredDifferences, binaryMap, scaledImgmask, scaledTmpmask);
       binaryMap = ThresholdMatchingResponseMap( scaledMap, threshold );
    end
    binaryMap = imresize(binaryMap, [H, W]);
    figure('Name','BinaryMap');
    imshow(binaryMap);
    map = matchingResponseFun( image, template, matchingFun, binaryMap );
end