%% Example and test

%% Demo 1: SE3 -> se3
R=rotvel2rot([4 4 5 ]') ;
t = [3 5 2]';
T = [R t; 0 0 0 1]

xi = log_se3(T)

%% Demo 2: se3 -> SE3
xi
T2=exp_se3(xi)

T-T2