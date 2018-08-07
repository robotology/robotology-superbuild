macro(set_tag tag_name tag_value)
    if(NOT ${tag_name})
        set(${tag_name} ${tag_value})
    endif()
endmacro()

set_tag(RTF_TAG d06f411e8c976018c62f520577a03085a4c300bf)
set_tag(WBToolbox_TAG 0ff5ca4aecc607e1f1901abffe3b7c960a4e6b11)
