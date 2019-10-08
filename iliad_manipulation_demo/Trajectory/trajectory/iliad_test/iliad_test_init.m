%ILIAD_TEST_INIT initializes the iliad_test variables and ROS environment
% Remarks:
%  - The left arm is the lower one, which is equipped with the velvet-tray.
%  - The right arm is the upper one, which is equipped with the soft-hand.

rosshutdown
rosinit%('http://192.168.0.150:11311')

%% Simulink parameters

global pose_left_def pose_right_def
global manipulation_mov
manipulation_mov = [];

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
pose_left_def  = ee_2_left7link(default_left,   'reverse_priority');
pose_right_def = ee_2_right7link(default_right, 'reverse_priority');

%% Display next step advice
disp(' ')
disp('----------------------------')
disp('---> RUN iliad_test.slx <---')
disp('----------------------------')
