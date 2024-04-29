#[=======================================================================[.rst:
RobSupPurePythonYCMEPHelper
-----------

A wrapper for ycm_ep_helper for pure Python projects in the robotology-superbuold::

 rob_sup_pure_python_ycm_ep_helper(<name>
   [COMPONENT <component>] (default = "external")
   [FOLDER <folder> (default = "<component>")
   [PYTHON_PACKAGE_NAME <python_package_name>] (default = "<name>")
   [REPOSITORY <repo>]
  #--Git and Hg only arguments-----------
   [TAG <tag>]
   )

#]=======================================================================]


if(COMMAND rob_sup_pure_python_ycm_ep_helper)
  return()
endif()

include(YCMEPHelper)

function(ROB_SUP_PURE_PYTHON_YCM_EP_HELPER _name)
  # Dependencies
  find_package(Python3 COMPONENTS Interpreter REQUIRED)

  # Check arguments
  set(_options)
  set(_oneValueArgs COMPONENT
                    FOLDER
                    REPOSITORY
                    TAG
                    PYTHON_PACKAGE_NAME)
  set(_multiValueArgs DEPENDS)

  cmake_parse_arguments(_PYH_${_name} "${_options}" "${_oneValueArgs}" "${_multiValueArgs}" "${ARGN}")

  if(NOT _PYH_${_name}_PYTHON_PACKAGE_NAME)
    set(_PYH_${_name}_PYTHON_PACKAGE_NAME ${_name})
  endif()

  # We pass --break-system-packages as it is required by Python 3.12 when operating outside a virtual env,
  # even if effectively we are kind in a virtual env defined by the superbuild in this case
  # We need to make sure not to pass it for Python <= 3.11, as otherwise pip uninstall will fail as --break-system-packages
  # is not an option
  if(LSB_RELEASE_CODENAME STREQUAL "noble" AND NOT ROBOTOLOGY_CONFIGURING_UNDER_CONDA)
    set(BREAK_SYSTEM_PACKAGES_OPTION "--break-system-packages")
  else()
    set(BREAK_SYSTEM_PACKAGES_OPTION "")
  endif()


  ycm_ep_helper(${_name} TYPE GIT
                         STYLE GITHUB
                         REPOSITORY ${_PYH_${_name}_REPOSITORY}
                         DEPENDS ${_PYH_${_name}_DEPENDS}
                         TAG ${_PYH_${_name}_TAG}
                         COMPONENT ${_PYH_${_name}_COMPONENT}
                         FOLDER ${_PYH_${_name}_FOLDER}
                         # Workaround for https://github.com/robotology/robotology-superbuild/pull/1069#issuecomment-1099446237
                         CONFIGURE_COMMAND ${CMAKE_COMMAND} --version
                         # To uninstall any existing package we call pip uninstall by passing the installation prefix to PYTHONPATH
                         # See https://stackoverflow.com/questions/55708589/how-to-pass-an-environment-variable-to-externalproject-add-configure-command
                         # See https://github.com/robotology/robotology-superbuild/issues/1118
                         # To avoid the complexity of handling two commands, we just use the build step to uninstall any existing package
                         BUILD_COMMAND ${CMAKE_COMMAND} -E env PYTHONPATH=${YCM_EP_INSTALL_DIR}/${ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR} pip uninstall ${BREAK_SYSTEM_PACKAGES_OPTION} -y ${_PYH_${_name}_PYTHON_PACKAGE_NAME}
                         INSTALL_COMMAND ${Python3_EXECUTABLE} -m pip install --upgrade --no-deps --target=${YCM_EP_INSTALL_DIR}/${ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR} -VV <SOURCE_DIR>)
endfunction()
