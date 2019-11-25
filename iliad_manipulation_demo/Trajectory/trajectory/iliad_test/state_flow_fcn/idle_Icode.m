function idle_Icode()
%IDLE_ICODE sets the Icode to `-1` to maintain the vito-iliad robot in idle

global sim_name

set_param(sim_name + '/Icode','Value', '-1');

end

