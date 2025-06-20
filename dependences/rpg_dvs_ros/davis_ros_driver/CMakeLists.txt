cmake_minimum_required(VERSION 2.8.3)
project(davis_ros_driver)

# NOTE: DAVISConfig.h fix
# find_package(dynamic_reconfigure REQUIRED)
find_package(catkin_simple REQUIRED)
find_package(libcaer REQUIRED)

catkin_simple()

SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -O3")

find_package(Boost REQUIRED COMPONENTS system thread)

# NOTE: DAVISConfig.h fix
# generate_dynamic_reconfigure_options(
#   cfg/DAVIS_ROS_Driver.cfg
# )

# make the executable
cs_add_executable(davis_ros_driver
  src/driver_node.cpp
  src/driver.cpp
)

# make the nodelet into a library
cs_add_library(davis_ros_driver_nodelet
  src/driver_nodelet.cpp
  src/driver.cpp
)

# link the executable to the necesarry libs
target_link_libraries(davis_ros_driver
  ${catkin_LIBRARIES}
  ${Boost_LIBRARIES}
  libcaer::caer
)

# link the executable to the necesarry libs
target_link_libraries(davis_ros_driver_nodelet
  ${catkin_LIBRARIES}
  ${Boost_LIBRARIES}
  libcaer::caer
)

# Install the nodelet library
cs_install()

# Install other support files for installation
install(FILES davis_ros_driver_nodelet.xml
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

# Export package
cs_export()
