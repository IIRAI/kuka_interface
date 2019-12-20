# How to use Reverse Priority with Dual Manipulation

It is possible to test and check the *Reverse Priority* project of this directory in many different ways.

1. [Visualization](#launch-the-viasualtion-in-rviz): visualize the robot, without simulation, just to test the kinematics.  
You can launch the visualization with and without *dual manipulation*.

2. [Simulation](#launch-the-simulation-in-rviz/gazebo): simulate the real robot and its interface in gazebo, run this with dual manipulation, if you want to move just the robot go to [1](#launch-the-viasualtion-in-rviz).

3. [Real robot](#Real-robot): test the dual manipualtion planner on the robot.

## launch the visualization in rviz

set the `sim_name` to:

    sim_name = "iliad_test";

use the following command to launch the visualization and use **only** matlab.

    roslaunch vito_description view_iliad.launch

Then run the `iliad_main.m`, each cell separately and follow the instruction.  

In case you want to visualize the *dual manipulation* plan launch instead

    roslaunch dual_manipulation_gui gui_ctrl_matlab.launch

and then run the `iliad_main.m`.

--------------------------------------------------------------------------------

## launch the simulation in rviz/gazebo

set the `sim_name` to:

    sim_name = "iliad_ctrl";

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

Then set the `sim_name` to:

    sim_name = "iliad_ctrl";

use the following command to comunicate with the robot

    roslaunch kuka_interface_pkg display_manage.launch use_robot_sim:=False

launch the dual manipulation planner

    roslaunch dual_manipulation_gui gui_ctrl_matlab.launch

Then run the `iliad_main.m`, each cell separately and follow the instruction.

NOTE: in case you want to send the robot to the home position without using 
reverse priority use the command

    rosrun kuka_interface_pkg homing
