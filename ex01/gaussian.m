% generate a 2D Gaussian filter
% paramters:
%     s   standard deviation of the Gaussian
% output: G     Gaussian filter
function G = gaussian(s)
    siz = 3*s;
    G = zeros(siz, siz);
    m = (1+siz)/2;
    for i=1:siz
        for j=1:siz
            G(i,j) = exp(-((i-m)*(i-m)+(j-m)*(j-m))/(2*s*s));
        end
    end
    s = sum(sum(G));
    G = G/s;
end