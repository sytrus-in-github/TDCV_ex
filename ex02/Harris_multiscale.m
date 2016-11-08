% return corners (as boolean matrix) by Harris detector for each scale
function [res,pts] = Harris_multiscale(img, s_init, c, alpha, thresh, n, k)
    % get the original size of the image
    sz = size(img);
    pts = [];
    res = [];
    % get all response maps and points
    for l=1:n
        s = s_init;
        for i=0:k-1
            r = HarrisResponse(img, c * s, s, alpha);
            r = imresize(r, sz);
            res = cat(3, res, r);
            p = HarrisPoints(r, thresh, false);
            pts = cat(3, pts, p);
            s = s_init * power(2,(i/k));
        end
        img = imresize(img, 0.5);
    end
    % debug show res
%     mx = max(max(max(res)));
%     mn = min(min(min(res)));
%     res = (res-mn)/(mx-mn);
%     s = size(res);
%     for i = 1:s(3)
%        figure('name',strcat('R_',num2str(i)));imshow(res(:,:,i).*pts(:,:,i)); 
%        figure('name',strcat('P_',num2str(i)));imshow(imdilate(pts(:,:,i),[1,1,1;1,0,1;1,1,1])); 
%     end
end