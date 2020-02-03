% shut down properly the iliad_ctrl things

clear('RP_server') % delete the service
rosshutdown
clear
clear divide_tr_or_left % delete persistent variables
clear avoid_table       % delete persistent variables
clc