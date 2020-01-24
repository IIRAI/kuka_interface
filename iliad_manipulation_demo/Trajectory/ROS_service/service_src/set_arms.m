function set_arms(waypoints)
% description

% global sim_name
data = iliad_data();
sim_name = data.sim_name;
global manipulation_mov
global hand_synergy

poses = zeros(6, 2);

home = [1.5223, 0.9502;...
        0.8010, 0.8011;...
        1.4997, 0.5798];

for t = 1 : length(waypoints)
    waypoint_position    = waypoints(t).Position;
    waypoint_orientation = waypoints(t).Orientation;
    pose_global = [waypoint_position.X;
                   waypoint_position.Y;
                   waypoint_position.Z;
                   waypoint_orientation.Z;
                   waypoint_orientation.Y;
                   waypoint_orientation.X];
    if pose_global(1:3) == zeros(3,1)
        pose_global(1:3) = home(:,t);
    end
    poses(:, t) = global2table(pose_global);
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

% convert dual manipulation pose to reverse priority reference system
pose_right = ee_2_right7link(poses(:,1), 'dual_manipulation');
if isnan(pose_right)
    pose_right = zeros(6,1);
end
pose_left = ee_2_left7link(poses(:,2), 'dual_manipulation');
if isnan(pose_left)
    pose_left = zeros(6,1);
end

% compensate x offset when the velvet is almost vertical (from real test)
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

for i = 1 : size(waypoint, 2)
    if isempty(hand_synergy)
        last_syn = 0.0;
    else
        last_syn = hand_synergy(end);
    end
    hand_synergy = [hand_synergy, last_syn]; 
end

disp('setting Icode value to 3...')
set_param(sim_name + '/Icode', 'Value', '3');

end