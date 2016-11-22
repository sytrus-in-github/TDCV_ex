function irgb = IntegralImage( rgb )
    [m, n, ~] = size(rgb);
    irgb = zeros(size(rgb));
    s = zeros(size(rgb));
    s(:,1,:)= rgb(:,1,:);
    for j = 2:n
        for i = 1:m
            for k = 1:3
                s(i,j,k) = s(i,j-1,k) + rgb(i,j,k);
            end
        end
    end
    irgb(1,:,:) = s(1,:,:);
    for i = 2:m
        for j = 1:n
            for k = 1:3
                irgb(i,j,k) = irgb(i-1,j,k) + s(i,j,k);
            end
        end
    end
end

