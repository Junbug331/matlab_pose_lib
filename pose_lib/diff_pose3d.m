function dtq = diff_pose3d(tq0)
% dq = diff_quat(q0,q1)
% dq is the quaternion that rotates q0*dq into q1


tq1 = tq0(:,2:end);
tq0 = tq0(:,1:end-1);

dtq = mul_pose3d(inv_pose3d(tq0),tq1);
