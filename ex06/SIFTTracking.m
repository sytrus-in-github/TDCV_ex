function [ X0_inliers, Xt_inliers ] = SIFTTracking( f0, d0, ft, dt, s, t, p )    
    % Compute matches
    [ matches, ~ ] = ComputeMatches(d0, dt);
    
    % Reorder matched keypoints and homogenize
    [~, num_points] = size(matches);
    X0 = ones(num_points, 3);
    Xt = ones(num_points, 3);
    X0(:,1:2) = f0(1:2,matches(1,:))';
    Xt(:,1:2) = ft(1:2,matches(2,:))';
    
    % Compute RANSAC inliers
    [X0_inliers, Xt_inliers] = adaptiveRANSAC(X0, Xt, @DLT, @EuclideanDistance, s, t, p);
end

