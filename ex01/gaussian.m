% generate a 2D Gaussian filter
% paramters:
%     s   standard deviation of the Gaussian
% output: G     Gaussian filter
function G = gaussian(s)
    siz = 3*s;
    G = zeros(siz, siz);
    for i=1:siz
        for j=1:siz
            G(i,j) = exp(-((i-siz/2)*(i-siz/2)+(j-siz/2)*(j-siz/2))/(2*s*s))/(2*pi*s*s);
        end
    end
end