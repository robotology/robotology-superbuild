# Install dependencies via a custom vcpkg 

If you prefer to install dependencies of the `robotology-superbuild` on your own existing [`vcpkg`](https://github.com/microsoft/vcpkg) installation,
the ports that are required are the following: 
~~~
./vcpkg.exe install --triplet x64-windows ace asio assimp boost-asio boost-any boost-bind boost-date-time boost-filesystem boost-format boost-interprocess boost-iostreams boost-program-options boost-property-tree boost-regex boost-smart-ptr boost-system boost-thread boost-variant boost-uuid freeglut gsl eigen3 glew glfw3 graphviz ode openssl libxml2 libjpeg-turbo nlohmann-json opencv portaudio matio sdl1 sdl2 qt5-base[latest] qt5-declarative qt5-multimedia qt5-quickcontrols qt5-quickcontrols2 sqlite3[core,tool] irrlicht qhull tinyxml2 ffmpeg zlib simde
~~~


Furthermore, we also require the custom `ipopt-binary` and `esdcan-binary` ports that are available in the [`robotology/robotology-vcpkg-ports`](https://github.com/robotology/robotology-vcpkg-ports) repo.
