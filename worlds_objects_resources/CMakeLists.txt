cmake_minimum_required(VERSION 3.8)
project(worlds_objects_resources)

# Find ROS
if($ENV{ROS_VERSION} EQUAL 1)
  find_package(catkin REQUIRED)
else()
  find_package(ament_cmake REQUIRED)
endif()

# Specify dependencies
if($ENV{ROS_VERSION} EQUAL 1)
  catkin_package(
    #  INCLUDE_DIRS include
    #  LIBRARIES navigation_resources
    #  CATKIN_DEPENDS other_catkin_pkg
    #  DEPENDS system_lib
  )
else()
  ament_package()
endif()

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
include_directories(
  # include
  # ${catkin_INCLUDE_DIRS}
)
