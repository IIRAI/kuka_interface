%% MANAGE_TEST contains the main script to run the `iliad_test.slx`

% Remarks:
%  - The left arm is the lower one, which is equipped with the velvet-tray.
%  - The right arm is the upper one, which is equipped with the soft-hand.

%% initialize variables
iliad_test_init

disp('run iliad_test.slx')
%% display iliad_test command prompt
activate_command

%% close matlab-ROS global node and clear all variables
iliad_test_end