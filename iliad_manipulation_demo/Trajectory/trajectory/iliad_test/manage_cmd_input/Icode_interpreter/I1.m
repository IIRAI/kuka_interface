%% I1 execute the Icode 1 command.
% move the vito-iliad robot to the specified position.
% Remark - how to use this command:
%   1- If the input is left empty the robot goes to the default position
%      defined in the `init` script of the `iliad_test`.
%      Note that new pose definition overwrite the default pose!
%   2- The input must be a vector 6x1 the first three values are the 
%      x, y, z position and the last three values are the three orientation
%      following the ZYX convention.
%   3- If the position or the orientation remain constant substitute the 
%      three values with NaN, the following are admissible values:
%            [NaN; 0; 0; 0]  % the robot maintains the current position
%            [0; 0; 0; NaN]  % the robot maintains the current orientation
%   4- One default pose exists for each arm, they are: 
%      `ee_left_t_def`, `ee_right_t_def`

%% left arm position
left = input('iliad_test command: $ left pose [idle]: ');

if ~isempty(left) % input position if empty maintain position
    if isnan(left(1))       % change just the orientation
        left_current_7link = str2num(get_param('iliad_test/pose_left', 'Value')); % position of the 7 link in in global ref
        left_current_ee    = left7link_2_ee(left_current_7link);                  % convert in ee position in table position
        left = [left_current_ee(1:3); left(2:4)];
    elseif isnan(left(4))   % change just the position
        left_current_7link = str2num(get_param('iliad_test/pose_left', 'Value')); % position of the 7 link in in global ref but here is useless
        left = [left(1:3); left_current_7link(4:6)];
    end
    
    % the RP control the 7 link pose, let's obtain it from the ee pose
    left = ee_2_left7link(left);
    % update left position
    set_param('iliad_test/pose_left', 'Value',...
              sprintf('[%f;%f;%f;%f;%f;%f]', left(1),left(2),left(3),...
                                             left(4),left(5),left(6))...
             );
end

%% right arm position (do the same as the left arm!)
right = input('iliad_test command: $ right pose [idle]: ');

if ~isempty(right) % input popsition if empty maintain position
    if isnan(right(1))      % change just the orientation
        right_current_7link = str2num(get_param('iliad_test/pose_right', 'Value')); % position of the 7 link in in global ref
        right_current_ee    = right7link_2_ee(right_current_7link);                 % convert in ee position in table position
        right = [right_current_ee(1:3); right(2:4)];
    elseif isnan(right(4))  % change just the position
        right_current_7link = str2num(get_param('iliad_test/pose_right', 'Value')); % position of the 7 link in in global ref but here is useless
        right = [right(1:3); right_current_7link(4:6)];
    end
    
    % the RP control the 7 link pose, let's obtain it from the ee pose
    right = ee_2_right7link(right);
     % update right position
    set_param('iliad_test/pose_right', 'Value',...
              sprintf('[%f;%f;%f;%f;%f;%f]', right(1),right(2),right(3),...
                                             right(4),right(5),right(6))...
             );
end

%% set Icode value
set_param('iliad_test/Icode','Value', '1');