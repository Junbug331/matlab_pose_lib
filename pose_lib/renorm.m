function q = renorm(q)
% qn = renorm(q)
% 		This renormalizes each quaternion such that it has unit magnitude;

imag = 1./sqrt(sum(q.^2));

for i=1:size(q,1)
  q(i,:) = q(i,:).*imag(:,:);
end

