FROM ros:iron-perception

ARG ROS_VERSION=iron
ARG LIO_WS=/root/lio_ws

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt upgrade -y && apt-get install -y git libgoogle-glog-dev  libsuitesparse-dev libatlas-base-dev htop net-tools libeigen3-dev


RUN git clone https://github.com/Livox-SDK/Livox-SDK2.git && \
    mkdir -p Livox-SDK2/build && \
    cd Livox-SDK2/build  && \
    cmake ..  && \
    make -j8  && \
    make install

RUN   mkdir -p ${LIO_WS}/src/ && \
      cd ${LIO_WS}/src/ && \
      git clone https://github.com/Livox-SDK/livox_ros_driver2.git

COPY ./ ${LIO_WS}/src/FAST_LIO/

WORKDIR $LIO_WS
SHELL ["/bin/bash", "-c"]
RUN   . "/opt/ros/${ROS_VERSION}/setup.bash" && \
      cd $LIO_WS/src/livox_ros_driver2 && \
      ./build.sh humble
COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
