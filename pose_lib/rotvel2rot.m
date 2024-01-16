function R = rotvel2rot(w)
%ROTVEL2ROT  convert a rotational velocity vector into a rotation matrix

R = quat2rot(rotvel2quat(w));

return 


t = norm(w);
if (t>0)
    W = skew(w/t);
    R = eye(3) + sin(t)*W + (1-cos(t))*W^2;
else
    R = eye(3);
end
return
