function map = PyramidalMatchingResponseMap( image, template, intermediateScales, threshold, matchingFun, matchingResponseFun )
    s = size(image);
    H = s(1);
    W = s(2);
    binaryMap = true(H,W);
    for i = 1:size(intermediateScales)
       scale = intermediateScales(i);
       scaledImage = imresize(image, 1/scale);
       scaledTemplate = imresize(template, 1/scale);
       s = size(scaledImage);
       h = s(1);
       w = s(2);
       binaryMap = imresize(binaryMap, [h, w]);
       scaledMap = matchingResponseFun( scaledImage, scaledTemplate, @SumSquaredDifferences, binaryMap );
       binaryMap = ThresholdMatchingResponseMap( scaledMap, threshold );
    end
    binaryMap = imresize(binaryMap, [H, W]);
    imshow(binaryMap);
    map = matchingResponseFun( image, template, matchingFun, binaryMap );
end