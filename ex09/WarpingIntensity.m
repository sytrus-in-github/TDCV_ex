function Intensity = WarpingIntensity( InputImage, ParameterVector, NumOfGridPoints )
% Given a parameter vector, a number of grid points and an image returns 
% the normalized intensity vector.
GridPoints = ParamToGrid(ParameterVector, NumOfGridPoints);
Intensity = zeros(length(GridPoints),1);
for i = 1:length(Intensity)
    Intensity(i,1) = InputImage(GridPoints(i,1),GridPoints(i,2));
end
Mean = mean(Intensity);
Var = var(Intensity);
Intensity = (Intensity - Mean * ones(size(Intensity)))/Var;
end