function [Rs ts]  = traj_interpol(tab, t, method,representation)
% quat based interpolation


if nargin <3 
    method = 'linear';
    representation = 'EUCLIDIAN';
end

if nargin <4 

    representation = 'EUCLIDIAN';
end

if strcmp(representation,'EUCLIDIAN')
% it is better than my rotvel interpolation as quat has lower chance of flip. 
    ts = interp1(tab(8,:),tab(1:3,:)',t,method,'extrap')';
    qs = renorm(interp1(tab(8,:),tab(4:7,:)',t,method,'extrap')');

    Rs = quat2rot(qs);

    Rs = permute(Rs,[2 3 1]);

    Rs = [Rs(:,:,1) Rs(:,:,2) Rs(:,:,3)];

elseif strcmp(representation,'ROTVEL')
    
    ts = interp1(tab(7,:), tab(1:3,:)', t, method, 'extrap')';
    qs = interp1(tab(7,:), tab(4:6,:)', t, method, 'extrap')';

    Rs = rotvel2rot(qs);

    Rs = permute(Rs,[2 3 1]);

    Rs = [Rs(:,:,1) Rs(:,:,2) Rs(:,:,3)];
    
elseif strcmp(representation,'ROTVEL_se3')
    % need to be fixed, found during pami experiment. it does not handle
    % the last interpolation.
    firstIndex = find(tab(7,:)<=t, 1, 'last');
    nextIndex = firstIndex + 1;

    if size(tab,2)<nextIndex
        firstIndex = firstIndex-1;
        nextIndex = nextIndex-1;
    end

    tau=(t-tab(7,firstIndex))/(tab(7,nextIndex)-tab(7,firstIndex));


    
    wTk=[rotvel2rot(tab(4:6,firstIndex)) tab(1:3,firstIndex);0 0 0 1];
    wTkp1=[rotvel2rot(tab(4:6,nextIndex)) tab(1:3,nextIndex);0 0 0 1];

    
    kTp1=inv(wTk)*wTkp1;
    
    

    if 0 % it used to be used before but it is not se3 interpolation
        r=rot2rotvel(kTp1(1:3,1:3));
        trans=kTp1(1:3,4);
        dT = [rotvel2rot(r*tau) trans*tau;0 0 0 1];
    else
        xi=log_SE3(kTp1);
        dT = exp_SE3(xi*tau);
    end
        
    wTkt = wTk*dT;
    
    ts = wTkt(1:3,4);
    Rs = wTkt(1:3,1:3)'; % global to local
else

    firstIndex = find(tab(8,:)<t, 1, 'last');
    nextIndex = firstIndex + 1;
    
    tau=(t-tab(8,firstIndex))/(tab(8,nextIndex)-tab(8,firstIndex));

    wTk=[quat2rot(tab(4:7,firstIndex)) tab(1:3,firstIndex);0 0 0 1];
    wTkp1=[quat2rot(tab(4:7,nextIndex)) tab(1:3,nextIndex);0 0 0 1];

    kTp1=inv(wTk)*wTkp1;

    r=rot2rotvel(kTp1(1:3,1:3));
    trans=kTp1(1:3,4);

    dT = [rotvel2rot(r*tau) trans*tau;0 0 0 1];

    wTkt = wTk*dT;
    
    ts = wTkt(1:3,4);
    Rs = wTkt(1:3,1:3)';
end