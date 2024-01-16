function xi = so3r3_to_se3(so3r3)
% Given, so3+R^3 poses, this will converts them to se3 poses.
% so3r3 = [r' t'] x n
% r is rotation vector

tsize=size(so3r3,2);

r=so3r3(1:3,:);
R= rotvel2rot(r);
t=so3r3(4:6,:);
for i = 1:tsize      
    T(:,:,i)=eye(4);
    T(1:3,1:3,i)=R(:,:,i);
    T(1:3,4,i)=t(:,i);
end
    


xi = log_se3(T);
