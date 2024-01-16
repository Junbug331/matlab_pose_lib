
function Rk = traj_interpol_cummulativeSpline_so3(R,Ttime, t_in)
% TODO: currently it does not cover the last time stamp
% firstIndex = find(Ttime<=t_in, 1, 'last');
%     if size(tab,2)<nextIndex

M = [0     1    -2     1
     0    -3     3     0
     0     3     3     0
     6     5     1     0]/6;
        
        
k = find(Ttime<=t_in, 1, 'last');
R0=R(:,:,k-1);

xi1=rot2rotvel(R(:,:,k-1)'*R(:,:,k));
xi2=rot2rotvel(R(:,:,k)'*R(:,:,k+1));
xi3=rot2rotvel(R(:,:,k+1)'*R(:,:,k+2));  

% xi1=dxi(:,k-1); % same as log_se3(inv(R(:,:,k-1))*R(:,:,k));
% xi2=dxi(:,k); % log_se3(inv(R(:,:,k))*R(:,:,k+1));
% xi3=dxi(:,k+1); % log_se3(inv(R(:,:,k+1))*R(:,:,k+2));   


t = (t_in-Ttime(k))/(Ttime(k+1)-Ttime(k));
tv = [ t^3 t^2 t 1   ];
weights = (tv*M);

Rk=R0*rot2rotvel(xi1*weights(2))*rot2rotvel(xi2*weights(3))*rot2rotvel(xi3*weights(4));    

