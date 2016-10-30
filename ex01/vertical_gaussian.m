% generate an 1D vertical Gaussian filter
% paramters:
%     s   standard deviation of the Gaussian
% output: vG     horizontal Gaussian filter
function vG = vertical_gaussian(s)
    siz = 3*s;
    vG = zeros(siz, 1);
    m = (1+siz)/2;
    for i=1:siz
        vG(i,1) = exp(-((i-m)*(i-m))/(2*s*s));
    end
    s = sum(vG);
    vG = vG/s;
end