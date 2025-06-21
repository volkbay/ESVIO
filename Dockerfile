# [volkbay, Mar2025]
FROM ros:noetic-perception

# Modify as you like
ENV WORKSPACE=/catkin_ws_dvs

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    software-properties-common

RUN DEBIAN_FRONTEND=noninteractive add-apt-repository -y \
    ppa:inivation-ppa/inivation

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git nano autoconf libtool libsuitesparse-dev python3-catkin-tools \
    python3-osrf-pycommon gnome-terminal dbus-x11 python3-pip wget \
    libhdf5-dev gfortran libcaer-dev usbutils \
    ros-noetic-rqt-reconfigure ros-noetic-rqt-image-view ros-noetic-rviz && \
    apt-get upgrade -y

RUN pip install evo

RUN mkdir -p ${WORKSPACE}/src && \
    cd ${WORKSPACE} && \
    catkin init && \
    catkin config --extend /opt/ros/${ROS_DISTRO} && \
    catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release && \
    catkin config --jobs 8

RUN cd ${WORKSPACE}/src && \
    git clone https://github.com/volkbay/ESVIO.git

RUN cd ${WORKSPACE}/src && \
    catkin build ceres_catkin && \
    catkin build camera_model && \
    catkin build esvio_estimator feature_tracker pose_graph && \
    catkin build davis_ros_driver dvs_renderer 

# (begin) HDF to ROSBAG conversion
ENV HDF5_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/hdf5/plugin
RUN mkdir ${HDF5_PLUGIN_PATH}

RUN pip install h5py

# Add blosc filter
RUN cd ${WORKSPACE}/src/ESVIO/dependences && \
    git clone https://github.com/Blosc/hdf5-blosc.git && \
    cd hdf5-blosc && \
    mkdir build && cd build && \
    cmake .. && \
    make && cp libH5Zblosc.so ${HDF5_PLUGIN_PATH}/

# Add LZF filter
RUN cd ${WORKSPACE}/src/ESVIO/dependences && \
    git clone https://github.com/h5py/h5py.git && \
    cd h5py/lzf && \
    h5fc -I"lzf" -O2 -fPIC -shared lzf/*.c lzf_filter.c -lhdf5 -o liblzf_filter.so && \
    cp liblzf_filter.so ${HDF5_PLUGIN_PATH}/

RUN /bin/bash -c "\
    source /opt/ros/${ROS_DISTRO}/setup.bash && \
    cd ${WORKSPACE}/src/ESVIO/dependences/events_h52bag && \
    mkdir build && cd build && \
    cmake .. && \
    make"

RUN cd ${WORKSPACE}/src && \
    catkin build mpl_dataset_toolbox events_repacking_helper
# (end) HDF to ROSBAG conversion

RUN echo "export NVIDIA_VISIBLE_DEVICES=all" >> /root/.bashrc
RUN echo "export NVIDIA_DRIVER_CAPABILITIES=all" >> /root/.bashrc
RUN echo "export QT_X11_NO_MITSHM=1" >> /root/.bashrc
RUN echo "source ${WORKSPACE}/devel/setup.bash" >> /root/.bashrc

# ORIN Specific
# RUN apt install libcanberra-gtk3-dev
# RUN wget https://github.com/libffi/libffi/releases/download/v3.4.8/libffi-3.4.8.tar.gz
# RUN tar -xzvf libffi-3.4.8.tar.gz 
# RUN cd libffi-3.4.8
# RUN ./configure --prefix=/usr/local
# RUN make -j$(nproc)
# RUN sudo make install

ENTRYPOINT ["/bin/bash"]


# Running Container:
# export DATASET_LOC=/... # YOUR DATA LOCATION
# docker run -it --privileged --net=host -v /dev/bus/usb:/dev/bus/usb \
#  -v /run/user/1000/gdm/Xauthority:/root/.Xauthority \
#  -v /run/user/1000/:/run/user/1000/ \
#  -v /tmp/.X11-unix/:/tmp/.X11-unix/ -v ${DATASET_LOC}:/data -e DISPLAY \
#  --env=NVIDIA_DRIVER_CAPABILITIES=all --gpus all --runtime=nvidia esvio