function [pose_in_global] = table2global(pose_in_table)
%TABLE2GLOBAL transform from table ref sys to global ref sys.
%   INPUT:
%       - `pose_in_table`: 6x1 vector containing the position and orientation
%                          of the end-effector wrt the table reference system
%   OUTPUT:
%       - `pose_in_global`: 6x1 vector containing the position and orientation
%                           of the end-effector wrt the global ref sys
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
table_position = [1.3500; 1.2010; 0.7000; zeros(3,1)];

% position wrt the table written in the global reference system
Rot_table = eul2rotm([-pi/2, 0, 0], 'ZYX');
pose_in_table(1:3) = Rot_table * pose_in_table(1:3);

% end-effector position in global reference system
pose_in_global = table_position + pose_in_table;

end

