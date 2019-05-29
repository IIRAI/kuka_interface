%% INIT initializes the iliad_test variables and ROS environment
rosshutdown
rosinit%('http://192.168.0.150:11311')

%% HOMING: define home joints positions
% home position
load('q_0_left')
load('q_0_right')

% homing: from default to home poition
load('q_out_left_home')
load('q_out_right_home')

q_left_home  = zeros(128, 2000);
q_right_home = zeros(128, 2000);

for i = 1:2000
    q_left_home(1:7, i)  = q_out_left_home(:, i);
    q_right_home(1:7, i) = q_out_right_home(:, i);
end

% table of number of samples for the desired trajectory
t_prova = [300,300;...
           300,300;...
           800,800;...
           800,800;...
           800,800];

% standard length (in samples) of the trajectory evaluated
max_output_len = 4000;