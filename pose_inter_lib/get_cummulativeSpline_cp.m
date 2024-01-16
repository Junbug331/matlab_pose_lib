function e = get_cummulativeSpline_cp(xicp,cptime,xi,time)

xicp=reshape(xicp,[6 length(xicp)/6]);

Tcp=exp_se3(xicp);
for k = 1:length(xi)
%for k = 12:length(xi)-13
    Tinter = traj_interpol_cummulativeSpline_se3(Tcp,cptime,time(k));
    Tdst=exp_se3(xi(:,k));
    e(6*k-5:6*k)  = log_se3(inv(Tinter)*Tdst);
end