function [qd_home_left, qd_home_right] = homing(q_init_left, q_init_right,...
                                                t_prova, max_output_len, scale_traj)
%HOMING returns the joint trajectory to send VITO_ILIAD to the home pose.
%   This function defienes the `homing` state in the state-flow machine.
% ----------------------------------------------------------------------- %
%   INPUT:
%       - q_init_left:    current position of the left arm (velvet)
%       - q_init_right:   current position of the right arm (hand)
%       - t_prova:        table of number of samples for the desired trajectory
%       - max_output_len: standard length (in samples) of the trajectory evaluated
%       - scale_traj:     1 if the trajectory must be scaled based on max joint speed, 0 for not 
%   OUTPUT:
%       - qd_home_left:  joint trajectory from current to home position, 
%                        left arm (velvet)
%       - qd_home_right: joint trajectory from current to home position,
%                        right arm (hand)
% ----------------------------------------------------------------------- %

% Define explicitly the home position
pos_home_left  = [0.9502;...
                  0.8011;...
                  0.5798];
rot_home_left = zeros(3, 1);

pos_home_right = [1.5223;...
                  0.8010;...
                  1.4997];
rot_home_right = zeros(3, 1);

% evaluate joint trajectory for homing
qd_local_left  = home_spline_traj_left( t_prova(1,1), q_init_left,  pos_home_left,  rot_home_left,  t_prova(1,1));
qd_local_right = home_spline_traj_right(t_prova(1,2), q_init_right, pos_home_right, rot_home_right, t_prova(1,2));
% OUTPUT: normalize trajectory to `max_output_length`

if scale_traj
    Ts      = 0.01;     % [s] sampling time
    max_vel = 1.5;      % [rad/s] maximum joint speed
    [qd_home_left, qd_home_right] = scale_trajectory(qd_local_left, qd_local_right,...
                                                     Ts, max_vel, max_output_len);
else
    qd_home_left  = [qd_local_left,  repmat(qd_local_left(1:7,  t_prova(1,2)), 1, max_output_len - t_prova(1,2))];
    qd_home_right = [qd_local_right, repmat(qd_local_right(1:7, t_prova(1,1)), 1, max_output_len - t_prova(1,1))];
end


end

