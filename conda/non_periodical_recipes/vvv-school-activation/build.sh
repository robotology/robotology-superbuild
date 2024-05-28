# Generate and copy the [de]activate scripts to $PREFIX/etc/conda/[de]activate.d.
# This will allow them to be run on environment activation.
for CHANGE in "activate" "deactivate"
do
    multisheller ${RECIPE_DIR}/${CHANGE}.msh --output ./${CHANGE}
    mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
    cp "${CHANGE}.sh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.sh"
    cp "${CHANGE}.bash" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.bash"
    cp "${CHANGE}.xsh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.xsh"
    cp "${CHANGE}.zsh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.zsh"
    cp "${CHANGE}.ps1" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.ps1"
done
