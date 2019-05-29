%% INIT initializes the iliad_test variables and ROS environment
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
% avoid starting from singularity when usind rviz
q_left_init  = [0.1, 0.1, 0.1, 0, 0,  1, -1.5]';
q_right_init = [0.1, 0.1, 0.1, 0, 0, -1,    0]';

%% HOMING: define home joints positions
% home position
load('q_0_left')
load('q_0_right')

