%% END_COMMAND reset the iliad_test.slx parameter to the default values

global pose_left_def pose_right_def

ask_command = 0;
set_param('iliad_test/enable','Value', '0');
set_param('iliad_test/Icode',  'Value', '0');
set_param('iliad_test/pose_left', 'Value',...
          sprintf('[%f;%f;%f;%f;%f;%f]', pose_left_def(1),pose_left_def(2),pose_left_def(3),pose_left_def(4),pose_left_def(5),pose_left_def(6))...
         );
set_param('iliad_test/pose_right', 'Value',...
          sprintf('[%f;%f;%f;%f;%f;%f]', pose_right_def(1),pose_right_def(2),pose_right_def(3),pose_right_def(4),pose_right_def(5),pose_right_def(6))...
         );
disp('Now close the `iliad_test.slx` and run `end_iliad_test`');