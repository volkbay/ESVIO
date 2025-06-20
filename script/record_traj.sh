#!/bin/bash

# ----- CONFIG -----
# Data folder containing the .h5 files
DATASET_DIR="/data/m3ed/"
# Sequence name (filename of the .h5 file, *without* '_data')
SEQ_NAME="spot_forest_road_1"
# ----- CONFIG END-----

# Define the input bag and output bag
SEQ_DIR=${DATASET_DIR}${SEQ_NAME}/
INPUT_BAG=${SEQ_DIR}${SEQ_NAME}.merged.bag
OUTPUT_BAG=${SEQ_DIR}${SEQ_NAME}.out.bag

# Start recording in the background
rosbag record -O $OUTPUT_BAG /stereo_esvio_estimator/odometry &
RECORD_PID=$!

# Start playing the input bag
rosbag play $INPUT_BAG

# Stop recording when playback finishes
sleep 2  # Give some buffer time
kill $RECORD_PID

evo_traj bag $OUTPUT_BAG /stereo_esvio_estimator/odometry --save_as_tum
mv ./stereo_esvio_estimator_odometry.tum ${SEQ_DIR}${SEQ_NAME}_traj.tum

# evo_ape tum ${SEQ_DIR}${SEQ_NAME}_pose_evo_gt.txt ${SEQ_DIR}${SEQ_NAME}_traj.tum -pa --plot_mode xz --t_max_diff 0.1
# evo_ape tum ${SEQ_DIR}${SEQ_NAME}_pose_evo_gt.txt ${SEQ_DIR}${SEQ_NAME}_traj.tum -pas --plot_mode xz --t_max_diff 0.1