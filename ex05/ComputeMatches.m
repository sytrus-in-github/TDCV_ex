function [ matches, scores ] = ComputeMatches( da,db )
    [matches, scores] = vl_ubcmatch(db, da);

    [drop, perm] = sort(scores, 'descend') ;
    matches = matches(:, perm) ;
    scores  = scores(perm) ;
end

