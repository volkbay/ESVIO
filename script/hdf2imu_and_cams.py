import os
import h5py
import rosbag
import rospy
from cv_bridge import CvBridge
from sensor_msgs.msg import Imu
import argparse

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Get paths")
    parser.add_argument("--input_folder", help="Input files directory")
    parser.add_argument("--sequence_name", help="Seq name w/o any suffix")

    args = parser.parse_args()
    input_folder = args.input_folder
    seq_name = args.sequence_name
    data_path = os.path.join(input_folder, seq_name + '_data.h5')
    print("Input file:", data_path)

    h5_file = h5py.File(data_path, 'r')

    # Read IMU Data
    acc = h5_file["ovc"]["imu"]["accel"][:]
    gyr = h5_file["ovc"]["imu"]["omega"][:]

    # Convert microsecond to nanosecond (add 1 us for zero time error)
    imu_ts = (h5_file["ovc"]["imu"]["ts"][:] + 1) * 1e3

    # Read Gray Scale Image Data
    left_frames = h5_file["ovc"]["left"]["data"]
    right_frames = h5_file["ovc"]["right"]["data"]
    # Convert microsecond to nanosecond (add 1 us for zero time error)
    cam_ts = (h5_file["ovc"]["ts"][:] + 1) * 1e3
    number_of_frames = left_frames.shape[0]

    bridge = CvBridge()

    dst_bag_paths = {
        'imu': os.path.join(input_folder, 'bags',
                            seq_name + '.imu.bag'),
        'left_camera': os.path.join(input_folder, 'bags',
                                    seq_name + '.left_camera.bag'),
        'right_camera': os.path.join(input_folder, 'bags',
                                     seq_name + '.right_camera.bag')
    }

    for topic, bag_path in dst_bag_paths.items():
        with rosbag.Bag(bag_path, 'w') as bag:
            if topic.endswith('camera'):
                for n in range(number_of_frames):
                    if topic == 'left_camera':
                        data = left_frames[n, :]
                    elif topic == 'right_camera':
                        data = right_frames[n, :]

                    # Convert microsecond to nanosecond
                    # (add 1 us for zero time error)
                    ros_time = rospy.Time(int(cam_ts[n] // 1e9),
                                          int(cam_ts[n] % 1e9))

                    msg = bridge.cv2_to_imgmsg(data, encoding="mono8")
                    msg.header.stamp = ros_time
                    bag.write("/" + topic, msg, t=msg.header.stamp)
            elif topic == 'imu':
                for n in range(len(imu_ts)):
                    # Some of the IMU messages are corrputed
                    if imu_ts[n] < 0:
                        continue

                    # Convert timestamp from nanoseconds to seconds
                    ros_time = rospy.Time(int(imu_ts[n] // 1e9),
                                          int(imu_ts[n] % 1e9))

                    # Create IMU message and set its timestamp
                    imu_msg = Imu()
                    imu_msg.header.stamp = ros_time

                    # Assuming imu_data is a tuple or object that
                    # contains the necessary fields
                    # (e.g., linear acceleration, angular velocity)
                    # Example: [acc_x, acc_y, acc_z]
                    imu_msg.linear_acceleration.x = acc[n][0]
                    imu_msg.linear_acceleration.y = acc[n][1]
                    imu_msg.linear_acceleration.z = acc[n][2]
                    # Example: [gyro_x, gyro_y, gyro_z]
                    imu_msg.angular_velocity.x = gyr[n][0]
                    imu_msg.angular_velocity.y = gyr[n][1]
                    imu_msg.angular_velocity.z = gyr[n][2]

                    # Write IMU data to the bag file
                    bag.write("/imu", imu_msg, t=imu_msg.header.stamp)
    h5_file.close()
    print("I - Finished writing bag files.")
