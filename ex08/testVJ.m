%scale = 0.4;
%imgFile = 'faceA.jpg';
%scale = 1.2;
%imgFile = 'faceB.jpg';
scale = 0.6;
imgFile = 'faceC.jpg';
vj = VJDetector(imgFile, 'Classifiers.mat', scale, 19);
faces = vj.findFaces();
disp(faces);
for i=1: length(faces)
    markFace(imgFile, faces{i}, scale);
end