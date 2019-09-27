function response = reverse_priority_test(~, reqMsg, response)
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
% ----ROS -------- MATLAB ----
%   ack      -->   Ack
%   command  -->   Command
%   ee_name  -->   EeName
      
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
    set_pose_right(pose, 'dual_manipulation')
    set_param('iliad_test/pose_left', 'Value',...
    sprintf('[%f;%f;%f;%f;%f;%f]', 0,0,0,0,0,0));
    set_param('iliad_test/Icode','Value', '1');
elseif strcmp(ee_name, 'left_hand')
    % update simulink model
    disp('setting LEFT hand')
    set_pose_left(pose, 'dual_manipulation')
    set_param('iliad_test/pose_right', 'Value',...
    sprintf('[%f;%f;%f;%f;%f;%f]', 0,0,0,0,0,0));
    set_param('iliad_test/Icode','Value', '1');
else % here should be something like full robot
    % homing
    disp('going HOME')
    set_param('iliad_test/Icode','Value', '0');
end

disp(' ')
disp('waiting to execute the movement...')

% wait to end the service until the robot has executed the movement
pause(5.0)           % wait 4.5 s, the trajectory has 4000 saples 

disp('... movement executed.')
disp(' ')

response.Ack = true;

end

