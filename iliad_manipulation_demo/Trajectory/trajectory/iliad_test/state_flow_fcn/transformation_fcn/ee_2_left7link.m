function [left_arm_7_link] = ee_2_left7link(velvet_pose_t)
%EE_2_LEFT7LINK returns the left_arm_7_link pose for RP position control
%   INPUT:
%       - `velvet_pose`: nx1 vector containing the position and orientation
%                        of the velvet tray in table reference system
%   OUTPUT:
%       - `left_arm_7_link`: nx1 vector containing the position and orientation
%                            of the left_arm_7_link wrt the global ref sys
%   Remark: the vector must be compose as follows
%       - the last three values are the orientation
%       - the first n-3 values are the points to be interpolated via
%       spline, each point must be defined in terms of x, y, z value.

%% obtain velvet position in global reference system
velvet_pose  = table2global(velvet_pose_t);

%% velvet offset wrt the left_arm_7_link in local frame
velvet_offset_local = [0, 0, -0.14]';

%% transformation to obtain the velvet offset in global reference system
% angle offset of left_arm_7_link wrt the global frame
ee_rot_offset = [-pi/2, 0, -pi/2];
R_offset = eul2rotm(ee_rot_offset, 'ZYX');

% rotation of the velvet tray
Rot = eul2rotm(velvet_pose(end-2:end)', 'ZYX');

%% compute velvet offset in global frame
velvet_offset = R_offset * Rot * velvet_offset_local;

%% compute position of the left_arm_7_link for each waypoint
% initialize output vector
left_arm_7_link = zeros(length(velvet_pose), 1);

i = 1; % transform all the points from the ee to the 7 link
while i < (length(velvet_pose) - 3)
    left_arm_7_link(i:i + 2) = velvet_pose(i:i + 2) + velvet_offset;

    i = i + 3;
end

% orientation does not change
left_arm_7_link(end-2:end) = velvet_pose(end-2:end); 

end