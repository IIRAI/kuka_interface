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
   pose_left(6) <= -1.0
    pose_left(1) = pose_left(1) - ((pose_left(6) + 1.0) / (-1.1 + 1.0)) * 0.05;
    pose_left(3) = pose_left(3) + ((pose_left(6) + 1.0) / (-1.1 + 1.0)) * 0.03;
end

% waypoint = [pose_left; zeros(6,1)];
waypoint = divide_tr_or_left(pose_left);

manipulation_mov = [manipulation_mov, waypoint];
if isempty(hand_synergy)
    last_syn = 0;
else
    last_syn = hand_synergy(end);
end
hand_synergy = [hand_synergy, last_syn]; 

end

