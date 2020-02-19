# Install dependencies via a custom vcpkg 

If you prefer to install dependencies of the `robotology-superbuild` on your own existing [`vcpkg`](https://github.com/microsoft/vcpkg) installation,
the ports that are required are the following: 
~~~
./vcpkg.exe install --triplet x64-windows ace freeglut gsl eigen3 ode openssl libxml2 eigen3 opencv3 matio sdl1 sdl2 qt5-base qt5-declarative qt5-multimedia qt5-quickcontrols2
~~~

Furthermore, we also require the custom `ipopt-binary` port that is available in the [`robotology/robotology-vcpkg-binary-ports`](https://github.com/robotology/robotology-vcpkg-binary-ports) repo.
