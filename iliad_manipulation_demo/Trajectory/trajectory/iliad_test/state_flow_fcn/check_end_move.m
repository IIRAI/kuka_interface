function [flag_state] = check_end_move(qd_left, qd_right, q_left, q_right,...
                                       max_output_len, pos_threshold)
%CHECK_END_MOVE check if the movement is ended evaluating the error 
% between the robot state and the desired final position.
%   INPUT:
%       - `qd_left`:        desired left trajectory
%       - `qd_right`:       desired right trajectory
%       - `q_left`:         current left position
%       - `q_right`:        current right position
%       - `max_output_len`: trajectory sample length
%       - `pos_threshold`:  threshold to evaluate if the movement ended
%   OUTPUT:
%       - `flag_state`: flag that specifies if the movement ended

err_left = max(abs(angdiff(qd_left(1:7, max_output_len),  q_left)));
err_right= max(abs(angdiff(qd_right(1:7, max_output_len), q_right)));

if(err_right <= pos_threshold && err_left <= pos_threshold)
    flag_state = 1;
else
    flag_state = 0;
end

end

