function set_pose_left(left, reference)
%SET_POSE_LEFT set the joint value in the simulink model as asked in input
%
%   How this function interpret the input:
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
%      they are defined in the `init` script of the `iliad_test`.
%
%   reference: is a string with value 'reverse_priority' or 'dual_manipulation',
%   this specifies which reference system the hand uses, since the dual
%   manipulation project adopted a different reference system for the hand
%   and a different [0, 0, 0] orientation.

if ~isempty(left) % input position if empty maintain position
    if isnan(left(1))       % change just the orientation
        left_current_7link = str2num(get_param('iliad_test/pose_left', 'Value')); % position of the 7 link in in global ref
        left_current_ee    = left7link_2_ee(left_current_7link);                  % convert in ee position in table position
        left = [left_current_ee(1:3); left(2:4)];
    elseif isnan(left(4))   % change just the position
        left_current_7link = str2num(get_param('iliad_test/pose_left', 'Value')); % position of the 7 link in in global ref but here is useless
        left = [left(1:3); left_current_7link(4:6)];
    end   
else
    left = str2num(get_param('iliad_test/pose_left', 'Value'));   % position of the 7 link in in global ref
end

% the RP control the 7 link pose, let's obtain it from the ee pose
left = ee_2_left7link(left, reference);
% update left position
set_param('iliad_test/pose_left', 'Value',...
          sprintf('[%f;%f;%f;%f;%f;%f]', left(1),left(2),left(3),...
                                         left(4),left(5),left(6))...
         );
end

