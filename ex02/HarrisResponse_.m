% return response matrix of the Harris detector 
function [lap, res] = HarrisResponse_(img, sig_d, sig_i, alpha)
    % get Gaussian derivatives
    Dx = [-1,1];
    Dy = [-1;1];
    Gd = fspecial('gaussian',round(3*sig_d),sig_d);
    Gi = fspecial('gaussian',round(3*sig_i),sig_i);
    Gx = conv2(Gd,Dx);
    Gy = conv2(Gd,Dy);
    % apply derivatives on input image
    Ix = conv2(img,Gx,'same');
    Iy = conv2(img,Gy,'same');
    % calculate compoments of matrix M
    Ixx = Ix.^2;
    Ixy = Ix.*Iy;
    Iyy = Iy.^2;
    Mxx = sig_d^2*conv2(Ixx,Gi,'same');
    Mxy = sig_d^2*conv2(Ixy,Gi,'same');
    Myy = sig_d^2*conv2(Iyy,Gi,'same');
    % calculate output response
    res = (Mxx.*Myy-Mxy.^2) - alpha*(Mxx+Myy).^2;
    % calculate normalized laplacian
    Gxx = conv2(Gx,Dx);
    Gyy = conv2(Gy,Dy);
    lap = sig_d^2*abs(conv2(img,Gxx,'same')+conv2(img,Gyy,'same'));
end