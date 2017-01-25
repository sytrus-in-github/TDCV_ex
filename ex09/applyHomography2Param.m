function newParam = applyHomography2Param(H, oldparam)
% update parameters with the homography matrix
    newPoints = transformPointsForward(H, paramAsPoints(oldparam));
    newPoints_ = newPoints';
    newParam = newPoints_(:)';
end