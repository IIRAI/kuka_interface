function [qd_left, qd_right] = go2pose(q_init_left, q_init_right,...
                                       pose_left, pose_right,...
                                       t_prova, max_output_len,...
                                       scale_traj)
%GO2POSE returns the joint trajectory to send VITO_ILIAD to the input pose.
% ---------------------------------------------------------------------------- %
%   INPUT:
%       - q_init_left:    current position of the left arm (velvet)
%       - q_init_right:   current position of the right arm (hand)
%       - pose_left:      [nx1] vector with pose and orientation of the left ee
%       - pose_right:     [nx1] vector with pose and orientation of the right ee
%       - t_prova:        table of number of samples for the desired trajectory
%       - max_output_len: length (in samples) of the trajectory evaluated
%       - scale_traj:     1 if the trajectory must be scaled based on max joint speed, 0 for not 
%   OUTPUT:
%       - qd_home_left:  joint trajectory from current to home position, 
%                        left arm (velvet)
%       - qd_home_right: joint trajectory from current to home position,
%                        right arm (hand)
% ---------------------------------------------------------------------------- %

if pose_left == zeros(6,1)      % left arm remains still
    qd_local_right = spline_traj_right(t_prova(1,2), q_init_right,...
                                       pose_right(1:end-3), pose_right(end-2:end),...
                                       t_prova(1,2));
    qd_local_left = q_init_left;
    qd_local_left = [qd_local_left, repmat(qd_local_left(1:7), 1, t_prova(1,2) - 1)];
elseif pose_right == zeros(6,1) % right arm remains still
    qd_local_left = spline_traj_left(t_prova(1,1), q_init_left,...
                                     pose_left(1:end-3), pose_left(end-2:end),...
                                     t_prova(1,1));
    qd_local_right = q_init_right;
    qd_local_right = [qd_local_right, repmat(qd_local_right(1:7), 1, t_prova(1,1) - 1)];
else
    qd_local_left = spline_traj_left(t_prova(1,1), q_init_left,...
                                     pose_left(1:end-3), pose_left(end-2:end),...
                                     t_prova(1,1));
    qd_local_right = spline_traj_right(t_prova(1,2), q_init_right,...
                                       pose_right(1:end-3), pose_right(end-2:end),...
                                       t_prova(1,2));
end

qd_left  = [qd_local_left,  repmat(qd_local_left(1:7,  t_prova(1,2)), 1, max_output_len - t_prova(1,2))];
qd_right = [qd_local_right, repmat(qd_local_right(1:7, t_prova(1,1)), 1, max_output_len - t_prova(1,1))];

end

