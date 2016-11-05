% return corners (as boolean matrix) by Harris detector for each scale 
% function [pts,res] = Harris_multiscale(img, sigma, alpha, thres, n, k)
%     % get the number of steps s for each scale level
%     s = 1;
%     c = k;
%     while c<2
%        s = s + 1;
%        c = c * k;
%     end
%     % get the original size of the image
%     sz = size(img);
%     % out = Harris(img, sigma, sigma, alpha, thres);
%     res = [];
%     pts = [];
%     for i=0:n-1
%         imscale(img,0.5^i);
%         for j = 0:s-1
%             res = cat(3,res,HarrisResponse(img, sigma*k^j, sigma, alpha));
%             pts = cat(3,pts,HarrisPoints(res,thres,true));
%         end
%     end
% end

% return corners (as boolean matrix) by Harris detector for each scale
function pts = Harris_multiscale(img, s, alpha, thres, n, k, c)
    sigma = s;
    res = [];
    pts = [];
    for i=1:n
        sigma = sigma * k;
        res = cat(3, res, HarrisResponse(img, c * sigma, sigma, alpha));
        pts = cat(3, pts, HarrisPoints(res(:,:,i), thres, true));
    end
end