function [q_left_out, q_right_out] = scale_trajectory(q_left, q_right,...
                                                      Ts, max_vel, max_output_len)
%SCALE_TRAJECTORY changes trajectory samples number to satisfy joint
%speed limits.
% ---------------------------------------------------------------------------- %
%   INPUT:
%         -`q_left`:  left joints trajectory  (7x300)
%         -`g_right`: right joints trajectory (7x300)
%         -`Ts`: sampling time [s]
%         -`max_vel`: maximum joint speed [rad/s]
%         -`max_output_len`: maximum samples length of the joint trajectory
%   OUTPUT:
%         -`q_left_out`:  scaled left joints trajectory  (7x4000)
%         -`q_right_out`: scaled right joints trajectory (7x4000)
% ---------------------------------------------------------------------------- %
%% evaluate the joint trajectory velocities
dq_left  = gradient(q_left,  Ts);
dq_right = gradient(q_right, Ts);

%% evaluate max value (absolute value) of the speed profile for each joint
max_joint_vel_left  = max(abs(dq_left)')';
max_joint_vel_right = max(abs(dq_right)')';

%% evaluate max speed for each arm
max_arm_left  = max(max_joint_vel_left);
max_arm_right = max(max_joint_vel_right);

%% scale trajectory
x = 1:300;
% evaluate sclae factor for each arm
if max_arm_left ~= 0
    scale_factor_left  = max_vel/max_arm_left;
else
    scale_factor_left = 1;
end
if max_arm_right ~= 0
    scale_factor_right = max_vel/max_arm_right;
else
    scale_factor_right = 1;
end
x_left  = 1 : scale_factor_left  : 300;
x_right = 1 : scale_factor_right : 300;
% compute scaling
q_left_scaled = [];
q_right_scaled = [];
for i = 1:7 % for each joint
    q_left_scaled  = [q_left_scaled;  interp1(x, q_left(i, x),...
                      x_left, 'spline')];
    q_right_scaled = [q_right_scaled; interp1(x, q_right(i, x),...
                      x_right, 'spline')];
end

%% normalize trajectory output 
q_left_out  = [q_left_scaled, repmat(q_left_scaled(1:7, length(q_left_scaled)),...
                                     1, max_output_len - length(q_left_scaled))];
q_right_out = [q_right_scaled, repmat(q_right_scaled(1:7, length(q_right_scaled)),...
                                      1, max_output_len - length(q_right_scaled))];
end

