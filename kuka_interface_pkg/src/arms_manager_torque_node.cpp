#include "kuka_interface_pkg/arms_manager_torque.h"

int main(int argc, char **argv)
{
    ros::init(argc, argv, "arms_manager_torque_node");

    ArmsManager AM;
    AM.init();
    AM.run();

    return 0;
}