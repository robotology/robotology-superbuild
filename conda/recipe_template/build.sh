#!/bin/sh

{% if source_subdir is defined and source_subdir|length %}
cd {{ source_subdir }}
{% endif %}

mkdir build
cd build

cmake .. \
    -GNinja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_VERBOSE_MAKEFILE=OFF \
    -DCMAKE_INSTALL_SYSTEM_RUNTIME_LIBS_SKIP=True \
{% for cmake_arg in cmake_args %}    {{ cmake_arg }} \
{% endfor %}

# Workaround for https://github.com/robotology/robotology-superbuild/issues/927#issuecomment-985522905
if [[ "$PKG_NAME" == gazebo-yarp-plugins ]]; then
    echo "Setting CPU_COUNT=1 for gazebo-yarp-plugins"
    export CPU_COUNT=1
fi

cmake --build . --config Release --parallel $CPU_COUNT
cmake --build . --config Release --target install

{% if copy_activation_scripts is sameas true %}
# Copy the [de]activate scripts to $PREFIX/etc/conda/[de]activate.d.
# This will allow them to be run on environment activation.
for CHANGE in "activate" "deactivate"
do
    mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
    cp "${RECIPE_DIR}/${CHANGE}.sh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.sh"
    cp "${RECIPE_DIR}/${CHANGE}.bash" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.bash"
    cp "${RECIPE_DIR}/${CHANGE}.xsh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.xsh"
    cp "${RECIPE_DIR}/${CHANGE}.zsh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.zsh"
    cp "${RECIPE_DIR}/${CHANGE}.ps1" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.ps1"
done
{% endif %}
