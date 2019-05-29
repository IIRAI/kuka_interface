% TESTING_SCRIPT contains some passage to obtains what needed for my thesis

%% init workspace
rosshutdown
clear
clc

%% find home position

% home position in configuration space
load('q_0_left')
load('q_0_right')

% robot parameters
KUKA_LWR_geometry_and_direct_kinematics % init KUKA LWR geometry params and DK
TWO_ARMS_transformations                % init KUKA ARMS transformations between base, arms and ee

% ----- SOLVE LEFT -----
% Denavit-Hartemberg table with numeric values 
DH_table_num_left = double(subs(DH_table_sym, q_sym, q_0_left));
% evaluate direct kinematic
[~, Tee_left] = direct_kinematics_DH(DH_table_num_left);
% use pre and post transformations
Tee_left = T_b_DH0l * Tee_left * T_DH7l_eel;
        
home_pos_left = Tee_left(1:3,4);       % LEFT POSITION

% ----- SOLVE RIGHT -----
% Denavit-Hartemberg table with numeric values 
DH_table_num_right = double(subs(DH_table_sym, q_sym, q_0_right));
% evaluate direct kinematic
[~, Tee_right] = direct_kinematics_DH(DH_table_num_right);
% use pre and post transformations
Tee_right = T_b_DH0r * Tee_right * T_DH7r_eer;
        
home_pos_right = Tee_right(1:3,4);     % RIGHT POSITION

%% DIsplay value

home_pos_left
home_pos_right
