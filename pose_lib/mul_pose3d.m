function c = mul_pose3d(a,b)
%compose two 6DOF configurations

Na = size(a,2);
Nb = size(b,2);
if Na==1 && Nb>Na
  a = repmat(a,1,Nb);
end
if Nb==1 && Na>Nb
  b = repmat(b,1,Na);
end


%c = zeros(max([size(a); size(b)]));
c = a; %zeros(size(a));


if size(a,1) == 6

qa = [a(1:3,:);rotvel2quat(a(4:6,:));];
qb = [b(1:3,:);rotvel2quat(b(4:6,:));];
qc = mul_pose3d(qa,qb);
c(1:3,:) = qc(1:3,:);
c(4:6,:) = quat2rotvel(qc(4:7,:));

elseif size(a,1) >= 7

c(1:3,:) = a(1:3,:) + quat_rotate(a(4:7,:),b(1:3,:));
c(4:7,:) = renorm(mul_quat(a(4:7,:),b(4:7,:)));  

end


