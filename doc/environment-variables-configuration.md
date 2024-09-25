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
* `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX\share\ergoCub`
* `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX\share\ICUBcontrib`

For what regards the [`CMAKE_PREFIX_PATH` environment variable](https://cmake.org/cmake/help/latest/variable/CMAKE_PREFIX_PATH.html), you need to append `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX` to it.

Just on Linux, you need to append `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/lib` to  [`LD_LIBRARY_PATH`](http://tldp.org/HOWTO/Program-Library-HOWTO/shared-libraries.html),
while on macOS you need to append `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/lib` to [`DYLD_LIBRARY_PATH`](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/DynamicLibraries/100-Articles/UsingDynamicLibraries.html).

For what regards correctly loading resources in URDF files, you need to append `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX\share` to the
[`ROS_PACKAGE_PATH`](http://wiki.ros.org/ROS/EnvironmentVariables#ROS_PACKAGE_PATH) environment variable for [ROS1](https://www.ros.org/), and `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX` to [`AMENT_PREFIX_PATH`](http://design.ros2.org/articles/ament.html) for [ROS2](https://index.ros.org/doc/ros2/)

To enable bash autocompletion, you need to add `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX\share` to `XDG_DATA_DIRS` environment variable. If you are on Linux and not using conda and `XDG_DATA_DIRS` is empty, before adding `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX\share` also append to it the value `/usr/local/share/:/usr/share/`.

## Profile-specific configuration steps

This section covers the configuration necessary for a specific profile.
For all profile options not listed, no additional configuration is required.

### Robot Testing
`$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/lib/robottestingframework` must be appended to the `LD_LIBRARY_PATH` environmental variable in macOS and Linux, or to `PATH` in Windows.
`$ROBOTOLOGY_SUPERBUILD_SOURCE_DIR/robotology/icub-tests/suites` must be appended to the `YARP_DATA_DIRS` environmental variable.
`$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/bin` must be appended to `BLOCKTEST_RESOURCE_PATH` environmental variable.

### Dynamics
`$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/lib/blockfactory` must be appended to the `BLOCKFACTORY_PLUGIN_PATH` environmental variable on Linux and macOS, while
`$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/bin/blockfactory` must be appended to the `BLOCKFACTORY_PLUGIN_PATH` on Windows.


### Human Dynamics
`$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/share/human-gazebo`,
and `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/share/HumanDynamicsEstimation`` must be appended to the `YARP_DATA_DIRS` environmental variable.

## Dependency-specific configuration steps

This section covers the configuration necessary for a specific dependency.
For all dependecies option not listed, no additional configuration is necessary.

### Gazebo Classic
The following enviroment variables need to be appended with robotology-superbuild related directories:
~~~
# Gazebo Classic related env variables (see http://gazebosim.org/tutorials?tut=components#EnvironmentVariables )
# This is only necessary if are using apt, if you are using conda-forge do not include the next line
source /usr/share/gazebo/setup.sh
export GAZEBO_PLUGIN_PATH=${GAZEBO_PLUGIN_PATH}:${ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX}/lib
export GAZEBO_MODEL_PATH=${GAZEBO_MODEL_PATH}:${ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX}/share/gazebo/models:${ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX}/share/iCub/robots:${ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX}/share:${ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX}/share/ergoCub/robots
export GAZEBO_RESOURCE_PATH=${GAZEBO_RESOURCE_PATH}:${ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX}/share/gazebo/worlds
~~~

### Modern Gazebo
The following enviroment variables need to be appended with robotology-superbuild related directories:
~~~
# Modern Gazebo (gz-sim) related env variables (see https://gazebosim.org/api/sim/8/resources.html )
export GZ_SIM_SYSTEM_PLUGIN_PATH=${GZ_SIM_SYSTEM_PLUGIN_PATH}:${ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX}/lib
export GZ_SIM_RESOURCE_PATH=${GZ_SIM_RESOURCE_PATH}:${ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX}/share/gazebo/models:${ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX}/share/iCub/robots:${ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX}/share:${ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX}/share/ergoCub/robots:${ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX}/share/gazebo/worlds
~~~

### MATLAB

For adding the multiple libraries to the MATLAB path, the environment variable `MATLABPATH` has to be appended with the following robotology-superbuild related directories:
* `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/mex`
* `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/mex/+wbc/simulink`
* `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/mex/+wbc/examples`
* `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/share/WBToolbox`
* `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/share/WBToolbox/images`

For MATLAB to find the robot model files added by the repository [`matlab-whole-body-simulator`](https://github.com/dic-iit/matlab-whole-body-simulator), you need to append `YARP_DATA_DIRS` the directory:
* `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/share/RRbot`

#### MATLAB/Gazebo Classic

`GAZEBO_MODEL_PATH` needs to be appended with:
* `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/share/RRbot/robots`

#### MATLAB/Modern Gazebo

`GZ_SIM_RESOURCE_PATH` needs to be appended with:
* `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/share/RRbot/robots`

### Python
`$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/lib/python3.6/dist-packages` and `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/lib/python3.6/site-packages` must be appended to the `PYTHONPATH` environmental variable.


### MuJoCo

If both MATLAB and MuJoCo are enabled, the environment variable `MATLABPATH` has to be appended with the following robotology-superbuild related directory:
* `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/mex/mujoco_simulink_blockset`
