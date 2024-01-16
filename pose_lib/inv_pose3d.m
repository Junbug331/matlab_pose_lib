function ia = inv_pose3d(a)

ia = a; %zeros(size(a));

if size(a,1)==6
  
  ia = [-quat_rotate(rotvel2quat(-a(4:6,:)),a(1:3,:));
        -a(4:6,:);
        ];
  
elseif size(a,1)>=7
  
  ia(4,:) = a(4,:);
  ia(5:7,:) = -a(5:7,:);
  ia(1:3,:) = -quat_rotate(ia(4:7,:),a(1:3,:));

end
