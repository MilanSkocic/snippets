add_library(static_example STATIC src1.c utilities.c)
set_target_properties(static_example PROPERTIES OUTPUT_NAME example)

add_library(shared_example SHARED src1.c utilities.c)
set_target_properties(shared_example PROPERTIES OUTPUT_NAME example)



target_include_directories(static_example PUBLIC ${CMAKE_SOURCE_DIR}/src)
target_link_libraries(static_example PRIVATE m)

target_include_directories(shared_example PUBLIC ${CMAKE_SOURCE_DIR}/src)
target_link_libraries(shared_example PRIVATE m)



set_target_properties(static_example PROPERTIES PUBLIC_HEADER ${CMAKE_SOURCE_DIR}/src/electrox.h)

set_target_properties(shared_example PROPERTIES PUBLIC_HEADER ${CMAKE_SOURCE_DIR}/src/electrox.h)
