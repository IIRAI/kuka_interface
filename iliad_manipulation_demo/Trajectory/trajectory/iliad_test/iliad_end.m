% shut down properly the iliad_test things

clear('RP_server') % delete the service
rosshutdown
clear
clear divide_tr_or_left % delete persistent variables
clc