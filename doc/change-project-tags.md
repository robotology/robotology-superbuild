Change project tags
===================

For [`YCM`-based superbuilds](http://robotology.github.io/ycm/gh-pages/git-master/manual/ycm-superbuild.7.html), the specific 
branch, tag or commit used for each specific CMake package can be manually specified  using the [`<package>_TAG`](http://robotology.github.io/ycm/gh-pages/git-master/manual/ycm-superbuild.7.html#overriding-parameters) 
CMake variables. By default, the `robotology-superbuild` uses the latest "stable" branches of the robotology repositories, but in some cases it may be necessary to use the "unstable" active development branches, 
or use some fixed tags. These advanced use cases are supported by the `ROBOTOLOGY_PROJECT_TAGS` CMake variable. 

`ROBOTOLOGY_PROJECT_TAGS` is an advanced CMake option, so it is visible from the CMake GUI only after enabling the visualization of advanced variables.
It can take one of three possible values: 
* `Stable` :  this is the default value, that will use the tags or branches specified in [`cmake/ProjectsTagsStable.cmake`](../cmake/ProjectsTagsStable.cmake) 
              that are the stables branches for the robotology projects.
* `Unstable` : by selecting this option, you will use the tags or branches specified in [`cmake/ProjectsTagsUnstable.cmake`](../cmake/ProjectsTagsUnstable.cmake), 
               that are the "unstable" active development branches for the robotology projects. This is reccomended just for users that work at the IIT labs in Genoa,
               as it can break compilation or runtime behaviour without any notice.
* `Custom` : by selecting this option, you need to manually specify the tags or branches that you want to use by specifying a custom project tags file in the 
             `ROBOTOLOGY_PROJECT_TAGS_CUSTOM_FILE` CMake option. It is necessary to specify the absolute location of the file.  This is useful when  you want to use a fixed version of the software built by the superbuild. The specified file is included in the project via the [`include` CMake command](https://cmake.org/cmake/help/v3.15/command/include.html), or if it ends with `.yaml` or `.repos` it is assumed to be a YAML file that is loaded by the [`ycm_load_vcs_yaml_info`](../cmake/YCMLoadVcsYamlInfo.cmake) CMake function.

**Due to limitations on how the CMake's [`ExternalProject`](https://cmake.org/cmake/help/latest/module/ExternalProject.html) modules handles the TAG option, the choice
of the `ROBOTOLOGY_PROJECT_TAGS` option needs to be done before the source code for the CMake packages is downloaded for the first time in the `src` directory. 
If you want to change the `ROBOTOLOGY_PROJECT_TAGS` or `ROBOTOLOGY_PROJECT_TAGS_CUSTOM_FILE` option in an existing superbuild, you need to manually delete the `external` and `robotology`
directories, and then configure again the superbuild. Note that this also means that if  you have multiple build directories for the same superbuild, all of them 
need to use consistent `ROBOTOLOGY_PROJECT_TAGS` values.**
