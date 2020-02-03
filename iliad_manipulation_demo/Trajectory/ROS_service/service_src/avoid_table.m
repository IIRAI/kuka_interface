function waypoint = avoid_table(pose_left, old_lefthand, y_last_value)
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


if (pose_left(3) > 0.70 && old_lefthand <= 0.70)
    if pose_left(3) > 0.8
        z_pose = 0.8;
    else
        z_pose = pose_left(3);
    end
%     pre_wp   = [1.15; y_last_value; z_pose; 0.0; 0.0; 0.0;...
%                 zeros(6,1)];
    pre_wp   = [1.00; y_last_value; z_pose; 0.0; 0.0; 0.0;...
                zeros(6,1)];
    post_wp  = [pose_left;...
                zeros(6,1)];
    waypoint = [pre_wp, post_wp];
elseif ((pose_left(3) < 0.70 && old_lefthand >= 0.70))
%     pre_wp   = [1.15; y_last_value; 0.77; 0.0; 0.0; 0.0;...
%                 zeros(6,1)];
    pre_wp   = [1.00; y_last_value; 0.77; 0.0; 0.0; 0.0;...
                zeros(6,1)];
    post_wp  = [pose_left;...
                zeros(6,1)];
    waypoint = [pre_wp, post_wp];
else
    waypoint = [pose_left; zeros(6,1)];
end

end
