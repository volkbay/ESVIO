import os
import h5py
import numpy as np
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

    # Extrinsics
    T_lc_to_le = np.array(
        h5_file["ovc"]["left"]["calib"]["T_to_prophesee_left"]).reshape(4, 4)
    T_rc_to_le = np.array(
        h5_file["ovc"]["right"]["calib"]["T_to_prophesee_left"]).reshape(4, 4)
    T_imu_to_le = np.array(
        h5_file["ovc"]["imu"]["calib"]["T_to_prophesee_left"]).reshape(4, 4)
    T_re_to_le = np.array(
        h5_file["prophesee"]["right"]["calib"]["T_to_prophesee_left"]
        ).reshape(4, 4)
    T_lc_to_rc = np.linalg.inv(T_rc_to_le) @ T_lc_to_le
    T_le_to_imu = np.linalg.inv(T_imu_to_le)
    T_le_to_re = np.linalg.inv(T_re_to_le)

    # Compute IMU-Cam Calibration
    T_imu_to_lc = np.linalg.inv(T_lc_to_le) @ T_imu_to_le
    T_imu_to_rc = np.linalg.inv(T_rc_to_le) @ T_imu_to_le
    T_imu_to_re = np.linalg.inv(T_re_to_le) @ T_imu_to_le
    T_lc_to_imu = np.linalg.inv(T_imu_to_lc)
    T_rc_to_imu = np.linalg.inv(T_imu_to_rc)
    T_re_to_imu = np.linalg.inv(T_imu_to_re)

    # Intrinsics
    lcam_int = h5_file["ovc"]["left"]["calib"]["intrinsics"][:]
    lcam_dis = h5_file["ovc"]["left"]["calib"]["distortion_coeffs"][:]

    rcam_int = h5_file["ovc"]["right"]["calib"]["intrinsics"][:]
    rcam_dis = h5_file["ovc"]["right"]["calib"]["distortion_coeffs"][:]

    lev_int = h5_file["prophesee"]["left"]["calib"]["intrinsics"][:]
    lev_dis = h5_file["prophesee"]["left"]["calib"]["distortion_coeffs"][:]

    rev_int = h5_file["prophesee"]["right"]["calib"]["intrinsics"][:]
    rev_dis = h5_file["prophesee"]["right"]["calib"]["distortion_coeffs"][:]

    cam0 = {
        'camera_model':
            str(h5_file["ovc"]["left"]["calib"]["camera_model"][()].
                decode('utf-8')),
        'distortion_coeffs': lcam_dis.tolist(),
        'distortion_model':
            str(h5_file["ovc"]["left"]["calib"]["distortion_model"][()].
                decode('utf-8')),
        'intrinsics': lcam_int.tolist(),
        'resolution': h5_file["ovc"]["left"]["calib"]["resolution"][:].tolist()
    }

    cam1 = {
        'camera_model':
            str(h5_file["ovc"]["right"]["calib"]["camera_model"][()].
                decode('utf-8')),
        'distortion_coeffs': rcam_dis.tolist(),
        'distortion_model':
            str(h5_file["ovc"]["right"]["calib"]["distortion_model"][()].
                decode('utf-8')),
        'intrinsics': rcam_int.tolist(),
        'resolution':
            h5_file["ovc"]["right"]["calib"]["resolution"][:].tolist()
    }

    event0 = {
        'camera_model':
            str(h5_file["prophesee"]["left"]["calib"]["camera_model"][()].
                decode('utf-8')),
        'distortion_coeffs': lev_dis.tolist(),
        'distortion_model':
            str(h5_file["prophesee"]["left"]["calib"]["distortion_model"][()].
                decode('utf-8')),
        'intrinsics': lev_int.tolist(),
        'resolution':
            h5_file["prophesee"]["left"]["calib"]["resolution"][:].tolist()
    }

    event1 = {
        'camera_model':
            str(h5_file["prophesee"]["right"]["calib"]["camera_model"][()].
                decode('utf-8')),
        'distortion_coeffs': rev_dis.tolist(),
        'distortion_model':
            str(h5_file["prophesee"]["right"]["calib"]["distortion_model"][()].
                decode('utf-8')),
        'intrinsics': rev_int.tolist(),
        'resolution':
            h5_file["prophesee"]["right"]["calib"]["resolution"][:].tolist()
    }

    # Bundle camera configurations into a dictionary
    camera_config = {
        'cam0': cam0,
        'cam1': cam1,
        'event0': event0,
        'event1': event1
    }

    # Open file and write manually using basic write()
    with open(os.path.join(input_folder, seq_name + '.yaml'), 'w') as file:
        # Intrinsics and metadata
        for k, v in camera_config.items():
            file.write(f'{k}:\n')
            file.write(f'distortion_model: {v["distortion_model"]}\n')
            file.write(f'model_type: {v["camera_model"].upper()}\n')
            file.write('camera_name: camera\n')
            file.write(f'image_width: {v["resolution"][0]}\n')
            file.write(f'image_height: {v["resolution"][1]}\n')
            file.write('distortion_parameters:\n')
            file.write(f'  k1: {v["distortion_coeffs"][0]}\n')
            file.write(f'  k2: {v["distortion_coeffs"][1]}\n')
            file.write(f'  p1: {v["distortion_coeffs"][2]}\n')
            file.write(f'  p2: {v["distortion_coeffs"][3]}\n')
            file.write('projection_parameters:\n')
            file.write(f'  fx: {v["intrinsics"][0]}\n')
            file.write(f'  fy: {v["intrinsics"][1]}\n')
            file.write(f'  cx: {v["intrinsics"][2]}\n')
            file.write(f'  cy: {v["intrinsics"][3]}\n')

        # Extrinsic transformations
        file.write('\n\n\n')
        file.write("T_left_cam_to_imu:\n")
        np.savetxt(file, T_lc_to_imu[:3, :3], fmt="%.6f", delimiter=", ")
        file.write('\n')
        np.savetxt(file, T_lc_to_imu[:3, 3].reshape(1, -1), fmt="%.6f",
                   delimiter=", ")

        file.write('\n\n\n')
        file.write("T_left_event_to_imu:\n")
        np.savetxt(file, T_le_to_imu[:3, :3], fmt="%.6f", delimiter=", ")
        file.write('\n')
        np.savetxt(file, T_le_to_imu[:3, 3].reshape(1, -1), fmt="%.6f",
                   delimiter=", ")

        file.write('\n\n\n')
        file.write("T_left_cam_to_right_cam:\n")
        np.savetxt(file, T_lc_to_rc[:3, :3], fmt="%.6f", delimiter=", ")
        file.write('\n')
        np.savetxt(file, T_lc_to_rc[:3, 3].reshape(1, -1), fmt="%.6f",
                   delimiter=", ")

        file.write('\n\n\n')
        file.write("T_right_cam_to_imu:\n")
        np.savetxt(file, T_rc_to_imu[:, :], fmt="%.6f", delimiter=", ")

        file.write('\n\n\n')
        file.write("T_left_event_to_right_event:\n")
        np.savetxt(file, T_le_to_re[:3, :3], fmt="%.6f", delimiter=", ")
        file.write('\n')
        np.savetxt(file, T_le_to_re[:3, 3].reshape(1, -1), fmt="%.6f",
                   delimiter=", ")

        file.write('\n\n\n')
        file.write("T_right_event_to_imu:\n")
        np.savetxt(file, T_re_to_imu[:, :], fmt="%.6f", delimiter=", ")
