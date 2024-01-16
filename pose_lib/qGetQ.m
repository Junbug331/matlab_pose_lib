function Q = qGetQ( R )
% qGetQ: converts 3x3 rotation matrix into equivalent quaternion
% Q = qGetQ( R );

[r,c,s] = size( R );
if( r ~= 3 | c ~= 3 )
    fprintf( 'R must be a 3x3 matrix\n\r' );
    return;
end

Q = zeros(4,s);

for q = 1:s
    % [ Rxx, Rxy, Rxz ] = R(1,1:3); 
    % [ Ryx, Ryy, Ryz ] = R(2,1:3);
    % [ Rzx, Rzy, Rzz ] = R(3,1:3);
    
    r = R(:,:,q);

    Rxx = r(1,1); Rxy = r(1,2); Rxz = r(1,3);
    Ryx = r(2,1); Ryy = r(2,2); Ryz = r(2,3);
    Rzx = r(3,1); Rzy = r(3,2); Rzz = r(3,3);

    w = sqrt( trace( r ) + 1 ) / 2;

    % check if w is real. Otherwise, zero it.
    if( imag( w ) > 0 )
        w = 0;
    end

    x = sqrt( 1 + Rxx - Ryy - Rzz ) / 2;
    y = sqrt( 1 + Ryy - Rxx - Rzz ) / 2;
    z = sqrt( 1 + Rzz - Ryy - Rxx ) / 2;

    [~, i ] = max( [w,x,y,z] );

    if( i == 1 )
        x = ( Rzy - Ryz ) / (4*w);
        y = ( Rxz - Rzx ) / (4*w);
        z = ( Ryx - Rxy ) / (4*w);
    end

    if( i == 2 )
        w = ( Rzy - Ryz ) / (4*x);
        y = ( Rxy + Ryx ) / (4*x);
        z = ( Rzx + Rxz ) / (4*x);
    end

    if( i == 3 )
        w = ( Rxz - Rzx ) / (4*y);
        x = ( Rxy + Ryx ) / (4*y);
        z = ( Ryz + Rzy ) / (4*y);
    end

    if( i == 4 )
        w = ( Ryx - Rxy ) / (4*z);
        x = ( Rzx + Rxz ) / (4*z);
        y = ( Ryz + Rzy ) / (4*z);
    end

    Q(1:4,q) = [ w; x; y; z ];
end