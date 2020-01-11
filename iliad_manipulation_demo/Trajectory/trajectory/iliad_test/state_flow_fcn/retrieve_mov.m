function [manipulation, change_state] = retrieve_mov()
%RETRIEVE_MOV returns the next waypoint to be executed from dual-manipulation
%   - `change_state`: 0, do not change state
%                     1, go home
%                     2, stay idle

% stores the waypoints from (dual manipulation) to be executed
% in this function the oldest waypoint is returned (to be executed) and deleted
global manipulation_mov
global hand_synergy

disp(' ')
disp(' ')
disp(' list of the hand synergy DHN:')
disp(hand_synergy)
disp('n° of waypoint for both manipulation and synergy:')
size(manipulation_mov, 2)
size(hand_synergy, 2)
disp(' ')
disp(' ')

if size(manipulation_mov, 2) ~= size(hand_synergy, 2)
    hand_synergy = zeros(1, size(manipulation_mov, 2));
    warn('some dual manipulation waypoints have not hand synergy set!!!')
    disp(' ')
end

n_col = size(manipulation_mov, 2);
change_state = 0; % by default no change state

if n_col > 1
    % waypoint
    manipulation = manipulation_mov(:,1);
    manipulation_mov = manipulation_mov(:, 2:n_col);  % delete first waypoint
    % synergy
    set_hand_synergy(hand_synergy(1));
    hand_synergy = hand_synergy(:, 2:end);  % delete first synergy
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
    if manipulation == zeros(12,1)
        change_state = 1;
    end
else % n_col == 0
    manipulation = zeros(12,1); % stay still, shush...
    change_state = 2;
end

end

