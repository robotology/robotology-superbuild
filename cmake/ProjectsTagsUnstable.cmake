macro(set_tag tag_name tag_value)
    if(NOT ${tag_name})
        set(${tag_name} ${tag_value})
    endif()
endmacro()

# External projects
set_tag(osqp_TAG v0.6.0)

# Robotology projects
# Custom commits are a workaround for https://github.com/robotology/robotology-superbuild/issues/372
set_tag(YARP_TAG master)
set_tag(ICUB_TAG 4839050fde87ddbf3572b98d608f74097aacbfd6)
set_tag(RobotTestingFramework_TAG devel)
set_tag(WBToolbox_TAG devel)
set_tag(BlockFactory_TAG devel)
set_tag(icub-tests_TAG devel)
set_tag(iDynTree_TAG devel)
set_tag(icub-firmware-shared_TAG 41bf5c1db3aa83808c401f608932373fcbba944d)
set_tag(yarp-matlab-bindings_TAG master)
set_tag(GazeboYARPPlugins_TAG devel)
set_tag(robots-configuration_TAG devel)
set_tag(icub-models_TAG devel)
set_tag(icub-gazebo_TAG devel)
set_tag(icub-gazebo-wholebody_TAG devel)
set_tag(whole-body-controllers_TAG master)
set_tag(OsqpEigen_TAG devel) 
