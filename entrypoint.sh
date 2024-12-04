#!/bin/bash
# If argument1 is launch: to launch all nodes, else may in exec mode

source /root/swarm_ws/devel/setup.bash
if [ "$1" == "launch" ]; then

else if [ "$1" == "bash" ]; then
    /bin/bash
else
    # exec with all arguments
    exec "$@"
fi
fi