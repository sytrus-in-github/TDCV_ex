function energy = EnergyFunction( alpha, beta, gamma, tx, ty, tz, A, M0, mt )
    R = AnglesToRotation(alpha, beta, gamma);
    T = [tx;ty;tz];
    energy = 0;
    [~,num_points] = size(M0);
    for i = 1:num_points
       proj = A*(R*M0(:,i)+T);
       proj = proj / proj(3,1);
%        N = norm(proj-mt(:,i));
%        energy = energy + N*N;
       N = proj-mt(:,i);
       energy = energy + N'*N;
    end
end

