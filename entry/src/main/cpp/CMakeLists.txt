# the minimum version of CMake.
cmake_minimum_required(VERSION 3.5.0)
project(CraftingLauncher)

# 设置根目录
set(NATIVERENDER_ROOT_PATH ${CMAKE_CURRENT_SOURCE_DIR})

# 如果有定义PACKAGE_FIND_FILE，进行相应的包含
if(DEFINED PACKAGE_FIND_FILE)
    include(${PACKAGE_FIND_FILE})
endif()

# 包含头文件目录
include_directories(${NATIVERENDER_ROOT_PATH}
                    ${NATIVERENDER_ROOT_PATH}/include)

# 添加 JNI 头文件路径
find_package(JNI REQUIRED)
include_directories(${JNI_INCLUDE_DIRS})

# 定义要编译的C++文件
add_library(entry SHARED napi_init.cpp)  # NAPI相关代码
add_library(nativeService SHARED NativeService.cpp)  # JNI接口相关代码

# 链接NAPI库
target_link_libraries(entry PUBLIC libace_napi.z.so)

# 链接JNI库
target_link_libraries(nativeService ${JNI_LIBRARIES})
