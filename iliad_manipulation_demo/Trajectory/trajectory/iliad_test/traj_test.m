function [qd_left, qd_right] = traj_test()
%TRAJ_TEST returns the trajectory to the iliad manipulator.
%   `...detailed description...`
%   OUTPUT:
%       - qd_left:  desired joint configuration of the left arm
%       - qd_right: desired joint configuration of the right arm

%% traj generation from waypoints
wp_right = [1.5009, 1.2710, 1.2214, 1.4795, 1.1710, 0.9430, -pi/2, 0, 0];
wp_left  = [0.9939,    0.4, 0.7951, 1.4795, 0.5420, 0.9430, -pi/2, 0, 0];
qd_local_right = spline_traj_right(t_prova(1,1), q_0_right, wp_right(1:6)', wp_right(end-2:end)', t_prova(1,1));
qd_local_left  = spline_traj_left(t_prova(1,2),  q_0_left,  wp_left(1:6)',  wp_left(end-2:end)',  t_prova(1,2));
%% normalize output: to have an output that is fixed size (always max_output_len points)
qd_right = zeros(7,max_output_len);
qd_left  = zeros(7,max_output_len);
qd_right = [qd_local_right, repmat(qd_local_right(1:7, t_prova(1,1)), 1, max_output_len - t_prova(1,1))];
qd_left  = [qd_local_left,  repmat(qd_local_left(1:7,  t_prova(1,2)), 1, max_output_len - t_prova(1,2))];

end

