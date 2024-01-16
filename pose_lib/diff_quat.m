function dq = diff_quat(q0, q1)
% dq = diff_quat(q0,q1)
% dq is the quaternion that rotates q0*dq into q1

if nargin < 2
  q1 = q0(:,2:end);
  q0 = q0(:,1:end-1);
end

dq = renorm(mul_quat(diag([1 -1 -1 -1])*q0,q1));