function [left_arm_7_link] = ee_2_left7link(velvet_pose)
%EE_2_LEFT7LINK returns the left_arm_7_link pose for RP position control
%   INPUT:
%       - `velvet_pose`: 6x1 vector containing the position and orientation
%                        of the velvet tray in global reference system
%   OUTPUT:
%       - `left_arm_7_link`: 6x1 vector containing the position and orientation
%                            of the left_arm_7_link wrt the global ref sys

%% velvet offset wrt the left_arm_7_link in local frame
velvet_offset_local = [0, 0, -0.14]';

%% transformation to obtain the velvet offset in global reference system
% angle offset of left_arm_7_link wrt the global frame
ee_rot_offset = [-pi/2, 0, -pi/2];
R_offset = eul2rotm(ee_rot_offset, 'ZYX');

% rotation of the velvet tray
Rot      = eul2rotm(velvet_pose(end-2:end)', 'ZYX');

%% compute velvet offset in global frame
velvet_offset = R_offset * Rot * velvet_offset_local;

%% compute position of the left_arm_7_link 
left_arm_7_link = velvet_pose + [velvet_offset; zeros(3,1)];

end

