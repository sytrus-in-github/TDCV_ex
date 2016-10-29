% generate an 1D vertical Gaussian filter
% paramters:
%     s   standard deviation of the Gaussian
% output: vG     horizontal Gaussian filter
function vG = vertical_gaussian(s)
    siz = 3*s;
    vG = zeros(siz, 1);
    for i=1:siz
        vG(i,1) = exp(-((i-siz/2)*(i-siz/2))/(2*s*s))/sqrt(2*pi*s*s);
    end
end