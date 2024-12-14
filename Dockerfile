FROM ros:noetic-perception-focal

ARG ROS_VERSION=noetic
ARG LIO_WS=/root/lio_ws

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/Livox-SDK/Livox-SDK2.git && \
    mkdir -p Livox-SDK2/build && \
    cd Livox-SDK2/build  && \
    cmake ..  && \
    make -j$(nproc)  && \
    make install

RUN   mkdir -p ${LIO_WS}/src/ && \
      cd ${LIO_WS}/src/ && \
      git clone https://github.com/Livox-SDK/livox_ros_driver2.git

COPY ./ ${LIO_WS}/src/FAST_LIO/

WORKDIR $LIO_WS
SHELL ["/bin/bash", "-c"]
RUN   . "/opt/ros/${ROS_VERSION}/setup.bash" && \
      cd $LIO_WS/src/livox_ros_driver2 && \
      ./build.sh ROS1
      # catkin_make -DCMAKE_BUILD_TYPE=Release
# COPY ./entrypoint.sh /
# ENTRYPOINT ["/entrypoint.sh"]
