classdef WeakClassifier_
    %WEAKCLASSIFIER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        dimensionThreshold; % value 1 or 2 according to the considered dimension
        threshold; % threshold of the classifier
        negativeFirst; % boolean if true ==> -1 ...-1|1..1 else 1..1|-1..-1 
    end
    
    methods
        function obj = WeakClassifier_()
            % Initialize the properties with any value since they won't be
            % used.
            %dimensionThreshold = 1;
            %threshold = 0;
        end
        
        function [obj, alpha, importanceWeights] = Train(obj, trainingExamples, labels, importanceWeights)
            % Train the weak classifier on the training set with given
            % importance weights. The function returns the trained
            % classifier, the output weight alpha of the classifier and the
            % updated importance weights of the training set.
            n = length(importanceWeights);
            
            % Best threshold with its error
            bestDimensionThreshold = 1;
            bestThreshold = 0;
            bestError = 0.5; 
            bestPredictedLabels = zeros(size(labels));
            bestNegativeFirst = true;
            
            % Create a list of the possible thresholds
            x_coord = sort(trainingExamples(:,1));
            y_coord = sort(trainingExamples(:,2));
            x_thresh = mean([x_coord(1:n-1,1), x_coord(2:n,1)],2);
            y_thresh = mean([y_coord(1:n-1,1), y_coord(2:n,1)],2);
            one = ones(n-1,1);
            possibleThresholds = [x_thresh, one ; y_thresh, 2*one];

            % Test each possible threshold and keep the best
            for i = 1:length(possibleThresholds)
                obj.threshold = possibleThresholds(i,1);
                obj.dimensionThreshold = possibleThresholds(i,2);
                obj.negativeFirst = true;
                predictedLabels = Test(obj, trainingExamples);
                error = sum(importanceWeights .* abs(predictedLabels - labels)/2);
                % flip direction if it should be the opposite
                if (error > 0.5)
                    error = 1-error;
                    predictedLabels = -predictedLabels;
                    obj.negativeFirst = false;
                end
                if (error < bestError)
                    bestThreshold = obj.threshold;
                    bestDimensionThreshold = obj.dimensionThreshold;
                    bestError = error;
                    bestPredictedLabels = predictedLabels;
                    bestNegativeFirst = obj.negativeFirst;
                end
            end
            
            % Update the classifier with the best threshold
            obj.threshold = bestThreshold;
            obj.dimensionThreshold = bestDimensionThreshold;
            obj.negativeFirst = bestNegativeFirst;
            % Compute alpha
            alpha = log((1 - bestError)/bestError);
            
            % Update importance weights
            importanceWeights = importanceWeights .* exp(alpha * (1.-labels .* bestPredictedLabels) / 2.);
            importanceWeights = importanceWeights / sum(importanceWeights);
        end
        
        function predictedLabels = Test(obj, testingExamples)
           % Test the weak classifier on a testing set and returns the 
           % predicted labels.
           predictedLabels = zeros(size(testingExamples,1),1);
           for i = 1:length(predictedLabels)
               if (testingExamples(i, obj.dimensionThreshold) < obj.threshold)
                   predictedLabels(i,1) = -1;
               else
                   predictedLabels(i,1) = 1;
               end
           end
           if (~obj.negativeFirst)
               predictedLabels = -predictedLabels;
           end
        end
    end
    
end

