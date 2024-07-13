macro(set_tag tag_name tag_value)
    if(NOT ${tag_name})
        set(${tag_name} ${tag_value})
    endif()
endmacro()

# External projects
set_tag(osqp_TAG v0.6.3)
set_tag(manif_REPOSITORY robotology-dependencies/manif.git)
set_tag(manif_TAG 0.0.4.103)
set_tag(qhull_TAG 2020.2)
set_tag(CppAD_TAG 20240000.2)
set_tag(proxsuite_TAG v0.6.4)
set_tag(casadi_TAG 3.6.5.backport3724)
set_tag(casadi-matlab-bindings_TAG v3.6.5.0)

# Robotology projects
set_tag(YCM_TAG 0d6b1a5a0f14c6334acd1d2b8ae3efceb51fe56c)
set_tag(YARP_TAG yarp-3.9)
set_tag(yarp-matlab-bindings_TAG yarp-3.9)
set_tag(gym-ignition_TAG v1.3.1)
