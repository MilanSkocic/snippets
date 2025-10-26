cmake_minimum_required(VERSION 3.10)
project(progcmake VERSION 1.0 LANGUAGES C)

set(CMAKE_INSTALL_PREFIX /home/milan/.local)

set(OUTPUT_DIR )

if(UNIX)
	set(OUTPUT_DIR unix)
elseif(WIN32)
	set(OUTPUT_DIR windows)
endif()

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${OUTPUT_DIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${OUTPUT_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${OUTPUT_DIR})
set(LIB_DIRS ${CMAKE_BINARY_DIR}/${OUTPUT_DIR})

add_subdirectory(src)
add_subdirectory(examples)
add_subdirectory(tests)

enable_testing()
add_test(NAME runtests COMMAND runtests) 


install(TARGETS static_example PUBLIC_HEADER DESTINATION include ARCHIVE DESTINATION lib)

install(TARGETS shared_example PUBLIC_HEADER DESTINATION include LIBRARY DESTINATION lib)
