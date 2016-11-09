function out = HarrisLaplace(img, pts, sigma0, n, k, thres)
    Dxx = [1,-2,1];
    Dyy = [1;-2;1];
    laplacians = [];
    % get all laplacians
    for l=0:n-1
        for i=0:k-1
            s = sigma0*(2^l)*power(2,(i/k));
            % get Gaussian derivatives
            Gd = gaussian(s);
            Gxx = conv2(Gd,Dxx);
            Gyy = conv2(Gd,Dyy);
            % compute second derivatives
            Lxx = conv2(img, Gxx,'same');
            Lyy = conv2(img, Gyy,'same');
            laplacians = cat(3, laplacians, abs(s*s*(Lxx+Lyy)));
        end
    end
    % filter points with respect to laplacian
    shift_u = cat(3,laplacians(:,:,2:end),laplacians(:,:,end));
    shift_d = cat(3,laplacians(:,:,1),laplacians(:,:,1:end-1));
    mask_u = laplacians>=shift_u;
    mask_d = laplacians>=shift_d;
    mask_t = laplacians>=thres;
    out = pts.*mask_u.*mask_d.*mask_t;
end