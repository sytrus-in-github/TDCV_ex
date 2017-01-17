% Number of weak classifiers
N = 1000;

dataset = 'data3';
% Load data1.mat
load(strcat(dataset,'.mat'));

% Create and train an AdaboostClassifier
classifier = AdaboostClassifier(N);
classifier = classifier.Train(dat(:,1:2), dat(:,3));
predictedLabels = classifier.Test(dat(:,1:2));
PlotData(dat(:,1:2), dat(:,3), 1, strcat(dataset,'.pdf'));
PlotData(dat(:,1:2), predictedLabels, 2, strcat(dataset,'-classified.pdf'));
classifier.PlotErrorEvolution(dat(:,1:2),dat(:,3),3, strcat(dataset,'-error-over-iterations.pdf'));