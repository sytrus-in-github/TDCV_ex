function bin = colorHist(img)
    hsv_img = rgb2hsv(img); % float value between 0..1 
    h_img = hsv_img(:,:,1);
    bin = zeros(256,1);
    for i=1:length(h_img(:))
        b = ceil(h_img(i) * 256);
        if b==0 
            b = 1; 
        end
        bin(b) = bin(b) + 1;
    end
end