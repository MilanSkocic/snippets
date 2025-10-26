link_directories(${LIB_DIRS})

add_executable(example1 example1.c)
target_include_directories(example1 PUBLIC ${CMAKE_SOURCE_DIR}/src)
target_link_libraries(example1 example)
