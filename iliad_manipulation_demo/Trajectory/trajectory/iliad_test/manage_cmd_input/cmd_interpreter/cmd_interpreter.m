%% CMD_INTERPRETER interprets the command to the vito-iliad robot in `iliad-test`.

% Remark: all the admissible commands must be written in lower case!

% global sim_name
data = iliad_data();
sim_name = data.sim_name;

switch cmd
    case 'h'         % print help
        display_help;
    case 'enable'    % turn on the arms
        enable_iliad;
    case 'disable'   % turn off the arms
        set_param(sim_name + '/enable','Value', '0');
    case 'end'          
        end_command; % exit the loop and set the default value for iliad_ctrl
    otherwise         
        warning('Unexpected command, type h for help ¯\_(⊙︿⊙)_/¯ ')
end