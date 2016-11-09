% return corners (as boolean matrix) by Harris detector given the response matrix 
function out = HarrisPoints(res, thresh)
%     % normalize maximum value to 1 if requested
%     if normalize
%         res = res/max(max(res));
%     end
    % get threshold mask
    mask_t = res>thresh;
    % get local maximum masks
    shift_l = [res(:,2:end),res(:,end)];
    shift_r = [res(:,1),res(:,1:end-1)];
    shift_u = [res(2:end,:);res(end,:)];
    shift_d = [res(1,:);res(1:end-1,:)];
    shift_ul = [shift_u(:,2:end),shift_u(:,end)];
    shift_ur = [shift_u(:,1),shift_u(:,1:end-1)];
    shift_dl = [shift_d(:,2:end),shift_d(:,end)];
    shift_dr = [shift_d(:,1),shift_d(:,1:end-1)];
    mask_l = res>=shift_l;
    mask_r = res>=shift_r;
    mask_u = res>=shift_u;
    mask_d = res>=shift_d;
    mask_ul = res>=shift_ul;
    mask_ur = res>=shift_ur;
    mask_dl = res>=shift_dl;
    mask_dr = res>=shift_dr;
    % get global mask for harris points
    out = mask_t & mask_l & mask_r & ...
        mask_u & mask_d & mask_ul & ...
        mask_ur & mask_dl & mask_dr;
end