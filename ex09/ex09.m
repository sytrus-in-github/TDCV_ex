templateFileName = 'data/seq/im000.pgm';
TemplatePos = [220, 200];
TemplateSize = 100;
NumOfGridPoints = 400;
UpdateRangeSerie = [30,27,24,21,18,15,12,9,6,3];
update_repeat = 5;
NumOfIterations = 500;

rootdir = 'data/seq/';
outputdir = 'data/output/';
imgseq = dir(rootdir);
imgfiles = cell(length(imgseq)-3,1);
for i=1:length(imgseq)-3
    imgfiles{i} = imgseq(i+3).name;
end
% imgfiles

tracker = HyperplaneTemplateMatchingTracker(templateFileName, TemplatePos, ...
    TemplateSize, NumOfGridPoints, UpdateRangeSerie, update_repeat, NumOfIterations);
trackedParams = tracker.trackImgSeq(rootdir, imgfiles, 1);
%trackedParams
tracker.visualizeTracking(rootdir, outputdir, imgfiles, trackedParams);

% InputImage = imread('data/seq/im000.pgm');
% UpdateRange = 30;
% ParameterVector = zeros(1,8);
% ParameterVector(1) = TemplatePos(1);
% ParameterVector(2) = TemplatePos(2);
% ParameterVector(3) = TemplatePos(1) + TemplateSize;
% ParameterVector(4) = TemplatePos(2);
% ParameterVector(5) = TemplatePos(1);
% ParameterVector(6) = TemplatePos(2) + TemplateSize;
% ParameterVector(7) = TemplatePos(1) + TemplateSize;
% ParameterVector(8) = TemplatePos(2) + TemplateSize;
% RandomWarpingIntensity( InputImage, ParameterVector, NumOfGridPoints, UpdateRange );
% tic;
% HyperplaneMatrix = ComputeHyperplaneMatrix( InputImage, ParameterVector, ...
%     NumOfGridPoints, UpdateRange, NumOfIterations );
% toc;

% UpdateRangeSerie = [30,27,24,21,18,15,12,9,6,3];
% UpdateMatrixSerie = zeros(8, NumOfGridPoints, length(UpdateRangeSerie));
% tic;
% for i = 1:length(UpdateRangeSerie)
%     UpdateMatrixSerie(:,:,i) = ComputeHyperplaneMatrix( InputImage, ...
%     ParameterVector, NumOfGridPoints, UpdateRangeSerie(i), NumOfIterations );
% end
% toc;

