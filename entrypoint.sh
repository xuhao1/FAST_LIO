#!/bin/bash
# If argument1 is launch: to launch all nodes, else may in exec mode

source /root/lio_ws/install/setup.bash
if [ "$1" == "launch" ]; then
    ros2 launch fast_lio mapping.launch.py rviz:=false
else if [ "$1" == "bash" ]; then
    /bin/bash
else
    # exec with all arguments
    exec "$@"
fi
fi