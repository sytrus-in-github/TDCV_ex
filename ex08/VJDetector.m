classdef VJDetector
    
    properties
       intimg % integral of image
       classifiers % haar-like features
       baseScale
    end
    
    methods
        function obj = VJDetector(imgfile, classifierfile, imgscale, base_scale)
            disp(imgscale)
            obj.classifiers = loadHaarLikeClassifiers(classifierfile);
            %intimg = double(imresize(rgb2gray(imread(imgfile)),imgscale));
            %intimg = cumsum(cumsum(intimg,1),2);
            %intimg = [zeros(size(intimg,1),1),intimg];
            %obj.intimg = [zeros(1,size(intimg,2));intimg];
            obj.intimg = integralImage(imresize(rgb2gray(imread(imgfile)),imgscale));
            obj.baseScale=base_scale;
        end
        
        function ret = rect(obj, r, c, w, h)
            ret = obj.intimg(r,c)-obj.intimg(r+h+1,c)+obj.intimg(r+h+1,c+w+1)-obj.intimg(r,c+w+1);
        end
        
        function ret = h(obj, i, dr, dc) %weakclassifier
            % depending on the type of feature, calculate t
            cls = obj.classifiers{i};
            %disp([cls.R cls.mean cls.maxPos cls.minPos])
            r = dr + cls.r;
            c = dc + cls.c;
            t = 0;
            switch cls.typeNum
                case 1
                    t = obj.rect(r, c, cls.winWidth/2-1, cls.winHeight-1)- ...
                        obj.rect(r, c+cls.winWidth/2, cls.winWidth/2-1, cls.winHeight-1);
                case 2
                    t = obj.rect(r, c, cls.winWidth-1, cls.winHeight/2-1)- ...
                        obj.rect(r+cls.winHeight/2, c, cls.winWidth-1, cls.winHeight/2-1);
                case 3
                    t = obj.rect(r, c, cls.winWidth/3-1, cls.winHeight-1)- ...
                        obj.rect(r, c+cls.winWidth/3, cls.winWidth/3-1, cls.winHeight-1)+ ...
                        obj.rect(r, c+2*cls.winWidth/3, cls.winWidth/3-1, cls.winHeight-1);
                case 4
                    t = obj.rect(r, c, cls.winWidth-1, cls.winHeight/3-1)- ...
                        obj.rect(r+cls.winHeight/3, c, cls.winWidth-1, cls.winHeight/3-1)+ ...
                        obj.rect(r+2*cls.winHeight/3, c, cls.winWidth-1, cls.winHeight/3-1);
                case 5
                    t = obj.rect(r, c, cls.winWidth/2-1, cls.winHeight/2-1)- ...
                        obj.rect(r, c+cls.winWidth/2, cls.winWidth/2-1, cls.winHeight/2-1)+ ...
                        obj.rect(r+cls.winHeight/2, c, cls.winWidth/2-1, cls.winHeight/2-1)- ...
                        obj.rect(r+cls.winHeight/2, c+cls.winWidth/2, cls.winWidth/2-1, cls.winHeight/2-1);
                otherwise
                    error(strcat('classifier ',int2str(i),' has type ',int2str(cls.typeNum)));
            end
            % return the classification result
            % disp([cls.typeNum, t]);
            nb = 5;
            nb2 = 50;
            ret = (t >= (cls.mean - abs(cls.mean - cls.minPos) * (cls.R - nb) / nb2) && ...
                   t <= (cls.mean + abs(cls.maxPos - cls.mean) * (cls.R - nb) / nb2));
            % ret = ret*2-1;
               
%             if (dr == 20||dr==22) && dc == 12 && ret==1
%                 disp([i, dr, dc, ret (cls.mean - abs(cls.mean - cls.minPos) * (cls.R - 6) / 50) t (cls.mean + abs(cls.maxPos - cls.mean) * (cls.R - 6) / 50)])
%             end
        end
        
        function ret = findFaces(obj)
            [ir, ic] = size(obj.intimg);
            maxr = 0;
            maxc = 0;
            maxleft = 0;
            ret = {};
            for i=1:ir-obj.baseScale
                for j=1:ic-obj.baseScale
                    left = 0;
                    right = 0;
                    for c=1:length(obj.classifiers)
                        cls = obj.classifiers{c};
                        left = left + obj.h(c,i,j) * cls.alpha;
                        right = right + cls.alpha;
                    end
                    if left>maxleft
                        maxr = i;
                        maxc = j;
                        maxleft = left;
                    end
                    if left > right/2
                        ret{end+1}=[i, j];
                    end
                end
            end
            if isempty(ret)
                disp('The best available:')
                disp([maxr maxc maxleft/right])
                ret{end+1}= [maxr, maxc];
            end
        end
    end
end