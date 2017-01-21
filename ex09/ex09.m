ParameterVector = [1,1,100,1,1,100,100,100];
ParameterVector = ParameterVector + 5000*ones(1,8);
InputImage = zeros(10000);
NumOfGridPoints = 400;
UpdateRange = 30;

Intensity = RandomWarpingIntensity( InputImage, ParameterVector, NumOfGridPoints, UpdateRange );