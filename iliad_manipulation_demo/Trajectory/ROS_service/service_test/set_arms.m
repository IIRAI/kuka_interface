function set_arms(waypoints)
% description

global sim_name
global manipulation_mov

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


disp('++++++++++++++++++++++++++')
poses
disp('++++++++++++++++++++++++++')


% update simulink model
disp('setting FULL ROBOT')

if isnan(poses(4:6,1))  % right hand
    poses(4:6,1) = [0.0; 1.57; 0.0];
end

if isnan(poses(4:6,2))  % left hand
    poses(4:6,2) = [3.14; 1.57; 0.0];
end

% convert dual manipulation pose to reverse priority reference system
pose_right = ee_2_right7link(poses(:,1), 'dual_manipulation');
if isnan(pose_right)
    pose_right = zeros(6,1);
end
pose_left = ee_2_right7link(poses(:,2), 'dual_manipulation');
if isnan(pose_left)
    pose_left = zeros(6,1);
end

waypoint = [pose_left; pose_right];
manipulation_mov = [manipulation_mov, waypoint];

disp('setting Icode value to 3...')
set_param(sim_name + '/Icode', 'Value', '3');

end