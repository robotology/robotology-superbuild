# Copyright (C) 2017  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Daniele E. Domenichelli <ddomenichelli@drdanz.it>, Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

set(YARP_OPTIONAL_DEPS "")
if(ROBOTOLOGY_ENABLE_ROBOT_TESTING)
  find_or_build_package(RobotTestingFramework QUIET)
  list(APPEND YARP_OPTIONAL_DEPS RobotTestingFramework)
endif()

# Workaround for https://github.com/robotology/robotology-superbuild/issues/377
set(YARP_OPTIONAL_CMAKE_ARGS "")
if(APPLE)
  list(APPEND YARP_OPTIONAL_CMAKE_ARGS "-DYARP_USE_SYSTEM_SQLite:BOOL=OFF")
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

# For what regards Python installation, the options changes depending
# on whether we are installing YARP from source, or generating a
# conda package on Windows as in that case the installation location
# will need to be outside of CMAKE_INSTALL_PREFIX
# See https://github.com/robotology/robotology-superbuild/issues/641
if(ROBOTOLOGY_USES_PYTHON AND ROBOTOLOGY_GENERATE_CONDA_RECIPES AND WIN32)
  list(APPEND YARP_OPTIONAL_CMAKE_ARGS "-DCMAKE_INSTALL_PYTHON3DIR:PATH=%SP_DIR%")
endif()

ycm_ep_helper(YARP TYPE GIT
                   STYLE GITHUB
                   REPOSITORY robotology/yarp.git
                   TAG master
                   COMPONENT core
                   FOLDER src
                   DEPENDS YCM
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
                              -DENABLE_yarppm_depthimage_to_mono:BOOL=ON
                              -DENABLE_yarppm_depthimage_to_rgb:BOOL=ON
                              # Deprecated, remove when YARP 3.5 is in Stable branches and latest releases
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
                              # Enable all "fake" devices in YARP, as they are quite useful for tutorials
                              -DENABLE_yarpmod_fakeAnalogSensor:BOOL=ON
                              -DENABLE_yarpmod_fakeBattery:BOOL=ON
                              -DENABLE_yarpmod_fakeDepthCamera:BOOL=ON
                              -DENABLE_yarpmod_fakeFrameGrabber:BOOL=ON
                              -DENABLE_yarpmod_fakeIMU:BOOL=ON
                              -DENABLE_yarpmod_fakeLaser:BOOL=ON
                              -DENABLE_yarpmod_fakeLocalizer:BOOL=ON
                              -DENABLE_yarpmod_fakeMicrophone:BOOL=ON
                              -DENABLE_yarpmod_fakeMotionControl:BOOL=ON
                              -DENABLE_yarpmod_fakeNavigation:BOOL=ON
                              -DENABLE_yarpmod_fakeSpeaker:BOOL=ON
                              -DYARP_COMPILE_EXPERIMENTAL_WRAPPERS:BOOL=ON
                              -DYARP_COMPILE_RobotTestingFramework_ADDONS:BOOL=${ROBOTOLOGY_ENABLE_ROBOT_TESTING}
                              -DYARP_COMPILE_BINDINGS:BOOL=${YARP_COMPILE_BINDINGS}
                              -DYARP_USE_I2C:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                              -DYARP_USE_SDL:BOOL=ON
                              -DCREATE_PYTHON:BOOL=${ROBOTOLOGY_USES_PYTHON}
                              -DCREATE_LUA:BOOL=${ROBOTOLOGY_USES_LUA}
                              -DENABLE_yarpmod_usbCamera:BOOL=${ENABLE_USBCAMERA}
                              -DENABLE_yarpmod_usbCameraRaw:BOOL=${ENABLE_USBCAMERA}
                              ${YARP_OPTIONAL_CMAKE_ARGS})

set(YARP_CONDA_DEPENDENCIES ace libopencv tinyxml qt eigen sdl sdl2 sqlite libjpeg-turbo)

if(ROBOTOLOGY_USES_PYTHON)
  list(APPEND YARP_CONDA_DEPENDENCIES swig)
  list(APPEND YARP_CONDA_DEPENDENCIES python)
endif()

if(NOT WIN32)
  list(APPEND YARP_CONDA_DEPENDENCIES bash-completion)
endif()
