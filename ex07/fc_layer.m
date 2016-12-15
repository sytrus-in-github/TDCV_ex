%% TDCV exercise on neural networks

classdef fc_layer < layer
    % Fully connected layer class
    % Holds the layers weights, biases, gradients and update values
    % Implements forward, backward and update function
	properties
		% Number of filters
		num_filters;
		% Weights
		W;
		% Biases
		b;
		% Weight gradients
		dW;
		% Bias gradients
		db;
		% Weight update
		uW;
		% Bias update
		ub;
        % Weight average
		aW;
		% Bias average
		ab;
        % Learning rate
        lr;
        % Momentum
        M;
        % Decay
        decay;
	end
	methods
		% Constructor
		function obj = fc_layer(num_filters, decay, lr, M)
			% Call layer constructor
			obj@layer('FullyConnected');
			% Set properties
			obj.num_filters = num_filters;
            
            if nargin > 1
                obj.decay = double(decay);
            else
                obj.decay = 0;
            end
            if nargin > 2
                obj.lr = double(lr);
            else
                obj.lr = 0;
            end
            if nargin > 3
                obj.M = double(M);
            else
                obj.M = 0;
            end
		end
		
		% Initialize the inner parameters and compute output shape
		function [obj, y] = initialize(obj, x)
            % Initialize the layers parameters W, b, dW, db, etc.
            %%% START YOUR CODE HERE %%%
            [width, height, channels, batch_size] = size(x);
            num_inputs = width * height * channels;
            % Parameters
            obj.W = double(sqrt(6)/(num_inputs+obj.num_filters+1)*(rand(num_inputs, obj.num_filters)-0.5));
			obj.b = double(zeros(obj.num_filters,1));
			
            % Gradients
			obj.dW = double(zeros(num_inputs, obj.num_filters));
			obj.db = double(zeros(obj.num_filters, 1));
			
            % Update (Useful for RMSProp and AdaM updates)
			obj.uW = double(zeros(num_inputs, obj.num_filters));
			obj.ub = double(zeros(obj.num_filters, 1));
            
            % Average (Useful for RMSProp and AdaM updates)
			obj.aW = mean(obj.W);
			obj.ab = 0;
			
            % Output
			y = double(zeros(1, 1, obj.num_filters, batch_size));
            %%% END YOUR CODE HERE %%%
		end
		
		% Forward pass
		function [obj, y , L] = forward(obj, x)
            % Compute the loss (L) and the layers output (y)
            % A vectorized implementation can speed up your training.
            % Make use of reshape and repmat to create the tensors
            %%% START YOUR CODE HERE %%%
            % Compute the loss (L)
            N = norm(obj.W);
            L = obj.decay/2*N*N;
            
            %Compute the layers output (y)
            [width, height, channels, batch_size] = size(x);
            num_inputs = width * height * channels;
            
            xr = reshape(x, [num_inputs * batch_size, 1]);
            Wr = repmat(obj.W, batch_size, batch_size);
            br = repmat(obj.b, batch_size, 1);
            yr = Wr * xr + br;
            y = reshape(yr, [1, 1, obj.num_filters, batch_size]);
            %%% END YOUR CODE HERE %%%
		end
		
		% Backward pass
		function [obj, dx] = backward(obj, dy, x)
            % Compute the gradients dx,dW and db using dy,x and W
            %%% START YOUR CODE HERE %%%
            % Compute the gradient dx
            [width, height, channels, batch_size] = size(x);
            num_inputs = width * height * channels;
            dyr = reshape(dy, [obj.num_filters * batch_size, 1]);
            Wr = repmat(obj.W, batch_size, batch_size);
            br = repmat(obj.b, batch_size, 1);
            dxr =  Wr\(dyr - br);
            dx = reshape(dxr, [width, height, channels, batch_size]);
            
            % Compute the gradient dW
            xr = reshape(x, [num_inputs * batch_size, 1]);
            obj.dWr = - (1 - obj.M) * obj.lr * dyr * xr' + obj.M * obj.dWr;
            obj.db = - (1 - obj.M) * obj.lr * dyr + obj.M * obj.db;
            %%% END YOUR CODE HERE %%%
		end
		
		% Updates the layers parameters via stochastic gradient descent
		function obj = update(obj)
            % Use dW and db computed in the backward pass together with the
            % layer settings for learning rate (lr) and momentum (M) to
            % compute the update, you can use uW,ub and aW,ab to store
            % certain values
            %%% START YOUR CODE HERE %%%
            
            
            
            % obj.W = ...
            % obj.b = ...
            %%% END YOUR CODE HERE %%%
		end
	end
end