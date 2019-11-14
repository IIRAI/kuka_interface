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

% retrieve message informations
ee_name   = reqMsg.EeName;
waypoints = reqMsg.Waypoints;

for t = 1 : length(waypoints) % size(waypoints, 1)
    waypoint_position    = waypoints(t).Position;
    waypoint_orientation = waypoints(t).Orientation;
    pose_global = [waypoint_position.X;
                   waypoint_position.Y;
                   waypoint_position.Z;
                   waypoint_orientation.Z;
                   waypoint_orientation.Y;
                   waypoint_orientation.X];
    arm_waypoint(ee_name, pose_global);
end
disp(' ')

response.Ack = true;

end
