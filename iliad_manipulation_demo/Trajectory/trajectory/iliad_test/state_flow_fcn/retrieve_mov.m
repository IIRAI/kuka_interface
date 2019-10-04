function [manipulation, homing] = retrieve_mov()

global manipulation_mov

n_col = size(manipulation_mov, 2);

if n_col > 1
    manipulation = manipulation_mov(:,1);
    manipulation_mov = manipulation_mov(:,2:n_col); % delete first waypoint
    homing = 0;
elseif n_col == 1
    manipulation = manipulation_mov(:,1);
    manipulation_mov = []; % reset waypoint
    homing = 0;
else % n_col == 0
    manipulation = zeros(12,1);
    homing = 1;
end

end

