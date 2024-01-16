function tq = T2trans_rot(T)
% output: tr = 6xn, tr=[t; r]
% input:
len = size(T,3);
t = T(1:3,4,:);
R = T(1:3,1:3,:);

r = rot2rotvel(R);


tq = [t;r];
