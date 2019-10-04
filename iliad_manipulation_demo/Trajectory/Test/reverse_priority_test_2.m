function response = reverse_priority_test_2(~, reqMsg, response)
%REVERSE_PRIORITY_TEST_2 testing the service with ROS indigo in docker container
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

global manipulation_mov

persistent waypoints   % stores the waypoints received from ROS
if isempty(waypoints)
    waypoints = [];
end
      
disp(' ***** Received request from Dual Manipulation ROS ***** ')
disp(' ')
disp('excuting the requested movement...')
disp(' ')

% retrieve message informations
ee_name              = reqMsg.EeName;
waypoint_position    = reqMsg.Waypoints.Position;
waypoint_orientation = reqMsg.Waypoints.Orientation;

% compose end-effector waypoint pose
% note: I think that the orientation is defined as ZYX
pose_global = [waypoint_position.X;
               waypoint_position.Y;
               waypoint_position.Z;
               waypoint_orientation.Z;
               waypoint_orientation.Y;
               waypoint_orientation.X];
   
pose = global2table(pose_global);
disp(pose)

if strcmp(ee_name, 'right_hand')
    % update simulink model
    disp('setting RIGHT hand')
    pose_right = ee_2_right7link(pose, 'dual_manipulation');
    waypoint = [zeros(6,1); pose_right];
    waypoints = [waypoints, waypoint];
elseif strcmp(ee_name, 'left_hand')
    % update simulink model
    disp('setting LEFT hand')
    pose_left = ee_2_left7link(pose, 'dual_manipulation');
    waypoint = [pose_left; zeros(6,1)];
    waypoints = [waypoints, waypoint];
else % here should be something like full robot
    % homing
    disp('The waypoint list is ended!')
    manipulation_mov = waypoints;
    waypoints = [];
    disp('setting Icode value to 3...')
    set_param('iliad_test/Icode', 'Value', '3');
end

disp(' ')

response.Ack = true;

end
