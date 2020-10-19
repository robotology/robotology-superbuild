# Copyright (C) 2017  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Daniele E. Domenichelli <ddomenichelli@drdanz.it>, Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_package(ACE QUIET)
find_package(SQLite QUIET)
find_package(Eigen3 QUIET)

set(YARP_OPTIONAL_DEPS "")
if(ROBOTOLOGY_ENABLE_ROBOT_TESTING)
  find_or_build_package(RobotTestingFramework QUIET)
  list(APPEND YARP_OPTIONAL_DEPS RobotTestingFramework)
endif()

# Workaround for https://github.com/robotology/robotology-superbuild/issues/377
if(NOT APPLE)
  find_package(SQLite QUIET)
  list(APPEND YARP_OPTIONAL_DEPS SQLite)
  set(YARP_OPTIONAL_CMAKE_ARGS "")
else()
  set(YARP_OPTIONAL_CMAKE_ARGS "-DYARP_USE_SYSTEM_SQLite:BOOL=OFF")
endif()

if(ROBOTOLOGY_USES_PYTHON OR ROBOTOLOGY_USES_LUA)
  set(YARP_COMPILE_BINDINGS ON)
else()
  set(YARP_COMPILE_BINDINGS OFF)
endif()


if (APPLE OR WIN32)
  set(ENABLE_USBCAMERA OFF)
else()
  set(ENABLE_USBCAMERA ${ROBOTOLOGY_ENABLE_ICUB_HEAD})
endif()

# Workaround for https://github.com/robotology/yarp/issues/2353
if(APPLE)
  set(ENABLE_yarpcar_mjpeg OFF)
else()
  set(ENABLE_yarpcar_mjpeg ON)
endif()

ycm_ep_helper(YARP TYPE GIT
                   STYLE GITHUB
                   REPOSITORY robotology/yarp.git
                   TAG master
                   COMPONENT core
                   FOLDER robotology
                   DEPENDS YCM
                           ACE
                           Eigen3
                           ${YARP_OPTIONAL_DEPS}
                   CMAKE_ARGS -DYARP_COMPILE_GUIS:BOOL=ON
                              -DYARP_USE_SYSTEM_SQLite:BOOL=ON
                              -DYARP_COMPILE_libYARP_math:BOOL=ON
                              -DYARP_COMPILE_CARRIER_PLUGINS:BOOL=ON
                              -DENABLE_yarpcar_bayer:BOOL=ON
                              -DENABLE_yarpcar_tcpros:BOOL=ON
                              -DENABLE_yarpcar_xmlrpc:BOOL=ON
                              -DENABLE_yarpcar_priority:BOOL=ON
                              -DENABLE_yarpcar_bayer:BOOL=ON
                              -DENABLE_yarpcar_mjpeg:BOOL=${ENABLE_yarpcar_mjpeg}
                              -DENABLE_yarpcar_portmonitor:BOOL=ON
                              -DENABLE_yarpcar_depthimage:BOOL=ON
                              -DENABLE_yarpcar_depthimage2:BOOL=ON
                              -DENABLE_yarpidl_thrift:BOOL=ON
                              -DYARP_COMPILE_DEVICE_PLUGINS:BOOL=ON
                              -DENABLE_yarpcar_human:BOOL=ON
                              -DENABLE_yarpcar_rossrv:BOOL=ON
                              -DENABLE_yarpmod_fakebot:BOOL=ON
                              -DENABLE_yarpmod_imuBosch_BNO055:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                              -DENABLE_yarpmod_SDLJoypad:BOOL=ON
                              -DENABLE_yarpmod_serialport:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                              -DENABLE_yarpmod_AudioPlayerWrapper:BOOL=ON
                              -DENABLE_yarpmod_AudioRecorderWrapper:BOOL=ON
                              -DENABLE_yarpmod_portaudio:BOOL=ON
                              -DENABLE_yarpmod_portaudioPlayer:BOOL=ON
                              -DENABLE_yarpmod_portaudioRecorder:BOOL=ON
                              -DYARP_COMPILE_EXPERIMENTAL_WRAPPERS:BOOL=ON
                              -DYARP_COMPILE_RobotTestingFramework_ADDONS:BOOL=${ROBOTOLOGY_ENABLE_ROBOT_TESTING}
                              -DYARP_COMPILE_BINDINGS:BOOL=${YARP_COMPILE_BINDINGS}
                              -DYARP_USE_I2C:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                              -DYARP_USE_SDL:BOOL=ON
                              -DCREATE_PYTHON:BOOL=${ROBOTOLOGY_USES_PYTHON}
                              -DCREATE_LUA:BOOL=${ROBOTOLOGY_USES_LUA}
                              -DENABLE_yarpmod_usbCamera:BOOL=${ENABLE_USBCAMERA}
                              ${YARP_OPTIONAL_CMAKE_ARGS})
