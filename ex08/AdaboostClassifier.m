classdef AdaboostClassifier
    %ADABOOSTCLASSIFIER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        WeakClassifierArray=WeakClassifier; % array of weak classifiers
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
            for i = 1:length(obj.WeakClassifierArray)
                fprintf('%d/%d\n',i,length(obj.WeakClassifierArray));
                [obj.WeakClassifierArray(i,1), classificationError, labelCorrelation] = obj.WeakClassifierArray(i,1).Train(trainingExamples, labels, importanceWeights);
                
                % Compute alpha and the new importance weights
                obj.Alpha(i,1) = log((1 - classificationError)/classificationError)/2;
                importanceWeights = importanceWeights .* exp(- obj.Alpha(i, 1) * labelCorrelation);
                importanceWeights = importanceWeights / sum(importanceWeights);
            end
        end
        
        function predictedLabels = Test(obj, testingExamples)
            % Test the Adaboost classifier on the testing set and returns
            % the predicted labels.
            predictedLabels = zeros(size(testingExamples,1),1);

            for i = 1:length(obj.WeakClassifierArray)
                predictedLabels = predictedLabels + obj.Alpha(i,1) .* obj.WeakClassifierArray(i,1).Test(testingExamples);
            end
            predictedLabels = sign(predictedLabels);
        end
        
        function predictedLabels = PartialTest(obj, testingExamples, numberWeakClassifiers)
            % Test only a part of the weak classifiers on the testing set and returns
            % the predicted labels. For error visualisation purposes.
            assert(numberWeakClassifiers <= length(obj.WeakClassifierArray));
            
            predictedLabels = zeros(length(testingExamples),1);

            for i = 1:numberWeakClassifiers
                predictedLabels = predictedLabels + obj.Alpha(i,1) .* obj.WeakClassifierArray(i,1).Test(testingExamples);
            end
            predictedLabels = sign(predictedLabels);
        end
        
        function out = PlotErrorEvolution(obj, testingExamples, labels, numFigure, fileName)
            % Plot the evolution error over the training iterations.
            figure(numFigure);
            error = zeros(length(obj.WeakClassifierArray),1);
            for i = 1:length(error)
                predictedLabels = obj.PartialTest(testingExamples, i);
                error(i,1) = sum(abs(predictedLabels - labels))/(2*length(labels));
            end
            plot(error,'b');
            saveas(gcf, fileName);
            out = 0;
        end
    end
    
end

