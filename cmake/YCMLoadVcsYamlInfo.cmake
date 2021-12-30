#.rst:
# YCMLoadVcsYamlInfo
# -------
#
# Load YCM project variables for a YCM superbuild from a VCS yaml file.
#
# .. command :: ycm_load_vcs_yaml_info
#
#  Extract information about one commit from one git repository in
#  ``SOURCE DIR``::
#
#    ycm_load_vcs_yaml_info(YAML_FILE <yaml_file>]
#                           <VERBOSE>)
#
#  ``YAML_FILE`` should point to a yaml file in the format supported by 
#  vcstool ( https://github.com/dirk-thomas/vcstool ). To simplify parsing
#  at the CMake level, arbitrary yaml files are not supported, but the current
#  subset is supported: 
#  * Two spaces indentation
#  * No comments
#  * Just GitHub repositories 
# 
#  If the VERBOSE option is passed, ycm_load_vcs_yaml_info will print all the variable
#  that it sets.
#
# For each package, the <package>_REPOSITORY and <package>_TAG CMake variable are set
# If this option are already set (for example via command line option) the version in the 
# YAML is ignored and the version already set is used

if(DEFINED __YCM_LOAD_VCS_YAML_INFO)
  return()
endif()
set(__YCM_LOAD_VCS_YAML_INFO 1)

include(CMakeParseArguments)

function(ycm_load_vcs_yaml_info)

  # Parse arguments and check values
  set(_options VERBOSE)
  set(_oneValueArgs YAML_FILE)
  set(_multiValueArgs)
  cmake_parse_arguments(_ylvyi "${_options}" "${_oneValueArgs}" "${_multiValueArgs}" "${ARGN}")

  if(NOT DEFINED _ylvyi_YAML_FILE)
    message(FATAL_ERROR "ycm_load_vcs_yaml_info: YAML_FILE parameter.")
  endif()
  
  # Load file and split in lines (see https://cmake.org/pipermail/cmake/2007-May/014222.html)
  file(READ "${_ylvyi_YAML_FILE}" contents)

  # Convert file contents into a CMake list (where each element in the list
  # is one line of the file)
  string(REGEX REPLACE ";" "\\\\;" contents "${contents}")
  string(REGEX REPLACE "\n" ";" contents "${contents}")

  # True if the initial repositories: key was found
  set(_ylvyi_REPO_KEY_FOUND FALSE)
  # Name of the package info currently being parsed
  set(_ylvyi_PACKAGE_CURRENTLY_PARSED "")
  foreach(line ${contents})
    # Parse the initial repositories: line
    if(NOT ${_ylvyi_REPO_KEY_FOUND})
      if(${line} STREQUAL "repositories:")
        set(_ylvyi_REPO_KEY_FOUND TRUE)
        continue()
      else()
        message(FATAL_ERROR "ycm_load_vcs_yaml_info: unexpected first line \"${line}\" instead of \"repository:\"")
      endif()
    endif()

    # If the line has the form "  <package>:", start to parse info for a new package
    if(${line} MATCHES "^  ([a-zA-Z0-9_.-]+):")
      set(_ylvyi_PACKAGE_CURRENTLY_PARSED ${CMAKE_MATCH_1})
    else()
      # Otherwise, the line must have the form "    <key>: <value>"    
      if(${line} MATCHES "^    ([a-zA-Z0-9_.-]+): ([a-zA-Z0-9_.:/\-]+)")
        set(_ylvyi_KEY_CURRENTLY_PARSED ${CMAKE_MATCH_1})
        set(_ylvyi_VALUE_CURRENTLY_PARSED ${CMAKE_MATCH_2})

        # Handle the possible keys
        if(_ylvyi_KEY_CURRENTLY_PARSED STREQUAL "type")
          if(NOT _ylvyi_VALUE_CURRENTLY_PARSED STREQUAL "git")
            message(FATAL_ERROR "ycm_load_vcs_yaml_info: type \"${_ylvyi_VALUE_CURRENTLY_PARSED}\" in line \"${line}\" not supported, only type \"git\" is currently supported.")
          endif()
        elseif(_ylvyi_KEY_CURRENTLY_PARSED STREQUAL "url")
          # If the <package>_REPOSITORY CMake variable is already set, we ignore the url key from the YAML
          if(NOT ${_ylvyi_PACKAGE_CURRENTLY_PARSED}_REPOSITORY)
            # For now we only support GitHub Style repositories, but adding other repository is just a matter of adding a new if here
            if(${_ylvyi_VALUE_CURRENTLY_PARSED} MATCHES "https://github.com/([a-zA-Z0-9/_.-]+.git)")
              set(${_ylvyi_PACKAGE_CURRENTLY_PARSED}_REPOSITORY ${CMAKE_MATCH_1} PARENT_SCOPE)
              if(_ylvyi_VERBOSE)
                message(STATUS "ycm_load_vcs_yaml_info: setting ${_ylvyi_PACKAGE_CURRENTLY_PARSED}_REPOSITORY to ${CMAKE_MATCH_1}")
              endif()
            else()
              message(FATAL_ERROR "ycm_load_vcs_yaml_info: not supported repo \"${_ylvyi_VALUE_CURRENTLY_PARSED}\" in line \"${line}\".")
            endif()
          else()
            if(_ylvyi_VERBOSE)
              message(STATUS "ycm_load_vcs_yaml_info: ${_ylvyi_PACKAGE_CURRENTLY_PARSED}_REPOSITORY manually set to ${${_ylvyi_PACKAGE_CURRENTLY_PARSED}_REPOSITORY}, ignoring .yaml value")
            endif()
          endif()
        elseif(_ylvyi_KEY_CURRENTLY_PARSED STREQUAL "version")
          # If the <package>_TAG CMake variable is already set, we ignore the version key from the YAML
          if(NOT ${_ylvyi_PACKAGE_CURRENTLY_PARSED}_TAG)
            # version is either a branch, a tag or a commit
            set(${_ylvyi_PACKAGE_CURRENTLY_PARSED}_TAG ${_ylvyi_VALUE_CURRENTLY_PARSED} PARENT_SCOPE)
            if(_ylvyi_VERBOSE)
              message(STATUS "ycm_load_vcs_yaml_info: setting ${_ylvyi_PACKAGE_CURRENTLY_PARSED}_TAG to ${_ylvyi_VALUE_CURRENTLY_PARSED}")
            endif()
          else()
            if(_ylvyi_VERBOSE)
              message(STATUS "ycm_load_vcs_yaml_info: ${_ylvyi_PACKAGE_CURRENTLY_PARSED}_TAG manually set to ${${_ylvyi_PACKAGE_CURRENTLY_PARSED}_TAG}, ignoring .yaml value")
            endif()
          endif()
        else()
          message(FATAL_ERROR "ycm_load_vcs_yaml_info: unexpected key \"${_ylvyi_KEY_CURRENTLY_PARSED}\" in line \"${line}\".")
        endif()
      else() 
        message(FATAL_ERROR "ycm_load_vcs_yaml_info: unexpected package info ${line} instead of a two or four space indented line.")
      endif()
    endif()    
  endforeach()

endfunction()
