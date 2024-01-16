function T = exp_SE3(xi)
% Ref: Dense Semantic SLAM
% xi = [r;t]; 1x6 se3
% T = [R t;0^T 1]; 4x4 SE3

% Example and test
% R=rotvel2rot([4 4 5 ]') 
% t = [3 5 2]';
% T = [R t; 0 0 0 1]
% xi = log_se3(T)
% exp_se3(xi)


tsize=size(xi,2);


if tsize>1
    
    for i = 1:tsize
        r = xi(1:3,i);
        t = xi(4:6,i);


        nr = norm(r);


        R=rotvel2rot(r);

        T(:,:,i) = [R t; 0 0 0 1];
    end
else
    r = xi(1:3);
    t = xi(4:6);




    R=rotvel2rot(r);


    T(:,:) = [R t; 0 0 0 1]; 
end
