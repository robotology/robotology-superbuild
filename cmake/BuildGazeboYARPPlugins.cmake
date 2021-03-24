#.rst:
# BuildGazeboYARPPlugins
# ----------------------
#
# GazeboYARPPlugins

#=============================================================================
# Copyright 2013-2014 iCub Facility, Istituto Italiano di Tecnologia
#   Authors: Daniele E. Domenichelli <daniele.domenichelli@iit.it>
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distribute this file outside of YCM, substitute the full
#  License text for the above reference.)

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)

# gazebo-config.cmake requires C
if(NOT CMAKE_C_COMPILER_LOADED)
    enable_language(C)
endif()

find_package(gazebo QUIET)


ycm_ep_helper(GazeboYARPPlugins TYPE GIT
                                STYLE GITHUB
                                REPOSITORY robotology/gazebo-yarp-plugins.git
                                TAG master
                                COMPONENT core
                                FOLDER src
                                DEPENDS YARP
                                        gazebo
                                CMAKE_ARGS -DGAZEBO_YARP_PLUGINS_HAS_OPENCV:BOOL=ON)

set(GazeboYARPPlugins_CONDA_DEPENDENCIES opencv gazebo)
