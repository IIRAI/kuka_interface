function waypoint = divide_tr_or_left(pose_left)
%DIVIDE_TR_OR_LEFT Divide the wypoint `pose_left` in two waypoint: first
%translation then change orientation.
%   INPUT:
%       -`pose_left`: vector [6x1], waypoint for the velvet
%   OUTPUT:
%       -`waypoint`: vector [6x2], each column is a waypoint
%               first waypoint  -> change of position
%               second waypoint -> change of orientation

persistent orien_old

if isempty (orien_old)
    orien_old = [0; 0; 0];
end

if orien_old ~= pose_left(4:6)
%     pre_wp_pos = [pose_left(1) - 0.05; pose_left(2); pose_left(3) - 0.18];
    pre_wp_pos = [pose_left(1); pose_left(2); pose_left(3)];
    
    pre_wp  = [pre_wp_pos; orien_old; zeros(6,1)];
    post_wp = [pose_left; zeros(6,1)];

    % update persistent variable
    orien_old = pose_left(4:6);

    waypoint = [pre_wp, post_wp];
else
    % update persistent variable
    orien_old = pose_left(4:6);
    
    waypoint = [pose_left; zeros(6,1)];
end

end

