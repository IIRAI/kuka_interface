function [right_arm_7_link] = ee_2_right7link(hand_pose)
%EE_2_RIGHT7LINK returns the right_arm_7_link pose for RP position control
%   INPUT:
%       - `hand_pose`: 6x1 vector containing the position and orientation
%                      of the soft hand in global reference system
%   OUTPUT:
%       - `right_arm_7_link`: 6x1 vector containing the position and orientation
%                             of the right_arm_7_link wrt the global ref sys

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

%% compute position of the right_arm_7_link 
right_arm_7_link = hand_pose + [hand_offset; zeros(3,1)];

end