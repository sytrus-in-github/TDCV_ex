% apply clamp padding to an image
% parameters:
%   I   input image
%   x   up/down border size
%   y   left/right border size
% output:   J     padded image
function J = pad_clamp(I,x,y)
    J = [I(1,1) * ones(x,y), ones(x,1) * I(1,:), I(1,end) * ones(x,y);...
        I(:,1) * ones(1,y), I, I(:,end) * ones(1,y);...
        I(end,1) * ones(x,y), ones(x,1) * I(end,:), I(end,end) * ones(x,y)];
end