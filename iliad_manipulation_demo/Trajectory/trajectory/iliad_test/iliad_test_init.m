%ILIAD_TEST_INIT initializes the iliad_test variables and ROS environment
% Remarks:
%  - The left arm is the lower one, which is equipped with the velvet-tray.
%  - The right arm is the upper one, which is equipped with the soft-hand.

rosshutdown
rosinit%('http://192.168.0.150:11311')

%% Simulink parameters

global default_left default_right

% table of number of samples for the desired trajectory
t_prova = [300,300;...
           300,300;...
           800,800;...
           800,800;...
           800,800];

% standard length (in samples) of the trajectory evaluated
max_output_len = 4000;

% threshold to consider a movement complete
pos_threshold = 0.1;

%% Initial configuration
% avoid starting from singular position when using rviz, unless RP would
% stuck/crash

q_left_init  = [0.1, 0.1, 0.1, 0, 0,  1, -1.5]';
q_right_init = [0.1, 0.1, 0.1, 0, 0, -1,    0]';

%% Define default position of the arms   ___________________
% table dimension from rviz model        |    Table        |
% length = 0.6 [m]                       ^    Plane        |
% width  = 0.8 [m]                       |Y                |
% height = 0.7 [m]                       |    X            |
%                                        +----->___________|

% deafault end_effectors position in table reference system
default_left  = [0.0, 0.1, 0.1, pi/2, 0, 0]';
default_right = [0.8, 0.1, 0.1, pi/2, 0, 0]';

% default position and orientation of the `left_arm_7_link` and `right_arm_7_link`
pose_left_def  = ee_2_left7link(default_left);
pose_right_def = ee_2_right7link(default_right);

%% Define movement to be executed for I2 Icode

% right hand waypoint
w1_r = [0.5; -0.1; 0.2];
w2_r = [0.4;  0.0; 0.2];
w3_r = [0.5;  0.1; 0.2];
w4_r = [0.6;  0.0; 0.2];
% movement of the ee in table reference system
I2_move_left_t  = [0; 0.1; 0.1; 0; 0; 0.; 0; 0; 0];
I2_move_right_t = [w1_r; w2_r; w3_r; w4_r; pi/2; 0; 0];
% movement of the 7 link in global reference system
I2_move_left  = ee_2_left7link(I2_move_left_t);
I2_move_right = ee_2_right7link(I2_move_right_t);