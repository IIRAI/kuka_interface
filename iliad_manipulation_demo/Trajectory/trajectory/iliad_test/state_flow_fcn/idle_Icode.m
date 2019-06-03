function idle_Icode()
%IDLE_ICODE sets the Icode to `-1` to maintain the vito-iliad robot in idle

set_param('iliad_test/Icode','Value', '-1');

end

