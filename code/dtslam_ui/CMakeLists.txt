##################################
# dtslam_ui lib
##################################

##################################
# Sources

#Add all files
file(GLOB_RECURSE sources_cpp *.cpp)
file(GLOB_RECURSE sources_h *.h)
file(GLOB_RECURSE assets_all assets/*)
#source_group(AllFiles FILES ${sources_cpp} ${sources_h})
GroupSources(dtslam_ui)

##################################
# Target
add_library(dtslam_ui ${sources_cpp} ${sources_h} ${assets_all})


find_package(catkin REQUIRED COMPONENTS
             cpp_common rostime roscpp_traits
             roscpp_serialization sensor_msgs rosbag)
include_directories(${catkin_INCLUDE_DIRS})

target_link_libraries( dtslam_ui
    dtslam
    ${OpenCV_LIBRARIES}
    glut
    ${catkin_LIBRARIES}
)

target_include_directories(dtslam_ui
PUBLIC ${OpenCV_INCLUDE_DIRS} INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/..  )

#INSTALL_TARGET_WITH_DEPS(alg_experiments ${3RD_PARTY_DIR}/bin)

#add_custom_command(TARGET dtslam_desktop_unittest POST_BUILD
#	COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/modules/dtslam/assets $<TARGET_FILE_DIR:dtslam_desktop_unittest>/assets)
#add_custom_command(TARGET dtslam_desktop_unittest POST_BUILD
#	COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/modules/dtslam_app/assets $<TARGET_FILE_DIR:dtslam_desktop_unittest>/assets)

#add_custom_command(TARGET dtslam_desktop_unittest POST_BUILD
#	COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/data $<TARGET_FILE_DIR:dtslam_desktop_unittest>/data)
