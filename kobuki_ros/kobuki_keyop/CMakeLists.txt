cmake_minimum_required(VERSION 3.5)
project(kobuki_keyop)

find_package(ament_cmake_ros REQUIRED)
find_package(ecl_build REQUIRED)
find_package(geometry_msgs REQUIRED)
find_package(kobuki_ros_interfaces REQUIRED)
find_package(rclcpp REQUIRED)
find_package(rclcpp_components REQUIRED)

ecl_enable_cxx14_compiler()
ecl_enable_cxx_warnings()

add_library(kobuki_keyop SHARED src/keyop.cpp)
target_include_directories(kobuki_keyop PUBLIC
  "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
  "$<INSTALL_INTERFACE:include>"
  ${rclcpp_components_INCLUDE_DIRS}
)
target_link_libraries(kobuki_keyop
  rclcpp::rclcpp
  ${geometry_msgs_TARGETS}
  ${kobuki_ros_interfaces_TARGETS}
)

rclcpp_components_register_node(kobuki_keyop
  PLUGIN "kobuki_keyop::KeyOp"
  EXECUTABLE kobuki_keyop_node)

install(TARGETS kobuki_keyop
  EXPORT ${PROJECT_NAME}
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
)
install(DIRECTORY include/${PROJECT_NAME}/
  DESTINATION include/${PROJECT_NAME}
)
install(DIRECTORY config
  DESTINATION share/${PROJECT_NAME}
)

ament_export_targets(${PROJECT_NAME})
ament_export_include_directories(include)
ament_export_libraries(kobuki_keyop)

ament_package()
