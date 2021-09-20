# Conda Powershell Troubleshooting

For most of the `conda` related documentation in the `robotology-superbuild`, it is assume that the command-line interpreter to use on Windows is the [Command Prompt](https://en.wikipedia.org/wiki/Cmd.exe). 

While Powershell may work in some situations, powershell users may encounter the problems listed in the following. See https://github.com/robotology/robotology-superbuild/issues/890 for the reference issue on supporting Powershell in conda docs.

## PowerShell and mamba init

If you want to use `mamba`, note that it is not sufficient to run `mamba init` in PowerShell, as this is not supported: https://github.com/mamba-org/mamba/issues/1088 .

## PowerShell profiles and ExecutionPolicy problems
If you use PowerShell, note that the `conda init` commands works by creating a [PowerShell profile script](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles). On new Windows machines, the default [Execution Policies](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies) for PowerShell is quite restrictive, and so [it does not permit to profiles to run](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.1#profiles-and-execution-policy). If that it is the case for you, after you run `conda init` you may get a "<ProfileFilePath> cannot be loaded because running scripts is disabled on this system." error whenever you launch PowerShell. To fix this problem, you can just open an Windows Powershell with "Run as administrator", and set the execution policy of your system to allow running profile scripts:
~~~
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
~~~

## Gazebo and ROS problems with PowerShell

Some conda packages that are not part of the `robotology`  channel, such as [Gazebo](https://github.com/conda-forge/gazebo-feedstock/issues/42) or [ROS](https://github.com/RoboStack/ros-noetic/issues/21)) do not support PowerShell in their activation scripts. If you want to use them, make sure that you use Command Prompt.

