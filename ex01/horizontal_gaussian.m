% generate an 1D horizontal Gaussian filter
% paramters:
%     s   standard deviation of the Gaussian
% output: hG     horizontal Gaussian filter
function hG = horizontal_gaussian(s)
    siz = 3*s;
    hG = zeros(1, siz);
    for j=1:siz
        hG(1,j) = exp(-((j-siz/2)*(j-siz/2))/(2*s*s))/sqrt(2*pi*s*s);
    end
end