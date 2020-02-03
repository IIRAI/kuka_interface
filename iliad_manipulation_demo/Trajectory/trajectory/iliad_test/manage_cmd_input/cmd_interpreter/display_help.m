%DISPLAY_HELP displays the available commands for the `test_iliad` scheme

disp('                                                       ');
disp(' ------------------------------------------------------');
disp(' `h`:       displays this table                        ');
disp(' `enable`:  allows the robot to move, default homing   ');
disp(' `disable`: stops the robot, no commands are effective ');
disp(' `end`:     close the command interpreter              ');
disp('                                                       ');
disp(' --------------------- Icode --------------------------');
disp(' `I0`: homing.                                         ');
disp(' `I1`: go to specified pose.                           ');
disp('       use the following input for default value       ');
disp('           `pose_left_def`                             ');
disp('           `pose_right_def`                            ');
disp(' `I2`: make a pre-defined movement based on the        ');
disp('       object position.                                ');
disp(' `I3`: is reserved for dual manipulation, do not use it');
disp(' `I4`: open HAND of the real robot                     ');
disp('       input the value [0, 1] for the hand synergy     ');
disp(' `I5`: open VELVET of the real robot                   ');
disp('       input the value [0, 1] for the velvet control   ');
disp(' `I6`: asks for a vector 1x6,                          ');
disp('       which defines the velvet sensible axis          ');
disp(' ------------------------------------------------------');
disp('                                                       ');

