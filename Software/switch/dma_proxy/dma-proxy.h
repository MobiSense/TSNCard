#ifndef DMA_PROXY_H
#define DMA_PROXY_H
/**
 * Copyright (C) 2021 Xilinx, Inc
 *
 * Licensed under the Apache License, Version 2.0 (the "License"). You may
 * not use this file except in compliance with the License. A copy of the
 * License is located at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations
 * under the License.
 */
/* This header file is shared between the DMA Proxy test application and the DMA
 * Proxy device driver. It defines the shared interface to allow DMA transfers
 * to be done from user space.
 *
 * A set of channel buffers are created by the driver for the transmit and
 * receive channel. The application may choose to use only a subset of the
 * channel buffers to allow prioritization of transmit vs receive.
 *
 * Note: the buffer in the data structure should be 1st in the channel interface
 * so that the buffer is cached aligned, otherwise there may be issues when
 * using cached memory.
 */
#include <pthread.h>

#include "buffer_queue.h"

#ifdef __cplusplus
extern "C" {
#endif

#define BUFFER_SIZE (128 * 1024) /* must match driver exactly */
#define BUFFER_COUNT 32          /* driver only */

#define TX_BUFFER_COUNT                                   \
    1 /* app only, must be <= to the number in the driver \
       */
#define RX_BUFFER_COUNT                                   \
    1 /* app only, must be <= to the number in the driver \
       */
#define BUFFER_INCREMENT                                                     \
    1 /* normally 1, but skipping buffers (2) defeats prefetching in the CPU \
       */

#define FINISH_XFER _IOW('a', 'a', int32_t *)
#define START_XFER _IOW('a', 'b', int32_t *)
#define XFER _IOR('a', 'c', int32_t *)
#define POLL_XFER _IOR('a', 'd', int32_t *)

uint16_t swapByteOrder16(uint16_t value);
uint32_t swapByteOrder(uint32_t value);
uint64_t swapByteOrder64(uint64_t value);

struct channel_buffer {
    unsigned int buffer[BUFFER_SIZE / sizeof(unsigned int)];
    enum proxy_status {
        PROXY_NO_ERROR = 0,
        PROXY_BUSY = 1,
        PROXY_TIMEOUT = 2,
        PROXY_ERROR = 3
    } status;
    unsigned int length;
} __attribute__((aligned(1024))); /* 64 byte alignment required for DMA, but
                                     1024 handy for viewing memory */

// TSN-perf packet header
typedef struct perf_packet {
#ifndef ETHER_ADDR_LEN
#define ETHER_ADDR_LEN 6
#endif
    uint64_t rx_timestamp; /* timestamp when packet is sent before PHY */
    uint64_t tx_timestamp; /* timestamp when packet is received after PHY */
    uint8_t ether_dhost[ETHER_ADDR_LEN]; /* destination ethernet address */
    uint8_t ether_shost[ETHER_ADDR_LEN]; /* source ethernet address */
    uint16_t TPID;                       /* 0x8100 */
    uint16_t
        vlan_header; /* vlan header: PCP(3 bits), CFI (1 bits), VID (12 bits) */
    uint16_t ether_type; /* 0x66ab */
} __attribute__((packed)) perf_packet;

// int TestDMAProxy(int num_transfer_, int test_size_, int verify_);

/**
 * @brief mutex to lock pkt queue
 *
 */
pthread_mutex_t pkt_queue_lock;

/**
 * @brief Initialize DMA tx/rx channel
 *
 * @return int
 */
int axi_dma_init();

/**
 * @brief send a buffer to DMA
 *
 * @param buffer
 * @param length
 */
void DMA_send(uint8_t *buffer, int length);

/**
 * @brief Thread that non-stoply receive DMA transfer
 * If the packet is PTP, push it to buffer_queue
 * if the packet is Critical, print its information
 * Otherwise, drop the packet
 *
 * @return void*
 */
void *DMA_rx_thread(buffer_queue *queue);

#ifdef __cplusplus
}
#endif

#endif
