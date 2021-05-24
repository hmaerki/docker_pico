cmake_minimum_required(VERSION 3.12)
include(pico_sdk_import.cmake)
project(pico_lcd1in14)
pico_sdk_init()

add_subdirectory(lib/Config)
add_subdirectory(lib/LCD)
add_subdirectory(lib/Fonts)
add_subdirectory(lib/GUI)

include_directories(./lib/Config)
include_directories(./lib/GUI)
include_directories(./lib/LCD)

# aux_source_directory(. DIR_examples_SRCS)

add_executable(pico_lcd1in14 
LCD_1in14_test.c
ImageData.c
)

# enable usb output, disable uart output
pico_enable_stdio_usb(pico_lcd1in14 1)
pico_enable_stdio_uart(pico_lcd1in14 1)

# create map/bin/hex/uf2 file etc.
pico_add_extra_outputs(pico_lcd1in14)

# add_library(examples ${DIR_examples_SRCS})
target_link_libraries(pico_lcd1in14 LCD GUI Fonts Config pico_stdlib hardware_spi)
