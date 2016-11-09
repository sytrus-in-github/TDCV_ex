function laplace_res = HarrisLaplaceResponse( harris_res,  s_init, c, n, k)
    laplace_res = [];
    Dx = [-1,1];
    Dy = [-1;1];
    for l=0:n-1
        s = s_init;
        for i=0:k-1
            % get Gaussian derivatives
            Gd = fspecial('gaussian',round(3*c*s),c*s);
            Gx = conv2(Gd,Dx);
            Gy = conv2(Gd,Dy);
            % compute second derivatives
            Lxx = conv2(conv2(harris_res(:,:,l*k+i+1),Gx,'same'),Gx,'same');
            Lyy = conv2(conv2(harris_res(:,:,l*k+i+1),Gy,'same'),Gy,'same');
            laplacian = abs(s*s*(Lxx+Lyy));
            laplace_res = cat(3, laplace_res, laplacian);
        end
    end
end

