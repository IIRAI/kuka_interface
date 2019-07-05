function [waypoint_left, waypoint_right] = object2waypoint(obj_pose)
% OBJECT2WAYPOINT return a sequence of waypoints for the left and right arm
% in function of the object position on the table. 

%% define left  end-effector pose (velvet tray)

% left hand waypoints
w1_l = [0.2; -0.2; 0.1];      % first pose in front of the table
w2_l = [obj_pose(1) - 0.2;...
        obj_pose(2) - 0.1;...
        obj_pose(3) + 0.1];
or_l = [pi/2; 0; 0];
% movement of the ee in table reference system
move_left_ee_t  = [w1_l; w2_l; or_l];
% movement of the 7th link in global reference system
waypoint_left  = ee_2_left7link(move_left_ee_t);

%% define right end-effector pose (soft hand)

% right hand waypoints
w1_r = [0.6; -0.2; 0.1];      % first pose in front of the table
w2_r = [obj_pose(1) + 0.2;...
        obj_pose(2) - 0.1;...
        obj_pose(3) + 0.1];
or_r = [pi/2; 0; 0];
% movement of the ee in table reference system
move_right_ee_t  = [w1_r; w2_r; or_r];
% movement of the 7th link in global reference system
waypoint_right  = ee_2_right7link(move_right_ee_t);

end

