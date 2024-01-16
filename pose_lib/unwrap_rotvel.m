function rvel = unwrap_rotvel(rvel)
%get the axis angle to be continuous

angle = sqrt(sum(rvel.^2));
angle(angle==0)=eps;
ax = rvel./(angle([1 1 1],:));
d = sum(rvel(:,1:end-1).*rvel(:,2:end));
flips = find(d<0);%-(pi/2)^2);
s = zeros(1,size(ax,2)-1);
s(flips(1:2:end)) = -2;
s(flips(2:2:end)) = 2;
s = cumsum([1 s]);
ax = ax.*s(ones(size(ax,1),1),:);
angle = unwrap(angle.*s);
rvel = ax.*angle([1 1 1],:);