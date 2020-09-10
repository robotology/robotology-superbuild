# Configure the X Server on Windows to work with WSL2

## Introduction 

The Linux instance in WSL2 are running as part of a lightweight virtual machine, so effectively the IP addresso of the WSL2 instance will be different from the IP address
of the Windows host, and the Windows host can communicate with the WSL2 instance thanks to a virtual IP network. For this reason, to run graphical applications on WSL2, 
you  need to install an X Server for Windows. As unfortunately the IP addresses of the virtual IP network change at every reboot, it is also necessary to configure the 
X Server that you use to accept connection from arbitrary IP addresses. This documentation page explains how to do this in hte most used Windows X Servers.
Note that accepting X server connections from arbitrary IP addresses may create security problems, so make sure to enable it only on private networks.

## Xming 
**IMPORTANT: The following procedure is not going to work if you have VcXsrv installed on your system. Before following this instruction, 
make sure that VcXsrv is not present in your system, and if it is installed uninstall it before proceeding.**

[Xming](https://sourceforge.net/projects/xming/) is an open source X server for Windows. To use it with WSL2, first of all install it.
Once you have installed it, launch the `XLaunch` program to create a configuration for it:

![xming_no_access_control_1](https://user-images.githubusercontent.com/1857049/92622879-dd176b00-f2c5-11ea-9d9e-ecce1af94ddf.png)

proceed with the default settings, and once you arrive to the "Specify parameter settings" dialog, make sure to tick the "No Access Control" option:

![xming_no_access_control_2](https://user-images.githubusercontent.com/1857049/92622884-de489800-f2c5-11ea-967b-5d0ce01eccd6.png)

Then, proceed and click on "Save Configuration" to save a `.xlaunch` file containing the specified settings in your preferred directory, for example the Desktop:

![xming_no_access_control_3](https://user-images.githubusercontent.com/1857049/92622889-dee12e80-f2c5-11ea-9741-0212b8517b84.png)

![xming_no_access_control_4](https://user-images.githubusercontent.com/1857049/92622883-ddb00180-f2c5-11ea-8db0-fbfa9c0876ee.png)

Now, before you launch graphical programs on WSL2, always remember to launch the X Server with "No Access Control" by double clicking on the created `wsl2.xlaunch` file:

![xming_no_access_control_5](https://user-images.githubusercontent.com/1857049/92622887-de489800-f2c5-11ea-9f90-68f7fcddeb9f.png)

## X410 
When using [X410](https://x410.dev/) with WSL2, remember to use it with the **Allow Public Access** option enabled.

## VcXsrv

According to our tests, VcXsrv is not compatible with GUI used in the robotology-superbuild. 
