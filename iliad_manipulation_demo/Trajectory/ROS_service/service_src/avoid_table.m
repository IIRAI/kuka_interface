function waypoint = avoid_table(pose_left, old_z_lefthand)
%AVOID_TABLE: when there is a risk to collide with the table,
% this function divides the waypoints `pose_left` in two waypoint:
% first goes up above the table the other is the old waypoint.
%   INPUT:
%       -`pose_left`: vector [6x1], waypoint for the velvet
%       -`old_z_lefthand`: scalar, z value of the previous waypoint of the
%       velvet end-effector
%   OUTPUT:
%       -`waypoint`: vector [6x2], each column is a waypoint
%               first waypoint  -> goes up
%               second waypoint -> goes to original target

if pose_left(3) > 0.80 && old_z_lefthand <= 0.80
    pre_wp   = [1.00; pose_left(2); pose_left(3) + 0.05; 0.0; 0.0; 0.0; zeros(6,1)];
    post_wp  = [pose_left; zeros(6,1)];
    waypoint = [pre_wp, post_wp];
else
    waypoint = [pose_left; zeros(6,1)];
end

end
