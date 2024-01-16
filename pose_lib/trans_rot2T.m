function T = trans_rot2T(tr)
% input: tr = 6xn, tr=[t; r]
% output:
len = size(tr,2);
t = tr(1:3,:);
q = tr(4:6,:);

R = rotvel2rot(q);

for i=1:len
    
   Tmp = eye(4);  
   Tmp(1:3,1:3) = R(:,:,i);  
   Tmp(1:3,4) = t(:,i); 
   T(:,:,i) = Tmp;
end