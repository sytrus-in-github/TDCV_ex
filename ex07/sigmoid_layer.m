%% TDCV exercise on neural networks

classdef sigmoid_layer < layer
    % Sigmoid layer class
    % Implements the sigmoid non-linearity together with a
    % sparsity term based on the Kullback-Leibler-Divergence
	properties
        % Sparsity factor
        beta;
        % Targeted average activation
        alpha;
        % Average activations
        A_avg;
        % Average momentum
        gamma;
	end
	methods
		% Constructor
		function obj = sigmoid_layer(alpha, beta, gamma)
			% Call layer constructor
			obj@layer('Sigmoid');
            if nargin > 0
                obj.alpha = alpha;
                obj.beta = beta;
                obj.gamma = gamma;
            else
                obj.alpha = 0;
                obj.beta = 0;
                obj.gamma = 0;
            end
        end
        
        % Initialize intern variables and compute output shape
        function [obj, y] = initialize(obj, x)
            % Initialize verage activations
            num_channels = x(3);
            obj.A_avg = double(zeros(num_channels,1));
            
            % Output shape is equal to the input shape
            y = x;
        end
		
		% Forward pass
		function [obj, y, L] = forward(obj, x)
            % Compute the average activation (A_avg), the loss (L) and the layers output (y)
            %%% START YOUR CODE HERE %%%
            y = 1/(1+exp(-x));
            infnanguard(y); % DEBUG
            obj.A_avg = mean(mean(mean(y, 4), 2), 1);
            if (obj.alpha == 0 || obj.alpha == 1)
                L = 0;
            else
                L = obj.beta * sum(obj.alpha * log(obj.alpha / obj.A_avg) + (1 - obj.alpha) * log((1 - obj.alpha) / (1 - obj.A_avg)));
            end
            infnanguard(L); % DEBUG
%             disp(L);
%             disp('--sg--')
            %%% END YOUR CODE HERE %%%
		end
		
		% Backward pass
		function [obj, dx] = backward(obj, dy, x)
            % Compute the gradients dx using dy,x and A_avg
            %%% START YOUR CODE HERE %%%
            [w, h, ~, b] = size(x);
            if (obj.alpha == 0 || obj.alpha == 1)
                dL = 0;
            else
                %dL = obj.beta * (obj.A_avg - obj.alpha) ./ (obj.alpha .* (1 - obj.alpha)) / (w * h * b); % derivative of KL div / y
                dL = obj.beta * sum(- obj.alpha / obj.A_avg + (1 - obj.alpha) / (1 - obj.A_avg));
            end
            dx = (dy + dL) .* exp(-x) ./ (1+exp(-x)).^2;
            infnanguard(dx); % DEBUG
            %%% END YOUR CODE HERE %%%
        end
	end
end