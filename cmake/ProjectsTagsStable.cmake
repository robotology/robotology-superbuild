macro(set_tag tag_name tag_value)
    if(NOT ${tag_name})
        set(${tag_name} ${tag_value})
    endif()
endmacro()

# External projects
set_tag(osqp_TAG v0.6.0)

# Robotology projects
set(YARP_TAG yarp-3.3)
set(yarp-matlab-bindings_TAG yarp-3.3)
