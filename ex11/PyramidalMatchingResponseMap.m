function map = PyramidalMatchingResponseMap( image, template, intermediateScales, percentage, matchingFun, matchingResponseFun)
    s = size(image);
    H = s(1);
    W = s(2);
    binaryMap = true(H,W);
    for i = 1:size(intermediateScales)
       scale = intermediateScales(i);
       scaledImage = imresize(image, 1/scale);
       scaledTemplate = imresize(template, 1/scale);
       s = size(scaledImage);
       binaryMap = imresize(binaryMap, [s(1),s(2)],'nearest');
       scaledMap = matchingResponseFun( scaledImage, scaledTemplate, matchingFun, binaryMap);
%        binaryMap = ThresholdMatchingResponseMap( scaledMap, threshold );
       binaryMap = PercentileMatchingResponseMap( scaledMap, s, percentage );
    end
    binaryMap = imresize(binaryMap, [H, W],'nearest');
    disp([max(binaryMap(:)) mean(binaryMap(:)) min(binaryMap(:))])
    figure('Name','BinaryMap');
    imshow(binaryMap);
    map = matchingResponseFun( image, template, matchingFun, binaryMap );
end