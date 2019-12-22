function data = iliad_data()
%ILIAD_DATA return a structure with the project data
%   Output data structure
%       -`data.sim_name`: simulink model to run
%       -`data.table_rs`: table reference system position
%
%   Remark: use this function and struct and not global variables,
%           if you have a different solution to avoid global
%           variables good for you!

data.sim_name = "iliad_test"; % for visualization
% data.sim_name = "iliad_ctrl"; % for simulation

data.table_rs = [1.3500; 1.2010; 0.7000];

end
