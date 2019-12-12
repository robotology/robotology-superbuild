macro(set_tag tag_name tag_value)
    if(NOT ${tag_name})
        set(${tag_name} ${tag_value})
    endif()
endmacro()

# Core profile 
set_tag(YARP_TAG v3.3.0)
set_tag(ICUB_TAG v1.14.0)
set_tag(ICUBcontrib_TAG v1.14.0)
set_tag(icub-models_TAG v1.14.0)
set_tag(robots-configuration_TAG v1.14.0)
set_tag(GazeboYARPPlugins_TAG v3.3.0)
set_tag(icub-gazebo_TAG v1.14.0)
set_tag(yarp-matlab-bindings_TAG v3.2.0)

# Robot Testing 
set_tag(RobotTestingFramework_TAG v2.0.0)
set_tag(icub-tests_TAG v1.14.0)

# Dynamics 
set_tag(iDynTree_TAG v0.11.2)
set_tag(codyco-modules_TAG v0.3.0)
set_tag(qpOASES_TAG 38ca942a04e66e8c7f7c4388bd6b32e312705a29)
set_tag(BlockFactory_TAG v0.8)
set_tag(WBToolbox_TAG v5)
set_tag(osqp_REPOSITORY robotology-dependencies/osqp.git)
set_tag(osqp_TAG 5798d55e9361494f822c63f1b35588ce73564f88)
set_tag(OsqpEigen_TAG v0.4.1)
set_tag(UnicyclePlanner_TAG d0b9df00766a6fe5ba3949087fb0100b092645de)
set_tag(walking-controllers_TAG v0.2.0)
set_tag(icub-gazebo-wholebody_TAG 007aadad6c400ac1bff215009d94a9e6f1b34e9d)
set_tag(whole-body-controllers_TAG v2.0)

# Teleoperation
set_tag(walking-teleoperation_TAG 60b449e6e8d5120a2a11ca2997521f46c51821c1)

# Human Dynamics 
# TODO as currently is broken w.r.t. YARP 3.3, see 
# https://github.com/robotology/robotology-superbuild/issues/313

# iCub Head
set_tag(icub-firmware-shared_TAG v1.14.0)
set_tag(xsensmt-yarp-driver_TAG 590d7efae137686ea3b942f7babcae762eb7061d)
