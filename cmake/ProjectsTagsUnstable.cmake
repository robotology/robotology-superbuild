macro(set_tag tag_name tag_value)
    if(NOT ${tag_name})
        set(${tag_name} ${tag_value})
    endif()
endmacro()

# External projects
set_tag(osqp_TAG v0.6.2)
set_tag(manif_REPOSITORY robotology-dependencies/manif.git)
set_tag(manif_TAG 0.0.4.1)
set_tag(qhull_TAG v8.0.2)
set_tag(CppAD_TAG 20210000.4)
set_tag(casadi 3.5.5.3)

# Robotology projects
# Workaround for https://github.com/robotology/robotology-superbuild/issues/900, 
# use the commit before https://github.com/robotology/yarp/pull/2709
set_tag(YARP_TAG 87359fee44d34bb523974ebb90bd876a6e1889eb)
set_tag(ICUB_TAG devel)
set_tag(RobotTestingFramework_TAG devel)
set_tag(blockTest_TAG devel)
set_tag(WBToolbox_TAG devel)
set_tag(BlockFactory_TAG devel)
set_tag(icub-tests_TAG devel)
set_tag(iDynTree_TAG devel)
set_tag(icub_firmware_shared_TAG devel)
set_tag(yarp-matlab-bindings_TAG master)
set_tag(GazeboYARPPlugins_TAG devel)
set_tag(robots-configuration_TAG devel)
set_tag(icub-models_TAG devel)
set_tag(icub-gazebo_TAG devel)
set_tag(icub-gazebo-wholebody_TAG devel)
set_tag(whole-body-controllers_TAG master)
set_tag(OsqpEigen_TAG master)
set_tag(YARP_telemetry_TAG master)
set_tag(gym-ignition_TAG v1.2.2)
set_tag(walking-teleoperation_TAG devel)
# Workaround for https://github.com/robotology/robotology-superbuild/issues/900
# and https://github.com/robotology/wearables/issues/132
set_tag(wearables_TAG 0ba0bfc5c3e84afd1ebaa14811aad5d55e8a70a9)
