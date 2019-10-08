%% MANAGE_TEST contains the main script to run the `iliad_test.slx`

% Remarks:
%  - The left arm is the lower one, which is equipped with the velvet-tray.
%  - The right arm is the upper one, which is equipped with the soft-hand.

%% launch the simulation in rviz
% use the following command to launch the visualization.

%   roslaunch vito_description view_iliad.launch

%% initialize variables
iliad_test_init

% activate ROS service to execute the manipulation task
RP_server = rossvcserver('/reverse_priority_service',...
                         'dual_manipulation_shared/ik_service',...
                         @reverse_priority_service); 
                     
%% display iliad_test command prompt to interact with the robot
activate_command

%% close matlab-ROS global node and clear all workspace variables
iliad_test_end