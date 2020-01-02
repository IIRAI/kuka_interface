function set_right_arm(pose, synergy)
%SET_RIGHT_ARM updates the waypoint list for the robot.
%   INPUT:
%       -`pose`: waypoint (6x1) of the right end effector (soft-hand)

% stores the waypoints from (dual manipulation) to be executed
% in this function the new waypoint is added to this list
global manipulation_mov
global hand_synergy

% update simulink model
disp('setting RIGHT hand')
% convert dual manipulation pose to reverse priority reference system
pose_right = ee_2_right7link(pose, 'dual_manipulation');
if isnan(pose_right)
    pose_right = zeros(6,1);
end
waypoint = [zeros(6,1); pose_right];
manipulation_mov = [manipulation_mov, waypoint];
if synergy == -1
    if isempty(hand_synergy)
        synergy = 0;
    else
        synergy = hand_synergy(end);
    end
end
hand_synergy     = [hand_synergy, synergy]; 

end

