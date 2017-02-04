function map = ColorMatchingResponseMap( image, template, matchingFun, binaryMap, imgmask, tmpmask)
    mapR = MatchingResponseMap( image(:,:,1), template(:,:,1), matchingFun, binaryMap, imgmask, tmpmask);
    mapG = MatchingResponseMap( image(:,:,2), template(:,:,2), matchingFun, binaryMap, imgmask, tmpmask);
    mapB = MatchingResponseMap( image(:,:,3), template(:,:,3), matchingFun, binaryMap, imgmask, tmpmask);
    map = (mapR + mapG + mapB)/3;
end

