# conda-forge based robotology-superbuild Installation

[`conda`](https://docs.conda.io/en/latest/) is a package manager (originally for Python, but effectively language agnostic) that works on Linux, macOS and Windows.

[`conda-forge`](https://conda-forge.org/)  is a community-mantained channel for the `conda` package manager that provides many dependencies useful for scientific software, in particular all the one that are required by the robotology-superbuild .

For an overview of advantages and disadvantages of conda and conda-forge, check the [`conda-forge-overview.md`](conda-forge-overview.md) document. If you are just interested in installing the robotology-superbuild, please proceed to the next sections.

## Table of Contents
* [Binary installation](#binary-installation)
* [Source installation](#source-installation)

## Binary installation

This section describes how to install the binary packages built from the `robotology-superbuild` on conda on Windows, macOS and Linux.

Depending on the speficic package, the binary packages are hosted either in [`conda-forge`](https://prefix.dev/channels/conda-forge) or [`robotology`](https://prefix.dev/channels/robotology) channels. Only packages that are built as part of the profiles and options that are supported on Conda (see [documentation on CMake options](cmake-options.md)) are available as conda binary packages.

The following conda platforms are supported by all packages of the robotology-superbuild:

* `linux-64` (Linux on x86-64)
* `osx-arm64` (macOS on ARM 64-bit)
* `win-64` (Windows on x86-64)

Some packages are also available for:
* `linux-aarch64` (Linux on ARM 64-bit)
* `osx-64` (macOS on x86-64)

As the switch from building the `robotology` channel packages from `osx-64` to `osx-arm64` happened in September 2024 (see https://github.com/robotology/robotology-superbuild/pull/1712), it may happen that some older packages are only available for `osx-64` and not `osx-arm64`.

If you need a binary package on a platform in which it is not available, feel free to [open an issue](https://github.com/robotology/robotology-superbuild/issues/new) requesting it.

### Install a conda distribution

If you do not have a conda distribution on your system, we suggest to use the minimal
[`miniforge`](https://github.com/conda-forge/miniforge) distribution, that uses `conda-forge` packages by default.

To install `miniforge`, please follow the instructions in our [`install-miniforge`](install-miniforge.md) documentation.

### Create an environment
Differently from `apt` and `homebrew`, the `conda` package manager is an `environment`-oriented package manager, meaning that packages are not
installed in some global location, but rather you install packages in an `environment` (that is just a directory in your filesystem), so that you
can easily have multiple different environments with different packages installed on your system. To read more about this, check https://docs.conda.io/projects/conda/en/4.6.1/user-guide/tasks/manage-environments.html .

For this reason, to use the robotology conda packages it is suggested to first create a conda environment, and then install in it all the packages you want to use. To create a new environment called `robotologyenv`, execute the following command:
~~~
conda create -n robotologyenv
~~~

Once you created the `robotologyenv` environment, you can "activate" it for the current terminal (i.e. make sure that the installed packages can be found) by the command:
~~~
conda activate robotologyenv
~~~

> [!IMPORTANT]
> If you open a new terminal, you need to manually activate the environment also there.

> [!IMPORTANT]
> To avoid strange conflicts in environment variables, it is a good idea to remove from  the environment any variable that refers to libraries or software not installed with conda. For example, if you have a robotology-superbuild installed with apt dependencies, it is a good idea to remove the source of the `setup.sh` from the `.bashrc` before using conda environments, or in Windows it can make sense to check with [Rapid Environment Editor](https://www.rapidee.com) that the environment is clean.

> [!IMPORTANT]
> On Windows, it is recommended to use Command Prompt to manage conda environments, as some packages (see https://github.com/conda-forge/gazebo-feedstock/issues/42 and https://github.com/RoboStack/ros-noetic/issues/21) have problems in activating environments on Powershell.

### Install robotology packages

Once you are in an activated environment, you can install robotology packages by just running the command:
~~~
conda install -c conda-forge -c https://repo.prefix.dev/robotology <packagename>
~~~

The list of available packages is available at https://anaconda.org/robotology/repo .

For example, if you want to install yarp and icub-main, you simple need to install:
~~~
conda install -c conda-forge -c https://repo.prefix.dev/robotology yarp icub-main
~~~

In addition, if you want to simulate the iCub in Gazebo Classic, you should also install `icub-models` and `gazebo-yarp-plugins`:
~~~
conda install -c conda-forge gazebo-yarp-plugins icub-models
~~~

While if you want to simulate it with Modern Gazebo (gz-sim), you should install `icub-models` and `gz-sim-yarp-plugins`:
~~~
conda install -c conda-forge gz-sim-yarp-plugins icub-models
~~~

If you want to develop some C++ code on the top of these libraries, it is recommended to also install the necessary compiler and development tools directly in the same environment:
~~~
conda install -c conda-forge compilers cmake pkg-config make ninja
~~~

### Advanced: robotology channel mirrors

To ensure redundancy, the `robotology` channel is available on two servers:
* [`prefix.dev`](https://prefix.dev/channels/robotology)
* [`anaconda.org`](https://anaconda.org/robotology/)

The full history of packages is available on the prefix.dev mirror, so if you aim for reproducibility, try to use the prefix.dev mirror by specifying the channel via `-c https://repo.prefix.dev/robotology`. On the anaconda.org, some packages built before 1st of January 2023 are not available, so if you only care for the latest packages, you can also install packages by simply passing `-c robotology` to conda.

## Source installation

This section describes how to compile and install the robotology-superbuild with conda-forge provided dependencies on Windows, macOS and Linux.

In particular, this instructions cover the following conda platforms:

* `linux-64` (Linux on x86-64)
* `osx-64` (macOS on x86-64)
* `win-64` (Windows on x86-64)
* `linux-aarch64` (Linux on ARM 64-bit)
* `osx-arm64` (macOS on ARM 64-bit)

### Install a conda distribution

If you do not have a conda distribution on your system, we suggest to use the minimal
[`miniforge`](https://github.com/conda-forge/miniforge) distribution, that uses `conda-forge` packages by default.

To install `miniforge`, please follow the instructions in our [`install-miniforge`](install-miniforge.md) documentation.

### Create an environment and install dependencies
Differently from `apt` and `homebrew`, the `conda` package manager is an `environment`-oriented package manager, meaning that packages are not
installed in some global location, but rather you install packages in an `environment` (that is just a directory in your filesystem), so that you
can easily have multiple different environments with different packages installed on your system. To read more about this, check https://docs.conda.io/projects/conda/en/4.6.1/user-guide/tasks/manage-environments.html .

For this reason, to compile the superbuild it is suggested to first create a conda environment, and then install in it all the dependencies
required by the robotology-superbuild. To create a new environment called `robsub`, execute the following command:
~~~
conda create -n robsub
~~~

Once you created the `robsub` environment, you can "activate" it for the current terminal (i.e. make sure that the installed packages can be found) by the command:
~~~
conda activate robsub
~~~

> [!IMPORTANT]
> If you open a new terminal, you need to manually activate the environment also there. If you compiled a robotology-superbuild in a given conda environment, remember to activate it before trying to compile or run any package
of the robotology-superbuild.

> [!IMPORTANT]
> To avoid strange conflicts in environment variables, it is a good idea to remove from  the environment any variable that refers to libraries or software not installed with conda. For example, if you have a robotology-superbuild installed with apt dependencies, it is a good idea to remove the source of the `setup.sh` from the `.bashrc` before using conda environments, or in Windows it can make sense to check with [Rapid Environment Editor](https://www.rapidee.com) that the environment is clean.

> [!IMPORTANT]
> On Windows, it is recommended to use Command Prompt to manage conda environments, as some packages (see https://github.com/conda-forge/gazebo-feedstock/issues/42 and https://github.com/RoboStack/ros-noetic/issues/21) have problems in activating environments on Powershell.

> [!IMPORTANT]
> If it happens that conda cannot resolve the environment when sequentially installing the needed packages as reported later, please consider to install all the conda packages in a unique command.


Once you activated it, you can install packages in it. In particular the dependencies for the robotology-superbuild can be installed as:

~~~
conda install -c conda-forge ace asio assimp libboost-devel cli11 eigen freetype glew glfw glm graphviz gsl "ipopt>3.13.0" irrlicht libjpeg-turbo libmatio libode libxml2 nlohmann_json qhull "pcl>=1.11.1" "libopencv>=4.10.0" opencv portaudio qt-main sdl sdl2 sqlite tinyxml tinyxml2 spdlog lua soxr qhull cmake compilers make ninja pkg-config tomlplusplus libzlib ffmpeg onnxruntime-cpp
~~~


**Additionally** if you are on **Linux**, you **also** need to install also the following packages:
~~~
conda install -c conda-forge bash-completion freeglut libdc1394 libi2c xorg-libxau libxcb xorg-libxdamage xorg-libxext xorg-libxfixes xorg-libxxf86vm xorg-libxrandr libgl-devel
~~~

**Additionally** if you are on **Windows**, you **also** need to install also the following packages:
~~~
conda install -c conda-forge freeglut
~~~

For some [profile](doc/cmake-options.md#profile-cmake-options) or [dependency](doc/cmake-options.md#dependencies-cmake-options) specific CMake option you may need to install additional system dependencies, following the dependency-specific documentation listed in the following. If you do not want to enable an option, you should ignore the corresponding section and continue with the installation process.

#### `ROBOTOLOGY_USES_PYTHON`

To install python and the other required dependencies when using `conda-forge` provided dependencies, use:
~~~
conda install -c conda-forge python pip numpy swig pybind11 pyqt matplotlib h5py tornado u-msgpack-python pyzmq ipython gst-plugins-good gst-plugins-bad pyqtwebengine qtpy pyyaml
~~~

#### `ROBOTOLOGY_USES_PCL_AND_VTK`

If you install your dependencies with `conda`, just make sure to install the `pcl` and `vtk` packages:

~~~
conda install -c conda-forge "pcl>=1.11.1" vtk
~~~

#### `ROBOTOLOGY_USES_GAZEBO`

If you install your dependencies with `conda`, just make sure to install the `gazebo` package:

~~~
conda install -c conda-forge gazebo
~~~

#### `ROBOTOLOGY_USES_GZ`

If you install your dependencies with `conda`, just make sure to install the `gz-sim9` (Gazebo Ionic) or `gz-sim8` (Gazebo Harmonic) package:

~~~
conda install -c conda-forge gz-sim9
~~~

#### `ROBOTOLOGY_USES_ROS2`

If you install your dependencies with `conda`, just make sure to install the required packages from the `robostack-staging` channel:

~~~
conda install -c conda-forge -c robostack-staging  ros-humble-ros-base ros-humble-test-msgs
~~~

#### `ROBOTOLOGY_USES_MOVEIT`

If you install your dependencies with `conda`, just make sure to install the required packages from the `robostack-staging` channel:

~~~
conda install -c conda-forge -c robostack-staging ros-humble-moveit  ros-humble-hardware-interface ros-humble-moveit-visual-tools ros-humble-gazebo-msgs ros-humble-controller-manager
~~~

### Clone the repo
To compile the `robotology-superbuild` code itself, you need to clone it, following the instructions in https://github.com/robotology/robotology-superbuild#clone-the-repo .

### Compile the robotology-superbuild

In a terminal in which you activate the `robsub` environment, you can compile.

> [!IMPORTANT]  
> On `linux-aarch64` (Linux with ARM processors) and `macos-arm64` (macOS with ARM processors) before building you need to set the `QT_HOST_PATH` env variable to `${CONDA_PREFIX}` before the build as a workaround for https://github.com/conda-forge/qt-main-feedstock/issues/273 .


On **Linux** or on **macOS**, run:

~~~
cd robotology-superbuild
mkdir build
cd build
cmake ..
source ./install/share/robotology-superbuild/setup.sh
cmake --build . --config Release
~~~

On **Windows**, run:
~~~
cd robotology-superbuild
mkdir build
cd build
cmake -G"Visual Studio 16 2019" ..
call .\install\share\robotology-superbuild\setup.bat
cmake --build . --config Release
~~~

> [!IMPORTANT]
> If you use Visual Studio 2022, the fourth command needs to be changed in `cmake -G"Visual Studio 17 2022" ..`. Visual Studio 2017 or earlier are not supported.

> [!IMPORTANT]
> On Windows, you need to make sure that your Windows installation has enabled support long path, see how to do that in https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation?tabs=registry#enable-long-paths-in-windows-10-version-1607-and-later.

> [!IMPORTANT]
> conda-forge does not provide Debug version of its libraries, so in Windows you can't compile in Debug mode if you are using conda-forge.



### Run software installed

On **Linux**, **macOS** or **Windows with Git Bash**, you can at this point run the software compiled by source with the robotology-superbuild in any new terminal as:
~~~
conda activate robsub
source ./robotology-superbuild/build/install/share/robotology-superbuild/setup.sh
~~~

On **Windows with cmd prompt**:
~~~
conda activate robsub
call ./robotology-superbuild/build/install/share/robotology-superbuild/setup.bat
~~~
