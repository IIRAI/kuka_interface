function response = reverse_priority_service(~, reqMsg, response)
%REVERSE_PRIORITY_TEST testing the service with ROS indigo in docker container
  % input:
    % `first`:  is the associated service server object.
    % `second`: is the request message object sent by the service client.
    % `third`:  is the default response message object.
  % output:
    % `response`: 
      % message based on the input request and sends it back to the client
      
% REMARK: the arguments of the request/response can be different from ROS
% i.e: 
% ---- ROS ------- MATLAB ----
%   ack      -->   Ack
%   command  -->   Command
%   ee_name  -->   EeName

%%
disp('########################################################################')
disp(' ***** Received request from Dual Manipulation ROS ***** ')

global sim_name

% retrieve message informations
command   = reqMsg.Command;
ee_name   = reqMsg.EeName;
waypoints = reqMsg.Waypoints;

disp('***** command:')
disp(command)
disp('***** ee_name:')
disp(ee_name)
disp('***************')

if strcmp(command, 'home')
    disp('going home...')
    set_param(sim_name + '/Icode','Value', '0');
    open_hand;
elseif strcmp(ee_name, 'full_robot')
    disp('# of wps in `full_robot`: ')
    disp(length(waypoints))
    if length(waypoints) <= 3
        set_arms(waypoints(end-1:end));
    else
        set_arms(waypoints(2:3));
    end
else
    disp('***** # waypoints:')
    disp(length(waypoints))
    disp('*******************')
    if length(waypoints) > 2
        waypoint_position    = waypoints(2).Position;
        waypoint_orientation = waypoints(2).Orientation;
        pose_global = [waypoint_position.X;
                       waypoint_position.Y;
                       waypoint_position.Z;
                       waypoint_orientation.Z;
                       waypoint_orientation.Y;
                       waypoint_orientation.X];
        % manage received waypoint
        arm_waypoint(ee_name, pose_global);
    else
        waypoint_position    = waypoints(1).Position;
        waypoint_orientation = waypoints(1).Orientation;
        pose_global = [waypoint_position.X;
                       waypoint_position.Y;
                       waypoint_position.Z;
                       waypoint_orientation.Z;
                       waypoint_orientation.Y;
                       waypoint_orientation.X];
        % manage received waypoint
        arm_waypoint(ee_name, pose_global);
    end
end

clear waypoints

disp(' ')

response.Ack = true;

end
