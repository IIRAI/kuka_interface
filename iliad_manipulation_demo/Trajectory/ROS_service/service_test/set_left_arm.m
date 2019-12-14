function set_left_arm(pose)
%SET_LEFT_ARM updates the waypoint list for the robot.
%   INPUT:
%       -`pose`: waypoint (6x1) of the left end effector (velvet-tray)

% stores the waypoints from (dual manipulation) to be executed
% in this function the new waypoint is added to this list
global manipulation_mov

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
   pose_left(6) == -1.10
    pose_left(1) = pose_left(1) - 0.05;
end

waypoint = [pose_left; zeros(6,1)];
manipulation_mov = [manipulation_mov, waypoint];

end

