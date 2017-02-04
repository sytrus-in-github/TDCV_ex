function ssd = SumSquaredDifferences( image, template, x, y, mask)
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
    if nargin == 5
        ssd = ssd(mask);
        support = sum(mask(:));
    else
        support = h * w;
    end
    ssd = ssd .^ 2;
    ssd = sum(ssd(:)) / support;
end
