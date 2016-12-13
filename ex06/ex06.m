%% exercise 1
% initialize intrinsic / extrensic parameters
A = [472.3 0.64 329.0; 0 471.0 268.3; 0 0 1];
R0 = eye(3);
T0 = [0; 0; 0];
% Get the first image
I0 = getImage(0);
% extract SIFT interesting points
[f0, d0] = ComputeSIFT(I0);
[~,nbsift] = size(f0);
% get 3D points
m0 = [f0(1:2,:);ones([1,nbsift])];
M0 = A\m0;
disp(size(M0))
%% exercise 2
% match SIFT points for all images
NBIMAGE = 44;
for i=1:NBIMAGE
    Ii = getImage(i);
    [fi,di] = ComputeSIFT(Ii);
    [matches, scores] = ComputeMatches(d0, di);
    % Reorder matched keypoints and homogenize
    [~, nb_matches] = size(matches);
    X1 = ones(nb_matches, 3);
    X2 = ones(nb_matches, 3);
    X1(:,1:2) = f0(1:2,matches(1,:))';
    X2(:,1:2) = fi(1:2,matches(2,:))';

    s = 5;
    t = 15;
    p = 0.99;
%     T = 20;
%     N = 100;
    %[X1_inline, X2_inline] = naiveRANSAC(X1, X2, @DLT, @EuclideanDistance, s, t, T, N);
    [X1_inline, X2_inline] = adaptiveRANSAC(X1, X2, @DLT, @EuclideanDistance, s, t, p);
    % draw match
    [sx, sy, ~] = size(I0);
    [ox, oy, ~] = size(Ii);
    canvas = zeros([sx, sy+oy, 3]);
    canvas(1:sx, 1:sy, :) = I0(:,:,:);
    canvas(1:ox, sy+1:sy+oy, :) = Ii(:,:,:);
    figure(1);
    imshow(uint8(canvas));
    hold on;
    [nin,~] = size(X1_inline);
    for j=1:nin
        p1 = X1_inline(j,1:2);
        p2 = X2_inline(j,1:2)+[sy,0];
        h = line([p2(1);p1(1)], [p2(2);p1(2)]);
        set(h,'linewidth', 0.1, 'color', 'g');
    end
    saveas(gcf, strcat('data/img_sequence/match',sprintf('%04d',i), '.jpg'))
    hold off;
end
