%% ICODE_INTERPRETER interprets the Icode to the vito-iliad robot in `iliad-test`.
% The Icode is used to switch from a state to another in the vito-iliad
% finite-state machine.

global sim_name

if strcmp(cmd, 'I')
    warning('Specify the Icode number! admissible input: I0, I1 etc...')
else
    switch cmd(2)
        case '0' % homing
            set_param(sim_name + '/Icode','Value', '0');
            if strcmp(sim_name, "iliad_test")
                open_hand;
            elseif strcmp(sim_name, "iliad_ctrl")
                disp('setting up the end-effextors...')
                % open hand command I6
                set_param(sim_name + '/hand_synergy', 'Value', sprintf('%f', 0));
                % unroll elvet tray
                set_param(sim_name + '/velvet_ctrl', 'Value', sprintf('%f', 1));
            end
        case '1' % go to position
            I1;
            set_param(sim_name + '/Icode','Value', '1');
        case '2' % make pre-defined movement based on the object position
            I2;
            set_param(sim_name + '/Icode','Value', '2');
        case '4'  % for visualization
            close_hand;
        case '5'  % for visualization
            open_hand;
        case '6'  % for simulation
            hand_syn = input(sim_name + ' command: $ hand synergy (0=open / 1=closed): ');
            set_param(sim_name + '/hand_synergy', 'Value', sprintf('%f', hand_syn));
        case '7'  % for simulation
            velvet_ctrl = input(sim_name + ' command: $ velvet control (0=roll up / 1=unroll): ');
            set_param(sim_name + '/velvet_ctrl', 'Value', sprintf('%f', velvet_ctrl));
        case '8'
            cmd_traj = input(sim_name + ' command: $ velvet sensible axis: ');
            set_param('iliad_ctrl/command_trajectory_left', 'Value',...
                       sprintf('[%f,%f,%f,%f,%f,%f]',...
                       cmd_traj(1), cmd_traj(2), cmd_traj(3),...
                       cmd_traj(4), cmd_traj(5), cmd_traj(6))...
                      );
        otherwise
            warning('Unexpected Icode, type h for help ¯\_(⊙︿⊙)_/¯ ')
    end
end