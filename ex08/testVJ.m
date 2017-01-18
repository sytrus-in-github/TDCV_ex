scale = 0.4;
imgFile = 'faceA.jpg';
% scale = 1.2;
% imgFile = 'faceB.jpg';
% scale = 0.6;
% imgFile = 'faceC.jpg';
vj = VJDetector(imgFile, 'Classifiers.mat', scale, 19);
faces = vj.findFaces();
disp(faces);
for i=1: length(faces)
    markFace(imgFile, faces{i}, scale);
end
% A = [1 1 1 1;2 2 2 2;3 3 3 3;4 4 4 4]
% intA = integral(A)
% rect(intA,2,2,1,1)
% 
% function ret = rect(intA, r, c, w, h)
%     ret = intA(r,c)-intA(r+h+1,c)+intA(r+h+1,c+w+1)-intA(r,c+w+1);
% end
% 
% function intg = integral(img)
%     intimg = cumsum(cumsum(img,1),2);
%     intimg = [zeros(size(intimg,1),1),intimg];
%     intg = [zeros(1,size(intimg,2));intimg];
% end