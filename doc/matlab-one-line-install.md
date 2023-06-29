# One-line Installation of Robotology MATLAB/Simulink Packages

This guide provides a simple documentation to install Robotology MATLAB/Simulink packages in a pure MATLAB workflow (so without launching **anything else** via terminal, so for example no Gazebo simulation).

## Installation
~~~matlab
websave('install_robotology_packages.m', 'https://raw.githubusercontent.com/robotology/robotology-superbuild/master/scripts/install_robotology_packages.m')
install_robotology_packages
robotology_setup
~~~
This will install everything in a `robotology-matlab` local directory, without perturbing anything else in your system. 
Once installed, you just need to re-run the `robotology_setup` script (or add it in your [`setup.m`](https://www.mathworks.com/help/matlab/ref/startup.html) file) to make the library available again. The overall installation process should take 2/3 minutes.

If the installation and launching the `robotology_setup`, you should be able to run the following MATLAB code without any error:
~~~
vec = iDynTree.Vector3();
vec.fromMatlab([1,2,3])
vec.toString();
~~~



### Installation on MATLAB Online
**This section is required only if you want to use this on [MATLAB Online](https://www.mathworks.com/products/matlab-online.html). If you are using a MATLAB installation on your system, please skip it.**

Due to specific problems on MATLAB Online, you can't install the libraries in the local directory, and if you need to run this on MATLAB Online the command is slightly nmore difficult: 
~~~matlab
websave('install_robotology_packages.m', 'https://raw.githubusercontent.com/robotology/robotology-superbuild/master/scripts/install_robotology_packages.m')
install_robotology_packages(installPrefix=fullfile(getenv('HOME'),'robotology-matlab'))
robotology_setup
~~~

## Uninstall 

To remove the packages installed by this guide, just remove the `robotology-gazebo` and the `install_robotology_packages.m` and `robotology_setup.m` scripts created by the installation.

## Technical Details

Under the hood, the `install_robotology_packages.m` scripts just automatically installs a conda environment in the `robotology-matlab` folder, automatically following the command described in [documentation on how to install robotology binary packages via conda](./conda-forge.md).
