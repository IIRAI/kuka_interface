function [manipulation, change_state] = retrieve_mov()
%RETRIEVE_MOV returns the next waypoint to be executed from dual-manipulation
%   - `change_state`: 0, do not change state
%                     1, go home
%                     2, stay idle

% stores the waypoints from (dual manipulation) to be executed
% in this function the oldest waypoint is returned (to be executed) and deleted
global manipulation_mov
global hand_synergy
global velvet_synergy;

disp(' ')
disp(' ')
disp(' list of the hand synergy:')
disp(hand_synergy)
disp(velvet_synergy)
disp('n° of waypoint for both manipulation and synergy:')
size(manipulation_mov, 2)
size(hand_synergy, 2)
size(velvet_synergy, 2)
disp(' ')
disp(' ')

if size(manipulation_mov, 2) ~= size(hand_synergy, 2) && size(manipulation_mov, 2) ~= size(velvet_synergy, 2)
    hand_synergy = zeros(1, size(manipulation_mov, 2));
    velvet_synergy = zeros(1, size(manipulation_mov, 2));
    warn('some dual manipulation waypoints have not hand synergy set!!!')
    disp(' ')
end

n_col = size(manipulation_mov, 2);
change_state = 0; % by default no change state

if n_col > 1
    % waypoint
    close_hand   = 0;
    close_velvet = 0;
    while (all(manipulation_mov(:,1) == 0))
        manipulation_mov = manipulation_mov(:, 2:end);  % delete first waypoint
        if hand_synergy(1) ~= 0
            close_hand = hand_synergy(1);
        end
        if velvet_synergy(1) ~= 0
            close_velvet = velvet_synergy(1);
        end
        hand_synergy   = hand_synergy(:, 2:end);      % delete first synergy
        velvet_synergy = velvet_synergy(:, 2:end);    % delete first synergy
    end
    disp(size(manipulation_mov))
    manipulation = manipulation_mov(:,1);
    manipulation_mov = manipulation_mov(:, 2:end);  % delete first waypoint
    % synergy
    if close_hand == 0
        set_hand_synergy(hand_synergy(1));
    else
        set_hand_synergy(close_hand);
    end
    if close_velvet == 0
        set_velvet_synergy(velvet_synergy(1));
    else
        set_velvet_synergy(close_velvet);
    end
    hand_synergy   = hand_synergy(:, 2:end);  % delete first synergy
    velvet_synergy = velvet_synergy(:, 2:end);  % delete first synergy
    % flag
    if manipulation == zeros(12,1)
        change_state = 1;
    end
elseif n_col == 1
    % waypoint
    manipulation = manipulation_mov(:,1);
    manipulation_mov = [];  % reset waypoint
    % synergy
    set_hand_synergy(hand_synergy(1));
    hand_synergy = [];  % reset synergy
    set_velvet_synergy(velvet_synergy(1));
    velvet_synergy = [];  % reset synergy
    if manipulation == zeros(12,1)
        change_state = 1;
    end
else % n_col == 0
    manipulation = zeros(12,1); % stay still, shush...
    change_state = 2;
end

end

