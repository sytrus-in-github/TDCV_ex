function map = MatchingResponseMap( image, template, matchingFun, binaryMap, imgmask, tmpmask)
    [H, W] = size(image);
    [h, w]= size(template);
    if ~exist('binaryMap','var') || isempty(binaryMap)
        binaryMap = true(size(image)); 
    end
    if ~exist('imgmask','var') || isempty(imgmask)
        imgmask = true(size(image)); 
    end
    if ~exist('tmpmask','var') || isempty(tmpmask)
        tmpmask = true(size(template)); 
    end
    map = zeros(H-h, W-w);
    for i = 1:H-h
        for j = 1:W-w
            if binaryMap(i, j)
                map(i, j) = matchingFun(image, template, i, j, and(tmpmask, imgmask(i:i+h-1, j:j+w-1)));
            end
        end
    end
    map = map + (not(binaryMap(1:H-h,1:W-w))) * max(max(map,[],1),[],2);
end

