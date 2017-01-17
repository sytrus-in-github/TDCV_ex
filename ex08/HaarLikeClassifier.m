classdef HaarLikeClassifier
    properties
        r;
        c;
        winWidth;
        winHeight;
        typeNum;
        % -----
        mean;
        std;
        maxPos;
        minPos;
        R;
        alpha;
        err;
        fnerr;
        fperr;   
    end
    
    methods 
        function obj = HaarLikeClassifier(feat)
            obj.r=feat(1);
            obj.c=feat(2);
            obj.winWidth=feat(3);
            obj.winHeight=feat(4);
            obj.typeNum=feat(5);
            % -----
            obj.mean=feat(6);
            obj.std=feat(7);
            obj.maxPos=feat(8);
            obj.minPos=feat(9);
            obj.R=feat(10);
            obj.alpha=feat(11);
            obj.err=feat(12);
            obj.fnerr=feat(13);
            obj.fperr=feat(14);
        end
    end
end