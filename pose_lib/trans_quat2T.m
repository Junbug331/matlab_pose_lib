function T = trans_quat2T(tq)
% input: tq = 7xn, tq=[t; q]
% output:
len = size(tq,2);
t = tq(1:3,:);
q = tq(4:7,:);

R = quat2rot(q);

for i=1:len
    
   Tmp = eye(4);  
   Tmp(1:3,1:3) = R(:,:,i);  
   Tmp(1:3,4) = t(:,i); 
   T(:,:,i) = Tmp;
end