function GridPoints = ParamToGrid( ParameterVector, NumOfGridPoints )
% Given a parameter vector and a number of grid points, returns a list of
% grid points. A parameter vector is given by the successive coordinates of
% its top-left corner, its bottom-left corner, its top-right corner and its
% bottom-right corner. NumOfGridPoints should be a square number.

GridSize = floor(sqrt(NumOfGridPoints));
GridPoints = zeros(GridSize*GridSize, 2);
xtl = ParameterVector(1);
ytl = ParameterVector(2);
xbl = ParameterVector(3);
ybl = ParameterVector(4);
xtr = ParameterVector(5);
ytr = ParameterVector(6);
xbr = ParameterVector(7);
ybr = ParameterVector(8);

for i = 1:GridSize
    for j = 1:GridSize
        GridPoints(j+GridSize*(i-1), :) = round(1/(GridSize*GridSize)*(...
            (GridSize+1-i) * (GridSize+1-j) * [xtl,ytl]...
            + (GridSize+1-i) * (j-1) * [xtr,ytr] ...
            + (i-1) * (GridSize+1-j) * [xbl,ybl] ...
            + (i-1) * (j-1) * [xbr,ybr]));
    end
end

end

