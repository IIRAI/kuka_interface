%%ACTIVATE_COMMAND interprets the `iliad_ctrl` commands

% print table of available commands
clc
display_help;
disp(' ');

data = iliad_data();
sim_name = data.sim_name;

% command loop flag
ask_command = 1;

while ask_command
    
    cmd = input(sim_name + ' command: $ ', 's'); % wait for command
    
    if isempty(cmd) % disable
        set_param(sim_name + '/enable','Value', '0');
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