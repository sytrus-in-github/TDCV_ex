function [WarpingDisplacement, Intensity] = RandomWarpingIntensity( InputImage, ParameterVector, NumOfGridPoints, UpdateRange )
% Randomly warps the template with small transformations and compute the
% normalized intensity vector with random noise.
    WarpingDisplacement = round(unifrnd(-UpdateRange,UpdateRange,1,8));
    WarpedParameterVector = ParameterVector + WarpingDisplacement;
    OriginalGridPoints = ParamToGrid(ParameterVector, NumOfGridPoints);
%     OriginalRectangle = [ParameterVector(1:2:8)',ParameterVector(2:2:8)'];
%     WarpedRectangle = [WarpedParameterVector(1:2:8)',WarpedParameterVector(2:2:8)'];
%     BackWarp = estimateGeometricTransform(WarpedRectangle,OriginalRectangle,'projective');
    BackWarp = getHomography(WarpedParameterVector, ParameterVector);
%     BackWarpedGridPoints = round(transformPointsForward(BackWarp,OriginalGridPoints));
    BackWarpedGridPoints = applyHomography2Grid(BackWarp, OriginalGridPoints);
    Intensity = zeros(length(BackWarpedGridPoints),1);
    [Height, Width] = size(InputImage);
    for i = 1:length(Intensity)
        if(BackWarpedGridPoints(i,1) <= 0 || BackWarpedGridPoints(i,2) <=0 ...
                || BackWarpedGridPoints(i,1) > Height || BackWarpedGridPoints(i,2) > Width)
            Intensity(i,1) = 0;
        else
            Intensity(i,1) = InputImage(BackWarpedGridPoints(i,1),BackWarpedGridPoints(i,2));
        end
    end
%    originalIntensity = WarpingIntensity(InputImage, ParameterVector, NumOfGridPoints);
%    warpedIntensity = WarpingIntensity(InputImage, WarpedParameterVector, NumOfGridPoints);
%    Intensity = warpedIntensity - originalIntensity;
    Mean = mean(Intensity);
    Var = var(Intensity);
    Intensity = (Intensity - Mean * ones(size(Intensity)))/Var;
    Noise = wgn(length(Intensity),1,0)/100;
    Intensity = Intensity + Noise;
end

