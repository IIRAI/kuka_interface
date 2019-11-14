
% open the soft-hand, this script is used in combination with the I-code
% interpreter

global handPub 

disp('opening hand')

msg = rosmessage(handPub);
msg.Name     = {'right_hand_synergy_joint'};
msg.Position = 0.0; % synergy

send(handPub, msg);