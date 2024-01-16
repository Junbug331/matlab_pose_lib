function xi = mul_se3(xi1,xi2)
% xi in 6xn
% xi out 6xn

    for i = 1:size(xi1,2)
        T1=exp_se3(xi1(:,i));
        T2=exp_se3(xi2(:,i));
        xi(:,i)=log_se3(T1*T2);
    end