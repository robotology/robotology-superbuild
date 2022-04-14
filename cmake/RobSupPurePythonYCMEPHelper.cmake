#[=======================================================================[.rst:
RobSupPurePythonYCMEPHelper
-----------

A wrapper for ycm_ep_helper for pure Python projects in the robotology-superbuold::

 rob_sup_pure_python_ycm_ep_helper(<name>
   [COMPONENT <component>] (default = "external")
   [FOLDER <folder> (default = "<component>")
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
                    TAG)
  set(_multiValueArgs DEPENDS)

  cmake_parse_arguments(_PYH_${_name} "${_options}" "${_oneValueArgs}" "${_multiValueArgs}" "${ARGN}")

  ycm_ep_helper(${_name} TYPE GIT
                         STYLE GITHUB
                         REPOSITORY ${_PYH_${_name}_REPOSITORY}
                         DEPENDS ${_PYH_${_name}_DEPENDS}
                         TAG ${_PYH_${_name}_TAG}
                         COMPONENT ${_PYH_${_name}_COMPONENT}
                         FOLDER ${_PYH_${_name}_FOLDER}
                         # Workaround for https://github.com/robotology/robotology-superbuild/pull/1069#issuecomment-1099446237
                         CONFIGURE_COMMAND ${CMAKE_COMMAND} --version
                         BUILD_COMMAND ${CMAKE_COMMAND} --version
                         INSTALL_COMMAND ${Python3_EXECUTABLE} -m pip install --upgrade --no-deps --target=${YCM_EP_INSTALL_DIR}/${ROBSUB_PYTHON_INSTALL_DIR} -VV <SOURCE_DIR>)
endfunction()
