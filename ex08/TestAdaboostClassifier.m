% Number of weak classifiers
N = 30;

% Load data1.mat
load('data1.mat');

% Create and train an AdaboostClassifier
classifier = AdaboostClassifier(N);
tic;
classifier = classifier.Train(dat(:,1:2), dat(:,3));
toc;
predictedLabels = classifier.Test(dat(:,1:2));
PlotData(dat(:,1:2), dat(:,3), 1);
PlotData(dat(:,1:2), predictedLabels, 2);