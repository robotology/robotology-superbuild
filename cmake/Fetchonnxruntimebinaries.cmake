# Copyright (C) Fondazione Istituto Italiano di Tecnologia

# silence deprecation warnings in newer versions of cmake
if(POLICY CMP0135)
  cmake_policy(SET CMP0135 NEW)
endif()

if(NOT CMAKE_SYSTEM_NAME STREQUAL "Linux")
    message(FATAL_ERROR "Fetchonnxruntimebinaries is only supported on Linux, not on ${CMAKE_SYSTEM_NAME}")
endif()

set(onnxruntimebinaries_VERSION "1.14.1")
if(CMAKE_HOST_SYSTEM_PROCESSOR STREQUAL "x86_64")
  set(onnxruntimebinaries_ARCH "x64")
elseif(CMAKE_HOST_SYSTEM_PROCESSOR STREQUAL "aarch64")
  set(onnxruntimebinaries_ARCH "aarch64")
else()
  message(FATAL_ERROR "Fetchonnxruntimebinaries is not supported on architecture ${CMAKE_HOST_SYSTEM_PROCESSOR}")
endif()

set(onnxruntimebinaries_URL "https://github.com/microsoft/onnxruntime/releases/download/v${onnxruntimebinaries_VERSION}/onnxruntime-linux-${onnxruntimebinaries_ARCH}-${onnxruntimebinaries_VERSION}.tgz")

FetchContent_Declare(
  onnxruntimebinaries
  URL      ${onnxruntimebinaries_URL}
)

FetchContent_GetProperties(onnxruntimebinaries)
if(NOT onnxruntimebinaries_POPULATED)
  message(STATUS "Downloading onnxruntime binaries.")
  FetchContent_Populate(onnxruntimebinaries)
  file(GLOB onnxruntimebinaries_HEADERS ${onnxruntimebinaries_SOURCE_DIR}/include/*)
  file(COPY ${onnxruntimebinaries_HEADERS} DESTINATION ${YCM_EP_INSTALL_DIR}/include)
  file(GLOB onnxruntimebinaries_LIBRARIES ${onnxruntimebinaries_SOURCE_DIR}/lib/*)
  file(COPY ${onnxruntimebinaries_LIBRARIES} DESTINATION ${YCM_EP_INSTALL_DIR}/lib)
  message(STATUS "Installing onnxruntime binaries in ${YCM_EP_INSTALL_DIR}")
endif()
