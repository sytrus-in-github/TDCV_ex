function  dist = probMap(img, bin)
    % get hue value for the image patch
    hsv_img = rgb2hsv(img); % float value between 0..1 
    h_img = hsv_img(:,:,1);
    % fill in the proba distribution
    b = ceil(h_img * 256);
    b(b==0) = 1;
    dist = bin(b);
    % normalize the proba distribution to max = 255
    mx = max(dist(:));
    dist = dist * 255. / mx;
end