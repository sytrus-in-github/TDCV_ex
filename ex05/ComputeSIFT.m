function [ fa, da, fb, db ] = ComputeSIFT( imga, imgb )
    A = im2single(imga);
    B = im2single(imgb);
    [fa, da] = vl_sift(A, 'PeakThresh', 0.005);
    [fb, db] = vl_sift(B, 'PeakThresh', 0.005);
%     [fa, da] = vl_sift(A);
%     [fb, db] = vl_sift(B);
end

