#!/bin/bash
# [volkbay'25]
# This script converts the .h5 files from the Prophesee dataset to ROS bags.
# It requires the events_h52bag package to be built and the events_repacking_helper package to be available.
# It also requires the mpl_dataset_toolbox package to merge the single-topic bags into a single bag.
# The script assumes that the .h5 files are located in a specific directory and ...
# it will create a new directory for the converted bags.
# Final product is a single bag under "data_folder/sequence_folder/merged_bag/"

# ----- CONFIG -----
# Data folder containing the .h5 files
DATASET_DIR="/data/m3ed/"
# Sequence name (filename of the .h5 file, *without* '_data')
SEQ_NAME="spot_forest_road_1"
# Size of the event frames (looking at the metadata or calibration info in the .h5 file)
SIZE_H_EVENT=720
SIZE_W_EVENT=1280
# ----- CONFIG END-----

SEQ_DIR=${DATASET_DIR}${SEQ_NAME}/
H5_FILE=${SEQ_DIR}${SEQ_NAME}_data.h5
SINGLE_BAG_PREFIX=${SEQ_DIR}bags/${SEQ_NAME}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Alias for events_h52bag 
events_h52bag() {
  ${SCRIPT_DIR}/../dependences/events_h52bag/build/events_h52bag "$@"
}

# From .h5 to a single calibration YAML file (all intrinsic and extrinsic)
python3 ${SCRIPT_DIR}/hdf2calib.py --input_folder ${SEQ_DIR} --sequence_name ${SEQ_NAME}

# IMU and camera frames in the .h5 to single-topic rosbags
mkdir ${SEQ_DIR}bags/
python3 ${SCRIPT_DIR}/hdf2imu_and_cams.py --input_folder ${SEQ_DIR} --sequence_name ${SEQ_NAME}

# Event .h5 to single-topic rosbags
events_h52bag ${H5_FILE} ${SINGLE_BAG_PREFIX}.left_event_not_sync left_event $SIZE_H_EVENT $SIZE_W_EVENT 500000000 100000 /prophesee/left
events_h52bag ${H5_FILE} ${SINGLE_BAG_PREFIX}.right_event_not_sync right_event $SIZE_H_EVENT $SIZE_W_EVENT 500000000 100000 /prophesee/right

# Adjust frequency of event streams to 60Hz
roslaunch events_repacking_helper repacking.launch bag_in:=${SINGLE_BAG_PREFIX}.left_event_not_sync.bag bag_out:=${SINGLE_BAG_PREFIX}.left_event.bag
rm ${SINGLE_BAG_PREFIX}.left_event_not_sync.bag
roslaunch events_repacking_helper repacking.launch bag_in:=${SINGLE_BAG_PREFIX}.right_event_not_sync.bag bag_out:=${SINGLE_BAG_PREFIX}.right_event.bag
rm ${SINGLE_BAG_PREFIX}.right_event_not_sync.bag

# Merge single topic bags
roslaunch mpl_dataset_toolbox bag_merger.launch directory_path:=${SEQ_DIR}bags/
mv ${SEQ_DIR}bags/merged_bags/${SEQ_NAME}.merged.bag ${SEQ_DIR}

# Merging single-topic bags is completed. Check the resulting bag for correct topics, file size and datapoint counts. Then, delete 'bags/'.
# rm -r ${SEQ_DIR}bags/
# rm ${H5_FILE}