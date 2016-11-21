function updated_forest = ReadTree( forest, file_name, tree_id )
    file = fopen(file_name,'r');
    file_data = fscanf(file, '%f');
    cursor = 1;
    num_internal = file_data(cursor, 1);
    cursor =  cursor + 1;
    internal_nodes = zeros(num_internal(1,1), 10);
    for i = 1:num_internal
        internal_data = file_data(cursor:cursor+10,1);
        for j = 1 : 10
           internal_nodes(i,j)= internal_data(j+1,1); 
        end
        % modifies indexing from 0 -> num_nodes - 1 to 1 -> num_nodes to
        % simplify further operations on trees
        for k = 1 : 2
            if internal_nodes(i,k) > 0 % child is internal
                internal_nodes(i,k) = internal_nodes(i,k)+1;
            else % child is leaf
                internal_nodes(i,k) = internal_nodes(i,k)-1;
            end
        end
        cursor = cursor + 11;
    end
    num_leaves = file_data(cursor, 1);
    cursor =  cursor + 1;
    leaves = zeros(num_leaves(1,1), 2);
    for i = 1:num_leaves
        leave_data = file_data(cursor:cursor+2,1);
        for j = 1 : 2
           leaves(i,j)= leave_data(j+1,1); 
        end
        cursor = cursor + 3;
    end
    
    forest(tree_id).internal_nodes = internal_nodes;
    forest(tree_id).leaves = leaves;
    
    updated_forest = forest;
end

