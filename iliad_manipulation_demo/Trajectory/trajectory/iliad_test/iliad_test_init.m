%ILIAD_TEST_INIT initializes the iliad_test variables and ROS environment
% Remarks:
%  - The left arm is the lower one, which is equipped with the velvet-tray.
%  - The right arm is the upper one, which is equipped with the soft-hand.

rosshutdown
rosinit%('http://192.168.0.150:11311')

%% Simulink parameters

% table of number of samples for the desired trajectory
t_prova = [300,300;...
           300,300;...
           800,800;...
           800,800;...
           800,800];

% standard length (in samples) of the trajectory evaluated
max_output_len = 4000;

%% Initial configuration
% avoid starting from singularity when usind rviz, unless RP would
% stuck/crash

q_left_init  = [0.1, 0.1, 0.1, 0, 0,  1, -1.5]';
q_right_init = [0.1, 0.1, 0.1, 0, 0, -1,    0]';

%% Define position to go

% end_effectors in table reference system
ee_left_table  = [0.8, 0.1, 0.1, -pi/2, 0, 0]';
ee_right_table = [0.0, 0.1, 0.1, -pi/2, 0, 0]';

% end_effectors in global reference system
ee_left_global  = table2global(ee_left_table);
ee_right_global = table2global(ee_right_table);

% position and orientation of the `left_arm_7_link` and `right_arm_7_link`

pose_left  = ee_2_left7link(ee_left_global);
pose_right = ee_2_right7link(ee_right_global);

% 1.3500, 1.2010, 0.7000 % table origin
% 1.4795, 0.5420, 0.9430 % velvet
% 1.4795, 1.1710, 0.9430 % shand