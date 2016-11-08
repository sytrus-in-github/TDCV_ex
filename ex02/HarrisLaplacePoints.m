function pts = HarrisLaplacePoints( laplace_res, harris_pts , thresh_l )
    [m,n,k] = size(laplace_res);
    pts = harris_pts;
    for i=1:k
        for u=1:m
            for v=1:n
                if pts(u,v,i)==1
                    if not(laplace_res(u,v,i) > thresh_l ...
                            && (i==k || laplace_res(u,v,i)>laplace_res(u,v,i+1)) ...
                            && (i==1 || laplace_res(u,v,i)>laplace_res(u,v,i-1)))
                      pts(u,v,i) = 0;  
                    end
                end
            end
        end
    end
end

