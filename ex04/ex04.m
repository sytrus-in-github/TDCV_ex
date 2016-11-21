% Read the forest
num_files = 10;
forest;
for i = 1:num_files
    forest = ReadTree(forest, strcat('data/Tree',int2str(i-1),'.txt'), i);
end

forest(1).internal_nodes(1:10,:)