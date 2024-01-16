function xi_out = mean_se3(xi)
% Ref: 
% xi = [r;t]; 1x6xn se3
% xi_out = [r;t]; 1x6 se3

num_pose =size(xi,2);
T = exp_se3(xi(:,1));
Ti=exp_se3(xi);
dxi = 0;
for i=1:100
    for j = 1:num_pose
        dxi = dxi+log_se3(inv_SE3(T)*Ti(:,:,j));
    end
    dxi=dxi/num_pose;
    
    if norm(dxi)<10^-8
        break;
    end
    
    T = T*exp_se3(dxi);
end
    

xi_out = log_se3(T);
