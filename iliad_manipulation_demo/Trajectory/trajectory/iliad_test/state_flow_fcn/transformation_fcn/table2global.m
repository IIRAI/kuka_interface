function [pose_in_global] = table2global(pose_in_table)
%TABLE2GLOBAL transform from table ref sys to global ref sys.
%   INPUT:
%       - `pose_in_table`: nx1 vector containing the position and orientation
%                          of the end-effector wrt the table reference system
%   OUTPUT:
%       - `pose_in_global`: nx1 vector containing the position and orientation
%                           of the end-effector wrt the global ref sys
%   Remark: the vector must be compose as follows
%       - the last three values are the orientation
%       - the first n-3 values are the points to be interpolated via
%       spline, each point must be defined in terms of x, y, z value.
% ------------------------------------------------------------------------
% table reference system scheme
% ___________________
% |    Table        |
% ^    Plane        |
% |Y                |
% |    X            |
% +----->___________|
% 
% table dimension from rviz model
% length = 0.6 [m]
% width  = 0.8 [m]
% height = 0.7 [m]
% 
% ------------------------------------------------------------------------

% table position, see rviz.
global table_rs
table_position = table_rs;

% rotation of the table reference system
Rot_table = eul2rotm([-pi/2, 0, 0], 'ZYX');

% initialize pose in global reference system
pose_in_global = zeros(length(pose_in_table),1);

i = 1; % transform all the points from the table to the global reference system
while i < (length(pose_in_table) - 3) 
    % rotate reference system
    pose_in_table(i:i + 2) = Rot_table * pose_in_table(i:i + 2);
    % end-effector position in global reference system
    pose_in_global(i:i + 2) = table_position + pose_in_table(i:i + 2);

    i = i + 3;
end

% orientation does not change
pose_in_global(end-2:end) = pose_in_table(end-2:end); 

end