function map = EdgeMatchingResponseMap( image, template, matchingFun, binaryMap)
    if ~exist('binaryMap','var') || isempty(binaryMap)
        binaryMap = true(size(image)); 
    end
    grad_threshold = 20;
    [dir_i,imgmask] = getGradientOrientation(image, grad_threshold);
    [dir_t,tmpmask] = getGradientOrientation(template, grad_threshold);
    [H, W] = size(dir_i);
    [h, w]= size(dir_t);
    map = zeros(H-h, W-w);
    for i = 1:H-h
        for j = 1:W-w
            if binaryMap(i, j)
                map(i, j) = matchingFun(dir_i, dir_t, i, j, and(tmpmask, imgmask(i:i+h-1, j:j+w-1)));
            end
        end
    end
    %map = map + (not(binaryMap(1:H-h,1:W-w))) * min(min(map,[],1),[],2);
end

