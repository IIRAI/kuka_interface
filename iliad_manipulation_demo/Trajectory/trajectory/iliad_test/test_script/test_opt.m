
clear
clc
%%
% initial position: home
q_curr_left  = [ 0.4352, -1.0289,  0.1226, -1.6992, -0.5845,  1.0377, -1.1276]'; 
q_curr_right = [-0.0000, -1.9509, -0.0000, -1.8703, -0.0000, -0.6711,  0.0000]';

% target pose
pose_left  = [0.4; -0.2; -0.1;    0; 0; 0];
pose_right = [0.6;  0.1;  0.3; pi/2; 0; 0];

%% parameters
% table of number of samples for the desired trajectory
t_prova = [300,300;...
           300,300;...
           800,800;...
           800,800;...
           800,800];

% standard length (in samples) of the trajectory evaluated
max_output_len = 4000;

%% trajectory evaluation
% evaluate trajectory 
qd_left  = table_spline_traj_left(t_prova(1,1), q_curr_left,...
                                  pose_left(1:end-3), pose_left(end-2:end),...
                                  t_prova(1,1));
qd_right = table_spline_traj_right(t_prova(1,2), q_curr_right,...
                                   pose_right(1:end-3), pose_right(end-2:end),...
                                   t_prova(1,2));
% optimize trajectory
disp(' ')
disp('optimize trajectory...')
[qd_right, qd_left] = optimize(qd_right, qd_left, 1);