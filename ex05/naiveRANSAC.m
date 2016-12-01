function  [X1_inline, X2_inline]= naiveRANSAC(X1, X2, func_trans, func_dist, nb_sample, dist_thres, inline_thres, max_trial)
    % X1, X2 pairs to be matched
    % func_trans the transformation function (input 2 matrices of matched points output transformation matrix)
    % func_dist the distance function (input 2 matrices of matched points output 1D vector of distances)
    % nb_sample the minimum number of samples that the func_trans needs
    % dist_thres the threshold for inliner distance (t or epsilon)
    % inline_thres the threshold for the proportion of the inliner of the samples (T/size or p)
    % max_trial the maximum number of trials (N)
    % X1_inline, X2_inline the found inline points
    
    % check that X1 and X2 have the same shape
    if size(X1) ~= size(X2)
        error('inconsistent shape between matching oint sets x1 and x2')
    end
    % get number of pairs and inliner thrershold
    s = size(X1);
    num = s(1);
    in_t = round(num * inline_thres);
    % initialize consensus set
    X1_inline = [];
    X2_inline = [];
    nb_inline = 0;
    % start trial
    trial = 0;
    while trial < max_trial
        % get transformation matrix from random sampling
        indx = randsample(num, nb_sample);
        M = func_trans(X1(indx,:), X2(indx,:));
        % TODO catch error caused by degeneration?
        % get the corresponding consensus set
        dists = func_dist(M*X1, X2);
        are_inline = dists<dist_thres;
        n_inline = sum(are_inline);
        % update the consensus set if it is better
        if n_inline>nb_inline
            nb_inline = n_inline;
            X1_inline = X1(are_inline, :);
            X2_inline = X2(are_inline, :);
        end
        % if we find enough inliner we can stop
        if n_inline>in_t
            break
        end
        % increment trial number
        trial = trial + 1;
    end
end