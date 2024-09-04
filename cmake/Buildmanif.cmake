# Copyright (C) 2020  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Giulio Romualdi <gulio.romualdi@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

# Workaround for https://github.com/artivis/manif/issues/311, if use use python bindings
# on Windows with MSVC we need to specify somehow the use of clang-cl
set(manif_CMAKE_GENERATOR_YCM_ARGS "")
set(manif_CLANG_CL_CMAKE_ARGS "")
if(ROBOTOLOGY_USES_PYTHON AND MSVC)
    if("${CMAKE_GENERATOR}" MATCHES "Visual Studio")
        # If Visual Studio is used, we specify the use of ClangCL via the CMake Generator Toolset option
        list(APPEND manif_CMAKE_GENERATOR_YCM_ARGS CMAKE_GENERATOR "${CMAKE_GENERATOR}")
        list(APPEND manif_CMAKE_GENERATOR_YCM_ARGS CMAKE_GENERATOR_TOOLSET "ClangCL")
    else()
        # Otherwise, we specify the use of clang-cl via CMAKE_C_COMPILER and CMAKE_CXX_COMPILER versions
        if($ENV{VCINSTALLDIR} STREQUAL "")
            message(FATAL_ERROR "Building robotology-superbuild with CMAKE_GENERATOR=${CMAKE_GENERATOR} and ROBOTOLOGY_USES_PYTHON is enabled, but no VCINSTALLDIR env variable defined.")
        endif()
        set(CANDIDATE_CLANG_CL_LOCATION $ENV{VCINSTALLDIR}\\Tools\\Llvm\\x64\\bin\\clang-cl.exe)
        if(NOT EXISTS ${CANDIDATE_CLANG_CL_LOCATION})
            message(FATAL_ERROR "Building robotology-superbuild on Windows ROBOTOLOGY_USES_PYTHON is enabled requires the 'C++ Clang Compiler for Windows' and 'C++ Clang-cl for vXYZ build tools' components of Visual Studio, but ${CANDIDATE_CLANG_CL_LOCATION} was not found. Please install the required components and try again.")
        endif()
        list(APPEND manif_CLANG_CL_CMAKE_ARGS "-DCMAKE_C_COMPILER=${CANDIDATE_CLANG_CL_LOCATION}")
        list(APPEND manif_CLANG_CL_CMAKE_ARGS "-DCMAKE_CXX_COMPILER=${CANDIDATE_CLANG_CL_LOCATION}")
    endif()
endif()

# We pass CMAKE_CXX_STANDARD=17 as we encountered problems when using -march=native
# and mixing libraries compiled with C++11 and C++17, see
# https://github.com/artivis/manif/issues/274
ycm_ep_helper(manif TYPE GIT
              STYLE GITHUB
              REPOSITORY artivis/manif.git
              TAG master
              COMPONENT external
              FOLDER src
              ${manif_CMAKE_GENERATOR_YCM_ARGS}
              CMAKE_ARGS -DCMAKE_CXX_STANDARD=17 -DBUILD_TESTING:BOOL=OFF -DBUILD_EXAMPLES:BOOL=OFF -DBUILD_PYTHON_BINDINGS:BOOL=${ROBOTOLOGY_USES_PYTHON}  -DMANIFPY_PKGDIR:PATH=${YCM_EP_INSTALL_DIR}/${ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR} ${manif_CLANG_CL_CMAKE_ARGS})

set(manif_CONDA_PKG_NAME manif)
set(manif_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)

