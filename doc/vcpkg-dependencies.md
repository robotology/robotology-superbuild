# Install dependencies via a custom vcpkg 

If you prefer to install dependencies of the `robotology-superbuild` on your own existing [`vcpkg`](https://github.com/microsoft/vcpkg) installation,
the ports that are required are the following: 
~~~
./vcpkg.exe install --triplet x64-windows ace asio boost-asio boost-process boost-dll boost-filesystem boost-system freeglut gsl eigen3 ode openssl libxml2 eigen3 opencv matio sdl1 sdl2 qt5-base[latest] qt5-declarative qt5-multimedia qt5-quickcontrols qt5-quickcontrols2 sqlite3[core,tool]
~~~

Furthermore, we also require the custom `ipopt-binary` and `esdcan-binary` ports that are available in the [`robotology/robotology-vcpkg-binary-ports`](https://github.com/robotology/robotology-vcpkg-binary-ports) repo.
