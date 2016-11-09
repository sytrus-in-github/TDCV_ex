function [] = drawMultiscaleHarris_(imgpath, s_init, c, n, k, alpha, thresh_h)
    img = imread(imgpath);
    s = size(img);
    ss = size(s);
    if ss(2)==3 && s(3)==3
        dimg = double(rgb2gray(img));
    else
        img = img(:,:,1);
        dimg = double(img);
    end
    figure('Name',strcat(imgpath,' - MSHarris'));
    imshow(uint8(img));
    hold on;
    pts = multiscaleHarris_(dimg, s_init, c, n, k, alpha, thresh_h);
    [xx, yy, zz] = size(pts);
    for z = 0:zz-1
        sig = s_init*(k^z);
        for y = 1:yy
            for x = 1:xx
                if pts(x,y,z+1) ~= 0
                    plot(y,x,'ro','MarkerSize',3*sig);
                end
            end
        end
    end
end