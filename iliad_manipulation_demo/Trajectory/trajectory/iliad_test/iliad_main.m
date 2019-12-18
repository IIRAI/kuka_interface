%% ILIAD_MAIN contains the main script to run the `iliad_test.slx`/`iliad_ctrl.slx`
% check the README.md !!!

%% initialize variables
global sim_name;
sim_name = "iliad_test"; % for visualization
% sim_name = "iliad_ctrl"; % for simulation

iliad_init

%% display iliad_test command prompt to interact with the robot
activate_command

%% close matlab-ROS global node and clear all workspace variables
iliad_end
