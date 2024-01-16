function xi = inv_se3(xi_in)
% xi in 6xn
% xi out 6xn
    for i = 1:size(xi_in,2)
        xi(:,i)=-xi_in(:,i);
    end