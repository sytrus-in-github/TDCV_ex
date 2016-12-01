function dist = EuclideanDistance( X, Y )
    dist = sqrt((X(:,1)./X(:,3)-Y(:,1)./Y(:,3)).^2+(X(:,2)./X(:,3)-Y(:,2)./Y(:,3)).^2);
end

