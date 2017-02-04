function [dir, mask] = getGradientOrientation(image, threshold)
    [Gm1,Gd1] = imgradient(image(:,:,1));
    [Gm2,Gd2] = imgradient(image(:,:,2));
    [Gm3,Gd3] = imgradient(image(:,:,3));
    mask = Gm1 > Gm2;
    Gm = Gm1 .* mask + Gm2 .* (1-mask);
    dir = Gd1 .* mask + Gd2 .* (1-mask);
    mask = Gm > Gm3;
    Gm = Gm .* mask + Gm3 .* (1-mask);
    dir = dir .* mask + Gd3 .* (1-mask);
    mask = Gm > threshold;
    dir = dir * pi / 180.;
end