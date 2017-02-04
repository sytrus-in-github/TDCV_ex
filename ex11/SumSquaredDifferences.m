function ssd = SumSquaredDifferences( image, template, x, y)
%     ssd = 0;
    [h, w] = size(template);
%     for i = 1:h
%         for j = 1:w
%             diff = template(i, j) - image(i + x - 1, j + y - 1);
%             ssd = ssd + diff*diff;
%         end
%     end
%     ssd = ssd / (h*w);
    ssd = template - image(x : x+h-1, y : y+w-1);
    ssd = ssd .^ 2;
    ssd = 1 - sum(ssd(:)) / (h*w);
end
