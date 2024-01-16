function dxi = diff_se3(xi)
% Given wT1 wT2 ... wTn, it will calculate kTk+1
% xi 6xn
% dxi 6x(n-1)

    for i = 1:length(xi)-1
        T1=exp_se3(-xi(:,i));
        T2=exp_se3(xi(:,i+1));
        dxi(:,i)=log_se3(T1*T2);
    end