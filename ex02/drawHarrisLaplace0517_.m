function [] = drawHarrisLaplace0517_(imgpath, s_init, c, k, alpha, thresh_h, thresh_l)
    img = imread(imgpath);
    s = size(img);
    ss = size(s);
    if ss(2)==3 && s(3)==3
        dimg = double(rgb2gray(img));
    else
        img = img(:,:,1);
        dimg = double(img);
    end
    figure('Name',strcat(imgpath,' - HarrisLaplace'));
    imshow(uint8(img));
    hold on;
    pts = HarrisLaplace0517_(dimg, s_init, c, k, alpha, thresh_h, thresh_l);
    [xx, yy, ~] = size(pts);
    lst = [0,5,17];
    for z = 1:3
        sig = s_init*(k^lst(z));
        for y = 1:yy
            for x = 1:xx
                if pts(x,y,z) ~= 0
                    plot(y,x,'ro','MarkerSize',3*sig);
                end
            end
        end
    end
end