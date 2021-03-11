macro(set_tag tag_name tag_value)
    if(NOT ${tag_name})
        set(${tag_name} ${tag_value})
    endif()
endmacro()

# External projects
set_tag(osqp_TAG v0.6.2)
set_tag(manif_TAG 0.0.3)
set_tag(qhull_TAG v8.0.2)
set_tag(CppAD_TAG 20210000.4)
set_tag(casadi 3.5.5.2)

# Robotology projects
set_tag(YCM_TAG ycm-0.12)
set_tag(YARP_TAG yarp-3.4)
set_tag(yarp-matlab-bindings_TAG yarp-3.4)

# Temporary workaround for Ubuntu 18.04 spdlog problems
set_tag(bipedal-locomotion-framework_TAG 5b76dc40b0f9e825e29f8de5e100240b9f7d640c)
