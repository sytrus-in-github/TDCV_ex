function ncc = NormalizedCrossCorrelation( image, template, x, y )
    sqNormT = 0; % we choose to compute the norm of the template each time
    sqNormI = 0;
    cc = 0;
    [h, w] = size(template);
    for i = 1:h
        for j = 1:w
            sqNormT = sqNormT + template(i, j)*template(i, j)^;
            sqNormI = sqNormI + image(i + x - 1, j + y - 1)*image(i + x - 1, j + y - 1);
            cc = cc + template(i, j)*image(i + x - 1, j + y - 1);
        end
    end
    ncc = cc/sqrt(sqNormT*sqNormI);
end

