#!/bin/bash
# If argument1 is launch: to launch all nodes, else may in exec mode

source /root/lio_ws/devel/setup.bash
if [ "$1" == "launch" ]; then
    roslaunch fast_lio mapping_mid360.launch
else if [ "$1" == "bash" ]; then
    /bin/bash
else
    # exec with all arguments
    exec "$@"
fi
fi