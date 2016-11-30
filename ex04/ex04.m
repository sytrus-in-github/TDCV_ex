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
[n,m,~] = size(irgb);

heatmap = zeros(n,m);
votes = zeros(n,m,2);

forest_cells = struct2cell(forest);
% Test all pixels and update heatmap and votes
tic;
for x = 1:m
    for y = 1:n
        predx = 0;
        predy = 0;
        for tree_id = 1:num_trees
            %% Test tree
            %internal_nodes = forest(tree_id).internal_nodes;
            internal_nodes = forest_cells{2*tree_id-1};
            %leaves = forest(tree_id).leaves;
            leaves = forest_cells{2*tree_id};
            curs = 1;
            while curs > 0
                %% Initialize variables
                cl = internal_nodes(curs,1); 
                cr = internal_nodes(curs,2); 
                t = internal_nodes(curs,3);
                xa = internal_nodes(curs,4);
                ya = internal_nodes(curs,5);
                za = internal_nodes(curs,6);
                xb = internal_nodes(curs,7);
                yb = internal_nodes(curs,8);
                zb = internal_nodes(curs,9);
                s = internal_nodes(curs,10);
                %% Compute the Haar-Like features
                % Compute ba
                X = x+xa;
                Y = y+ya;
                z = za;
                color = round(3-z);
                
                minx = int16(X-s);
                miny = int16(Y-s);
                maxx = int16(X+s);
                maxy = int16(Y+s);
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
                ba = 1/(2*s+1)^2 * (irgb(maxy,maxx,color) - irgb(miny,maxx,color) - irgb(maxy,minx,color) + irgb(miny,minx,color));
                % Compute bb
                X = x+xb;
                Y = y+yb;
                z = zb;
                color = round(3-z);
                minx = int16(X-s);
                miny = int16(Y-s);
                maxx = int16(X+s);
                maxy = int16(Y+s);
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
                bb = 1/(2*s+1)^2 * (irgb(maxy,maxx,color) - irgb(miny,maxx,color) - irgb(maxy,minx,color) + irgb(miny,minx,color));
                %% Test
                if ba - bb < t
                    curs = cl;
                else
                    curs = cr;
                end
            end
            leave = abs(curs);
            px = leaves(leave,1);
            py = leaves(leave,2);
            predx = predx+px;
            predy = predy+py;
        end
        predx = predx/num_trees;
        predy = predy/num_trees;
        X = round(x + predx);
        Y = round(y + predy);
        if X > 0 && Y > 0 && X <= m && Y <= n
            heatmap(Y,X) = heatmap(Y, X) + 1;
        end
        votes(y,x,1) = X;
        votes(y,x,2) = Y;
    end
end
toc
    
result = mat2gray(heatmap);
figure('Name', 'Heatmap');
imshow(result);

% figure('Name', 'Points');
% imshow(uint8(rgb));
hold on;
% draw maximum
[M,j] = max(heatmap);
[~,i] = max(M);
j = j(i);
plot(i,j,'ro','MarkerSize',5);
% draw points voting for maximum
points= zeros(n,m);
c = 0;
for x = 1:m
    for y = 1:n
        v = votes(y,x,:);
        vx = v(1);
        vy = v(2);
        if all([vx, vy] == [i, j])
            points(y,x) = 1;
            plot(x,y,'go','MarkerSize',3);
            c = c+1;
        else
            points(y,x) = 0;
        end
    end
end
disp(c);