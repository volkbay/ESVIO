cmake_minimum_required(VERSION 2.8.3)
project(feature_tracker)

set(CMAKE_BUILD_TYPE "Release")
set(CMAKE_CXX_FLAGS "-std=c++11")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -Wall -g")

find_package(catkin REQUIRED COMPONENTS
    roscpp
    std_msgs
    sensor_msgs
    cv_bridge
    camera_model
    tf
    ceres_catkin
    )

find_package(OpenCV REQUIRED)

catkin_package()

include_directories(
    ${catkin_INCLUDE_DIRS}
    )

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
find_package(Eigen3)
include_directories(
  ${catkin_INCLUDE_DIRS}
  ${EIGEN3_INCLUDE_DIR}
)

# stereo image feature
add_executable(stereo_image_tracker
    src/stereo_image_tracker_node.cpp
    src/parameters.cpp
    src/feature_tracker.cpp
    src/event_detector/event_detector.cc
    )
target_link_libraries(stereo_image_tracker ${catkin_LIBRARIES} ${OpenCV_LIBS})

# stereo event feature
add_executable(stereo_event_tracker
    src/stereo_event_tracker_node.cpp
    src/parameters.cpp
    src/feature_tracker.cpp
    src/event_detector/event_detector.cc
    src/utility/visualization.cpp
    )
target_link_libraries(stereo_event_tracker ${catkin_LIBRARIES} ${OpenCV_LIBS})

