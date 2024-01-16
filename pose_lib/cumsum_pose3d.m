function C = cumsum_pose3d(A)

N = size(A,2);
C = zeros(size(A));
C(:,1) = A(:,1);

dR = quat2rot(A(4:7,:));
R = cat(3,eye(3),dR);
for i=1:N
  R(:,:,i+1) = R(:,:,i)*dR(:,:,i);
end

tR = A(1:3,:);
for i=1:3
  tR(i,:) = sum(shiftdim(R(i,:,1:N)).*A(1:3,:));
end

C(1:3,:) = cumsum(tR,2);
C(4:7,:) = unwrap_quat(rot2quat(R(:,:,2:N+1)));
