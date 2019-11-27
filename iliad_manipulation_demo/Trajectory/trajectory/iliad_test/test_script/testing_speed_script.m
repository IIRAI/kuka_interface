% TESTING_SPEED_SCRIPT changing the trajectory time execution to limit the max speed

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

%% 1 testing concatenation of trajectories

iliad_test_init

pose_left_table  = [0.1, -0.1, 0.0, pi/2, 0, 0]';
pose_right_table = [0,  0.0, 0, 0, 0, 0]';

pose_left  = table2global(pose_left_table);
pose_right = table2global(pose_right_table);

% [qd_left, qd_right_ = homing(q_left_init, q_right_init,...
%                                  t_prova, max_output_len);

scale_traj = 1;
                             
[q_left, q_right] = go2pose(q_left_init, q_right_init,...
                            pose_left, pose_right,...
                            t_prova, max_output_len, scale_traj);

%% plot position trajectory
figure('Name','trajectory left arm');
hold on
grid on
for i = 1:7
    plot(q_left(i,1:300))
end

figure('Name','trajectory right arm');
hold on
grid on
for i = 1:7
    plot(q_right(i,1:300))
end

%%
dq_left  = gradient(q_left(:,1:300),  0.01);
dq_right = gradient(q_right(:,1:300), 0.01);

%% plot velocity trajectory
figure('Name','joint velocity left arm');
hold on
grid on
for i = 1:7
    plot(dq_left(i,1:300))
end

figure('Name','joint velocity right arm');
hold on
grid on
for i = 1:7
    plot(dq_right(i,1:300))
end

%% evaluate max value (absolute value) of the speed profile for each joint

max_vel_left  = max(abs(dq_left)')';
max_vel_right = max(abs(dq_right)')';

%%
max_left  = max(max_vel_left);
max_right = max(max_vel_right);

x  = 1:300;
x_left  = 1:1.5/max_left:300;
x_right = 1:1.5/max_right:300;
q_left_corrected  = [];
q_right_corrected = [];

for i = 1:7
    q_left_corrected  = [q_left_corrected; interp1(x, q_left(i, 1:300),...
                         x_left,'spline')];
    q_right_corrected = [q_right_corrected; interp1(x, q_right(i, 1:300),...
                         x_right,'spline')];
end

%% 
figure('Name','trajectory corrected left arm');
hold on
grid on
for i = 1:7
    plot(q_left_corrected (i,:))
end

figure('Name','trajectory corrected right arm');
hold on
grid on
for i = 1:7
    plot(q_right_corrected (i,:))
end

%%
dq_left_corrected  = gradient(q_left_corrected,  0.01);
dq_right_corrected = gradient(q_right_corrected, 0.01);

%%

figure('Name','joint velocity left arm');
hold on
grid on
for i = 1:7
    plot(dq_left_corrected(i,:))
end

figure('Name','joint velocity right arm');
hold on
grid on
for i = 1:7
    plot(dq_right_corrected(i,:))
end

%%
q_left_corrected_long  = [q_left_corrected, repmat(q_left_corrected(:, length(q_left_corrected)),...
                                                   1, max_output_len - length(q_left_corrected))];
q_right_corrected_long = [q_right_corrected, repmat(q_right_corrected(:, length(q_right_corrected)),...
                                                    1, max_output_len - length(q_right_corrected))];
                                                
                                                
%%

Ts      = 0.01;     % [s] sampling time
max_vel = 1.5;      % [rad/s] maximum joint speed
max_output_len = 4000;
[qd_left, qd_right] = scale_trajectory(q_left, q_right,...
                                           Ts, max_vel, max_output_len);
                                       
figure('Name','joint velocity left arm');
hold on
grid on
for i = 1:7
    plot(qd_left(i,:))
end

figure('Name','joint velocity right arm');
hold on
grid on
for i = 1:7
    plot(qd_right(i,:))
end