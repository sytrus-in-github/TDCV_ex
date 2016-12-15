function [xa, ya, xb, yb] = DrawMatches( I0, It, X0, Xt, num_figure)
figure(1); clf;
imagesc(cat(2, I0, It));

xa = X0(:,1)' ;
xb = Xt(:,1)' + size(I0,2) ;
ya = X0(:,2)' ;
yb = Xt(:,2)' ;

hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 1, 'color', 'b') ;
axis image off;
saveas(gcf, strcat('data/img_sequence/match',sprintf('%04d',num_figure),'.jpg'));
end

