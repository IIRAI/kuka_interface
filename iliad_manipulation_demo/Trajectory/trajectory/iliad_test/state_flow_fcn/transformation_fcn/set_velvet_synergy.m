function set_velvet_synergy(syn)
%SET_VELVET_SYNERGY set the synergy value for the velvet tray when using the
% real robot or when simulating it
%   input:
%   -`syn`: scalar value ot the velvet synergy

data = iliad_data();
sim_name = data.sim_name;

set_param(sim_name + '/velvet_ctrl', 'Value', num2str(syn));

end