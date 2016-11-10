%% SIFT extraction and matching
% load image
obj = imread('data/shell.jpg');
% load scene
scn = imread('data/test_shell1.jpg');
% resize image
obj = imresize(obj,size(scn,1)/size(obj,1));
% compute keypoints and descriptors
[fs, ds, fo, do] = ComputeSIFT(scn, obj);
% draw SIFT
DrawSIFT(scn,obj,fs,fo,1);
% compute matches
[matches, scores] = ComputeMatches(ds, do);
% draw matches with outliers
DrawMatches(scn, obj, matches, fs, fo, false, 2);
% draw matches without outliers
[xa, ya, ~, ~] =DrawMatches(scn, obj, matches, fs, fo, true, 3);
% draw bounding box
DrawBoundingBox(scn, xa, ya, 4);
