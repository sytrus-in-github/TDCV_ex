function warpedGridPoints = applyHomography2Grid(H, gridpoints)
% warp grid points with the homography matrix
    warpedGridPoints = round(transformPointsForward(H, gridpoints));
end