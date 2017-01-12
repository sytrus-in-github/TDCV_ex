%% TDCV exercise on neural networks

function stop = visualize_features(x,optimValues,state)
% Visualize the features learned by the network using backpropagation
% The idea is to give the backward function an activation vector which sets
% the activation of a single neuron to 1 and all other activations to 0 and
% then backpropagate this activation to the input. To display the learned
% filter properly you should normalize it beforehand.
% The network should be available via the global variable net
% The input size is
    global net;
    
    %%% START YOUR CODE HERE %%%
    siz = 10;
    bord = 2;
    [w, h, ~, ~] = size(net.blobs{1});
    image = zeros((w+bord) * siz, (h+bord) * siz);
    %%{
    % fc1
    weights = x(1:w*h*siz*siz);
    ws = reshape(weights, [w, h, siz, siz]);
    for i = 1:siz
        for j = 1:siz
            image((i-1)*(w+bord)+1:(i-1)*(w+bord)+w,(j-1)*(h+bord)+1:(j-1)*(h+bord)+h) = ws(1:w,1:h,i,j);
        end
    end
    %}
    %{
    % fc2
    weights = x(101+w*h*siz*siz:100+2*w*h*siz*siz);
    ws = reshape(weights, [siz, siz, w, h]);
    for i = 1:siz
        for j = 1:siz
            image((i-1)*(w+bord)+1:(i-1)*(w+bord)+w,(j-1)*(h+bord)+1:(j-1)*(h+bord)+h) = ws(i,j,1:w,1:h);
        end
    end
    %}
    %{
    % Only with solve
    NB_HIDDEN = 100;
    siz = 10;
    dy = ones(1, 1, NB_HIDDEN, batch_size)*0.1;
    
    for i = 1:NB_HIDDEN
        dy(1,1,i,i) = 0.9;
    end
    [~, dx] = net.backward_from_to(dy,2,1);
    
%     disp([max(dx(:)), min(dx(:))])
    for i = 1:siz
        for j = 1:siz
            image((i-1)*(w+bord)+1:(i-1)*(w+bord)+w,(j-1)*(h+bord)+1:(j-1)*(h+bord)+h) = dx(1:w,1:h,1,i+siz*(j-1));
        end
    end

    %}
    nz = image(image ~= 0);
    me = mean(nz);
    mx = max(nz);
    mn = min(nz);
    %disp([mx, me, mn]);
    image(image == 0) = me;
    image = (image+mn)/(mx+mn);
    gray_image = mat2gray(image);
    
    imwrite(gray_image,strcat('data/features_',int2str(optimValues.iteration),'.png'));
    
    
    
    
    
    
    
    
    
    
    
    
    
    %%% END YOUR CODE HERE %%%
    
    stop = 0;
end

