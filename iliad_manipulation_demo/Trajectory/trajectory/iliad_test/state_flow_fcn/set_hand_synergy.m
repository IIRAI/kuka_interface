function set_hand_synergy(syn)
%SET_HAND_SYNERGY set the synergy value for the soft hand when using the
%real robot or when simulating it
%   input:
%   -`syn`: scalar value ot the hand synergy

data = iliad_data();
sim_name = data.sim_name;

global handPub 

if strcmp(sim_name, 'iliad_ctrl')  % when using gazebo or the real robot
    set_param(sim_name + '/hand_synergy', 'Value', num2str(syn));  % close hand
else  % when using the visualization only
    msg = rosmessage(handPub);
    msg.Name     = {'right_hand_synergy_joint'};
    msg.Position = syn; % synergy
    send(handPub, msg);
end

end

