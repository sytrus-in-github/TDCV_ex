% apply convolution to an image
% parameters:
%   img           input image
%   K           convolution kernel
%   pad_mode    padding method: 0.zero 1.clamp 2.mirror
% output:   J     convoluted image
function J = convolution(img,K,pad_mode)
    % check if pad_mode is valid
    if ~(ismember(pad_mode,[0,1,2,'zero','clamp','mirror']))   
        error('pad_mod should be either [zero], [clamp] or [mirror] (or a value in 0..2)')
    end
    % get matrices sizes, and border sizes for padding
    s = size(K);
    Kx = s(1);
    Ky = s(2);
    px = floor(Kx/2);
    py = floor(Ky/2);
    s = size(img);
    Ix = s(1);
    Iy = s(2);
    % perform padding
    switch(pad_mode)
        case {0, 'zero'}
            I = [zeros(px,2*py+Iy);zeros(Ix,py),img,zeros(Ix,py);zeros(px,2*py+Iy)];
        case {1, 'clamp'}
            I = pad_clamp(img,px,py);
        case {2, 'mirror'}
            I = pad_mirror(img,px,py);
    end
    % if kernel even sized, then expand it by adding zeros
    if mod(Kx,2) == 0
       K(end+1,1) = 0;
    end
    if mod(Ky,2) == 0
       K(1,end+1) = 0;
    end
    % flip kernel
    K = flip(flip(K,1),2);
    % perform convolution
    J = zeros(Ix,Iy);
    for i=1:Ix
        for j=1:Iy
            J(i,j) = sum(reshape((I(i:i+2*px,j:j+2*py).*K),[],1));
        end
    end
end