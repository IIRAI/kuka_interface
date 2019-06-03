function [hand_pose] = right7link_2_ee(right_arm_7_link)
    %RIGHT7LINK_2_EE returns the soft hand pose for RP position control
    %   INPUT:
    %       - `right_arm_7_link`: 6x1 vector containing the position and orientation
    %                             of the right_arm_7_link wrt the global ref sys
    %   OUTPUT:
    %       - `hand_pose`: 6x1 vector containing the position and orientation
    %                      of the soft hand in table reference system
    
    %% soft hand offset wrt the right_arm_7_link in local frame
    hand_offset_local = [0, 0, -0.20]';

    %% transformation to obtain the soft hand offset in global reference system
    % angle offset of right_arm_7_link wrt the global frame
    ee_rot_offset = [-pi, -pi/2, 0];
    R_offset = eul2rotm(ee_rot_offset, 'ZYX');

    % rotation of the soft hand
    Rot = eul2rotm(right_arm_7_link(end-2:end)', 'ZYX');

    %% compute hand offset in global frame
    hand_offset = R_offset * Rot * hand_offset_local;

    %% compute position of the right_arm_7_link 
    hand_pose = right_arm_7_link - [hand_offset; zeros(3,1)];

    %% obtain soft hand position in global reference system
    hand_pose = global2table(hand_pose);
    
    end