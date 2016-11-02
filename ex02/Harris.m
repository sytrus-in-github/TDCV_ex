% return corners (as boolean matrix) by Harris detector 
function out = Harris(img, sig_d, sig_i, alpha, thres)
    % get Gaussian derivatives
    Dx = [-1,1];
    Dy = [-1;1];
    Gd = gaussian(sig_d);
    Gx = conv2(Gd,Dx);
    Gy = conv2(Gd,Dy);
    % apply derivatives on input image
    Ix = conv2(img,Gx,'same');
    Iy = conv2(img,Gy,'same');
    % calculate compoments of matrix M
    Ixx = Ix.^2;
    Ixy = Ix.*Iy;
    Iyy = Iy.^2;
    Gi = gaussian(sig_i);
    Mxx = conv2(Ixx,Gi,'same');
    Mxy = conv2(Ixy,Gi,'same');
    Myy = conv2(Iyy,Gi,'same');
    % calculate output response
    out = (Mxx.*Myy-Mxy.^2) - alpha*(Mxx+Myy).^2;
    % normalize maximum value to 1
    out = out/max(max(out));
    % get threshold mask
    mask_t = out>thres;
    % get local maximum masks
    shift_l = [out(:,2:end),out(:,end)];
    shift_r = [out(:,1),out(:,1:end-1)];
    shift_u = [out(2:end,:);out(end,:)];
    shift_d = [out(1,:);out(1:end-1,:)];
    shift_ul = [shift_u(:,2:end),shift_u(:,end)];
    shift_ur = [shift_u(:,1),shift_u(:,1:end-1)];
    shift_dl = [shift_d(:,2:end),shift_d(:,end)];
    shift_dr = [shift_d(:,1),shift_d(:,1:end-1)];
    mask_l = out>=shift_l;
    mask_r = out>=shift_r;
    mask_u = out>=shift_u;
    mask_d = out>=shift_d;
    mask_ul = out>=shift_ul;
    mask_ur = out>=shift_ur;
    mask_dl = out>=shift_dl;
    mask_dr = out>=shift_dr;
    %get global mask for harris points
    out = mask_t & mask_l & mask_r & ...
        mask_u & mask_d & mask_ul & ...
        mask_ur & mask_dl & mask_dr;
end