# Use the robotology-superbuild on the icub-head 

## Introduction 
One of the main goals of the robotology-superbuild is to simplify downloading and building all the software 
that is necessary to have on the main control computer contained in the head of the iCub robot, whose hostname 
is `icub-head` (or `pc104` in older iCub versions). This documentation provides the basic information necessary to 
use the robotology-superbuild on the computer contained in the head of the iCub robot. 

**Warning: if your iCub robot is not currently using the robotology-superbuild, do not attempt to migrate it
without coordinating with the iCub support.  For any doubt, please open an issue at https://github.com/robotology/icub-tech-support.**

## Prepare your system 
The operating system contained in the `icub-head`/`pc104` is tipically installed by IIT, for more information on it, please
check the relevant documentation at http://wiki.icub.org/wiki/The_Linux_on_the_pc104 . On this machine, 
in `/home/icub/.bashrc_iCub` a script containing several enviroment variables definitions is provided. If you want to  migrate to use
the robotology-superbuild, you need to remove the existing `.bashrc_iCub` file, and substitute it with the one provided in https://git.robotology.eu/MBrunettini/icub-environment/raw/master/bashrc_iCub_superbuild.
After you modified the `.bashrc_iCub` script, reboot the computer and  in a new shell check che values of the `ROBOTOLOGY_SUPERBUILD_SOURCE_DIR` and `YARP_ROBOT_NAME` env variables.
If `ROBOTOLOGY_SUPERBUILD_SOURCE_DIR` contains `/usr/local/src/robot/robotology-superbuild`, and `YARP_ROBOT_NAME` contains the string specific to your robot,
then the modification of the `.bashrc_iCub` was successful. 

## Get software source code, compile and install
On the `icub-head`/`pc104`, the software repository necessary to run the iCub robot are contained in the `/usr/local/src/robot` directory.
On a new machine, this directory should be empty. All the relevant software can download and build with the following commands:
~~~sh
cd /usr/local/src/robot
git clone https://github.com/robotology/robotology-superbuild.git
cd robotology-superbuild
mkdir build
cmake -DROBOTOLOGY_USES_GAZEBO:BOOL=OFF -DROBOTOLOGY_ENABLE_ICUB_HEAD:BOOL=ON ..
make
~~~
The main difference over the standard installation of the robotology-superbuild, is that the `ROBOTOLOGY_USES_GAZEBO` option
is disabled (as the Gazebo is tipically not installed in the `icub-head`/`pc104` machine) and the `ROBOTOLOGY_ENABLE_ICUB_HEAD` option
is enabled, to enable all the YARP devices that are necessary to interface with the internal communication bus of the iCub robot.
The `make` command in this case will download, compile and install all the software necessary to run the robot itself.

If you need to use other *superbuild profiles*, they can be easily enabled with the corresponding CMake option.

**Important: do not run `make install` for the superbuild: the superbuild already installs all the software in 
`/usr/local/src/robot/robotology-superbuild/build/install`, and installing the software elsewhere on the robot is not currently supported.**

**Important: If you are using an old iCub that still uses the CAN internal bus, you also need to enable the `ROBOTOLOGY_USES_CFW2CAN` CMake options. 
See the main robotology-superbuild README for more detailed information.**


## Run the software 
If the `make` command of the robotology-superbuild was successful, you just need to reboot the machine (or source again the `.bashrc_iCub`  file) and 
you will then be ready to use all the software provided by the robotology-superbuild.


# Existing Wiki Documentation 
Most of the existing documentation regarding the installation of the software on the pc104/icub-head 

| Normal page            |  Superbuild version           |
|:-------------------------:|:---------------------------------:|
| http://wiki.icub.org/wiki/ICub_Software_Installation |  http://wiki.icub.org/wiki/ICub_Software_Installation_(superbuild) | 
| http://wiki.icub.org/wiki/Windows:_installation_from_sources  | http://wiki.icub.org/wiki/Windows:_installation_from_sources_using_the_robotology-superbuild | 
|  http://wiki.icub.org/wiki/Linux:Installation_from_sources  |  http://wiki.icub.org/wiki/Linux:Installation_from_sources_using_the_robotology-superbuild  | 
| http://wiki.icub.org/wiki/MacOSX:_installation  |  http://wiki.icub.org/wiki/MacOS:Installation_from_sources_using_the_robotology-superbuild |  
| http://wiki.icub.org/wiki/ICub_server_laptop_installation_instructions | Change the last code box in section http://wiki.icub.org/wiki/ICub_server_laptop_installation_instructions#Software_repositories to `git clone https://github.com/robotology/robotology-superbuild.git` | 
| http://wiki.icub.org/wiki/Compilation_on_the_pc104 | https://wiki.icub.org/wiki/Compilation_on_the_pc104/icub-head_with_the_robotology-superbuild  | 
| https://git.robotology.eu/MBrunettini/icub-environment/raw/master/home/bashrc_iCub |  https://git.robotology.eu/MBrunettini/icub-environment/raw/master/home/bashrc_iCub_superbuild | 
