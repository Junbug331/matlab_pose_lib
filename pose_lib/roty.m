%-------------------------------------------------------
function rotmat= roty(theta)
s = sin(theta/180*pi);
c = cos(theta/180*pi);

rotmat = [c 0 s 0;
    0 1 0 0
    -s 0 c 0
    0 0 0 1];
  