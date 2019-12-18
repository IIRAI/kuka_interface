function [left_arm_7_link] = ee_2_left7link(velvet_pose_t, reference)
%EE_2_LEFT7LINK returns the left_arm_7_link pose for RP position control
%   INPUT:
%       - `velvet_pose`: nx1 vector containing the position and orientation
%                        of the velvet tray in table reference system
%       - `reference`: is a string with value 'reverse_priority' or 'dual_manipulation',
%                      this specifies which reference system the hand uses, since 
%                      the dual manipulation project adopted a different reference 
%                      system for the hand and a different [0, 0, 0] orientation.
%   OUTPUT:
%       - `left_arm_7_link`: nx1 vector containing the position and orientation
%                            of the left_arm_7_link wrt the global ref sys
%   Remark: the vector must be compose as follows
%       - the last three values are the orientation
%       - the first n-3 values are the points to be interpolated via
%       spline, each point must be defined in terms of x, y, z value.

%% obtain velvet position in global reference system
velvet_pose  = table2global(velvet_pose_t);

%% initialize output vector
left_arm_7_link = zeros(length(velvet_pose), 1);

%% orientation change if the data come fromdual manipulation
if strcmp(reference, 'dual_manipulation')
    left_arm_7_link(end-2:end) = dm2rp_velvet(velvet_pose(end-2:end));
else % strcmp(reference, 'reverse_priority') <-- default reference system
    left_arm_7_link(end-2:end) = velvet_pose(end-2:end); 
end

%% velvet offset wrt the left_arm_7_link in local frame
velvet_offset_local = [0; 0.05; -0.15];

%% transformation to obtain the velvet offset in global reference system
% angle offset of left_arm_7_link wrt the global frame
ee_rot_offset = [-pi/2, 0, -pi/2];
R_offset = eul2rotm(ee_rot_offset, 'ZYX');

% rotation of the velvet tray
Rot = eul2rotm(left_arm_7_link(end-2:end)', 'ZYX');

%% compute velvet offset in global frame
velvet_offset = R_offset * Rot * velvet_offset_local;

%% compute position of the left_arm_7_link for each waypoint
i = 1; % transform all the points from the ee to the 7 link
while i < (length(velvet_pose) - 3)
    left_arm_7_link(i:i + 2) = velvet_pose(i:i + 2) + velvet_offset;
    i = i + 3;
end

end