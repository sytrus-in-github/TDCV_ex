function [dir, mask] = getGrayscaleGradientOrientation(image, threshold)
    [Gm, dir] = imgradient(rgb2gray(image));
    mask = Gm > threshold;
    dir = dir * pi / 180.;
end