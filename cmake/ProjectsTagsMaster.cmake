macro(set_tag tag_name tag_value)
    if(NOT ${tag_name})
        set(${tag_name} ${tag_value})
    endif()
endmacro()

set_tag(RTF_TAG d06f411e8c976018c62f520577a03085a4c300bf)
set_tag(WBToolbox_TAG e7998ffc391f876a991bcd20f9d0eaf4266827f9)
