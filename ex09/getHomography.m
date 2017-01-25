function H = getHomography(fromparameters, toparameters)
% get homography matrix H from 2 parameter vectors
    H = estimateGeometricTransform(paramAsPoints(fromparameters), ...
                                   paramAsPoints(toparameters), 'projective');
end