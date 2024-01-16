
close all
% se3 interpolation example

% two random poses
% xyz rx ry rz t
pose=[
    0 0 0   0.1059   -0.2393   -0.1357  0   
     0 0 0   0.0059   -0.1393   -0.0357  1
     0 0 0   -0.8050    0.012    0.9373  2 
 0 0 0   -0.9050    0.112    0.8373  3 ];

% draw trajectory
figure(1)
axis equal
grid on


% draw coordinate frames
for t=0:0.05:3
    t
        [drotm dtrans]  = traj_interpol(pose', t,'pchip','ROTVEL');           
        Ttmp = [drotm dtrans; 0 0 0 1];
        hold on
        draw_axis_from_T(Ttmp,'',1,1,0);
        hold on
        pause(0.1) 
        wqc =rot2quat(drotm);
end


