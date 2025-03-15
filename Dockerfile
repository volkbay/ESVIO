# [volkbay, Mar2025]
FROM osrf/ros:noetic-desktop-full

ENV WORKSPACE /catkin_ws_dvs

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
	git nano autoconf libtool libsuitesparse-dev python3-catkin-tools python3-osrf-pycommon && \
    apt-get upgrade -y

RUN mkdir -p ${WORKSPACE}/src && \
	cd ${WORKSPACE} && \
	catkin init && \
	catkin config --extend /opt/ros/${ROS_DISTRO} && \
	catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release && \
    catkin config --jobs 8

RUN cd ${WORKSPACE}/src && \
    git clone https://github.com/arclab-hku/ESVIO.git

# TODO: delete this line if related CMakeLists is updated
RUN sed -i '16i \    ceres_catkin' ESVIO/feature_tracker/CMakeLists.txt 

RUN cd ${WORKSPACE}/src && \
    catkin build ceres_catkin camera_model esvio_estimator feature_tracker pose_graph

RUN	echo "export NVIDIA_VISIBLE_DEVICES=all" >> /root/.bashrc
RUN	echo "export NVIDIA_DRIVER_CAPABILITIES=all" >> /root/.bashrc
RUN	echo "export QT_X11_NO_MITSHM=1" >> /root/.bashrc
RUN echo "source ${WORKSPACE}/devel/setup.bash"

ENTRYPOINT ["/bin/bash"]


# Running Container:
# export DATASET_LOC=/hdd/prj/volkan/ebv/img
# docker run -it  -v /run/user/1000/gdm/Xauthority:/root/.Xauthority \
# -v /tmp/.X11-unix/:/tmp/.X11-unix/ -v ${DATASET_LOC}:/data -e DISPLAY \
# --env=NVIDIA_DRIVER_CAPABILITIES=all --gpus all <image_name>