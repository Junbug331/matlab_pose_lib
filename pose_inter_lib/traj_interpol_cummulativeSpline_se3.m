
function Tk = traj_interpol_cummulativeSpline_se3(T,Ttime, t_in)
% TODO: currently it does not cover the last time stamp
% firstIndex = find(Ttime<=t_in, 1, 'last');
%     if size(tab,2)<nextIndex

M = [0     1    -2     1
     0    -3     3     0
     0     3     3     0
     6     5     1     0]/6;
        
        
k = find(Ttime<=t_in, 1, 'last');
T0=T(:,:,k-1);

xi1=log_se3(inv(T(:,:,k-1))*T(:,:,k));
xi2=log_se3(inv(T(:,:,k))*T(:,:,k+1));
xi3=log_se3(inv(T(:,:,k+1))*T(:,:,k+2));  

% xi1=dxi(:,k-1); % same as log_se3(inv(T(:,:,k-1))*T(:,:,k));
% xi2=dxi(:,k); % log_se3(inv(T(:,:,k))*T(:,:,k+1));
% xi3=dxi(:,k+1); % log_se3(inv(T(:,:,k+1))*T(:,:,k+2));   


t = (t_in-Ttime(k))/(Ttime(k+1)-Ttime(k));
tv = [ t^3 t^2 t 1   ];
weights = (tv*M);

Tk=T0*exp_se3(xi1*weights(2))*exp_se3(xi2*weights(3))*exp_se3(xi3*weights(4));    

