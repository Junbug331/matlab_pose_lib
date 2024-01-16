% to extract uniformly distributed image features. 
% this uses bin based occupancy grid( idea is from SVO).
% use with matlab feature tracker.
function points = selectUniformImgSpace(points1,W,H,binsize)

if nargin < 4
    binsize = 10;
end

bins(binsize, binsize,4) = 0;
try
for p = 1:length(points1.Location)
    l=points1.Location(p,:);
    x = l(1);
    y = l(2);
    
    % if already existing feature is weaker than the new one, replace.
    if bins(floor(((x-1)/W)*binsize+1), floor(((y-1)/H)*binsize+1),3) <points1.Metric(p)
        bins(floor(((x-1)/W)*binsize+1), floor(((y-1)/H)*binsize+1),1:2)=[x y];
        bins(floor(((x-1)/W)*binsize+1), floor(((y-1)/H)*binsize+1),3)=points1.Metric(p);
        bins(floor(((x-1)/W)*binsize+1), floor(((y-1)/H)*binsize+1),4)=p;
    end
    
end
catch
    a = 1
end

% select points according to the bin occupation result.
ind = find(bins(:,:,4)>0);
a=bins(:,:,4);
final_ind=a(ind);
points = points1(final_ind);

