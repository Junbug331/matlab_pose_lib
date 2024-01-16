function e = get_Spline_cp(xicp,cptime,xi,time)


xicp=reshape(xicp,[3 length(xicp)/3]);


for k = 1:length(xi)
    t = traj_interpol_Spline(xicp,cptime, time(k)) ;

    e(3*k-2:3*k)  = t- xi(:,k);
end