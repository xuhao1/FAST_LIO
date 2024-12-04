FROM ros:noetic-perception-focal

ARG ROS_VERSION=noetic
ARG LIO_WS=/root/lio_ws

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/Livox-SDK/Livox-SDK.git && \
    cd Livox-SDK/build  && \
    cmake ..  && \
    make -j$(nproc)  && \
    make install

RUN   mkdir -p ${LIO_WS}/src/ && \
      cd ${LIO_WS}/src/ && \
      git clone https://github.com/Livox-SDK/livox_ros_driver.git && \
      git clone https://github.com/hku-mars/FAST_LIO.git && \
      cd FAST_LIO && \
      git submodule update --init

WORKDIR $LIO_WS
SHELL ["/bin/bash", "-c"]
RUN   . "/opt/ros/${ROS_VERSION}/setup.sh" && \
      catkin_make -DCMAKE_BUILD_TYPE=Release
# COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
