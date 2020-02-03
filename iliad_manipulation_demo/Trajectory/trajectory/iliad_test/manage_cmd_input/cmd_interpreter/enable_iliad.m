%% ENABLE_ILIAD defines default command to be executed when the robot is enabled

% global sim_name;
data = iliad_data();
sim_name = data.sim_name;

set_param(sim_name + '/enable','Value', '1');
if strcmp(sim_name, "iliad_ctrl")  % if real robot set up the ee too
    disp('setting up the end-effextors...')
    % open hand command I6
    set_param('iliad_ctrl/hand_synergy', 'Value', sprintf('%f', 0));
    % unroll elvet tray
    set_param('iliad_ctrl/velvet_ctrl', 'Value', sprintf('%f', 0.5));
    % define sensible axis for the velvet tray
    cmd_traj = [0 0 1 0 0 0];
    set_param('iliad_ctrl/command_trajectory_left', 'Value',...
               sprintf('[%f,%f,%f,%f,%f,%f]',...
               cmd_traj(1), cmd_traj(2), cmd_traj(3),...
               cmd_traj(4), cmd_traj(5), cmd_traj(6))...
              );
end