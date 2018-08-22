macro(set_tag tag_name tag_value)
    if(NOT ${tag_name})
        set(${tag_name} ${tag_value})
    endif()
endmacro()

set_tag(RTF_TAG d06f411e8c976018c62f520577a03085a4c300bf)
