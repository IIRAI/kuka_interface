%% I1 execute the Icode 1 command.
% move the vito-iliad robot to the specified position w.r.t. the table reference
% system.
% Remark - how to use this command:
%   1- If the input is left empty the robot goes to the default position
%      defined in the `init` script of the `iliad_test`.
%      Note that new pose definition overwrites the default pose for the current
%      workspace!
%   2- The input must be a vector 6x1 the first three values are the 
%      x, y, z position and the last three values are the three orientation
%      following the ZYX convention!.
%   3- If the position or the orientation remain constant substitute the 
%      three values with NaN, the following are admissible values:
%            [NaN; 0; 0; 0]  % the robot maintains the current position
%            [0; 0; 0; NaN]  % the robot maintains the current orientation
%   4- One default pose exists for each arm, they are: 
%            `pose_left_def`
%            `pose_right_def`
%      they are defined in the `init` script of the `iliad_test`.

% global sim_name
data = iliad_data();
sim_name = data.sim_name;

%% left arm position
left = input(sim_name + ' command: $ left pose [idle]: ');
left = reshape(left, length(left), 1); % make sure it is a column
% update simulink model
set_pose_left(left, 'reverse_priority')

%% right arm position (do the same as the left arm!)
right = input(sim_name + ' command: $ right pose [idle]: ');
right = reshape(right, length(right), 1); % make sure it is a column
% update simulink model
set_pose_right(right, 'reverse_priority')
