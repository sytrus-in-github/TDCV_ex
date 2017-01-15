function out = PlotData( dataPoints, labels, numFigure )
%PLOTDATA Summary of this function goes here
%   Detailed explanation goes here
    figure(numFigure);
    colors = zeros(length(labels), 3);
    for i = 1:length(labels)
        if (labels(i) < 0)
            colors(i,3) = 1;
        else
            colors(i,1) = 1;
        end
    end
    scatter(dataPoints(:,1),dataPoints(:,2),[],colors, '+');
    out = 0;
end

