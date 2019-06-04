function [right_arm_7_link] = ee_2_right7link(hand_pose_t)
%EE_2_RIGHT7LINK returns the right_arm_7_link pose for RP position control
%   INPUT:
%       - `hand_pose`: nx1 vector containing the position and orientation
%                      of the soft hand in table reference system
%   OUTPUT:
%       - `right_arm_7_link`: nx1 vector containing the position and orientation
%                             of the right_arm_7_link wrt the global ref sys
%   Remark: the vector must be compose as follows
%       - the last three values are the orientation
%       - the first n-3 values are the points to be interpolated via
%       spline, each point must be defined in terms of x, y, z value.

%% obtain hand position in global reference system
hand_pose = table2global(hand_pose_t);

%% soft hand offset wrt the right_arm_7_link in local frame
hand_offset_local = [0, 0, -0.20]';

%% transformation to obtain the soft hand offset in global reference system
% angle offset of right_arm_7_link wrt the global frame
ee_rot_offset = [-pi, -pi/2, 0];
R_offset = eul2rotm(ee_rot_offset, 'ZYX');

% rotation of the soft hand
Rot      = eul2rotm(hand_pose(end-2:end)', 'ZYX');

%% compute hand offset in global frame
hand_offset = R_offset * Rot * hand_offset_local;

%% compute position of the right_arm_7_link for each waypoint
% initialize output vector
right_arm_7_link = zeros(length(hand_pose), 1);

i = 1; % transform all the points from the ee to the 7 link
while i < (length(hand_pose) - 3)
    right_arm_7_link(i:i + 2) = hand_pose(i:i + 2) + hand_offset;

    i = i + 3;
end

% orientation does not change
right_arm_7_link(end-2:end) = hand_pose(end-2:end); 

end