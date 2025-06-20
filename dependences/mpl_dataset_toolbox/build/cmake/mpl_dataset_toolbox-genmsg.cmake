# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "mpl_dataset_toolbox: 2 messages, 0 services")

set(MSG_I_FLAGS "-Impl_dataset_toolbox:/catkin_ws_dvs/src/mpl_dataset_toolbox/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(mpl_dataset_toolbox_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/Event.msg" NAME_WE)
add_custom_target(_mpl_dataset_toolbox_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "mpl_dataset_toolbox" "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/Event.msg" ""
)

get_filename_component(_filename "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/EventArray.msg" NAME_WE)
add_custom_target(_mpl_dataset_toolbox_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "mpl_dataset_toolbox" "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/EventArray.msg" "mpl_dataset_toolbox/Event:std_msgs/Header"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(mpl_dataset_toolbox
  "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/Event.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/mpl_dataset_toolbox
)
_generate_msg_cpp(mpl_dataset_toolbox
  "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/EventArray.msg"
  "${MSG_I_FLAGS}"
  "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/Event.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/mpl_dataset_toolbox
)

### Generating Services

### Generating Module File
_generate_module_cpp(mpl_dataset_toolbox
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/mpl_dataset_toolbox
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(mpl_dataset_toolbox_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(mpl_dataset_toolbox_generate_messages mpl_dataset_toolbox_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/Event.msg" NAME_WE)
add_dependencies(mpl_dataset_toolbox_generate_messages_cpp _mpl_dataset_toolbox_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/EventArray.msg" NAME_WE)
add_dependencies(mpl_dataset_toolbox_generate_messages_cpp _mpl_dataset_toolbox_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(mpl_dataset_toolbox_gencpp)
add_dependencies(mpl_dataset_toolbox_gencpp mpl_dataset_toolbox_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS mpl_dataset_toolbox_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(mpl_dataset_toolbox
  "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/Event.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/mpl_dataset_toolbox
)
_generate_msg_eus(mpl_dataset_toolbox
  "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/EventArray.msg"
  "${MSG_I_FLAGS}"
  "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/Event.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/mpl_dataset_toolbox
)

### Generating Services

### Generating Module File
_generate_module_eus(mpl_dataset_toolbox
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/mpl_dataset_toolbox
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(mpl_dataset_toolbox_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(mpl_dataset_toolbox_generate_messages mpl_dataset_toolbox_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/Event.msg" NAME_WE)
add_dependencies(mpl_dataset_toolbox_generate_messages_eus _mpl_dataset_toolbox_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/EventArray.msg" NAME_WE)
add_dependencies(mpl_dataset_toolbox_generate_messages_eus _mpl_dataset_toolbox_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(mpl_dataset_toolbox_geneus)
add_dependencies(mpl_dataset_toolbox_geneus mpl_dataset_toolbox_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS mpl_dataset_toolbox_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(mpl_dataset_toolbox
  "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/Event.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/mpl_dataset_toolbox
)
_generate_msg_lisp(mpl_dataset_toolbox
  "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/EventArray.msg"
  "${MSG_I_FLAGS}"
  "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/Event.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/mpl_dataset_toolbox
)

### Generating Services

### Generating Module File
_generate_module_lisp(mpl_dataset_toolbox
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/mpl_dataset_toolbox
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(mpl_dataset_toolbox_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(mpl_dataset_toolbox_generate_messages mpl_dataset_toolbox_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/Event.msg" NAME_WE)
add_dependencies(mpl_dataset_toolbox_generate_messages_lisp _mpl_dataset_toolbox_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/EventArray.msg" NAME_WE)
add_dependencies(mpl_dataset_toolbox_generate_messages_lisp _mpl_dataset_toolbox_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(mpl_dataset_toolbox_genlisp)
add_dependencies(mpl_dataset_toolbox_genlisp mpl_dataset_toolbox_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS mpl_dataset_toolbox_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(mpl_dataset_toolbox
  "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/Event.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/mpl_dataset_toolbox
)
_generate_msg_nodejs(mpl_dataset_toolbox
  "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/EventArray.msg"
  "${MSG_I_FLAGS}"
  "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/Event.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/mpl_dataset_toolbox
)

### Generating Services

### Generating Module File
_generate_module_nodejs(mpl_dataset_toolbox
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/mpl_dataset_toolbox
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(mpl_dataset_toolbox_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(mpl_dataset_toolbox_generate_messages mpl_dataset_toolbox_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/Event.msg" NAME_WE)
add_dependencies(mpl_dataset_toolbox_generate_messages_nodejs _mpl_dataset_toolbox_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/EventArray.msg" NAME_WE)
add_dependencies(mpl_dataset_toolbox_generate_messages_nodejs _mpl_dataset_toolbox_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(mpl_dataset_toolbox_gennodejs)
add_dependencies(mpl_dataset_toolbox_gennodejs mpl_dataset_toolbox_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS mpl_dataset_toolbox_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(mpl_dataset_toolbox
  "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/Event.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/mpl_dataset_toolbox
)
_generate_msg_py(mpl_dataset_toolbox
  "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/EventArray.msg"
  "${MSG_I_FLAGS}"
  "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/Event.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/mpl_dataset_toolbox
)

### Generating Services

### Generating Module File
_generate_module_py(mpl_dataset_toolbox
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/mpl_dataset_toolbox
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(mpl_dataset_toolbox_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(mpl_dataset_toolbox_generate_messages mpl_dataset_toolbox_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/Event.msg" NAME_WE)
add_dependencies(mpl_dataset_toolbox_generate_messages_py _mpl_dataset_toolbox_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws_dvs/src/mpl_dataset_toolbox/msg/EventArray.msg" NAME_WE)
add_dependencies(mpl_dataset_toolbox_generate_messages_py _mpl_dataset_toolbox_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(mpl_dataset_toolbox_genpy)
add_dependencies(mpl_dataset_toolbox_genpy mpl_dataset_toolbox_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS mpl_dataset_toolbox_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/mpl_dataset_toolbox)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/mpl_dataset_toolbox
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(mpl_dataset_toolbox_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/mpl_dataset_toolbox)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/mpl_dataset_toolbox
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(mpl_dataset_toolbox_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/mpl_dataset_toolbox)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/mpl_dataset_toolbox
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(mpl_dataset_toolbox_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/mpl_dataset_toolbox)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/mpl_dataset_toolbox
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(mpl_dataset_toolbox_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/mpl_dataset_toolbox)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/mpl_dataset_toolbox\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/mpl_dataset_toolbox
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(mpl_dataset_toolbox_generate_messages_py std_msgs_generate_messages_py)
endif()
