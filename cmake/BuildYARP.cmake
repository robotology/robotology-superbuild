# Copyright (C) 2017  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Daniele E. Domenichelli <ddomenichelli@drdanz.it>, Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YCM QUIET)

set(YARP_OPTIONAL_DEPS "")
if(ROBOTOLOGY_ENABLE_ROBOT_TESTING)
  find_or_build_package(RobotTestingFramework QUIET)
  list(APPEND YARP_OPTIONAL_DEPS RobotTestingFramework)
endif()

set(YARP_OPTIONAL_CMAKE_ARGS "")

if(ROBOTOLOGY_USES_PYTHON OR ROBOTOLOGY_USES_LUA OR ROBOTOLOGY_USES_CSHARP)
  set(YARP_COMPILE_BINDINGS ON)
else()
  set(YARP_COMPILE_BINDINGS OFF)
endif()


if (APPLE OR WIN32)
  set(ENABLE_USBCAMERA OFF)
else()
  set(ENABLE_USBCAMERA ON)
endif()

# I2C is only enabled on Linux
if(${CMAKE_SYSTEM_NAME} STREQUAL "Linux" AND ${ROBOTOLOGY_ENABLE_ICUB_HEAD})
  set(YARP_USE_I2C ON)
else()
  set(YARP_USE_I2C OFF)
endif()

if(ROBOTOLOGY_USES_PYTHON)
  list(APPEND YARP_OPTIONAL_DEPS "-DCMAKE_INSTALL_PYTHON3DIR=${ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR}")
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
                              # Workaround for https://github.com/robotology/robotology-superbuild/issues/1091
                              -DYARP_DISABLE_MACOS_BUNDLES:BOOL=ON
                              -DENABLE_yarpcar_bayer:BOOL=ON
                              -DENABLE_yarpcar_tcpros:BOOL=ON
                              -DENABLE_yarpcar_xmlrpc:BOOL=ON
                              -DENABLE_yarpcar_priority:BOOL=ON
                              -DENABLE_yarpcar_bayer:BOOL=ON
                              -DENABLE_yarpcar_mjpeg:BOOL=ON
                              -DENABLE_yarpcar_portmonitor:BOOL=ON
                              -DENABLE_yarppm_bottle_compression_zlib:BOOL=ON
                              -DENABLE_yarppm_depthimage_compression_zlib:BOOL=ON
                              -DENABLE_yarppm_image_compression_ffmpeg:BOOL=ON
                              -DENABLE_yarppm_depthimage_to_mono:BOOL=ON
                              -DENABLE_yarppm_depthimage_to_rgb:BOOL=ON
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
                              -DENABLE_yarpmod_opencv_grabber:BOOL=ON
                              # Enable all "fake" devices in YARP, as they are quite useful for tutorials
                              -DYARP_COMPILE_ALL_FAKE_DEVICES:BOOL=ON
                              -DYARP_COMPILE_RobotTestingFramework_ADDONS:BOOL=${ROBOTOLOGY_ENABLE_ROBOT_TESTING}
                              -DYARP_COMPILE_BINDINGS:BOOL=${YARP_COMPILE_BINDINGS}
                              -DYARP_USE_I2C:BOOL=${YARP_USE_I2C}
                              -DYARP_USE_SDL:BOOL=ON
                              -DCREATE_PYTHON:BOOL=${ROBOTOLOGY_USES_PYTHON}
                              -DCREATE_LUA:BOOL=${ROBOTOLOGY_USES_LUA}
                              -DCREATE_CSHARP:BOOL=${ROBOTOLOGY_USES_CSHARP}
                              -DENABLE_yarpmod_usbCamera:BOOL=${ENABLE_USBCAMERA}
                              -DENABLE_yarpmod_usbCameraRaw:BOOL=${ENABLE_USBCAMERA}
                              ${YARP_OPTIONAL_CMAKE_ARGS})

set(YARP_CONDA_PKG_NAME libyarp)
set(YARP_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
