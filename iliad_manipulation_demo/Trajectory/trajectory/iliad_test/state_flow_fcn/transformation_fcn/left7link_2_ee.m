function [velvet_pose] = left7link_2_ee(left_arm_7_link)
    %LEFT7LINK_2_EE returns the velve tray pose for RP position control
    %   INPUT:
    %       - `left_arm_7_link`: 6x1 vector containing the position and orientation
    %                            of the left_arm_7_link wrt the global ref sys
    %   OUTPUT:
    %       - `velvet_pose`: 6x1 vector containing the position and orientation
    %                        of the velvet tray in table reference system
    
    %% velvet offset wrt the left_arm_7_link in local frame
    velvet_offset_local = [0, 0, -0.14]';

    %% transformation to obtain the velvet offset in global reference system
    % angle offset of left_arm_7_link wrt the global frame
    ee_rot_offset = [-pi/2, 0, -pi/2];
    R_offset = eul2rotm(ee_rot_offset, 'ZYX');

    % rotation of the velvet tray
    Rot      = eul2rotm(left_arm_7_link(end-2:end)', 'ZYX');

    %% compute velvet offset in global frame
    velvet_offset = R_offset * Rot * velvet_offset_local;

    %% compute position of the left_arm_7_link 
    velvet_pose =  left_arm_7_link - [velvet_offset; zeros(3,1)];

    %% obtain velvet position in global reference system
    velvet_pose = global2table(velvet_pose);
    
    end