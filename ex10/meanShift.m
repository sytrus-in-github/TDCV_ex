function [ xReg, yReg ] = meanShift( img, xReg, yReg, hReg, wReg, bin )
    % compute the new coordinates of the tracked region
    dist = probMap(img(xReg:xReg+hReg, yReg:yReg+wReg,:), bin);
    
    xc = xReg+(hReg+1)/2;
    yc = yReg+(wReg+1)/2;
    oldXc = xReg+(hReg+1)/2;
    oldYc = yReg+(wReg+1)/2;
    it = 0;
    while(it == 0 || (it < 20 && (abs(oldXc-xc)+abs(oldYc-yc) > 2))) 
        it = it + 1;
        oldXc = xc;
        oldYc = yc;
        xc = 0;
        yc = 0;
        n = 0;
        for dx = 1:hReg
            for dy  = 1:wReg
                xc = xc + (xReg+dx)*dist(dx,dy);
                yc = yc + (yReg+dy)*dist(dx,dy);
                n = n + dist(dx,dy);
            end
        end
        xc = xc/n;
        yc = yc/n;
        xReg = round(xc - (hReg+1)/2);
        yReg = round(yc - (wReg+1)/2);
        dist = probMap(img(xReg:xReg+hReg, yReg:yReg+wReg,:), bin);
    end
end

