function [] = drawHarris(imgpath, sig_d, sig_i, alpha, threshold, showsigma)
    img = imread(imgpath);
    s = size(img);
    ss = size(s);
    if ss(2)==3 && s(3)==3
        dimg = double(rgb2gray(img));
    else
        img = img(:,:,1);
        dimg = double(img);
    end
    figure('Name',strcat(imgpath,' - Harris'));
    imshow(uint8(img));
    hold on;
    pts = Harris(dimg, sig_d, sig_i, alpha, threshold);
    [xx, yy] = size(pts);
    for y = 1:yy
        for x = 1:xx
            if pts(x,y) ~= 0
                if showsigma
                    plot(y,x,'ro','MarkerSize',3*sig_i);
                else
                    plot(y,x,'ro')
                end
            end
        end
    end
end