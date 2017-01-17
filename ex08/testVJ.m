vj = VJDetector('faceA.jpg', 'Classifiers.mat', 0.5, 19);
faces = vj.findFaces();
disp(faces);
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