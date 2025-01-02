# the minimum version of CMake.
cmake_minimum_required(VERSION 3.5.0)
project(marsxlog)

set(NATIVERENDER_ROOT_PATH ${CMAKE_CURRENT_SOURCE_DIR})
set(NAPI_MARS_PATH ${CMAKE_SOURCE_DIR}/mars)

include_directories(${NAPI_MARS_PATH}/openssl/include)

add_subdirectory(${NAPI_MARS_PATH}/comm comm)
add_subdirectory(${NAPI_MARS_PATH}/boot boot)
add_subdirectory(${NAPI_MARS_PATH}/boost boost)
add_subdirectory(${NAPI_MARS_PATH}/app app)
add_subdirectory(${NAPI_MARS_PATH}/baseevent baseevent)
add_subdirectory(${NAPI_MARS_PATH}/xlog xlog)
add_subdirectory(${NAPI_MARS_PATH}/sdt sdt)
add_subdirectory(${NAPI_MARS_PATH}/stn stn)

# for zstd
option(ZSTD_BUILD_STATIC "BUILD STATIC LIBRARIES" ON)
option(ZSTD_BUILD_SHARED "BUILD SHARED LIBRARIES" OFF)
set(ZSTD_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/mars/zstd")
set(LIBRARY_DIR ${ZSTD_SOURCE_DIR}/lib)
include(GNUInstallDirs)
add_subdirectory(${NAPI_MARS_PATH}/zstd/build/cmake/lib zstd)

include(${NAPI_MARS_PATH}/comm/utils.cmake)

if(DEFINED PACKAGE_FIND_FILE)
    include(${PACKAGE_FIND_FILE})
endif()

if(NATIVE_CALLBACK)
    message("common native callback")
    add_definitions(-DNATIVE_CALLBACK)
endif()

link_directories(app baseevent xlog sdt stn comm boost zstd)

# marsxlog
set(SELF_LIB_NAME marsxlog)
file(GLOB SELF_SRC_FILES ${NAPI_MARS_PATH}/libraries/mars_ohos_xlog_sdk/napi/import.cc)
add_library(${SELF_LIB_NAME} SHARED ${SELF_SRC_FILES})
install(TARGETS ${SELF_LIB_NAME} LIBRARY DESTINATION ${SELF_LIBS_OUT} ARCHIVE DESTINATION ${SELF_LIBS_OUT})
get_filename_component(EXPORT_XLOG_EXP_FILE ${NAPI_MARS_PATH}/libraries/mars_ohos_xlog_sdk/napi/export.exp ABSOLUTE)
set(SELF_XLOG_LINKER_FLAG "-Wl,--gc-sections -Wl,--version-script='${EXPORT_XLOG_EXP_FILE}'")
target_link_libraries(${SELF_LIB_NAME} "${SELF_XLOG_LINKER_FLAG}"
        xlog
        mars-boost
        comm
        libzstd_static
        libace_napi.z.so
        libhilog_ndk.z.so
        libz.so)