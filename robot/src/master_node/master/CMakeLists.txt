cmake_minimum_required(VERSION 3.9)
project(master)

add_compile_options(-std=c++11)

set(HTTP_CLIENT "/usr/include/cpprest/http_client.h")
set(WS_CLIENT "/usr/include/cpprest/ws_client.h")


find_package(catkin REQUIRED COMPONENTS roscpp std_msgs message_generation)

find_package(Boost REQUIRED COMPONENTS system)

add_message_files(FILES Pair.msg CupNumber.msg)

generate_messages(DEPENDENCIES std_msgs)

#add_dependencies(master master_generate_messages_cpp)

catkin_package(
  INCLUDE_DIRS include
  LIBRARIES master
  CATKIN_DEPENDS roscpp std_msgs message_runtime
  DEPENDS system_lib
  #EXPORTED_TARGETS master_generate_messages_cpp
)

include_directories(include
  ${catkin_INCLUDE_DIRS}
  ${HTTP_CLIENT}
  ${WS_CLIENT}
)
include_directories(/usr/include/cpprest)
include_directories(include msg)

## Declare a C++ library
# add_library(${PROJECT_NAME}
#   src/${PROJECT_NAME}/master.cpp
# )

 add_executable(${PROJECT_NAME} src/master.cpp)

 target_link_libraries(${PROJECT_NAME}
   ${catkin_LIBRARIES}
   boost_system
   crypto
   ssl
   cpprest
 )
