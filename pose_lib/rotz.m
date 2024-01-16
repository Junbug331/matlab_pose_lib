%-------------------------------------------------------
function rotmat= rotz(theta)
s = sin(theta/180*pi);
c = cos(theta/180*pi);

rotmat = [c -s 0 0;
    s c 0 0;
    0 0 1 0;
    0 0 0 1];
  