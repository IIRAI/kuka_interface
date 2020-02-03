# How to use Reverse Priority with Dual Manipulation

It is possible to test and check the *Reverse Priority* project of this directory in two ways.

1. [Simulation](#launch-the-simulation-in-rviz/gazebo): simulate the real robot and its interface in gazebo, run this with dual manipulation, if you want to move just the robot go to [1](#launch-the-viasualtion-in-rviz).

2. [Real robot](#Real-robot): test the dual manipualtion planner on the robot.

--------------------------------------------------------------------------------

## launch the simulation in rviz/gazebo

use the following command to launch the simulation in gazebo and start the managers to interface with it

    roslaunch kuka_interface_pkg display_manage.launch

launch the dual manipualtion planner

    roslaunch dual_manipulation_gui gui_ctrl_matlab.launch

Then run the `iliad_main.m`, each cell separately and follow the instruction.  

--------------------------------------------------------------------------------

## Real robot

To setup the robot comunication check that:

1. specify the ROS ip address in your terminal (add them in your `.basrc` and source it)

    export ROS_MASTER_URI=http://192.168.0.150:11311  
    export ROS_IP=192.168.0.150

2. after attaching the usb cable of the robot to the computer enable the permission to use it

    sudo chmod 777 /dev/ttyUSB0

Then launch a roscore separatedly so that you can close and re-launch the other nodes if they failed without losing the ros core manager.  
Launch the manager of the forse sensors:

    roslaunch force_torque_sensor display.launch

Open the browser to the addresses `192.168.0.2/setting.htm` and `192.168.0.250/setting.htm` and set the frequency of the filter to *5 Hz* and select *Apply*.

Run the robot using the following command (then you can close gazebo if you have another visualization program)

    roslaunch kuka_interface_pkg display_manage.launch use_robot_sim:=false

Launch the manager of the end-effectors

    roslaunch kuka_interface_pkg arm_manager_force.launch

finally launch the dual manipulation planner

    roslaunch dual_manipulation_gui gui_ctrl_matlab.launch

Then run the `iliad_main.m`, each cell separately and follow the instruction.

--------------------------------------------------------------------------------

NOTE: in case you want to send the robot to the home position without using
reverse priority use the command

    rosrun kuka_interface_pkg homing
