macro(set_tag tag_name tag_value)
    if(NOT ${tag_name})
        set(${tag_name} ${tag_value})
    endif()
endmacro()

# External projects
set_tag(osqp_TAG v1.0.0)
set_tag(manif_TAG 0.0.5)
set_tag(CppAD_TAG 20250000.2)
set_tag(proxsuite_TAG v0.7.1)
set_tag(casadi_REPOSITORY ami-iit/casadi.git)
set_tag(casadi_TAG 3.7.0.1)
set_tag(casadi-matlab-bindings_TAG v3.7.0.0)

# Robotology projects
set_tag(YCM_TAG master)
set_tag(YARP_TAG yarp-3.11)
set_tag(yarp-devices-ros2_TAG v1.1.0)
set_tag(yarp-matlab-bindings_TAG yarp-3.11)
set_tag(gym-ignition_TAG v1.3.1)
