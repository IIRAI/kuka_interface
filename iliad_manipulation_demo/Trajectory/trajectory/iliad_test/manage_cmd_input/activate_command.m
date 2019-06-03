%%ACTIVATE_COMMAND interprets the `iliad_test` commands

% print table of available commands
clc
display_help;
disp(' ');

% loop flag
ask_command = 1;

while ask_command
    
    cmd = input('iliad_test command: $ ', 's'); % wait for command
    
    % interpret Icode
    if strcmp(cmd(1), 'I')
        switch cmd(2)
            case '0' % homing
                set_param('iliad_test/Icode','Value', '0');
            case '1' 
                I1; % go to position
            otherwise
                warning('Unexpected Icode, type h for help ¯\_(⊙︿⊙)_/¯ ')
        end
    else
        
    % interpret command
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
    end
   
end