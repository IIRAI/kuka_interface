function set_left_arm(pose)
%SET_LEFT_ARM updates the waypoint list for the robot.
%   INPUT:
%       -`pose`: waypoint (6x1) of the left end effector (velvet-tray)

% stores the waypoints from (dual manipulation) to be executed
% in this function the new waypoint is added to this list
global manipulation_mov
global hand_synergy

% update simulink model
disp('setting LEFT hand')
% convert dual manipulation pose to reverse priority reference system
pose_left = ee_2_left7link(pose, 'dual_manipulation');
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

% waypoint = [pose_left; zeros(6,1)];
if isempty(manipulation_mov)
    waypoint = avoid_table(pose_left, 0, pose_left(2));
else
    % find last z value of the velvet pose
    z_left_values = manipulation_mov(3, :);
    z_last_value = z_left_values(1:find(z_left_values, 1, 'last'));
    % find last y value of the velvet pose
    y_left_values = manipulation_mov(2, :);
    y_last_value = y_left_values(1:find(y_left_values, 1, 'last'));
    
    if ~isempty(z_last_value) && ~isempty(y_last_value)
        waypoint = avoid_table(pose_left,  z_last_value(end), y_last_value(end));
    else
        waypoint = avoid_table(pose_left, 0, pose_left(2));
    end
end

disp(' ')
disp(' ')

disp(' ***** list of manipulation waypoints: ')

manipulation_mov = [manipulation_mov, waypoint];

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

end

