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

  execute_process(COMMAND ${Python3_EXECUTABLE}
                  -c "from distutils import sysconfig; print(sysconfig.get_python_lib(1,0,prefix=''))"
                  OUTPUT_VARIABLE _PYTHON_INSTDIR)
  string(STRIP ${_PYTHON_INSTDIR} ROBSUB_PYTHON_INSTALL_DIR)

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
                         BUILD_COMMAND ${CMAKE_COMMAND} -E env PYTHONPATH=${YCM_EP_INSTALL_DIR}/${ROBSUB_PYTHON_INSTALL_DIR} pip uninstall -y ${_PYH_${_name}_PYTHON_PACKAGE_NAME}
                         INSTALL_COMMAND ${Python3_EXECUTABLE} -m pip install --upgrade --no-deps --target=${YCM_EP_INSTALL_DIR}/${ROBSUB_PYTHON_INSTALL_DIR} -VV <SOURCE_DIR>)
endfunction()
