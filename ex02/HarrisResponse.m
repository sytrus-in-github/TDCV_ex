% return response matrix of the Harris detector 
function out = HarrisResponse(img, sig_d, sig_i, alpha)
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
    Mxx = sig_d*sig_d*conv2(Ixx,Gi,'same');
    Mxy = sig_d*sig_d*conv2(Ixy,Gi,'same');
    Myy = sig_d*sig_d*conv2(Iyy,Gi,'same');
    % calculate output response
    out = (Mxx.*Myy-Mxy.^2) - alpha*(Mxx+Myy).^2;
end