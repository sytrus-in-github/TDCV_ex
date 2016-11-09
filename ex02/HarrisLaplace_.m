function pts = HarrisLaplace_(img, sigma0, c, n, k, alpha, t_h, t_l)
    s = sigma0;
    resl = [];
    lapl = [];
    % get all response matrices and laplacians
    for i = 0:n-1
        [lap,res] = HarrisResponse_(img, c*s, s, alpha);
        resl = cat(3,resl,res);
        lapl = cat(3,lapl,lap);
        s = s*k;
    end
    % filtering to get points
    % - in each scale
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
    % - multiscale
    pts = pts & (lapl>=t_l);
    shift = cat(3,lapl(:,:,2:end),lapl(:,:,end));
    pts = pts & (lapl>=shift);
    shift = cat(3,lapl(:,:,1),lapl(:,:,1:end-1));
    pts = pts & (lapl>=shift);
%     % debug draw response, laplace
%     mx = max(max(max(resl)))
%     mn = min(min(min(resl)))
%     resl = (resl-mn)/(mx-mn);
%     mx = max(max(max(lapl)))
%     mn = min(min(min(lapl)))
%     lapl = (lapl-mn)/(mx-mn);
%     for i = 1:n
%         figure;imshow(uint8(resl(:,:,i)*255));
%     end
%     for i = 1:n
%         figure;imshow(uint8(lapl(:,:,i)*255));
%     end
end
