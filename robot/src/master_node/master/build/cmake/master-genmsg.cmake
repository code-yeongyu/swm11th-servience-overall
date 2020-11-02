# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "master: 2 messages, 0 services")

set(MSG_I_FLAGS "-Imaster:/home/ssk807/catkin_ws/src/master/msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(master_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/ssk807/catkin_ws/src/master/msg/Pair.msg" NAME_WE)
add_custom_target(_master_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "master" "/home/ssk807/catkin_ws/src/master/msg/Pair.msg" ""
)

get_filename_component(_filename "/home/ssk807/catkin_ws/src/master/msg/CupNumber.msg" NAME_WE)
add_custom_target(_master_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "master" "/home/ssk807/catkin_ws/src/master/msg/CupNumber.msg" "master/Pair"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(master
  "/home/ssk807/catkin_ws/src/master/msg/Pair.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/master
)
_generate_msg_cpp(master
  "/home/ssk807/catkin_ws/src/master/msg/CupNumber.msg"
  "${MSG_I_FLAGS}"
  "/home/ssk807/catkin_ws/src/master/msg/Pair.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/master
)

### Generating Services

### Generating Module File
_generate_module_cpp(master
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/master
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(master_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(master_generate_messages master_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ssk807/catkin_ws/src/master/msg/Pair.msg" NAME_WE)
add_dependencies(master_generate_messages_cpp _master_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ssk807/catkin_ws/src/master/msg/CupNumber.msg" NAME_WE)
add_dependencies(master_generate_messages_cpp _master_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(master_gencpp)
add_dependencies(master_gencpp master_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS master_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(master
  "/home/ssk807/catkin_ws/src/master/msg/Pair.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/master
)
_generate_msg_eus(master
  "/home/ssk807/catkin_ws/src/master/msg/CupNumber.msg"
  "${MSG_I_FLAGS}"
  "/home/ssk807/catkin_ws/src/master/msg/Pair.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/master
)

### Generating Services

### Generating Module File
_generate_module_eus(master
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/master
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(master_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(master_generate_messages master_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ssk807/catkin_ws/src/master/msg/Pair.msg" NAME_WE)
add_dependencies(master_generate_messages_eus _master_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ssk807/catkin_ws/src/master/msg/CupNumber.msg" NAME_WE)
add_dependencies(master_generate_messages_eus _master_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(master_geneus)
add_dependencies(master_geneus master_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS master_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(master
  "/home/ssk807/catkin_ws/src/master/msg/Pair.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/master
)
_generate_msg_lisp(master
  "/home/ssk807/catkin_ws/src/master/msg/CupNumber.msg"
  "${MSG_I_FLAGS}"
  "/home/ssk807/catkin_ws/src/master/msg/Pair.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/master
)

### Generating Services

### Generating Module File
_generate_module_lisp(master
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/master
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(master_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(master_generate_messages master_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ssk807/catkin_ws/src/master/msg/Pair.msg" NAME_WE)
add_dependencies(master_generate_messages_lisp _master_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ssk807/catkin_ws/src/master/msg/CupNumber.msg" NAME_WE)
add_dependencies(master_generate_messages_lisp _master_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(master_genlisp)
add_dependencies(master_genlisp master_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS master_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(master
  "/home/ssk807/catkin_ws/src/master/msg/Pair.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/master
)
_generate_msg_nodejs(master
  "/home/ssk807/catkin_ws/src/master/msg/CupNumber.msg"
  "${MSG_I_FLAGS}"
  "/home/ssk807/catkin_ws/src/master/msg/Pair.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/master
)

### Generating Services

### Generating Module File
_generate_module_nodejs(master
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/master
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(master_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(master_generate_messages master_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ssk807/catkin_ws/src/master/msg/Pair.msg" NAME_WE)
add_dependencies(master_generate_messages_nodejs _master_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ssk807/catkin_ws/src/master/msg/CupNumber.msg" NAME_WE)
add_dependencies(master_generate_messages_nodejs _master_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(master_gennodejs)
add_dependencies(master_gennodejs master_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS master_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(master
  "/home/ssk807/catkin_ws/src/master/msg/Pair.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/master
)
_generate_msg_py(master
  "/home/ssk807/catkin_ws/src/master/msg/CupNumber.msg"
  "${MSG_I_FLAGS}"
  "/home/ssk807/catkin_ws/src/master/msg/Pair.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/master
)

### Generating Services

### Generating Module File
_generate_module_py(master
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/master
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(master_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(master_generate_messages master_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ssk807/catkin_ws/src/master/msg/Pair.msg" NAME_WE)
add_dependencies(master_generate_messages_py _master_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ssk807/catkin_ws/src/master/msg/CupNumber.msg" NAME_WE)
add_dependencies(master_generate_messages_py _master_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(master_genpy)
add_dependencies(master_genpy master_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS master_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/master)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/master
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(master_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/master)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/master
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(master_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/master)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/master
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(master_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/master)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/master
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(master_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/master)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/master\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/master
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(master_generate_messages_py std_msgs_generate_messages_py)
endif()
