%% I2 execute the Icode 2 command.
% Move the vito-iliad robot to the specified position based on the OBJECT position.
% This command can be seen as a high-level enhancement of the command I1,
% which gives directly the end-effector final pose, while the I3 command
% evaluates the end-effectors pose based on the object pose (given as
% input).

global sim_name

%% object position
obj_pose = input(sim_name + ' command: $ object position [table ref]: ');

% update left position
set_param(sim_name + '/object_pose', 'Value',...
          sprintf('[%f;%f;%f]', obj_pose(1),obj_pose(2),obj_pose(3))...
         );