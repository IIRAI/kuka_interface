%% END_COMMAND reset the iliad_ctrl.slx parameter to the default values
% this script is called when the `end` command is executed in the
% iliad_ctrl command line

global pose_left_def pose_right_def
% global sim_name
data = iliad_data();
sim_name = data.sim_name;

%% deactivate command loop flag
ask_command = 0;

%% reset to default value
set_param(sim_name + '/enable', 'Value', '0');
set_param(sim_name + '/Icode',  'Value', '0');
set_param(sim_name + '/hand_synergy', 'Value', '0');  % open hand
set_param(sim_name + '/pose_left', 'Value',...
          sprintf('[%f;%f;%f;%f;%f;%f]', pose_left_def(1),pose_left_def(2),...
                                         pose_left_def(3),pose_left_def(4),...
                                         pose_left_def(5),pose_left_def(6))...
         );
set_param(sim_name + '/pose_right', 'Value',...
          sprintf('[%f;%f;%f;%f;%f;%f]', pose_right_def(1),pose_right_def(2),...
                                         pose_right_def(3),pose_right_def(4),...
                                         pose_right_def(5),pose_right_def(6))...
         );
set_param(sim_name + '/object_pose', 'Value',...
          sprintf('[%f;%f;%f]', 0.4, 0, 0)...
         );

%% closing output
disp(' ')
disp('-------------------------------------------------------')
disp('Now CLOSE the `' + sim_name + '.slx` and RUN `iliad_end`');
disp('-------------------------------------------------------')