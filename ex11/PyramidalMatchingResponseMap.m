function map = PyramidalMatchingResponseMap( image, template, intermediateScales, percentage, matchingFun, matchingResponseFun )
    s = size(image);
    H = s(1);
    W = s(2);
    binaryMap = true(H,W);
    for i = 1:size(intermediateScales)
       scale = intermediateScales(i);
       scaledImage = imresize(image, 1/scale);
       scaledTemplate = imresize(template, 1/scale);
       si = size(scaledImage);
       binaryMap = imresize(binaryMap, [si(1),si(2)]);
       scaledMap = matchingResponseFun( scaledImage, scaledTemplate, matchingFun, binaryMap );
       binaryMap = PercentileMatchingResponseMap( scaledMap, si, percentage );
    end
    binaryMap = imresize(binaryMap, [H, W]);
    %figure('Name','Binary map');
    %imshow(binaryMap);
    map = matchingResponseFun( image, template, matchingFun, binaryMap );
end