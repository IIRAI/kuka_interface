%% MANAGE_TEST contains the main script to run the `iliad_test.slx`

%% launch the visualization in rviz
% set the `sim_name` to:
% 
%   sim_name = "iliad_test";
% 
% use the following command to launch the visualization and use only matlab.
% 
%   roslaunch vito_description view_iliad.launch

%% launch the simulaition in rviz/gazebo
% set the `sim_name` to:
% 
%   sim_name = "iliad_ctrl";
% 
% use the following command to launch the simulaiton in gazebo
% 
%   roslaunch vito_description display.launch 
% 
% activate the controller managers
% 
%   roslaunch kuka_interface_pkg manager.launch

%% To launch dual manipulation check its documentation.

%% initialize variables
global sim_name;
sim_name = "iliad_ctrl"; % specify which sim to use

iliad_test_init
                     
%% display iliad_test command prompt to interact with the robot
activate_command

%% close matlab-ROS global node and clear all workspace variables
iliad_test_end
