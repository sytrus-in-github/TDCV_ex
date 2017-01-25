classdef HyperplaneTemplateMatchingTracker
    properties
        Template;
        templateI;
        truncTemplate;
        UpdateMatrixSerie;
        nbUpdateMatrix;
        updateRepeat;
        originalParam;
        currentParam;
        currentH;
        nbGridPoints;
    end
    
    methods
        function obj = HyperplaneTemplateMatchingTracker( ...
            templateFileName, TemplatePos, TemplateSize, NumOfGridPoints, ...
            UpdateRangeSerie, update_repeat, NumOfIterations)
            tic;
            disp('*** initializing tracker ...')
            % initialize tracker parameters
            obj.Template = imread(templateFileName);
            obj.updateRepeat = update_repeat;
            obj.nbGridPoints = NumOfGridPoints;
            obj.nbUpdateMatrix = length(UpdateRangeSerie);
            obj.originalParam = zeros(1,8);
            obj.originalParam(1) = TemplatePos(1);
            obj.originalParam(2) = TemplatePos(2);
            obj.originalParam(3) = TemplatePos(1) + TemplateSize;
            obj.originalParam(4) = TemplatePos(2);
            obj.originalParam(5) = TemplatePos(1);
            obj.originalParam(6) = TemplatePos(2) + TemplateSize;
            obj.originalParam(7) = TemplatePos(1) + TemplateSize;
            obj.originalParam(8) = TemplatePos(2) + TemplateSize;
            obj.templateI = WarpingIntensity(obj.Template, obj.originalParam, NumOfGridPoints);
            obj.currentParam = obj.originalParam; % copy
            obj.currentH = getHomography(obj.originalParam, obj.currentParam); % should be identity
            obj.currentH = obj.currentH.T; % keep only the matrix
            % get trunc template
            obj.truncTemplate = zeros(obj.originalParam(3)-obj.originalParam(1));
            for u = 1:length(obj.truncTemplate)
                for v = 1:length(obj.truncTemplate)
                    obj.truncTemplate(u,v) = obj.Template(u+obj.originalParam(1)-1,v+obj.originalParam(2)-1);
                end
            end
            % get HyperplaneMatrices (A) of different ranges
            obj.UpdateMatrixSerie = zeros(8, NumOfGridPoints, length(UpdateRangeSerie));
            for i = 1:length(UpdateRangeSerie)
                obj.UpdateMatrixSerie(:,:,i) = ComputeHyperplaneMatrix( ...
                    obj.Template, obj.originalParam, NumOfGridPoints, ...
                    UpdateRangeSerie(i), NumOfIterations);
            end
            disp('*** tracker ready.')
            toc;
        end
        
        function parameterList = trackImgSeq(obj, rootdir ,cellsOfImageNames, displayForEachStep)
            tic;
            disp('*** tracking ...')
            parameterList = zeros(length(cellsOfImageNames), 8);
            for i = 1:length(cellsOfImageNames)
                img = imread(strcat(rootdir, cellsOfImageNames{i}));
                [obj, newParam] = obj.trackImg(img);
                parameterList(i, :) = newParam;
                if displayForEachStep
                    obj.drawTracking(img, newParam);
                end
                disp(strcat(cellsOfImageNames{i}, ' done.'))
            end
            disp(strcat('*** tracking done for: ', int2str(length(cellsOfImageNames)), ' images.'))
            toc;
        end
        
        function out = visualizeTracking(obj, rootdir, outputdir, cellsOfImageNames, parameterList)
            disp('*** visualizing ...')
            originRef = imref2d(size(obj.truncTemplate));
            originRef.XWorldLimits = originRef.XWorldLimits + obj.originalParam(1)-1;
            originRef.YWorldLimits = originRef.YWorldLimits + obj.originalParam(2)-1;
            [Height, Width] = size(obj.Template);
            for i = 1:length(cellsOfImageNames)
                img = imread(strcat(rootdir, cellsOfImageNames{i}));
                H = getHomography(obj.originalParam, parameterList(i, :));
                [W, R] = imwarp(obj.truncTemplate,originRef,H);
                offsetX = R.XWorldLimits(1);
                offsetY = R.YWorldLimits(1);
                output = img * 0.5;
                [h,w] = size(W);
                for u = 1:h
                    for v = 1:w
                        if (round(u+offsetX) > 0 && round(u+offsetX) <= Height...
                                && round(v+offsetY) > 0 && round(v+offsetY) <= Width)
                            output(round(u+offsetX),round(v+offsetY)) = output(round(u+offsetX),round(v+offsetY)) + 0.5 * W(u,v);
                        end
                    end
                end
                imwrite(output,strcat(outputdir, cellsOfImageNames{i}));
            end
            disp(strcat('*** visualizing done for: ', int2str(length(cellsOfImageNames)), ' images.'))
            out = 0;
        end
    end
    methods(Access=private)
        function [obj, newParam] = trackImg(obj, img)
            for m = 1:obj.nbUpdateMatrix
                A = obj.UpdateMatrixSerie(:,:,m);
                for r = 1:obj.updateRepeat
                    newI = WarpingIntensity( img, obj.currentParam, obj.nbGridPoints);
                    deltaI = newI - obj.templateI;
                    deltaP = A * deltaI;
                    deltaParam = deltaP' + obj.originalParam; % we don't take obj.originalParam = 0 thus we need to add it
                    updateH = getHomography(deltaParam, obj.originalParam); % back warp of deltaParam
                    % update tracker status
                    obj.currentH = obj.currentH * updateH.T; % w(P) <-w(P) o w(dP)^{-1}
                    obj.currentParam = applyHomography2Param(projective2d(obj.currentH), obj.originalParam);
                end
            end
            newParam = obj.currentParam;
        end
        
        function [] = drawTracking(obj, img, parameter)
            originRef = imref2d(size(obj.truncTemplate));
            originRef.XWorldLimits = originRef.XWorldLimits + obj.originalParam(1)-1;
            originRef.YWorldLimits = originRef.YWorldLimits + obj.originalParam(2)-1;
            [Height, Width] = size(obj.Template);
                H = getHomography(obj.originalParam, parameter);
                [W, R] = imwarp(obj.truncTemplate,originRef,H);
                offsetX = R.XWorldLimits(1);
                offsetY = R.YWorldLimits(1);
                output = img * 0.5;
                [h,w] = size(W);
                for u = 1:h
                    for v = 1:w
                        if (round(u+offsetX) > 0 && round(u+offsetX) <= Height...
                                && round(v+offsetY) > 0 && round(v+offsetY) <= Width)
                            output(round(u+offsetX),round(v+offsetY)) = output(round(u+offsetX),round(v+offsetY)) + 0.5 * W(u,v);
                        end
                    end
                end
                imshow(output);
        end
    end
end