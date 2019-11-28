# launch the visualization in rviz

set the `sim_name` to:

    sim_name = "iliad_test";
 
use the following command to launch the visualization and use only matlab.
 
    roslaunch vito_description view_iliad.launch

--------------------------------------------------------------------------------

# launch the simulaition in rviz/gazebo

set the `sim_name` to:
 
    sim_name = "iliad_ctrl";
 
use the following command to launch the simulaiton in gazebo
 
    roslaunch vito_description display.launch 
 
activate the controller managers
 
    roslaunch kuka_interface_pkg manager.launch

--------------------------------------------------------------------------------

### To launch dual manipulation check its documentation.