
% close the soft-hand, this script is used in combination with the I-code
% interpreter

global handPub 

disp('closing hand')

msg = rosmessage(handPub);
msg.Name     = {'right_hand_synergy_joint'};
msg.Position = 0.5; % synergy

send(handPub, msg);