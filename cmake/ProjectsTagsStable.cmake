macro(set_tag tag_name tag_value)
    if(NOT ${tag_name})
        set(${tag_name} ${tag_value})
    endif()
endmacro()

# External projects
set_tag(osqp_TAG v0.6.2)
set_tag(manif_REPOSITORY robotology-dependencies/manif.git)
set_tag(manif_TAG 0.0.4.1)
set_tag(qhull_TAG 2020.2)
set_tag(CppAD_TAG 20220000.4)
set_tag(casadi 3.5.5.3)

# Robotology projects
set_tag(YCM_TAG ycm-0.14)
set_tag(YARP_TAG yarp-3.7)
set_tag(yarp-matlab-bindings_TAG yarp-3.7)
set_tag(gym-ignition_TAG v1.3.1)
set_tag(YARP_telemetry_TAG v0.5.1)
set_tag(robometry_TAG v1.0.0)
