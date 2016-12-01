function [ fa, da, fb, db ] = ComputeSIFT( imga, imgb )
    A = im2single(rgb2gray(imga));
    B = im2single(rgb2gray(imgb));
    [fa, da] = vl_sift(A, 'PeakThresh', 0.005);
    [fb, db] = vl_sift(B, 'PeakThresh', 0.005);
end

