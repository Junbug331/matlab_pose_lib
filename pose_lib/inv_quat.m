function iq = inv_quat(q)
iq = [q(1,:);-q(2:4,:)];
iq = reshape(iq,size(q));