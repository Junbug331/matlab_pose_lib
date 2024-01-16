% Example pose in R^3 + so3
r=[-1.1142   -2.0312    2.1034
   -1.1142   -2.0642    2.0845
    1.1161    2.0811   -2.0687
    1.1001    2.1027   -2.0433]'

t=[486.7756  868.2090   96.2427
  473.9690  872.6656  117.5077
  467.0888  874.3565  131.6388
  451.6689  879.7380  148.5135]'

R=rotvel2rot(r)


% so3r3 mean
xi_so3r3 = [r;t]
mean(xi_so3r3')' % incorrect!

% se3 mean
xi = so3r3_to_se3(xi_so3r3)
mean(xi')' % incorrect!

% se3 mean 
xi_out = mean_se3(xi) % correct mean

Ti=exp_se3(xi)
exp_se3(xi_out)