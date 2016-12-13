function [fa, da] = ComputeSIFT(imga)
    simg = im2single(rgb2gray(imga));
    [fa, da] = vl_sift(simg);
end

