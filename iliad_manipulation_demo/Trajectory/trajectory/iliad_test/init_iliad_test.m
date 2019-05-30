%% INIT initializes the iliad_test variables and ROS environment
rosshutdown
rosinit%('http://192.168.0.150:11311')

% Remarks:
%  - The left arm is the lower one, which is equipped with the velvet-tray.
%  - The right arm is the upper one, which is equipped with the soft-hand.

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

%% HOMING: define home joints positions
% home position
load('q_0_left')
load('q_0_right')

%% Define position to go

pose_left  = [1.4795, 0.5420, 0.9430, -pi/2, 0, 0]';
pose_right = [1.4795, 1.1710, 0.9430, -pi/2, 0, 0]';

pose_left_2  = [0.9502, 0.8011, 0.5798, 0, 0, 0]';
pose_right_2  = [1.5223, 0.8010, 1.4997, 0, 0, 0]';

code = 0;