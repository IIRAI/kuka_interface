%% define a ROS service to interpret commands from DUAL MANIPULATION planning
% run the client in ROS, you can check it at:
%   `dual_manipulation_state_manager/test_matlab_ros_service`
% run it, after running the service server in matlab (defined herein),
% using:
%   `rosrun dual_manipulation_state_manager test_matlab_ros_service`

% initialize matlab-ros master node
% rosinit
% define the server, input: server name, server type, service functin
RP_server = rossvcserver('/reverse_priority_service',...
                         'dual_manipulation_shared/ik_service',...
                         @reverse_priority_test); 

%% remember to close the service!!!
clear('RP_server')
rosshutdown