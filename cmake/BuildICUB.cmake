# Copyright (C) 2017  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)

set(ICUB_DEPENDS "")
list(APPEND ICUB_DEPENDS YCM)
list(APPEND ICUB_DEPENDS YARP)

if(ROBOTOLOGY_ENABLE_ICUB_HEAD)
  find_or_build_package(icub_firmware_shared QUIET)
  list(APPEND ICUB_DEPENDS icub_firmware_shared)
endif()

# See discussion in https://github.com/robotology/icub-main/issues/551
# Workaround for https://github.com/robotology/icub-main/issues/842
set(ICUBMAIN_COMPILE_SIMULATORS OFF)

# See discussion in https://github.com/robotology/robotology-superbuild/issues/237
# and https://github.com/robotology/robotology-superbuild/issues/236
if (APPLE OR WIN32)
  set(ENABLE_DRAGONFLY2 OFF)
else()
  set(ENABLE_DRAGONFLY2 ${ROBOTOLOGY_ENABLE_ICUB_HEAD})
endif()

# See https://github.com/robotology/icub-main/issues/624
if (WIN32)
  set(ENABLE_icubmod_xsensmtx OFF)
else()
  set(ENABLE_icubmod_xsensmtx ${ROBOTOLOGY_ENABLE_ICUB_HEAD})
endif()

# Socketcan is only enabled on Linux, and if ROBOTOLOGY_ENABLE_ICUB_HEAD is enabled
if (CMAKE_SYSTEM_NAME STREQUAL "Linux")
  set(ENABLE_icubmod_socketcan ${ROBOTOLOGY_ENABLE_ICUB_HEAD})
else()
  set(ENABLE_icubmod_socketcan OFF)
endif()

if(ROBOTOLOGY_USES_PYTHON OR ROBOTOLOGY_USES_LUA)
  set(ICUB_COMPILE_BINDINGS ON)
else()
  set(ICUB_COMPILE_BINDINGS OFF)
endif()

ycm_ep_helper(ICUB TYPE GIT
                   STYLE GITHUB
                   REPOSITORY robotology/icub-main.git
                   DEPENDS ${ICUB_DEPENDS}
                   COMPONENT iCub
                   FOLDER src
                   CMAKE_ARGS -DICUB_INSTALL_WITH_RPATH:BOOL=ON
                   CMAKE_CACHE_ARGS -DENABLE_icubmod_cartesiancontrollerserver:BOOL=ON
                                    -DENABLE_icubmod_cartesiancontrollerclient:BOOL=ON
                                    -DENABLE_icubmod_gazecontrollerclient:BOOL=ON
                                    -DENABLE_icubmod_serial:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_serialport:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_skinWrapper:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_dragonfly2:BOOL=${ENABLE_DRAGONFLY2}
                                    -DENABLE_icubmod_portaudio:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_sharedcan:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_bcbBattery:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_canmotioncontrol:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_canBusAnalogSensor:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_canBusInertialMTB:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_canBusSkin:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_canBusFtSensor:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_canBusVirtualAnalogSensor:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_cfw2can:BOOL=${ROBOTOLOGY_USES_CFW2CAN}
                                    -DENABLE_icubmod_ecan:BOOL=${ROBOTOLOGY_USES_ESDCAN}
                                    -DENABLE_icubmod_embObjBattery:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_embObjFTsensor:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_embObjMultipleFTsensors:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_embObjIMU:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_embObjInertials:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_embObjMais:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_embObjMotionControl:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_embObjSkin:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_embObjStrain:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_embObjVirtualAnalogSensor:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_parametricCalibrator:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_parametricCalibratorEth:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_embObjPOS:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DENABLE_icubmod_xsensmtx:BOOL=${ENABLE_icubmod_xsensmtx}
                                    -DENABLE_icubmod_socketcan:BOOL=${ENABLE_icubmod_socketcan}
                                    -DICUB_USE_icub_firmware_shared:BOOL=${ROBOTOLOGY_ENABLE_ICUB_HEAD}
                                    -DICUBMAIN_COMPILE_SIMULATORS:BOOL=${ICUBMAIN_COMPILE_SIMULATORS}
                                    -DICUB_COMPILE_BINDINGS:BOOL=${ICUB_COMPILE_BINDINGS}
                                    -DCREATE_PYTHON:BOOL=${ROBOTOLOGY_USES_PYTHON}
                                    -DCREATE_LUA:BOOL=${ROBOTOLOGY_USES_LUA})

set(ICUB_CONDA_DEPENDENCIES ace libopencv gsl ipopt libode qt-main sdl)

if(NOT (APPLE OR WIN32))
  list(APPEND ICUB_CONDA_DEPENDENCIES libdc1394)
endif()

if(NOT APPLE)
  list(APPEND ICUB_CONDA_DEPENDENCIES freeglut)
endif()
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
  list(APPEND ICUB_CONDA_DEPENDENCIES libglu)
endif()

if(ROBOTOLOGY_USES_ESDCAN)
  list(APPEND ICUB_CONDA_DEPENDENCIES esdcan)
endif()

if(ICUB_COMPILE_BINDINGS)
  list(APPEND ICUB_CONDA_DEPENDENCIES swig)
endif()

if(ROBOTOLOGY_USES_PYTHON)
  list(APPEND ICUB_CONDA_DEPENDENCIES python)
endif()

if(ROBOTOLOGY_USES_LUA)
  list(APPEND ICUB_CONDA_DEPENDENCIES lua)
endif()

