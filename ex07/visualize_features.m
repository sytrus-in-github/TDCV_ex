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
    
    NB_HIDDEN = 100;
    %disp(size(net.input_size));
    %[w  h  c  batch_size] = net.input_size;
    w = net.input_size(1);
    h = net.input_size(2);
    c = net.input_size(3);
    batch_size = net.input_size(4);
    if NB_HIDDEN > batch_size || c ~= 1
        error('Not implemented yet')
    end
    image = zeros(w, h);
    dy = zeros(1, 1, NB_HIDDEN, batch_size);
    
    for i = 1:NB_HIDDEN
        dy(1,1,i,i) = 1;
    end
    siz = sqrt(NB_HIDDEN);
    [~, dx] = net.backward_from_to(dy,2,1);
    for i = 1:siz
        for j = 1:siz
            image((i-1)*siz+1:i*siz,(j-1)*siz+1:j*siz) = dx(1:siz,1:siz,1,i+siz*(j-1));
        end
    end
    
    gray_image = mat2gray(image);
    
    imwrite(gray_image,'data/features.png');
    
    
    
    
    
    
    
    
    
    
    
    
    
    %%% END YOUR CODE HERE %%%
    
    stop = 0;
end

