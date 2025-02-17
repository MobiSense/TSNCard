cmake_minimum_required(VERSION 3.0.0)
project(time_sync_app VERSION 0.1.0)

# SET(CMAKE_BUILD_TYPE Debug)
IF(NOT CMAKE_BUILD_TYPE)
  SET(CMAKE_BUILD_TYPE Release)
ENDIF()

MESSAGE("Build type: " ${CMAKE_BUILD_TYPE})

set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -O0 -Wall -lpthread -lm -Wno-psabi -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-function -Wno-switch -march=native -DLOG_USE_COLOR -Wno-builtin-macro-redefined -D'__FILE__=\"$(subst $(realpath ${CMAKE_SOURCE_DIR})/,,$(abspath $<))\"'")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -O0 -Wall -lpthread -lm -Wno-psabi -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-function -Wno-switch -march=native -DLOG_USE_COLOR -Wno-builtin-macro-redefined -D'__FILE__=\"$(subst $(realpath ${CMAKE_SOURCE_DIR})/,,$(abspath $<))\"'" )

set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -O0 -g3 -Wall -lpthread -lm -Wno-psabi -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-function -Wno-switch -march=native -DLOG_USE_COLOR -Wno-builtin-macro-redefined -D'__FILE__=\"$(subst $(realpath ${CMAKE_SOURCE_DIR})/,,$(abspath $<))\"'")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -O0 -g3 -Wall -lpthread -lm -Wno-psabi -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-function -Wno-switch -march=native -DLOG_USE_COLOR -Wno-builtin-macro-redefined -D'__FILE__=\"$(subst $(realpath ${CMAKE_SOURCE_DIR})/,,$(abspath $<))\"'")

set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 11)

include_directories("${PROJECT_SOURCE_DIR}/dma_proxy" 
"${PROJECT_SOURCE_DIR}/time_sync"
"${PROJECT_SOURCE_DIR}/log"
"${PROJECT_SOURCE_DIR}/tsn_drivers"
)

add_library(${PROJECT_NAME} SHARED
dma_proxy/buffer_queue.c
dma_proxy/dma-proxy.c
tsn_drivers/gpio_reset.c
time_sync/clock_master_sync_receive_sm.c
time_sync/clock_master_sync_send_sm.c
time_sync/clock_slave_sync_sm.c
time_sync/eth_frame.c
time_sync/md_pdelay_req_sm.c
time_sync/md_pdelay_resp_sm.c
time_sync/md_sync_receive_sm.c
time_sync/md_sync_send_sm.c
time_sync/msg_frame.c
time_sync/port_sync_sync_receive_sm.c
time_sync/port_sync_sync_send_sm.c
time_sync/port_announce_information_ext_sm.c
time_sync/port_announce_transmit_sm.c
time_sync/port_announce_information_sm.c
time_sync/port_state_selection_sm.c
tsn_drivers/ptp_types.c
time_sync/site_sync_sync_sm.c
tsn_drivers/tagger.c
tsn_drivers/gcl.c
tsn_drivers/switch_rules.c
tsn_drivers/tsu.c
tsn_drivers/rtc.c
tsn_drivers/uio.c
log/log.c
config.c
topo.cpp
)

add_executable(time_sync time_sync_main_loop.c)
target_link_libraries(time_sync ${PROJECT_NAME})

add_executable(switch_config switch_config_main.c)
target_link_libraries(switch_config ${PROJECT_NAME})
