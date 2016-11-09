function pts = multiscaleHarris_(img, sigma0, c, n, k, alpha, t_h)
    s = sigma0;
    resl = [];
    % get all response matrices and laplacians
    for i = 0:n-1
        res = HarrisResponse(img, c*s, s, alpha);
        resl = cat(3,resl,res);
        s = s*k;
    end
    % filtering to get points
    pts = resl>=t_h;
    shift = [resl(:,2:end,:),resl(:,end,:)];
    pts = pts & (resl>=shift);
    shift = [resl(:,1,:),resl(:,1:end-1,:)];
    pts = pts & (resl>=shift);
    shift_u = [resl(2:end,:,:);resl(end,:,:)];
    pts = pts & (resl>=shift_u);
    shift_d = [resl(1,:,:);resl(1:end-1,:,:)];
    pts = pts & (resl>=shift_d);
    shift = [shift_u(:,2:end,:),shift_u(:,end,:)];
    pts = pts & (resl>=shift);
    shift = [shift_u(:,1,:),shift_u(:,1:end-1,:)];
    pts = pts & (resl>=shift);
    shift = [shift_d(:,2:end,:),shift_d(:,end,:)];
    pts = pts & (resl>=shift);
    shift = [shift_d(:,1,:),shift_d(:,1:end-1,:)];
    pts = pts & (resl>=shift);
end