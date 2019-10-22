Change project tags
===================

For [`YCM`-based superbuilds](http://robotology.github.io/ycm/gh-pages/git-master/manual/ycm-superbuild.7.html), the specific 
branch, tag or commit used for each specific CMake package can be manually specified  using the [`<package>_TAG`](http://robotology.github.io/ycm/gh-pages/git-master/manual/ycm-superbuild.7.html#overriding-parameters) 
CMake variables. By default, the `robotology-superbuild` uses the latest "stable" branches of the robotology repositories, but in some cases it may be necessary to use the "unstable" active development branches, 
or use some fixed tags. These advanced use cases are supported by the `ROBOTOLOGY_PROJECT_TAGS` CMake variable. 

`ROBOTOLOGY_PROJECT_TAGS` is an advanced CMake option, so it is visible from the CMake GUI only after enabling the visualization of advanced variables.
It can take one of three possible values: 
* `Stable` :  this is the default value, that will use the tags or branches specified in [`cmake/ProjectTagsStable.cmake`](cmake/ProjectTagsStable.cmake) 
              that are the stables branches for the robotology projects.
* `Unstable` : by selecting this option, you will use the tags or branches specified in [`cmake/ProjectTagsUnstable.cmake`](cmake/ProjectTagsUnstable.cmake), 
               that are the "unstable" active development branches for the robotology projects. This is reccomended just for users that work at the IIT labs in Genoa,
               as it can break compilation or runtime behaviour without any notice.
* `Custom` : by selecting this option, you need to manually specify the tags or branches that you want to use by specifying a custom project tags file in the 
             `ROBOTOLOGY_PROJECT_TAGS_CUSTOM_FILE` CMake option. This is useful when  you want to use a fixed version of the software built by the superbuild. The specified file is included in the project via the [`include` CMake command](https://cmake.org/cmake/help/v3.15/command/include.html), so this file can be either kept outside the superbuild source directory by specifying an absolute path, or relative and without the `.cmake` extension if stored in the `cmake/` folder, that tipically is committed in custom branch or fork. 

**Due to limitations on how the CMake's [`ExternalProject`](https://cmake.org/cmake/help/latest/module/ExternalProject.html) modules handles the TAG option, the choice
of the `ROBOTOLOGY_PROJECT_TAGS` option needs to be done before the source code for the CMake packages is downloaded for the first time in the `external` and `robotology` directories. 
If you want to change the `ROBOTOLOGY_PROJECT_TAGS` or `ROBOTOLOGY_PROJECT_TAGS_CUSTOM_FILE` option in an existing superbuild, you need to manually delete the `external` and `robotology`
directories, and then configure again the superbuild. Note that this also means that if  you have multiple build directories for the same superbuild, all of them 
need to use consistent `ROBOTOLOGY_PROJECT_TAGS` values.**
