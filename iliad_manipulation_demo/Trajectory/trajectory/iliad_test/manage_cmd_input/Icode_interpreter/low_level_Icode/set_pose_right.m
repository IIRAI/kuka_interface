function set_pose_right(right)
%SET_POSE_RIGHT set the joint value in the simulink model as asked in input
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
%            `pose_right_def`
%      they are defined in the `init` script of the `iliad_test`.

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

end

