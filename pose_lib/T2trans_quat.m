function tq = T2trans_quat(T)
% output: tq = 7xn, tq=[t; q]
% input:
len = size(T,3);
t = T(1:3,4,:);
R = T(1:3,1:3,:);

q = rot2quat(R);


tq = [t;q];
