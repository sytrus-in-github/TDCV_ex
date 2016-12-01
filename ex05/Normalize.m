function [ U, xn ] = Normalize( x )
% Normalize the points with the transformation U such that their centroid 
% is at the origin and their average distance from the origin is equal to
% sqrt(2)
    [num_points,~] = size(x);
    copyx = zeros(size(x));
    for i = 1:num_points
       copyx(i,:) = x(i,:)/x(i,3); 
    end
    M = mean(copyx);
    avgx = M(1,1);
    avgy = M(1,2);
    avgd = mean(sqrt((copyx(:,1)-avgx).^2+(copyx(:,2)-avgy).^2));
    U = eye(3);
    U(1,3) = -avgx;
    U(2,3) = -avgy;
    U(1,:) = U(1,:)*sqrt(2)/avgd;
    U(2,:) = U(2,:)*sqrt(2)/avgd;
    xn = U*x';
    xn = xn';
end

