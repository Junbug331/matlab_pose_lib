function [qs,qs0,t,bs,rvel,accb,magb] = load_imu_data_raw(fname,q0,b0,imu_topic_name)

if ~exist('imu_topic_name')
  imu_topic_name = '/imu0';
end
if ~strncmp(imu_topic_name,'/',1)
    imu_topic_name = ['/' imu_topic_name];   
end

imu_topic_name='imu/data';%wildcat

[~,filename,ext] = fileparts(fname);
if exist('read_bag','file')==3 && strcmp(ext,'.bag')
  d = read_bag(fname,imu_topic_name);
  t = d(3,:);
elseif exist('rosbag_wrapper','file')==3 && strcmp(ext,'.bag')
  bag = ros.Bag(fname);
  msgs = bag.readAll(imu_topic_name);
  accessor = @(msg) msg;
  converter = @(msg) [double(msg.header.seq); double(msg.header.stamp.sec); double(msg.header.stamp.nsec); ...
    double(msg.orientation); double(msg.orientation_covariance);
    double(msg.angular_velocity); double(msg.angular_velocity_covariance);
    double(msg.linear_acceleration); double(msg.linear_acceleration_covariance)];
  d = ros.msgs2mat(msgs,accessor,converter);
  d = [d(2,:)+d(3,:)*1e-9; d(1,:); d(2,:)+d(3,:)*1e-9; d(4:end,:)];
  t = d(3,:);%time stamp
else % assuming can only read .txt or .txt.gz files
  fnametxt = strrep(fname,'.bag',sprintf('_%s.txt',strrep(imu_topic_name,'/','')));
  d = load_txtgz_data(fnametxt)';
  t = d(3,:)*1e-9;
end

qs0 = d([7 4 5 6],:);
rvel = d(17:19,:);
accb = d(29:31,:);
magb = d(8:10,:);

if ~exist('q0') || isempty(q0)
    q0 = rot2quat(eye(3)); % same as [1 0 0 0]'; 
    %q0 = qs0(:,1); 
end
if ~exist('b0') || isempty(b0), 
  b0 = zeros(3,1); 
  b0 = mean(rvel(1:3,1:min(500,end)),2);
end

dt = 1/100;
dt = median(diff(t));

bs = repmat(b0,1,size(qs0,2));
%qs0 : origianal orientation from IMU
%qs : accumulated rotational velocity, bias removed
qs = mul_quat(q0,cumsum_quat(rotvel2quat((rvel-bs)*dt)));

breaks = [0 find(diff(t)>10/100) length(t)]
for i=2:length(breaks)
  g = breaks(i-1)+1:breaks(i);
  [p,s,m] = polyfit(g,t(g),1);
  ts(g) = polyval(p,g',[],m);
end

%[t,errs,rerr] = smooth_time2(t',dt,[.01 .00005],inf,1e-3);
t = ts(:);

% accellerometer data is delayed a bit so correct it
%accb = interp1(1:length(accb),accb',(1:length(accb))'+.75,'pchip','extrap')';
