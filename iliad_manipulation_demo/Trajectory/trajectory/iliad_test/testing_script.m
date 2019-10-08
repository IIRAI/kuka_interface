% TESTING_SCRIPT contains some passage to obtains what needed for my thesis

%% init workspace
rosshutdown
clear
clc

%% find home position as waypoints

% home position in configuration space
load('q_0_left')
load('q_0_right')

% robot parameters
KUKA_LWR_geometry_and_direct_kinematics % init KUKA LWR geometry params and DK
TWO_ARMS_transformations                % init KUKA ARMS transformations between base, arms and ee

% ----- SOLVE LEFT -----
% Denavit-Hartemberg table with numeric values 
DH_table_num_left = double(subs(DH_table_sym, q_sym, q_0_left));
% evaluate direct kinematic
[~, Tee_left] = direct_kinematics_DH(DH_table_num_left);
% use pre and post transformations
Tee_left = T_b_DH0l * Tee_left * T_DH7l_eel;
        
home_pos_left = Tee_left(1:3,4);       % LEFT POSITION

% ----- SOLVE RIGHT -----
% Denavit-Hartemberg table with numeric values 
DH_table_num_right = double(subs(DH_table_sym, q_sym, q_0_right));
% evaluate direct kinematic
[~, Tee_right] = direct_kinematics_DH(DH_table_num_right);
% use pre and post transformations
Tee_right = T_b_DH0r * Tee_right * T_DH7r_eer;
        
home_pos_right = Tee_right(1:3,4);     % RIGHT POSITION

%% Display value

home_pos_left
home_pos_right

%% 1 testing concatenation of trajectories

iliad_test_init

pose_left  = [0.8, 0.8, 0.8, pi/2, 0, 0]';
pose_right = [0.8, 0.8, 0.8, pi/2, 0, 0]';

[qd_left_1, qd_right_1] = homing(q_left_init, q_right_init,...
                                 t_prova, max_output_len);

[qd_left_2, qd_right_2] = go2pose(qd_left_1(:,end),  qd_right_1(:,end),...
                                  pose_left, pose_right,...
                                  t_prova, max_output_len);
                              
%% 2 testing concatenation of trajectories

init_iliad_test

[qd_left_1, qd_right_1] = go2pose(q_left_init, q_right_init,...
                                  pose_left, pose_right,...
                                  t_prova, max_output_len);

[qd_left_2, qd_right_2] = homing(qd_left_1(:,end),  qd_right_1(:,end),...
                                 t_prova, max_output_len);



%% concatenate
q_left  = [qd_left_1, qd_left_2];
q_right = [qd_right_1, qd_right_2];

%% plot testing concatenation

figure
hold on
grid on
for i = 1:7
    plot(qd_left_1(i,1:300))
end

%%
figure
hold on
grid on
for i = 1:7
    plot(q_left(i,:))
end

%%
gradient(qd_left_1(1,1:300), 0.01)