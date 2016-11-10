function [ matches, scores ] = ComputeMatches( ds,do )
    [matches, scores] = vl_ubcmatch(do, ds);

    [drop, perm] = sort(scores, 'descend') ;
    matches = matches(:, perm) ;
    scores  = scores(perm) ;
end

