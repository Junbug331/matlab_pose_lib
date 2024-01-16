function xi = log_SE3(T)
% Ref: Dense Semantic SLAM
% xi = [r;t]; 1x6 se3
% T = [R t;0^T 1]; 4x4 SE3

% Example and test
% R=rotvel2rot([4 4 5 ]') 
% t = [3 5 2]';
% T = [R t; 0 0 0 1]
% xi = log_se3(T)
% exp_se3(xi)

tsize=size(T,3);

for i = 1:tsize
    R= T(1:3,1:3,i);
    t = T(1:3,4,i);

    r=rot2rotvel(R);

    xi(:,i) = [r;t];
end

return
