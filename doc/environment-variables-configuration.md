# Enviroment Variables Configuration

During the configuration process, the robotology-superbuild installs the `setup.sh` (in Linux and macOS) or the `setup.bat`, `addPathsToUserEnvVariables.ps1` and `removePathsFromUserEnvVariables.ps1` (in Windows) scripts.

These scripts can be used to automatically add to the [enviroment variables](https://en.wikipedia.org/wiki/Environment_variable)
of the process the variables necessary to successfully launch the software installed by the robotology-superbuild, even if it is not installed in the system install prefix.

However, for some use cases it may be necessary to manually deal with the necessary enviroment modification, and so all the enviroment variables
that are needed by the software installed by the robotology-superbuild are documented in this page. 

## Generic configuration 

In the rest of the document, we assume that the environment variable `ROBOTOLOGY_SUPERBUILD_SOURCE_DIR` points to the  
directory where you cloned the robotology-superbuild repository, and `ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX`to the directory
where you have installed the robotology-superbuild.

For what regards the [`Path`](https://en.wikipedia.org/wiki/PATH_(variable)) variable, you need 
to append `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX\bin` to it.

For what regards the [`YARP_DATA_DIRS`](http://www.yarp.it/yarp_data_dirs.html) environment variable, you must append the following directories:

* `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX\share\yarp`
* `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX\share\iCub`
* `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX\share\ICUBcontrib`

For what regards the [`CMAKE_PREFIX_PATH` environment variable](https://cmake.org/cmake/help/latest/variable/CMAKE_PREFIX_PATH.html), you need to append `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX` to it.

Just on Linux, you need to append `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/lib` to  [`LD_LIBRARY_PATH`](http://tldp.org/HOWTO/Program-Library-HOWTO/shared-libraries.html),
while on macOS you need to append `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/lib` to [`DYLD_LIBRARY_PATH`](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/DynamicLibraries/100-Articles/UsingDynamicLibraries.html).

## Profile-specific configuration steps 

This section covers the configuration necessary for a specific profile. 
For all profile options not listed, no additional configuration is required.

### Robot Testing
`$ROBOTOLOGY_SUPERBUILD_SOURCE_DIR/robotology/icub-tests/suites` must be appended to the `YARP_DATA_DIRS` enviromental variable

### Dynamics
`$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/lib/blockfactory` must be appended to the `BLOCKFACTORY_PLUGIN_PATH` enviromental variable

### Human Dynamics
`$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/share/human-gazebo`, 
`$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/share/HumanDynamicsEstimation`,
and`$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/share/Wearables` must be appended to the `YARP_DATA_DIRS` enviromental variable.

## Dependency-specific configuration steps 

This section covers the configuration necessary for a specific dependency. 
For all dependecies option not listed, no additional configuration is necessary.

### Gazebo
The following enviroment variables need to be appended with robotology-superbuild related directories:
~~~
# Gazebo related env variables (see http://gazebosim.org/tutorials?tut=components#EnvironmentVariables )
# This is /usr/local/share/gazebo/setup.sh if Gazebo was installed in macOS using homebrew
source /usr/share/gazebo/setup.sh
export GAZEBO_PLUGIN_PATH=${GAZEBO_PLUGIN_PATH}:${ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX}/lib
export GAZEBO_MODEL_PATH=${GAZEBO_MODEL_PATH}:${ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX}/share/gazebo/models:${ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX}/share/iCub/robots:${ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX}/share
export GAZEBO_RESOURCE_PATH=${GAZEBO_RESOURCE_PATH}:${ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX}/share/gazebo/worlds
~~~

### Python
`$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/lib/python3.6/dist-packages` and `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/lib/python3.6/site-packages` must be appended to the `PYTHONPATH` environmental variable. 
