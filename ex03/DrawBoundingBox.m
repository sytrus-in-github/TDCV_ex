function out = DrawBoundingBox( scn, xa, ya, num_figure )
    figure(num_figure); clf;
    imagesc(scn) ;
    xmax = max(xa);
    xmin = min(xa);
    ymax = max(ya);
    ymin = min(ya);
    hold on ;
    h1 = line([xmax ; xmax], [ymax ; ymin]) ;
    h2 = line([xmax ; xmax], [ymax ; ymin]) ;
    h3 = line([xmax ; xmax], [ymax ; ymin]) ;
    h4 = line([xmax ; xmax], [ymax ; ymin]) ;
    r = rectangle('Position', [xmin, ymin, xmax-xmin, ymax-ymin], 'EdgeColor', 'g', 'linewidth', 2);
    axis image off;
    out = 0;
end

