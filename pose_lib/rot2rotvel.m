function w = rot2rotvel(Rs)
%ROT2ROTVEL  convert a rotational matrix into a rotation velocity vector

axang = rotm2axang(Rs(1:3,1:3));
w = axang(1:3)'*axang(4);

return

q = (acos((Rs(1,1,:)+Rs(2,2,:)+Rs(3,3,:)-1)/2));
q = q(:)';
w = zeros(3,length(q));
g = find(q);
if ~isempty(g)
    w(:,g) = reshape(...
        [(Rs(3,2,g)-Rs(2,3,g));
        (Rs(1,3,g)-Rs(3,1,g));
        (Rs(2,1,g)-Rs(1,2,g)); ], [3, length(g)])/2.*q([1 1 1],g)./sin(q([1 1 1],g));
end
return


