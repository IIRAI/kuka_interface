function arm_waypoint(ee_name, command, pose_global)
%ARM_WAYPOINT manages the iliad waypoints received from Dual Manipulation
%   Input:
%   - `ee_name`: name of the end effector to move ('right_hand', 'left_hand')
%   - `pose_global`: 6x1 vector [x, y, z, Z, Y, X]
%                    where: 
%                       [x, y, z]: waypoint position
%                       [Z, Y, Z]: waypoint orientation

% global sim_name
data = iliad_data();
sim_name = data.sim_name;

persistent old_right old_left
if isempty(old_right)
    old_right = zeros(6,1);
end
if isempty(old_left)
    old_left = zeros(6,1);
end

pose = global2table(pose_global);
% checkity check, chick chack
if pose(4) == 0 && pose(5) == 0 && pose(6) == 0 && (strcmp(ee_name, 'right_hand') || strcmp(ee_name, 'closed_hand') || strcmp(ee_name, 'opened_hand'))
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
 
if strcmp(ee_name, 'right_hand')
    if strcmp(command, 'simple_grasp')
        disp(' ')
        disp(' ====== right hand, simple grasp ======= ')
        set_right_arm(pose, 0.5);
        disp(' ')
    elseif strcmp(command, 'simple_ungrasp')
        disp(' ')
        disp(' ====== right hand, simple UNgrasp ======= ')
        set_right_arm(pose, 0.0);
        disp(' ')
    else
        disp(' ')
        disp(' ====== right hand, NOT simple grasp ======= ')
        set_right_arm(pose, -1);
        disp(' ')
    end
else % strcmp(ee_name, 'left_hand')
    if strcmp(command, 'simple_grasp')
        disp(' ')
        disp(' ====== left hand, simple grasp ======= ')
        set_left_arm(pose, 0);
        disp(' ')
    elseif strcmp(command, 'simple_ungrasp')
        disp(' ')
        disp(' ====== left hand, simple UNgrasp ======= ')
        set_left_arm(pose, 1);
        disp(' ')
    else 
        disp(' ')
        disp(' ====== left hand, NOT simple grasp ======= ')
        set_left_arm(pose, -1);
        disp(' ')
    end
end

disp('setting Icode value to 3...')
set_param(sim_name + '/Icode', 'Value', '3');

end

