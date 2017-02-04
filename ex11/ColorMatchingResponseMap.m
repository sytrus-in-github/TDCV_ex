function map = ColorMatchingResponseMap( image, template, matchingFun, binaryMap )
    mapR = MatchingResponseMap( mat2gray(image(:,:,1)), mat2gray(template(:,:,1)), matchingFun, binaryMap );
    mapG = MatchingResponseMap( mat2gray(image(:,:,2)), mat2gray(template(:,:,2)), matchingFun, binaryMap );
    mapB = MatchingResponseMap( mat2gray(image(:,:,3)), mat2gray(template(:,:,3)), matchingFun, binaryMap );
    map = (mapR + mapG + mapB)/3;
end

