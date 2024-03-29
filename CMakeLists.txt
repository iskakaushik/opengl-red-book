cmake_minimum_required(VERSION 3.15)

project(opengl_demo CXX)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_WARN_DEPRECATED false)

find_package(fmt REQUIRED)
find_package(cxxopts REQUIRED)
find_package(spdlog REQUIRED)

find_package(glfw3 REQUIRED)
find_package(glad REQUIRED)

add_executable(opengl_demo src/main.cpp src/shaders.h src/shaders.cpp)
target_compile_features(opengl_demo PRIVATE cxx_std_17)

target_link_libraries(opengl_demo
  PRIVATE

  # general
  fmt::fmt
  cxxopts::cxxopts
  spdlog::spdlog

  # GL
  glfw
  glad::glad
)
