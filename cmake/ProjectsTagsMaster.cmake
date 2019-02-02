macro(set_tag tag_name tag_value)
    if(NOT ${tag_name})
        set(${tag_name} ${tag_value})
    endif()
endmacro()

set_tag(WBToolbox_TAG 368119e32955e8eed5626ddc871bba76f4cd28c1)
