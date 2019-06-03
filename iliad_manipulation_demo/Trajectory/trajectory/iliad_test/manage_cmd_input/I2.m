%% I2 execute the Icode 2 command.
% move the vito-iliad robot to the specified position.

right = input('iliad_test command: $ right pose ');
right = ee_2_right7link(right);
set_param('iliad_test/pose_right', 'Value',...
          sprintf('[%f;%f;%f;%f;%f;%f]', right(1),right(2),right(3),right(4),right(5),right(6))...
         );
left = input('iliad_test command: $ left pose ');
left = ee_2_left7link(left);
set_param('iliad_test/pose_left', 'Value',...
          sprintf('[%f;%f;%f;%f;%f;%f]', left(1),left(2),left(3),left(4),left(5),left(6))...
         );
set_param('iliad_test/Icode','Value', '1');