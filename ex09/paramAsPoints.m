function pointMat = paramAsPoints(parameters)
% transform parameters to suitable format
   pointMat = [parameters(1:2:end)',parameters(2:2:end)'];
end