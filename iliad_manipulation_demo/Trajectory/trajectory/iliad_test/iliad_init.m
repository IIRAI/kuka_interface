%%ILIAD_INIT initializes the iliad_ctrl variables and ROS environment
% Remarks:
%  - The left arm is the lower one,  which is equipped with the velvet-tray.
%  - The right arm is the upper one, which is equipped with the soft-hand.

rosshutdown
rosinit

%% Simulink parameters

%global sim_name
data = iliad_data();
sim_name = data.sim_name;
global pose_left_def pose_right_def
global manipulation_mov              % stores the waypoints from (dual manipulation) to be executed
global hand_synergy                  % stores the synergies from (dual manipulation) to be executed
global velvet_synergy

manipulation_mov = [];
hand_synergy = [];
velvet_synergy = [];

global table_rs  % position of the reference system of the table in <world> frame
table_rs = [1.3500; 1.2010; 0.7000];

% table of number of samples for the desired trajectory
t_prova = [200,200;...
           300,300;...
           800,800;...
           800,800;...
           800,800];

% standard length (in samples) of the trajectory evaluated
max_output_len = 4000;

% threshold to consider a movement complete
pos_threshold = 0.01;

%% Initial configuration
% avoid starting from singular position when using rviz, unless RP would
% stuck/crash

q_left_init  = [ 0.4352, -1.0289,  0.1226, -1.6992, -0.5845,  1.0377, -1.1276]';
q_right_init = [-0.0000, -1.9509, -0.0000, -1.8703, -0.0000, -0.6711,  0.0000]';

%% Define default position of the arms   ___________________
% table dimension from rviz model        |    Table        |
% length = 0.6 [m]                       ^    Plane        |
% width  = 0.8 [m]                       |Y                |
% height = 0.7 [m]                       |    X            |
%                                        +----->___________|
% the position of the table reference system in <world> frame is:
% [1.3500; 1.2010; 0.7000]

% deafault end_effectors position in table reference system
default_left  = [0.0, 0.1, 0.1, pi/2, 0, 0]';
default_right = [0.8, 0.1, 0.1, pi/2, 0, 0]';

% default position and orientation of the `left_arm_7_link` and `right_arm_7_link`
pose_left_def  = ee_2_left7link(default_left,   'reverse_priority');
pose_right_def = ee_2_right7link(default_right, 'reverse_priority');

%% global publishers
global handPub
handPub = rospublisher('/right_hand/joint_states','sensor_msgs/JointState');

%% activate ROS service to execute the manipulation task
RP_server = rossvcserver('/reverse_priority_service',...
                         'dual_manipulation_shared/ik_service',...
                         @reverse_priority_service); 

%% Display next step advice
disp(' ')
disp('----------------------------')
disp('---> RUN ' + sim_name + '.slx <---')
disp('----------------------------')
