function [ fs, ds, fo, do ] = ComputeSIFT( scn, obj )
    O = im2single(rgb2gray(obj));
    S = im2single(rgb2gray(scn));
    [fo, do] = vl_sift(O, 'PeakThresh', 0.005);
    [fs, ds] = vl_sift(S, 'PeakThresh', 0.005);
end

