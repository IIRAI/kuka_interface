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
                set_param('iliad_test/code','Value', '0');
            case '1' % go to position
                set_param('iliad_test/code','Value', '1');
            otherwise
                warning('Unexpected Icode, type h for help ¯\_(⊙︿⊙)_/¯ ')
        end
    else
    % interpret command
        switch cmd
            case 'h'            % print help
                display_help;
            case 'enable'       % turn on the arms
                set_param('iliad_test/enable','Value', '1');
            case 'disable'      % turn off the arms
                set_param('iliad_test/enable','Value', '0');
            case 'end'          % exit the loop and set the default value for iliad_test
                ask_command = 0;
                set_param('iliad_test/enable','Value', '0');
                set_param('iliad_test/code',  'Value', '0');
                disp('Now close the `iliad_test.slx` and run `end_iliad_test`');
            otherwise         
                warning('Unexpected command, type h for help ¯\_(⊙︿⊙)_/¯ ')
        end
    end
   
end