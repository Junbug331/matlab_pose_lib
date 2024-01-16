function q = cumsum_quat(dq)

N = size(dq,2);
q = zeros(4,N);

q(:,1) = dq(:,1);

for i=2:N
  q(:,i) = mul_quat(q(:,i-1),dq(:,i));
end


end

function r = mul_quat(p,q)

r = [ 
    p(1).*q(1) - sum(p(2:4).*q(2:4)); 
    p(1).*q(2:4) + ...
    q(1).*p(2:4) + ...
    p([3 4 2]).*q([4 2 3]) - ...
    p([4 2 3]).*q([3 4 2])];

end