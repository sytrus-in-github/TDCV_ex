% Read the forest
num_trees = 10;
forest(1).internal_nodes = [];
forest(1).leaves = [];
for i = 1:num_trees
    forest = ReadTree(forest, strcat('data/Tree',int2str(i-1),'.txt'), i);
end

% Load image and compute integral image
rgb = double(imread('data/2007_000032.jpg'));
irgb = IntegralImage(rgb);
[m,n,~] = size(irgb);

heatmap = zeros(m,n);
votes = zeros(m,n,2);

% Test all pixels and update heatmap and votes
for x = 1:m
    for y = 1:n
        predx = 0;
        predy = 0;
        for tree_id = 1:num_trees
            %% Test tree
            curs = 1;
            while curs > 0
                %% Initialize variables
                cl = forest(tree_id).internal_nodes(curs,1); 
                cr = forest(tree_id).internal_nodes(curs,2); 
                t = forest(tree_id).internal_nodes(curs,3);
                xa = forest(tree_id).internal_nodes(curs,4);
                ya = forest(tree_id).internal_nodes(curs,5);
                za = forest(tree_id).internal_nodes(curs,6);
                xb = forest(tree_id).internal_nodes(curs,7);
                yb = forest(tree_id).internal_nodes(curs,8);
                zb = forest(tree_id).internal_nodes(curs,9);
                s = forest(tree_id).internal_nodes(curs,10);
                %% Compute the Haar-Like features
                % Compute ba
                X = x+xa;
                Y = y+ya;
                z = za;
                color = 1;
                switch z
                    case 0
                        color = 3;
                    case 1 
                        color = 2;
                    case 2 
                        color = 1;
                end
                [m,n,~] = size(irgb);
                minx = int16(Y-s);
                miny = int16(X-s);
                maxx = int16(Y+s);
                maxy = int16(X+s);
                if maxx > m
                    maxx = m;
                end
                if minx < 1
                    minx = 1;
                end
                if maxy > n
                    maxy = n;
                end
                if miny < 1
                    miny = 1;
                end
                if minx > m
                    minx = m;
                end
                if maxx < 1
                    maxx = 1;
                end
                if miny > n
                    miny = n;
                end
                if maxy < 1
                    maxy = 1;
                end
                ba = 1/(2*s+1)^2 * (irgb(maxx,maxy,color) - irgb(minx,maxy,color) - irgb(maxx,miny,color) + irgb(minx,miny,color));
                % Compute bb
                X = x+xb;
                Y = y+yb;
                z = zb;
                color = 1;
                switch z
                    case 0
                        color = 3;
                    case 1 
                        color = 2;
                    case 2 
                        color = 1;
                end
                [m,n,~] = size(irgb);
                minx = int16(Y-s);
                miny = int16(X-s);
                maxx = int16(Y+s);
                maxy = int16(X+s);
                if maxx > m
                    maxx = m;
                end
                if minx < 1
                    minx = 1;
                end
                if maxy > n
                    maxy = n;
                end
                if miny < 1
                    miny = 1;
                end
                if minx > m
                    minx = m;
                end
                if maxx < 1
                    maxx = 1;
                end
                if miny > n
                    miny = n;
                end
                if maxy < 1
                    maxy = 1;
                end
                bb = 1/(2*s+1)^2 * (irgb(maxx,maxy,color) - irgb(minx,maxy,color) - irgb(maxx,miny,color) + irgb(minx,miny,color));
                %% Test
                if ba - bb < t
                    curs = cl;
                else
                    curs = cr;
                end
            end
            leave = abs(curs);
            px = forest(tree_id).leaves(leave,1);
            py = forest(tree_id).leaves(leave,2);
            predx = predx+px;
            predy = predy+py;
        end
        predx = predx/num_trees;
        predy = predy/num_trees;
        X = round(x + predy);
        Y = round(y + predx);
        if X > 0 && Y > 0 && X <= m && Y <= n
            heatmap(X, Y) = heatmap(X, Y) + 1;
        end
        votes(x,y,1) = X;
        votes(x,y,2) = Y;
    end
end
    
result = mat2gray(heatmap);
figure('Name', 'Heatmap');
imshow(result);