function arm_waypoint(ee_name, pose_global)
%ARM_WAYPOINT manages the iliad waypoints received from Dual Manipulation
%   Input:
%   - `ee_name`: name of the end effector to move ('right_hand', 'left_hand')
%   - `pose_global`: 6x1 vector [x, y, z, Z, Y, X]
%                    where: 
%                       [x, y, z]: waypoint position
%                       [Z, Y, Z]: waypoint orientation

% stores the waypoints from (dual manipulation) to be executed
% in this function the new waypoint is added to this list
global manipulation_mov

persistent old_right old_left
if isempty(old_right)
    old_right = zeros(6,1);
end
if isempty(old_left)
    old_left = zeros(6,1);
end
  
pose = global2table(pose_global);
% checkity check, chick chack
if pose(4) == 0 && pose(5) == 0 && pose(6) == 0 && strcmp(ee_name, 'right_hand')
    pose = old_right;
end
if pose(4) == 0 && pose(5) == 0 && pose(6) == 0 && strcmp(ee_name, 'left_hand')
    pose = old_left;
end
% update old_orientation
if strcmp(ee_name, 'right_hand')
    old_right = pose;
elseif strcmp(ee_name, 'left_hand')
    old_left = pose;
end

disp('display pose in table')
disp(pose)
disp('of the end effector')
disp(ee_name)

if strcmp(ee_name, 'right_hand') || strcmp(ee_name, 'closed_hand') || strcmp(ee_name, 'opened_hand')
    % update simulink model
    disp('setting RIGHT hand')
    % convert dual manipulation pose to reverse priority reference system
    pose_right = ee_2_right7link(pose, 'dual_manipulation');
    if isnan(pose_right)
        pose_right = zeros(6,1);
    end
    waypoint = [zeros(6,1); pose_right];
    manipulation_mov = [manipulation_mov, waypoint];
    % -----
elseif strcmp(ee_name, 'left_hand')
    % update simulink model
    disp('setting LEFT hand')
    % convert dual manipulation pose to reverse priority reference system
    pose_left = ee_2_left7link(pose, 'dual_manipulation');
    if isnan(pose_left)
        pose_left = zeros(6,1);
    end
    waypoint = [pose_left; zeros(6,1)];
    manipulation_mov = [manipulation_mov, waypoint];
    % -----
else % here should be something like full robot
    % homing
%     disp(ee_name)
%     disp('full robot is called')
%     waypoint = zeros(12,1);
%     manipulation_mov = [manipulation_mov, waypoint];
end

disp('setting Icode value to 3...')
set_param('iliad_test/Icode', 'Value', '3');

end

