InputImage = imread('seq/im000.pgm');
TemplatePos = [220, 200];
TemplateSize = 100;
NumOfGridPoints = 400;
UpdateRange = 30;
NumOfIterations = 500;
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
tic;
HyperplaneMatrix = ComputeHyperplaneMatrix( InputImage, TemplatePos, ...
 TemplateSize, NumOfGridPoints, UpdateRange, NumOfIterations );
toc;

% UpdateRangeSerie = [30,27,24,21,18,15,12,9,6,3];
% UpdateMatrixSerie = zeros(8, NumOfGridPoints, length(UpdateRangeSerie));
% tic;
% for i = 1:length(UpdateRangeSerie)
%     UpdateMatrixSerie(:,:,i) = ComputeHyperplaneMatrix( InputImage, TemplatePos, ...
%  TemplateSize, NumOfGridPoints, UpdateRangeSerie(i), NumOfIterations );
% end
% toc;

