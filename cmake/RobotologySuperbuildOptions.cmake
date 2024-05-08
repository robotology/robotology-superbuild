# Copyright (C) Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

set(YCM_USE_CMAKE_PROPOSED TRUE CACHE BOOL "Use files including unmerged cmake patches")

set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE BOOL "Enable/Disable output of compile commands during generation.")
mark_as_advanced(CMAKE_EXPORT_COMPILE_COMMANDS)

# YCM options
option(YCM_DISABLE_SYSTEM_PACKAGES "Disable use of all the system installed packages" ON)

# Dependencies options
## Matlab related options
option(ROBOTOLOGY_USES_MATLAB "Enable compilation of software that depend on Matlab and Simulink" FALSE)
option(ROBOTOLOGY_NOT_USE_SIMULINK "Disable compilation of software that depend on Simulink" FALSE)

## Other dynamic languages options
option(ROBOTOLOGY_USES_OCTAVE "Enable compilation of software that depend on Octave" FALSE)
option(ROBOTOLOGY_USES_LUA "Enable compilation of software that depend on Lua" FALSE)
mark_as_advanced(ROBOTOLOGY_USES_LUA)
option(ROBOTOLOGY_USES_PYTHON "Enable compilation of software that depend on Python" FALSE)
option(ROBOTOLOGY_USES_CSHARP "Enable compilation of software that depends on CSharp" FALSE)
mark_as_advanced(ROBOTOLOGY_USES_CSHARP)

## Enable packages that depend on the Gazebo Classic simulator
if(ROBOTOLOGY_CONFIGURING_UNDER_CONDA OR APPLE OR WIN32)
  set(ROBOTOLOGY_USES_GAZEBO_DEFAULT ON)
else()
  find_program(ROBSUB_LSB_RELEASE lsb_release)
  if(ROBSUB_LSB_RELEASE)
    execute_process(COMMAND lsb_release -cs
      OUTPUT_VARIABLE LSB_RELEASE_CODENAME
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
  endif()
  if(LSB_RELEASE_CODENAME STREQUAL "noble")
    set(ROBOTOLOGY_USES_GAZEBO_DEFAULT OFF)
  else()
    set(ROBOTOLOGY_USES_GAZEBO_DEFAULT ON)
  endif()
endif()
option(ROBOTOLOGY_USES_GAZEBO "Enable compilation of software that depends on Gazebo Classic" ${ROBOTOLOGY_USES_GAZEBO_DEFAULT})
option(ROBOTOLOGY_USES_PCL_AND_VTK "Enable compilation of software that depends on PCL and VTK" OFF)
option(ROBOTOLOGY_USES_MUJOCO "Enable compilation of mujoco and software that depends on it" OFF)

## Enable packages that depend on the Modern Gazebo (gz-sim) simulator
option(ROBOTOLOGY_USES_GZ "Enable compilation of software that depends on Modern Gazebo (gz-sim)" OFF)


## Enable packages that depend on the Ignition Gazebo simulator
set(ROBOTOLOGY_USES_IGNITION_DEFAULT FALSE)
option(ROBOTOLOGY_USES_IGNITION "Enable compilation of software that depends on Ignition Gazebo" ${ROBOTOLOGY_USES_IGNITION_DEFAULT})

# Enable/disable different profiles
option(ROBOTOLOGY_ENABLE_CORE "Enable compilation of core software libraries." TRUE)
option(ROBOTOLOGY_ENABLE_ROBOT_TESTING "Enable compilation of software for robot testing." FALSE)
option(ROBOTOLOGY_ENABLE_DYNAMICS "Enable compilation of software for balancing and walking." FALSE)
option(ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS "Enable compilation of all the dependencies of bipedal-locomotion-framework." FALSE)
option(ROBOTOLOGY_ENABLE_TELEOPERATION "Enable compilation of software for teleoperation." FALSE)
# ROBOTOLOGY_ENABLE_EVENT_DRIVEN is not supported on Windows, do not show the option there
if(WIN32 OR APPLE)
  set(ROBOTOLOGY_ENABLE_EVENT_DRIVEN FALSE)
else()
  option(ROBOTOLOGY_ENABLE_EVENT_DRIVEN "Enable compilation of software for event-driven." FALSE)
endif()
option(ROBOTOLOGY_ENABLE_ICUB_HEAD "Enable compilation of software necessary on the system running in the head of the iCub robot." FALSE)
option(ROBOTOLOGY_ENABLE_ICUB_BASIC_DEMOS "Enable compilation of software necessary for iCub basic demonstrations." FALSE)
option(ROBOTOLOGY_ENABLE_HUMAN_DYNAMICS "Enable compilation of software for human dynamics estimation." FALSE)
option(ROBOTOLOGY_ENABLE_GRASPING "Enable compilation of software for grasping." FALSE)

# This is just a private undocumented option to download repos that are tracked in LatestReleases.yaml,
# but they are not actually build by the superbuild
option(ROBOTOLOGY_INTERNAL_CLONE_ALL_REPOS_FOR_UPDATE "(Internal) Clone all repos for automatic version update." FALSE)
mark_as_advanced(ROBOTOLOGY_INTERNAL_CLONE_ALL_REPOS_FOR_UPDATE)

include(CMakeDependentOption)

cmake_dependent_option(ROBOTOLOGY_USES_CFW2CAN "Enable compilation of software that runs on the head of the iCub and depends on CFW2CAN." FALSE "ROBOTOLOGY_ENABLE_ICUB_HEAD" FALSE)
cmake_dependent_option(ROBOTOLOGY_USES_ESDCAN "Enable compilation of software that runs on the head of the iCub and depends on ESDCAN." FALSE "ROBOTOLOGY_ENABLE_ICUB_HEAD" FALSE)
cmake_dependent_option(ROBOTOLOGY_USES_XSENS_MVN_SDK "Enable compilation of software that runs on the wearable producer machine and depends on Xsens MVN SDK." FALSE "ROBOTOLOGY_ENABLE_HUMAN_DYNAMICS" FALSE)


option(ROBOTOLOGY_ENABLE_IOL "Enable compilation of software necessary for the Interactive Objects Learning demo." FALSE)
mark_as_advanced(ROBOTOLOGY_ENABLE_IOL)
option(ROBOTOLOGY_ENABLE_R1_ROBOT "Enable compilation of software necessary on the pc running on the R1 robot." FALSE)
mark_as_advanced(ROBOTOLOGY_ENABLE_R1_ROBOT)

# Set default build type to "Release" in single-config generators
get_property(IS_MULTICONFIG GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
if(NOT IS_MULTICONFIG)
    if(NOT CMAKE_BUILD_TYPE)
      set(CMAKE_BUILD_TYPE "Release" CACHE STRING
        "Choose the type of build, recommanded options are: Debug or Release" FORCE)
    endif()
endif()

# Ensure that Debug mode is not used on Windows when using conda dependencies
# Note: here we assume that CONDA_PREFIX env variable being defined means that we are compiling
# against conda-forge dependencies and that no debug-compatible libraries are available, 
# if that changes in the future please change or remove this check
if(WIN32 AND DEFINED ENV{CONDA_PREFIX})
    if(NOT IS_MULTICONFIG)
        # Single config generators, raise a CMake error if CMAKE_BUILD_TYPE is Debug
        if(CMAKE_BUILD_TYPE STREQUAL "Debug")
            message(FATAL_ERROR "Building with conda-forge dependencies on Windows does not support compiling in Debug, please compile in RelWithDebInfo.")
        endif()
    else()
        # Multiple config generators, remove Debug from CMAKE_CONFIGURATION_TYPES, so it is not possible to compile in debug
        list(REMOVE_ITEM CMAKE_CONFIGURATION_TYPES "Debug")
    endif()
endif()

set(ROBOTOLOGY_PROJECT_TAGS "Stable" CACHE STRING "The tags to be used for the robotology projects: Stable, Unstable, LatestRelease or Custom. This can be changed only before the first configuration.")
set(ROBOTOLOGY_PROJECT_TAGS_CUSTOM_FILE CACHE FILEPATH "If ROBOTOLOGY_PROJECT_TAGS is custom, this file will be loaded to specify the tags of the projects to use.")
set_property(CACHE ROBOTOLOGY_PROJECT_TAGS PROPERTY STRINGS "Stable" "Unstable" "LatestRelease" "Custom")

if(ROBOTOLOGY_PROJECT_TAGS STREQUAL "Stable")
    include(ProjectsTagsStable)
elseif(ROBOTOLOGY_PROJECT_TAGS STREQUAL "Unstable")
    include(ProjectsTagsUnstable)
elseif(ROBOTOLOGY_PROJECT_TAGS STREQUAL "LatestRelease")
    include(YCMLoadVcsYamlInfo)
    ycm_load_vcs_yaml_info(YAML_FILE ${PROJECT_SOURCE_DIR}/releases/latest.releases.yaml VERBOSE)
elseif(ROBOTOLOGY_PROJECT_TAGS STREQUAL "Custom")
    if(ROBOTOLOGY_PROJECT_TAGS_CUSTOM_FILE MATCHES ".yaml$" OR
       ROBOTOLOGY_PROJECT_TAGS_CUSTOM_FILE MATCHES ".repos$")
       include(YCMLoadVcsYamlInfo)
       ycm_load_vcs_yaml_info(YAML_FILE ${ROBOTOLOGY_PROJECT_TAGS_CUSTOM_FILE} VERBOSE)
    else()
        include(${ROBOTOLOGY_PROJECT_TAGS_CUSTOM_FILE})
    endif()
else()
    message(FATAL_ERROR "The ROBOTOLOGY_PROJECT_TAGS variable can be Stable, Unstable or Custom. ${ROBOTOLOGY_PROJECT_TAGS} value is not supported.")
endif()

option(ROBOTOLOGY_GENERATE_CONDA_RECIPES "If enabled, generate conda recipes instead of building the superbuild. This should not be used by end users." OFF)
mark_as_advanced(ROBOTOLOGY_GENERATE_CONDA_RECIPES)
