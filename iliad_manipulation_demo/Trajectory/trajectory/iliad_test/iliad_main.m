%% ILIAD_MAIN contains the main script to run the `iliad_test.slx`/`iliad_ctrl.slx`
% check the README.md !!!

%% initialize variables
iliad_init

%% display iliad command prompt to enable and interact with the robot w/ I-code
activate_command

%% close matlab-ROS global node and clear all workspace variables
iliad_end
