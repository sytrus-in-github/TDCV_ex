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

%% exercise 2 and 3
% Ransac paramaters
s = 5;
t = 15;
p = 0.99;

param_t = [0,0,0,0,0,0];
camera_coord = zeros(3,45);
for index = 1:44
    disp(index);
    % Get the image
    It = getImage(index);

    % extract SIFT interesting points
    [ft, dt] = ComputeSIFT(It);
    
    num_inliers = 0;
    while num_inliers < 50
        [m0, mt] = SIFTTracking(f0, d0, ft, dt, s, t, p);
        [num_inliers, ~] = size(m0);
    end
    
    %DrawMatches(I0, It, m0, mt, index);
    M0 = A\m0';
    
    fun = @(param)EnergyFunction(param(1),param(2),param(3),param(4),param(5),param(6), A, M0, mt');
    
    newparam_t = fminsearch(fun, param_t);
    param_t = newparam_t;
    camera_coord(:,index+1) = AnglesToRotation(param_t(1),param_t(2),param_t(3))*[-param_t(4);-param_t(5);-param_t(6)];
end
figure(2); clf;
plot3(camera_coord(1,:),camera_coord(2,:),camera_coord(3,:));
for index = 1:45
   text(camera_coord(1,index), camera_coord(2,index), camera_coord(3,index), int2str(index-1)); 
end
