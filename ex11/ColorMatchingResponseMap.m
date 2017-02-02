function map = ColorMatchingResponseMap( image, template, matchingFun, binaryMap )
    mapR = MatchingResponseMap( image(:,:,1), template(:,:,1), matchingFun, binaryMap );
    mapG = MatchingResponseMap( image(:,:,2), template(:,:,2), matchingFun, binaryMap );
    mapB = MatchingResponseMap( image(:,:,3), template(:,:,3), matchingFun, binaryMap );
    map = (mapR + mapG + mapB)/3;
end

