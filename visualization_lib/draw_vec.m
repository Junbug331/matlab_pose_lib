%-------------------------------------------------------
function draw_vec(dest,origin,colour)
if nargin <2
    origin =[0 0 0]';
end

if nargin <3
    colour ='r';
end

axis_line_thickness = 1;

quiver3(origin(1),origin(2),origin(3),dest(1),dest(2),dest(3),colour,'LineWidth', axis_line_thickness)
