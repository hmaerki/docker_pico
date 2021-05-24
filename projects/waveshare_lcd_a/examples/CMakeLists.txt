aux_source_directory(. DIR_examples_SRCS)

include_directories(../lib/Config)
include_directories(../lib/GUI)
include_directories(../lib/LCD)

add_library(examples ${DIR_examples_SRCS})
target_link_libraries(examples PUBLIC Config LCD)