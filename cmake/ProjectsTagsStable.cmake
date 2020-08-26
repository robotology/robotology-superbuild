macro(set_tag tag_name tag_value)
    if(NOT ${tag_name})
        set(${tag_name} ${tag_value})
    endif()
endmacro()

# External projects
set_tag(osqp_TAG v0.6.0)

# Robotology projects
set_tag(YCM_TAG ycm-0.11)
set_tag(YARP_TAG yarp-3.4)
set_tag(yarp-matlab-bindings_TAG yarp-3.4)
set_tag(icub_firmware_shared_TAG devel)
set_tag(GazeboYARPPlugins_TAG devel)
