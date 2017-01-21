function Intensity = RandomWarpingIntensity( InputImage, ParameterVector, NumOfGridPoints, UpdateRange )
% Randomly warps the template with small transformations and compute the
% normalized intensity vector with random noise.
RandomUpdates = round(unifrnd(-UpdateRange,UpdateRange,8,1));
WarpedParameterVector = ParameterVector + RandomUpdates;

OriginalGridPoints = ParamToGrid(ParameterVector, NumOfGridPoints);
OriginalRectangle = [ParameterVector(1:2:8)',ParameterVector(2:2:8)'];

WarpedRectangle = [WarpedParameterVector(1:2:8)',WarpedParameterVector(2:2:8)'];
BackWarp = estimateGeometricTransform(WarpedRectangle,OriginalRectangle,'projective');
BackWarpedGridPoints = round(transformPointsForward(BackWarp,OriginalGridPoints));
disp(BackWarp.T);
Intensity = zeros(length(BackWarpedGridPoints),1);
for i = 1:length(Intensity)
    disp([OriginalGridPoints(i,1),OriginalGridPoints(i,2),BackWarpedGridPoints(i,1),BackWarpedGridPoints(i,2)]);
    Intensity(i,1) = InputImage(BackWarpedGridPoints(i,1),BackWarpedGridPoints(i,2));
end
Mean = mean(Intensity);
Var = var(Intensity);
Intensity = (Intensity - Mean * ones(size(Intensity)))/Var;

Noise = unifrnd(0,1,length(Intensity),1);
Intensity = Intensity + Noise;
end

