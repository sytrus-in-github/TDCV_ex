function p = Argmin( M )
    [V, X] = min(M,[],1);
    [~,y] = min(V,[],2);
    p = [X(y), y];
end

