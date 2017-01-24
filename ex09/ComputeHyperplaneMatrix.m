function HyperplaneMatrix = ComputeHyperplaneMatrix( InputImage, TemplatePos, TemplateSize, NumOfGridPoints, UpdateRange, NumOfIterations )
%COMPUTEHYPERPLANEMATRIX Summary of this function goes here
%   Detailed explanation goes here
    NumOfGridPoints = round(sqrt(NumOfGridPoints))*round(sqrt(NumOfGridPoints));
    if(NumOfIterations < NumOfGridPoints)
        NumOfIterations = NumOfGridPoints;
    end
        
    ParameterVector = zeros(1,8);
    ParameterVector(1) = TemplatePos(1);
    ParameterVector(2) = TemplatePos(2);
    ParameterVector(3) = TemplatePos(1) + TemplateSize;
    ParameterVector(4) = TemplatePos(2);
    ParameterVector(5) = TemplatePos(1);
    ParameterVector(6) = TemplatePos(2) + TemplateSize;
    ParameterVector(7) = TemplatePos(1) + TemplateSize;
    ParameterVector(8) = TemplatePos(2) + TemplateSize;
    
    OriginalIntensity = WarpingIntensity( InputImage, ParameterVector, NumOfGridPoints);
    
    IntensityMatrix = zeros(NumOfGridPoints, NumOfIterations);
    ParameterMatrix = zeros(8, NumOfIterations);
    
    for i = 1:NumOfIterations
        [WarpingDisplacement, WarpedIntensity] = RandomWarpingIntensity( InputImage, ParameterVector, NumOfGridPoints, UpdateRange );
        ParameterMatrix(1:8,i) = WarpingDisplacement(1,1:8)';
        IntensityMatrix(1:NumOfGridPoints,i) = WarpedIntensity(1:NumOfGridPoints,1) - OriginalIntensity(1:NumOfGridPoints,1);
    end
    
    HyperplaneMatrix = ParameterMatrix*IntensityMatrix'/(IntensityMatrix*IntensityMatrix');
end

