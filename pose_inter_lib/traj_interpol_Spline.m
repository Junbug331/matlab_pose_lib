
function tk = traj_interpol_Spline(t,Ttime, t_in)
% TODO: currently it does not cover the last time stamp
% firstIndex = find(Ttime<=t_in, 1, 'last');
%     if size(tab,2)<nextIndex


% Basis matrix
M = [-1 3 -3 1;3 -6 3 0; -3 0 3 0;1 4 1 0];
        
        
k = find(Ttime<=t_in, 1, 'last');

t_ = (t_in-Ttime(k))/(Ttime(k+1)-Ttime(k));

tv = [t_^3 t_^2 t_ 1];


% control points index 
t_4 = t(:,k-1:k+2)'; 
tvm = tv*M/6;
tk=tvm*t_4;

