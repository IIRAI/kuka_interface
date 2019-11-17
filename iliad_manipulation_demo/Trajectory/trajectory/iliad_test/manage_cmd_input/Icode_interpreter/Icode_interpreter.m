%% ICODE_INTERPRETER interprets the Icode to the vito-iliad robot in `iliad-test`.
% The Icode is used to switch from a state to another in the vito-iliad
% finite-state machine.

if strcmp(cmd, 'I')
    warning('Specify the Icode number! admissible input: I0, I1 etc...')
else
    switch cmd(2)
        case '0' % homing
            set_param('iliad_test/Icode','Value', '0');
            open_hand;
        case '1' % go to position
            I1;
            set_param('iliad_test/Icode','Value', '1');
        case '2' % make pre-defined movement based on the object position
            I2;
            set_param('iliad_test/Icode','Value', '2');
        case '4'
            close_hand;
        case '5'
            open_hand;
        otherwise
            warning('Unexpected Icode, type h for help ¯\_(⊙︿⊙)_/¯ ')
    end
end