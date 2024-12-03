# Copyright (C) Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(yarp-devices-ros2 QUIET)


ycm_ep_helper(xcub-moveit2 TYPE GIT
                                STYLE GITHUB
                                REPOSITORY icub-tech-iit/xcub-moveit2.git
                                TAG master
                                COMPONENT core
                                FOLDER src
                                DEPENDS YARP yarp-devices-ros2
                                # This is because xcub-moveit2 is a ros-style repository
                                # composed by multiple CMake projects, for compatibility with CMake
                                # we added an all_packages folder with CMakeLists.txt that add each 
                                # subfolder with add_subdirectory
                                SOURCE_SUBDIR xcub_moveit_all_packages)
