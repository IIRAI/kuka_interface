%% CMD_INTERPRETER interprets the command to the vito-iliad robot in `iliad-test`.

% Remark: all the admissible commands must be written in lower case!

global sim_name

switch cmd
    case 'h'         % print help
        display_help;
    case 'enable'    % turn on the arms
        set_param(sim_name + '/enable','Value', '1');
        if strcmp(sim_name, "iliad_ctrl")  % if real robot set up the ee too
            disp('setting up the end-effextors...')
            % open hand command I6
            set_param(sim_name + '/hand_synergy', 'Value', sprintf('%f', 0));
            % unroll elvet tray
            set_param(sim_name + '/velvet_ctrl', 'Value', sprintf('%f', 1));
        end
    case 'disable'   % turn off the arms
        set_param(sim_name + '/enable','Value', '0');
    case 'end'          
        end_command; % exit the loop and set the default value for iliad_test
    otherwise         
        warning('Unexpected command, type h for help ¯\_(⊙︿⊙)_/¯ ')
end