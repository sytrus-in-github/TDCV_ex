function p = Argmax( M )
    [V, X] = max(M,[],1);
    [~,y] = max(V,[],2);
    p = [X(y), y];
end

