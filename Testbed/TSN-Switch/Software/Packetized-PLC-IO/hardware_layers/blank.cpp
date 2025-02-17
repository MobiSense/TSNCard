//-----------------------------------------------------------------------------
// Copyright 2015 Thiago Alves
//
// Based on the LDmicro software by Jonathan Westhues
// This file is part of the OpenPLC Software Stack.
//
// OpenPLC is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// OpenPLC is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with OpenPLC.  If not, see <http://www.gnu.org/licenses/>.
//------
//
// This file is the hardware layer for the OpenPLC. If you change the platform
// where it is running, you may only need to change this file. All the I/O
// related stuff is here. Basically it provides functions to read and write
// to the OpenPLC internal buffers in order to update I/O state.
// Thiago Alves, Dec 2015
//-----------------------------------------------------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <fcntl.h>
#include "ladder.h"
#include "custom_layer.h"
#include <sys/mman.h>
#include <sys/ioctl.h>
#include <sys/param.h>
#include "string.h"
#include <time.h>
#include <sys/time.h>
#include <stdint.h>
#include <signal.h>
#include <sched.h>
#include <errno.h>
#include <inttypes.h>
#include <algorithm>
#include <string>
#include <iostream>
#include <vector>
#include <map>

#include "dma-proxy-plc.h"
#include "tsn_drivers/gpio_reset.h"
#include "tsn_drivers/rtc.h"
#include "tsn_drivers/ptp_types.h"
#include "config.h"

/* ----------------------- CONFIG begin ----------------------------- */

/* output more info */
#define DEBUG_ENABLE 0

/* Packet header structure (42 bytes):
 * destination ethernet address                          - 6 bytes
 * source ethernet address                               - 6 bytes
 * TPID                                                  - 2 bytes
 * vlan header: PCP(3 bits), CFI (1 bits), VID (12 bits) - 2 bytes
 * ether_length                                          - 2 bytes
 * unused                                                - 2 bytes
 * tx_timestamp                                          - 8 bytes
 * rx_timestamp                                          - 8 bytes
 * seq_id                                                - 2 bytes  
 * pkt_id                                                - 4 bytes
 */
#define PACKET_HEADER_SIZE  42 

/* 在正经的 critical content 之后，buf[42:59] 所有 byte 的值应该从 0x12 依次递减到 0x01
*/
#define PACKET_PAYLOAD_SIZE 18 /* 0x12, 0x11,..., 0x01 */

/* ----------------------- CONFIG  end  ----------------------------- */

#define PROXY_NO_ERROR 0
#define PROXY_BUSY 1
#define PROXY_TIMEOUT 2
#define PROXY_ERROR 3

/* The user must tune the application number of channels to match the proxy driver device tree
 * and the names of each channel must match the dma-names in the device tree for the proxy
 * driver node. The number of channels can be less than the number of names as the other
 * channels will just not be used in testing.
 */
#define TX_CHANNEL_COUNT 1
#define RX_CHANNEL_COUNT 1

const char *tx_channel_names_[] = {"dma_proxy_tx_plc", /* add unique channel names here */};
const char *rx_channel_names_[] = {"dma_proxy_rx_plc", /* add unique channel names here */};

#define MAX_INPUT 1
#define MAX_OUTPUT 1
#define MAX_ANALOG_OUT 1

struct channel
{
	struct channel_buffer *buf_ptr;
	int fd;
	pthread_t tid;
};
static uint32_t tx_idx;
struct channel tx_channels[TX_CHANNEL_COUNT], rx_channels[RX_CHANNEL_COUNT];
uint32_t out_pkt_id;

uint64_t *input_timestamp;
uint32_t *input_pkt_id;

std::map<int, int> seqid_index;

UScaledNs next_compute_ts;

int dropped = 0;

uint64_t send_timestamp; 
uint32_t send_pkt_id;

void print_formatted_bytes(uint8_t *RxBufferPtr, int output_size) {
	 for(int i = 0; i < output_size; i++) {
	 	if (i%8 == 0 && i!=0) {
	 		printf("\n");
	 	}
		char tmp[10];
		sprintf(tmp, "%02x\t", RxBufferPtr[i]);
	 	printf(tmp);
	 }
	 printf("\n");
}
void dma_init()
{
	int i;
	/* Open the file descriptors for each tx channel and map the kernel driver memory into user space */
	for (i = 0; i < TX_CHANNEL_COUNT; i++)
	{
		char channel_name[64] = "/dev/";
		strcat(channel_name, tx_channel_names_[i]);
		tx_channels[i].fd = open(channel_name, O_RDWR);
		if (tx_channels[i].fd < 1)
		{
			log("Unable to open DMA proxy device file \r");
			exit(EXIT_FAILURE);
		}
		tx_channels[i].buf_ptr = (struct channel_buffer *)mmap(NULL, sizeof(struct channel_buffer) * TX_BUFFER_COUNT,
															   PROT_READ | PROT_WRITE, MAP_SHARED, tx_channels[i].fd, 0);
		if (tx_channels[i].buf_ptr == MAP_FAILED)
		{
			log("Failed to mmap tx channel\n");
			exit(EXIT_FAILURE);
		}
	}

	/* Open the file descriptors for each rx channel and map the kernel driver memory into user space */
	for (i = 0; i < RX_CHANNEL_COUNT; i++)
	{
		char channel_name[64] = "/dev/";
		strcat(channel_name, rx_channel_names_[i]);
		rx_channels[i].fd = open(channel_name, O_RDWR);
		if (rx_channels[i].fd < 1)
		{
			log("Unable to open DMA proxy device file\r");
			exit(EXIT_FAILURE);
		}
		rx_channels[i].buf_ptr = (struct channel_buffer *)mmap(NULL, sizeof(struct channel_buffer) * RX_BUFFER_COUNT,
															   PROT_READ | PROT_WRITE, MAP_SHARED, rx_channels[i].fd, 0);
		if (rx_channels[i].buf_ptr == MAP_FAILED)
		{
			log("Failed to mmap rx channel\n");
			exit(EXIT_FAILURE);
		}
	}

}

void sendFrame(uint32_t seq_id, uint64_t send_timestamp, uint32_t send_pkt_id, char *src_mac_addr, char *dst_mac_addr)
{
	int i, counter = 0, buffer_id, in_progress_count = 0;
	int stop_in_progress = 0;

	// Start all buffers being sent
    uint8_t *vp;

	for (buffer_id = 0; buffer_id < TX_BUFFER_COUNT; buffer_id += BUFFER_INCREMENT)
	{

		/* Set up the length for the DMA transfer and initialize the transmit
		 * buffer to a known pattern.
		 */
        int origin_frame_length = PACKET_HEADER_SIZE + PACKET_PAYLOAD_SIZE; 
		tx_channels[0].buf_ptr[buffer_id].length = origin_frame_length;

		uint8_t BufferPtr[origin_frame_length];
		/* destination ethernet address */
		BufferPtr[0] = dst_mac_addr[0];
		BufferPtr[1] = dst_mac_addr[1];
		BufferPtr[2] = dst_mac_addr[2];
		BufferPtr[3] = dst_mac_addr[3];
		BufferPtr[4] = dst_mac_addr[4];
		BufferPtr[5] = dst_mac_addr[5];
		/* source ethernet address */
		BufferPtr[6]  = src_mac_addr[0];
		BufferPtr[7]  = src_mac_addr[1];
		BufferPtr[8]  = src_mac_addr[2];
		BufferPtr[9]  = src_mac_addr[3];
		BufferPtr[10] = src_mac_addr[4];
		BufferPtr[11] = src_mac_addr[5];
		/* 0x8100 */
		BufferPtr[12] = 0x81;
		BufferPtr[13] = 0x00;
		/* vlan header: PCP(3 bits), CFI (1 bits), VID (12 bits) */
		BufferPtr[14] = 0x20; // PCP = 1, CFI = 0, 0b0010_0000 -> 0x20, outout's flow's priority is all set to 1.
		BufferPtr[15] = 0x00;
		/* ether length */
		BufferPtr[16] = 0x00;
		BufferPtr[17] = 0x2A;
		/* unused */
		BufferPtr[18] = 0x00;
		BufferPtr[19] = 0x00;
		/* timestamp when packet is sent before PHY */
		vp = (uint8_t *)&send_timestamp;
		BufferPtr[20] = vp[7];
		BufferPtr[21] = vp[6];
		BufferPtr[22] = vp[5];
		BufferPtr[23] = vp[4];
		BufferPtr[24] = vp[3];
		BufferPtr[25] = vp[2];
		BufferPtr[26] = vp[1];
		BufferPtr[27] = vp[0];
		/* timestamp when packet is received after PHY */
		BufferPtr[28] = 0;
		BufferPtr[29] = 0;
		BufferPtr[30] = 0;
		BufferPtr[31] = 0;
		BufferPtr[32] = 0;
		BufferPtr[33] = 0;
		BufferPtr[34] = 0;
		BufferPtr[35] = 0;
		/* sequence id for this data stream traffic */
		vp = (uint8_t *)&seq_id;
		BufferPtr[36] = vp[1];
		BufferPtr[37] = vp[0];
		/* packet id for this packet in the seq_id data stream */
   		vp = (uint8_t *)&send_pkt_id;
		BufferPtr[38] = vp[3];
		BufferPtr[39] = vp[2];
		BufferPtr[40] = vp[1];
		BufferPtr[41] = vp[0];
		/* rest: 0x12, 0x11,..., 0x01 */
		for (i = PACKET_HEADER_SIZE; i < origin_frame_length; i++)
			BufferPtr[i] = origin_frame_length - i;
        // print_formatted_bytes(BufferPtr, 60);
        
		if (DEBUG_ENABLE) {
			printf("-->TX: seq_id: 0x%04x, pkt_id: %" PRIu32 ", timestamp: %" PRIu64 "\n", (unsigned long)seq_id, send_pkt_id, send_timestamp);
		}

		memcpy(tx_channels[0].buf_ptr[buffer_id].buffer, BufferPtr, origin_frame_length);

		ioctl(tx_channels[0].fd, XFER, &buffer_id);
		if (tx_channels[0].buf_ptr[buffer_id].status != PROXY_NO_ERROR)
		{
			printf("tx_thread fail.\r\n");
		}
		else
		{
			// printf("tx_thread success. out_pkt_id = %d\r\n", out_pkt_id);
			out_pkt_id += 1;
		}
	}
}

//-----------------------------------------------------------------------------
// This function is called by the main OpenPLC routine when it is initializing.
// Hardware initialization procedures should be here.
//-----------------------------------------------------------------------------
void initializeHardware()
{
    init_configure();
    input_timestamp = (uint64_t*)malloc(INPUT_STREAM_NUM*sizeof(uint64_t));
    input_pkt_id = (uint32_t*)malloc(INPUT_STREAM_NUM*sizeof(uint32_t));
    out_pkt_id = 0;
	for (int i = 0; i < INPUT_STREAM_NUM; i++) {
		input_timestamp[i] = 0;
	}
	dma_init();
    /* init seq_id_index dict */
    for (int i = 0; i < INPUT_STREAM_NUM; i++) {
        seqid_index[input_seq_ids[i]] = i;
    }
    // reset_PL_by_GPIO("960");
}

//-----------------------------------------------------------------------------
// This function is called by the main OpenPLC routine when it is finalizing.
// Resource clearing procedures should be here.
//-----------------------------------------------------------------------------
void finalizeHardware()
{
	free(input_timestamp);
	free(input_pkt_id);
}

//-----------------------------------------------------------------------------
// This function is called by the OpenPLC in a loop. Here the internal buffers
// must be updated to reflect the actual Input state. The mutex bufferLock
// must be used to protect access to the buffers on a threaded environment.
//-----------------------------------------------------------------------------
void updateBuffersIn()
{
	pthread_mutex_lock(&bufferLock); //lock mutex

	/*********READING AND WRITING TO I/O**************

	*bool_input[0][0] = read_digital_input(0);
	write_digital_output(0, *bool_output[0][0]);

	*int_input[0] = read_analog_input(0);
	write_analog_output(0, *int_output[0]);

	**************************************************/
	//INPUT
	for (int i = 0; i < MAX_INPUT; i++)
	{
		if (bool_input[i / 8][i % 8] != NULL)
		{
			int value;
            int count = 0;
            while (1) {
                // wait for packet
                // dma rx
                int in_progress_count = 0, buffer_id = 0;
                int rx_counter = 0;
                rx_channels[0].buf_ptr[buffer_id].length = PACKET_HEADER_SIZE + PACKET_PAYLOAD_SIZE + 2000; // make buffer a little more
                // Poll the status of current RX transfer
                ioctl(rx_channels[0].fd, START_XFER, &buffer_id);
                ioctl(rx_channels[0].fd, FINISH_XFER, &buffer_id);
                if (rx_channels[0].buf_ptr[buffer_id].status == PROXY_NO_ERROR)
                {
                    value = 1;
                    uint8_t *RxBufferPtr;
                    RxBufferPtr = (uint8_t *)rx_channels[0].buf_ptr[buffer_id].buffer;
                    uint16_t seq_id = ((uint64_t)(RxBufferPtr[36]) << 8) |
                                    ((uint64_t)(RxBufferPtr[37]) << 0);
                    uint32_t pkt_id = ((uint64_t)(RxBufferPtr[38]) << 24) | 
                                    ((uint64_t)(RxBufferPtr[39]) << 16) |
                                    ((uint64_t)(RxBufferPtr[40]) <<  8) |
                                    ((uint64_t)(RxBufferPtr[41]) <<  0);
                    
                    uint64_t tx_timestamp = ((uint64_t)(RxBufferPtr[20]) << 56) | 
                                            ((uint64_t)(RxBufferPtr[21]) << 48) |
                                            ((uint64_t)(RxBufferPtr[22]) << 40) |
                                            ((uint64_t)(RxBufferPtr[23]) << 32) |
                                            ((uint64_t)(RxBufferPtr[24]) << 24) |
                                            ((uint64_t)(RxBufferPtr[25]) << 16) |
                                            ((uint64_t)(RxBufferPtr[26]) <<  8) |
                                            ((uint64_t)(RxBufferPtr[27]) <<  0);
                    UScaledNs tmp, current_ts;
                    get_current_local_sync_ts(&tmp, &current_ts);
                    if (DEBUG_ENABLE) {
                        printf("[%" PRIu64 " ns]{%" PRIu64 "} receive packet. packet's tx_timestamp is %" PRIu64 "{%" PRIu64 "}. d2s latency: %" PRIu64 ". \n", current_ts.nsec, current_ts.nsec / (uint64_t)(CYCLE_TIME), tx_timestamp, tx_timestamp / (uint64_t)(CYCLE_TIME), current_ts.nsec - tx_timestamp);
						printf("<--RX: seq_id: 0x%04x, pkt_id: %" PRIu32 ", timestamp: %" PRIu64 "\n", (unsigned long)seq_id, pkt_id, tx_timestamp);
                    }

                    /* get nearest timestamp to compute task */
                    
                    uint64_t past_cycles = tx_timestamp / (uint64_t)CYCLE_TIME;
                    
                    if ((past_cycles * (uint64_t)CYCLE_TIME + (uint64_t)COMPUTE_OFFSET >= current_ts.nsec)) {
                        next_compute_ts.nsec = past_cycles * (uint64_t)CYCLE_TIME + (uint64_t)COMPUTE_OFFSET;
                    } else if ((uint64_t)COMPUTE_OFFSET <= (tx_timestamp % (uint64_t)CYCLE_TIME)){
                        next_compute_ts.nsec = (past_cycles + 1) * (uint64_t)CYCLE_TIME + (uint64_t)COMPUTE_OFFSET;
					} else {
                        dropped += 1;
                        printf("**** Drop off late packet.[%d]\n", dropped);
                        continue;
                    }
                
                    uint64_t to_next_compute_interval = next_compute_ts.nsec - current_ts.nsec;

                    

                    input_timestamp[seqid_index[seq_id]] = tx_timestamp;
                    input_pkt_id[seqid_index[seq_id]] = pkt_id;
                    bool send_packet = true;
               
					send_timestamp = input_timestamp[0]; 
					send_pkt_id = input_pkt_id[0];

					/* Only send when receive packets of the same time cycle*/
					for (int i = 0; i < INPUT_STREAM_NUM; i++) {
						send_packet = send_packet && ((input_timestamp[i] >= next_compute_ts.nsec - (uint64_t)(CYCLE_TIME))) && (input_timestamp[0] != 0);
						/* send minimum timestamp of streams */
						if (send_timestamp > input_timestamp[i]) {
							send_timestamp = input_timestamp[i];
						}
						/* select maximum packet id of streams */
						if (send_pkt_id < input_pkt_id[i]) { 
							send_pkt_id = input_pkt_id[i];
						}
					}
					if (send_packet) {
                        if (DEBUG_ENABLE) {
                            printf("should sleep [%d] ns until [%" PRIu64 "] \n", (int)to_next_compute_interval, next_compute_ts.nsec);
                        }
                        /* Deterministic send and compute*/

                        // cpu sleep 
                        // sleep_until(&tmp_timer, (int)to_next_compute_interval);
                        // get_current_local_sync_ts(&tmp, &current_ts);
                        
                        // wait for the compute time coming up
                        while (1) {
                            get_current_local_sync_ts(&tmp, &current_ts);
                            if (current_ts.nsec >= next_compute_ts.nsec) {
                                // output sync time
                                if (DEBUG_ENABLE) {
                                    printf("[%" PRIu64 " ns] start to execute tasks.\n", current_ts.nsec);
                                }
                                break;
                            }
                        }
						value = 1;  
                    	break;
					}
                    
                }
            }   
			*bool_input[i / 8][i % 8] = value;
		}
	}

	pthread_mutex_unlock(&bufferLock); //unlock mutex
}

//-----------------------------------------------------------------------------
// This function is called by the OpenPLC in a loop. Here the internal buffers
// must be updated to reflect the actual Output state. The mutex bufferLock
// must be used to protect access to the buffers on a threaded environment.
//-----------------------------------------------------------------------------
void updateBuffersOut()
{
	pthread_mutex_lock(&bufferLock); //lock mutex

	/*********READING AND WRITING TO I/O**************

	*bool_input[0][0] = read_digital_input(0);
	write_digital_output(0, *bool_output[0][0]);

	*int_input[0] = read_analog_input(0);
	write_analog_output(0, *int_output[0]);

	**************************************************/
	for (int i = 0; i < MAX_OUTPUT; i++)
	{
		if (bool_output[i / 8][i % 8] != NULL)
		{
			int value = *bool_output[i / 8][i % 8];
			// transfer packet
			// dma tx
			if (value == 1)
			{
                UScaledNs tmp, current_ts;
                get_current_local_sync_ts(&tmp, &current_ts);
                
                /* simulate complex control logic */ 
                UScaledNs send_ts;
                send_ts.nsec = current_ts.nsec + (uint64_t)COMPUTE_TIME;
                uint64_t product = 1;
                int count = 0;
                
                // 6553600ns run 1870 times in loop, 6553600 / 1870 = 3504
                uint64_t compute_times = (uint64_t)(COMPUTE_TIME-200000) / (uint64_t)3504;
                for (int k = 0; k < compute_times; k++) {
                    get_current_local_sync_ts(&tmp, &current_ts);
                }

                
                if (DEBUG_ENABLE) {
                    printf("[%" PRIu64 " ns] start to send task. count = %d.\n", current_ts.nsec, count);
                }
                for (int i = 0; i < OUTPUT_STREAM_NUM; i++) {
                    sendFrame((uint32_t)output_seq_ids[i], send_timestamp, send_pkt_id, output_src_address, output_dst_addresses[i]);
                }
				
				
			}
		}
	}

	pthread_mutex_unlock(&bufferLock); //unlock mutex
}
