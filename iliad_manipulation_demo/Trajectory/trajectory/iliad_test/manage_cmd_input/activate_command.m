%%ACTIVATE_COMMAND interprets the `iliad_test` commands

% print table of available commands
clc
display_help;
disp(' ');

% command loop flag
ask_command = 1;

while ask_command
    
    cmd = input('iliad_test command: $ ', 's'); % wait for command
    
    if isempty(cmd)
        set_param('iliad_test/enable','Value', '0');
        warning('An empty input is interpreted as a `disable` command')
        disp('type h for help (◠﹏◠)')
    else
        % interpret Icode
        if strcmp(cmd(1), 'I')
            Icode_interpreter;
        else % interpret command
            cmd_interpreter;
        end
    end
   
end