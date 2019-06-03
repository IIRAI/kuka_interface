%% I1 execute the Icode 1 command.
% move the vito-iliad robot to the specified position.
% Remark - how to use this command:
%   1- If the input is left empty the robot goes to the default position
%      defined in the `init` script of the `iliad_test`.
%      Note that new pose definition overwrite the default pose!
%   2- The input must be a vector 6x1 the first three values are the 
%      x, y, z position and the last three values are the three orientation.
%   3- If the position or the orientation remain constant substitute the 
%      three values with NaN, the following are admissible values:
%            [NaN; 0; 0; 0]  % the robot maintains the current position
%            [0; 0; 0; NaN]  % the robot maintains the current orientation
%   4- One default pose exists for each arm, they are: 
%      `ee_left_t_def`, `ee_right_t_def`

%% left arm position
left = input('iliad_test command: $ left pose [default]:');

if isempty(left) % mantain current position
    left_current = str2num(get_param('iliad_test/pose_left', 'Value'));     % the position in in global ref
    left = left7link_2_ee(left_current);                                    % convert the position in table position
else % input position
    if isnan(left(1))       % change just the orientation
        left_current = str2num(get_param('iliad_test/pose_left', 'Value')); % the position in in global ref
        left = [left_current(1:3); left(2:4)];
        left = left7link_2_ee(left);                                        % convert the position in table position
    elseif isnan(left(4))   % change just the position
        left_current = str2num(get_param('iliad_test/pose_left', 'Value')); % the position in in global ref but here is useless
        left = [left(1:3); left_current(4:6)];
    end
    
    % update left position
    left = ee_2_left7link(left);
    set_param('iliad_test/pose_left', 'Value',...
              sprintf('[%f;%f;%f;%f;%f;%f]', left(1),left(2),left(3),...
                                             left(4),left(5),left(6))...
             );
end

%% right arm position
right = input('iliad_test command: $ right pose [default]: ');

if isempty(right) % default position
    right_current = str2num(get_param('iliad_test/pose_right', 'Value'));   % the position in in global ref
    right = right7link_2_ee(right_current);                                 % convert the position in table position
else % input position
    if isnan(right(1))      % change just the orientation
        right_current = str2num(get_param('iliad_test/pose_right', 'Value')); % the position in in global ref
        right = [right_current(1:3); right(2:4)];
        right = right7link_2_ee(right);                                       % convert the position in table position
    elseif isnan(right(4))  % change just the position
        right_current = str2num(get_param('iliad_test/pose_right', 'Value')); % the position in in global ref but here is useless
        right = [right(1:3); right_current(4:6)];
    end
    
    % update right position
    right = ee_2_right7link(right);
    set_param('iliad_test/pose_right', 'Value',...
              sprintf('[%f;%f;%f;%f;%f;%f]', right(1),right(2),right(3),...
                                             right(4),right(5),right(6))...
             );
end

%% set Icode value
set_param('iliad_test/Icode','Value', '1');