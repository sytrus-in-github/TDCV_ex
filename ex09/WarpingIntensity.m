function Intensity = WarpingIntensity( InputImage, ParameterVector, NumOfGridPoints )
% Given a parameter vector, a number of grid points and an image returns 
% the normalized intensity vector.
    GridPoints = ParamToGrid(ParameterVector, NumOfGridPoints);
    Intensity = zeros(length(GridPoints),1);
    for i = 1:length(Intensity)
%         disp([GridPoints(i,1),GridPoints(i,2)])
        try
        Intensity(i,1) = InputImage(GridPoints(i,1),GridPoints(i,2));
        catch ME
           disp([GridPoints(i,1),GridPoints(i,2)])
           rethrow(ME);
        end
    end
    Mean = mean(Intensity);
    Var = var(Intensity);
    Intensity = (Intensity - Mean * ones(size(Intensity)))/Var;
end