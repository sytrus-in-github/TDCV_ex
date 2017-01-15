classdef AdaboostClassifier
    %ADABOOSTCLASSIFIER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        WeakClassifierArray= WeakClassifier; % array of weak classifiers
        Alpha; % array of alpha coefficients relative to the classifiers
    end
    
    methods
        function obj = AdaboostClassifier(numberWeakClassifiers)
            % Initialize the Adaboost classifier with numberWeakClassifiers
            % initialized weak classifiers with alpha coefficients equal to
            % 0.
            obj.WeakClassifierArray(1:numberWeakClassifiers,1) = WeakClassifier;
            obj.Alpha = zeros(numberWeakClassifiers,1);
        end
        
        function obj = Train(obj, trainingExamples, labels)
            % Train the Adaboost classifier on the training set and returns
            % the trained classifier.
            
            % Initialize the importance weights
            importanceWeights = ones(size(labels));
            importanceWeights = importanceWeights / length(importanceWeights);
            
            % Train successively the weak classifiers
            for i = 1:size(obj.WeakClassifierArray)
                [obj.WeakClassifierArray(i,1), alpha, importanceWeights] = obj.WeakClassifierArray(i,1).Train(trainingExamples, labels, importanceWeights);
                obj.Alpha(i,1) = alpha;
            end
        end
        
        function predictedLabels = Test(obj, testingExamples)
            % Test the Adaboost classifier on the testing set and returns
            % the predicted labels.
            predictedLabels = zeros(size(testingExamples,1),1);

            for i = 1:size(obj.WeakClassifierArray)
                K = obj.WeakClassifierArray(i,1).Test(testingExamples);
                predictedLabels = predictedLabels + obj.Alpha(i,1) .* obj.WeakClassifierArray(i,1).Test(testingExamples);
%                 disp(obj.Alpha(i,1));
%                 disp(K(57,1));
%                 disp(predictedLabels(57,1));
            end
            predictedLabels = sign(predictedLabels);
        end
    end
    
end

