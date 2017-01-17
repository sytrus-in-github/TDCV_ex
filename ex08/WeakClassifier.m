
classdef WeakClassifier
    %WEAKCLASSIFIER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        dimensionThreshold; % value 1 or 2 according to the considered dimension
        threshold; % threshold of the classifier
    end
    
    methods
        function obj = WeakClassifier()
            % Initialize the properties with any value since they won't be
            % used.
        end
        
        function [obj, classificationError, labelCorrelation] = Train(obj, trainingExamples, labels, importanceWeights)
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
                predictedLabels = Test(obj, trainingExamples);
                error = sum(importanceWeights .* abs(predictedLabels - labels)/2);
                if (abs(error-0.5) > abs(bestError-0.5))
                    bestThreshold = obj.threshold;
                    bestDimensionThreshold = obj.dimensionThreshold;
                    bestError = error;
                    bestPredictedLabels = predictedLabels;
                end
            end
            
            % Update the classifier with the best threshold
            obj.threshold = bestThreshold;
            obj.dimensionThreshold = bestDimensionThreshold;
            
            % Get the classification error and the label correlation
            classificationError = bestError;
            labelCorrelation = labels .* bestPredictedLabels;
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
        end
    end
    
end

