function out = DrawSIFT( scn, obj, fs, fo, num_figure)
figure(num_figure); clf;
imagesc(cat(2, scn,obj)) ;
vl_plotframe(fs);
fo(1,:) = fo(1,:) + size(scn, 2);
vl_plotframe(fo);
axis image off;
out = 0;
end

