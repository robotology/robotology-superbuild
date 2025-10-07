macro(set_tag tag_name tag_value)
    if(NOT ${tag_name})
        set(${tag_name} ${tag_value})
    endif()
endmacro()

# External projects
set_tag(osqp_REPOSITORY robotology-dependencies/osqp.git)
set_tag(osqp_TAG v1.0.0.1)
set_tag(osqp-matlab_TAG v0.9.0.1)
set_tag(manif_REPOSITORY traversaro/manif.git)
set_tag(manif_TAG patch-8)
set_tag(CppAD_TAG 20250000.2)
set_tag(proxsuite_TAG v0.7.2)
set_tag(casadi_REPOSITORY ami-iit/casadi.git)
set_tag(casadi_TAG 3.7_osqpv1_support)
set_tag(casadi-matlab-bindings_TAG v3.7.0.0)
# Workaround for https://github.com/robotology/robotology-superbuild/issues/1890
set_tag(pyngrok_TAG 7.2.12)

# Robotology projects
set_tag(YCM_TAG master)
set_tag(YARP_TAG yarp-3.12)
set_tag(yarp-matlab-bindings_TAG yarp-3.12)
set_tag(yarp-devices-ros2_TAG v2.0.0)
set_tag(gym-ignition_TAG v1.3.1)
