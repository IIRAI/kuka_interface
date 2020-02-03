function set_arms(waypoints)
% description

% global sim_name
data = iliad_data();
sim_name = data.sim_name;
global manipulation_mov
global hand_synergy
global velvet_synergy

poses = zeros(6, 2);
pose_global = zeros(6, 2);

home = [1.5223, 0.9502;...
        0.8010, 0.8011;...
        1.4997, 0.5798];

for t = 1 : length(waypoints)
    waypoint_position    = waypoints(t).Position;
    waypoint_orientation = waypoints(t).Orientation;
    pose_global(:, t) = [waypoint_position.X;
                         waypoint_position.Y;
                         waypoint_position.Z;
                         waypoint_orientation.Z;
                         waypoint_orientation.Y;
                         waypoint_orientation.X];   
end

if pose_global(1:3, 1) == zeros(3,1)
    pose_global(:, 1) = zeros(6,1);
    pose_global(:, 2) = zeros(6,1);
elseif pose_global(1:3, 2) == zeros(3,1)
    pose_global(:, 1) = zeros(6,1);
    pose_global(:, 2) = zeros(6,1);
end

for t = 1 : length(waypoints)
    if pose_global(1:3, t) == zeros(3,1)
        pose_global(1:3, t) = home(:,t);
    end
    poses(:, t) = global2table(pose_global(:, t));
end

% update simulink model
disp('setting FULL ROBOT')

if isnan(poses(4:6,1)) | poses(4:6,1) == zeros(3,1) % right hand
    poses(4:6,1) = [0.0; 1.57; 0.0];
end
if isnan(poses(4:6,2)) | poses(4:6,2) == zeros(3,1)  % left hand
    poses(4:6,2) = [3.14; -1.57; 0.00];
end

disp('++++++++++++++++++++++++++')
poses
disp('++++++++++++++++++++++++++')

% select the proper waypoint for the left arm and the right arm
if poses(3,1) > poses(3,2)  % the right arm z value must be higher than the left arm
    r_pose = poses(:,1);
    l_pose = poses(:,2);
else
    r_pose = poses(:,2);
    l_pose = poses(:,1);
end

% convert dual manipulation pose to reverse priority reference system
pose_right = ee_2_right7link(r_pose, 'dual_manipulation');
if isnan(pose_right)
    pose_right = zeros(6,1);
end
pose_left = ee_2_left7link(l_pose, 'dual_manipulation');
if isnan(pose_left)
    pose_left = zeros(6,1);
end

% compensate x offset when the velvet is almost vertical
if pose_left(4) <= 0.05 && pose_left(4) >= -0.05 &&...
   pose_left(5) <= 0.05 && pose_left(5) >= -0.05 &&...
   pose_left(6) <= -0.9
    pose_left(1) = pose_left(1) - ((pose_left(6) + 0.9) / (-0.9 + 0.8)) * 0.05;
    pose_left(3) = pose_left(3) + ((pose_left(6) + 0.9) / (-0.9 + 0.8)) * 0.03;
end

% waypoint = [pose_left; pose_right];

if isempty(manipulation_mov)
    waypoint = avoid_table(pose_left, 0, pose_left(2));
else    
    % find last z value of the velvet pose
    z_left_values = manipulation_mov(3, :);
    z_last_value = z_left_values(1:find(z_left_values,1,'last'));
    % find last y value of the velvet pose
    y_left_values = manipulation_mov(2, :);
    y_last_value = y_left_values(1:find(y_left_values,1,'last'));
    
    if ~isempty(z_last_value) && ~isempty(y_last_value)
        waypoint = avoid_table(pose_left,  z_last_value(end), y_last_value(end));
    else
        waypoint = avoid_table(pose_left, 0, pose_left(2));
    end    
end

% waypoint(7:12, size(waypoint, 2)) = pose_right;
waypoint(7:12, 1) = pose_right; 

disp(' ')
disp(' ')

disp(' ***** list of manipulation waypoints: ')

manipulation_mov = [manipulation_mov, waypoint]

disp(' ')
disp(' ')

% hand synergy
for i = 1 : size(waypoint, 2)
    if isempty(hand_synergy)
        last_syn = 0.0;
    else
        last_syn = hand_synergy(end);
    end
    hand_synergy = [hand_synergy, last_syn]; 
end

% velvet synergy
for i = 1 : size(waypoint, 2)
    if isempty(velvet_synergy)
%         last_syn = 0.5;
        last_syn = 1;
    else
        last_syn = velvet_synergy(end);
    end
    velvet_synergy = [velvet_synergy, last_syn]; 
end

disp('setting Icode value to 3...')
set_param(sim_name + '/Icode', 'Value', '3');

end