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
               
%%
   
pose = global2table(pose_global);
disp(pose)

if strcmp(ee_name, 'right_hand')
    % update simulink model
    disp('setting RIGHT hand')
    % convert dual manipulation pose to reverse priority reference system
    pose_right = ee_2_right7link(pose, 'dual_manipulation');
    if isnan(pose_right)
        pose_right = zeros(6,1);
    end
    waypoint = [zeros(6,1); pose_right];
    % -----
    %waypoints = [waypoints, waypoint];
    manipulation_mov = [manipulation_mov, waypoint];
    disp('setting Icode value to 3...')
    set_param('iliad_test/Icode', 'Value', '3');
    % -----
elseif strcmp(ee_name, 'left_hand')
    % update simulink model
    disp('setting LEFT hand')
    % convert dual manipulation pose to reverse priority reference system
    pose_left = ee_2_left7link(pose, 'dual_manipulation');
    if isnan(pose_left)
        pose_left = zeros(6,1);
    end
    waypoint = [pose_left; zeros(6,1)];
    % -----
    %waypoints = [waypoints, waypoint];
    manipulation_mov = [manipulation_mov, waypoint];
    disp('setting Icode value to 3...')
    set_param('iliad_test/Icode', 'Value', '3');
    % -----
else % here should be something like full robot
    % homing
    disp(ee_name)
    disp('full robot is called')
    %manipulation_mov = waypoints;
    %-----
%     if size(reqMsg.Waypoints, 1) == 3
%         pose_left = ee_2_left7link(pose, 'dual_manipulation');
%         waypoint = [pose_left; zeros(6,1)];
%     elseif size(reqMsg.Waypoints, 1) == 4
%         pose_right = ee_2_right7link(pose, 'dual_manipulation');
%         waypoint = [zeros(6,1); pose_right];
%     else
        waypoint = zeros(12,1);
%     end
    manipulation_mov = [manipulation_mov, waypoint];
    %-----
    waypoints = [];
    disp('setting Icode value to 3...')
    set_param('iliad_test/Icode', 'Value', '3');
end

disp(' ')

response.Ack = true;

end
