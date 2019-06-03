%% CMD_INTERPRETER interprets the command to the vito-iliad robot in `iliad-test`.

% Remark: all the admissible commands must be written in lower case!

switch cmd
    case 'h'         % print help
        display_help;
    case 'enable'    % turn on the arms
        set_param('iliad_test/enable','Value', '1');
    case 'disable'   % turn off the arms
        set_param('iliad_test/enable','Value', '0');
    case 'end'          
        end_command; % exit the loop and set the default value for iliad_test
    otherwise         
        warning('Unexpected command, type h for help ¯\_(⊙︿⊙)_/¯ ')
end