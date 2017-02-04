function map = MatchingResponseMap( image, template, matchingFun, binaryMap )
    [H, W] = size(image);
    [h, w]= size(template);
    if nargin < 4
       binaryMap = true(size(image)); 
    end
    map = zeros(H-h, W-w);
    for i = 1:H-h
        for j = 1:W-w
            if binaryMap(i, j)
                map(i, j) = matchingFun(image, template, i, j);
            end
        end
    end
    %map = map + (not(binaryMap(1:H-h,1:W-w))) * min(min(map,[],1),[],2);
end

