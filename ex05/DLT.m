function H = DLT( x, y )
% Returns the solution H of y_i = H*x_i
    [num_points,~] = size(x);
    [U, xn] = Normalize(x);
    [T, yn] = Normalize(y);
    An = zeros(2*num_points,9);
    for i = 1:num_points
       An(2*i-1,4:6) = -yn(i,3)*xn(i,:);
       An(2*i-1,7:9) = yn(i,2)*xn(i,:);
       An(2*i,1:3) = yn(i,3)*xn(i,:);
       An(2*i,7:9) = -yn(i,1)*xn(i,:);
    end
    [~,~,V] = svd(An,'econ');
    hn = V(:,9);
    Hn = zeros(3,3);
    for i = 1:3
        for j = 1:3
            Hn(i,j) = hn(3*(i-1)+j,1);
        end
    end
    H = T\Hn*U;
end

