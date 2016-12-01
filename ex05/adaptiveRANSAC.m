function  [X1_inline, X2_inline]= adaptiveRANSAC(X1, X2, func_trans, func_dist, s, t, p)
    % X1, X2 pairs to be matched
    % func_trans the transformation function (input 2 matrices of matched points output transformation matrix)
    % func_dist the distance function (input 2 matrices of matched points output 1D vector of distances)
    % s the minimum number of samples that the func_trans needs (s)
    % t the threshold for inliner distance (t)
    % p the threshold for the proportion of the inliner of the samples
    % X1_inline, X2_inline the found inline points
    
    % check that X1 and X2 have the same shape
    if size(X1) ~= size(X2)
        error('inconsistent shape between matching oint sets x1 and x2')
    end
    % get number of pairs and inliner thrershold
    [num, ~] = size(X1);
    % initialize consensus set
    X1_inline = [];
    X2_inline = [];
    nb_inline = 0;
    % start trial
    trial = 0;
    N = intmax;
    while trial < N
        % get transformation matrix from random sampling
        indx = randsample(num, s);
        M = func_trans(X1(indx,:), X2(indx,:));
        % TODO catch error caused by degeneration?
        % get the corresponding consensus set
        dists = func_dist(M*X1, X2);
        are_inline = dists < t;
        n_inline = sum(are_inline);
        %update N
        oneMinusEpsilon = n_inline / num;
        N = ceil(log(1 - p) / log(1 - oneMinusEpsilon ^ s));
        % update the consensus set if it is better
        if n_inline>nb_inline
            nb_inline = n_inline;
            X1_inline = X1(are_inline, :);
            X2_inline = X2(are_inline, :);
        end
        % increment trial number
        trial = trial + 1;
    end
end