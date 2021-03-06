% return corners (as boolean matrix) by Harris detector 
% normalize is a boolean value which determine if the response function
% will be normalized for the thresholding (so tha tthe max. value is 1)
function out = Harris(img, sig_d, sig_i, alpha, thresh)
    out = HarrisResponse(img, sig_d, sig_i, alpha);
    out = HarrisPoints(out,thresh);
end