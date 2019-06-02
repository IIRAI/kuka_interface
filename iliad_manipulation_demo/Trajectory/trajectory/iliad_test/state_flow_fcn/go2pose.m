function [qd_left, qd_right] = go2pose(q_init_left, q_init_right,...
                                       pose_right, pose_left,...
                                       t_prova, max_output_len)
%GO2POSE returns the joint trajectory to send VITO_ILIAD to the input pose.
%   This function defienes the `homing` state in the state-flow machine.
% ----------------------------------------------------------------------- %
%   INPUT:
%       - q_init_left:    current position of the left arm (velvet)
%       - q_init_right:   current position of the right arm (hand)
%       - pose_right:     [6x1] vector with pose and orientation of the right ee
%       - pose_left:      [6x1] vector with pose and orientation of the left ee
%       - t_prova:        table of number of samples for the desired trajectory
%       - max_output_len: standard length (in samples) of the trajectory evaluated
%   OUTPUT:
%       - qd_home_left:  joint trajectory from current to home position, 
%                        left arm (velvet)
%       - qd_home_right: joint trajectory from current to home position,
%                        right arm (hand)
% ----------------------------------------------------------------------- %

% evaluate joint trajectory for homing
qd_local_left  = spline_traj_left( t_prova(1,1), q_init_left,...
                                   pose_left(1:end-3),  pose_left(end-2:end),...
                                   t_prova(1,1));
qd_local_right = spline_traj_right(t_prova(1,2), q_init_right,...
                                   pose_right(1:end-3), pose_right(end-2:end),...
                                   t_prova(1,2));
% OUTPUT: normalize trajectory to `max_output_length`
qd_left  = [qd_local_left,  repmat(qd_local_left(1:7,  t_prova(1,2)), 1, max_output_len - t_prova(1,2))];
qd_right = [qd_local_right, repmat(qd_local_right(1:7, t_prova(1,1)), 1, max_output_len - t_prova(1,1))];

end

