function classifiers = loadHaarLikeClassifiers(filename)
    cs = load(filename);
    cs = cs.classifiers;
    [~, ln] = size(cs);
    classifiers = cell([ln-1, 1]);
    for i=2:ln
        classifiers{i-1} = HaarLikeClassifier(cs(:,i));
    end
end