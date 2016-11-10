function [xa,ya,xb,yb] = DrawMatches( scn, obj, matches, fs, fo, without_outliers, num_figure)
figure(num_figure); clf;
imagesc(cat(2, scn,obj));

xa = fs(1,matches(2,:)) ;
xb = fo(1,matches(1,:)) + size(scn,2) ;
ya = fs(2,matches(2,:)) ;
yb = fo(2,matches(1,:)) ;

if(without_outliers)
    [~, ina, inb] = estimateGeometricTransform([xa;ya]', [xb;yb]', 'affine');
    xa = ina(:,1)';
    ya = ina(:,2)';
    xb = inb(:,1)';
    yb = inb(:,2)';
end

hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 1, 'color', 'b') ;

axis image off;
end

