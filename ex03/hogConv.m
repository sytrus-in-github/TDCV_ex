function [v,x,y]=hogConv(hogscn, obj, c_scn, c)
    % do the convolution calculation
    obj = im2single(rgb2gray(obj));
    W = vl_hog(obj, c);
    fm = vl_nnconv(hogscn,W,[]);
    % get maximum value and its coordinate
    [M,I] = max(fm);
    [v,iy] = max(M);
    ix = I(iy);
    [wy,wx,~] = size(W);
    v = v/wx/wy;
    x = round((wx/2+ix-1)*c_scn);
    y = round((wy/2+iy-1)*c_scn);
end