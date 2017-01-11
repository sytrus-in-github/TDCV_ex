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
    disp('visualize');
    number_outputs = prod(net.input_size(1:3));
    siz = sqrt(number_outputs);
    batch_size = net.input_size(4);
    image = zeros(number_outputs, number_outputs);
    dy = zeros(1,1,number_outputs,batch_size);
    for i = 1:number_outputs
        dy(1,1,i,i) = 1;
    end

    [~, dx] = net.backward_all(dy);
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

