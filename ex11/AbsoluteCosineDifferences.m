function acd = AbsoluteCosineDifferences(image, template, x, y, mask)
    [h, w] = size(template);
    acd = template - image(x : x+h-1, y : y+w-1);
    if nargin == 5
        acd = acd(mask);
        support = sum(mask(:));
    else
        support = h * w;
    end
    if support == 0
        acd = 1;
        return
    end
    acd = abs(cos(acd));
    acd = sum(acd(:)) / support;
    acd = 1 - acd;
end