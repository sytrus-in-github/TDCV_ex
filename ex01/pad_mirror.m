% apply mirror padding to an image
% parameters:
%   I   input image
%   x   up/down border size
%   y   left/right border size
% output:   J     padded image
function J = pad_mirror(I,x,y)
    % get size of input image
    s = size(I);
    Ix = s(1);
    Iy = s(2);
    % if padding border exceed input image size, recursively build up image
    if x>Ix
        J = pad_mirror([I(end:-1:1, :); I; I(end:-1:1, :)],x-Ix,y);
        return
    end
    if y>Iy
        J = pad_mirror([I(:, end:-1:1), I, I(:, end:-1:1)],x,y-Iy);
        return
    end
    % add mirrored border
    J = [I(x:-1:1,y:-1:1), I(x:-1:1,:), I(x:-1:1,end:-1:end-y+1);...
        I(:,y:-1:1), I, I(:,end:-1:end-y+1);...
        I(end:-1:end-x+1,y:-1:1), I(end:-1:end-x+1,:), I(end:-1:end-x+1,end:-1:end-y+1)];
end