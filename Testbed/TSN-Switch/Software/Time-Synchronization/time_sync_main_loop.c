/******************************************************************************
 * Copyright (C) 2010 - 2020 Xilinx, Inc.  All rights reserved.
 * SPDX-License-Identifier: MIT
 ******************************************************************************/

/*****************************************************************************/
/**
 *
 * @file xaxidma_example_simple_poll.c
 *
 * This file demonstrates how to use the xaxidma driver on the Xilinx AXI
 * DMA core (AXIDMA) to transfer packets in polling mode when the AXI DMA core
 * is configured in simple mode.
 *
 * This code assumes a loopback hardware widget is connected to the AXI DMA
 * core for data packet loopback.
 *
 * To see the debug print, you need a Uart16550 or uartlite in your system,
 * and please set "-DDEBUG" in your compiler options. You need to rebuild your
 * software executable.
 *
 * Make sure that MEMORY_BASE is defined properly as per the HW system. The
 * h/w system built in Area mode has a maximum DDR memory limit of 64MB. In
 * throughput mode, it is 512MB.  These limits are need to ensured for
 * proper operation of this code.
 *
 *
 * <pre>
 * MODIFICATION HISTORY:
 *
 * Ver   Who  Date     Changes
 * ----- ---- -------- -------------------------------------------------------
 * 4.00a rkv  02/22/11 New example created for simple DMA, this example is for
 *       	       simple DMA
 * 5.00a srt  03/06/12 Added Flushing and Invalidation of Caches to fix CRs
 *		       648103, 648701.
 *		       Added V7 DDR Base Address to fix CR 649405.
 * 6.00a srt  03/27/12 Changed API calls to support MCDMA driver.
 * 7.00a srt  06/18/12 API calls are reverted back for backward compatibility.
 * 7.01a srt  11/02/12 Buffer sizes (Tx and Rx) are modified to meet maximum
 *		       DDR memory limit of the h/w system built with Area mode
 * 7.02a srt  03/01/13 Updated DDR base address for IPI designs (CR 703656).
 * 9.1   adk  01/07/16 Updated DDR base address for Ultrascale (CR 799532) and
 *		       removed the defines for S6/V6.
 * 9.3   ms   01/23/17 Modified printf statement in main function to
 *                     ensure that "Successfully ran" and "Failed" strings are
 *                     available in all examples. This is a fix for CR-965028.
 *       ms   04/05/17 Modified Comment lines in functions to
 *                     recognize it as documentation block for doxygen
 *                     generation of examples.
 * 9.9   rsp  01/21/19 Fix use of #elif check in deriving DDR_BASE_ADDR.
 * 9.10  rsp  09/17/19 Fix cache maintenance ops for source and dest buffer.
 * </pre>
 *
 * ***************************************************************************

 */
/***************************** Include Files *********************************/

#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>
#include <string.h>
#include <inttypes.h>

#include "config.h"
#include "dma_proxy/buffer_queue.h"
#include "dma_proxy/dma-proxy.h"
#include "time_sync/eth_frame.h"
#include "time_sync/msg_frame.h"
#include "time_sync/state_machines.h"
#include "tsn_drivers/gcl.h"
#include "tsn_drivers/rtc.h"
#include "tsn_drivers/tsu.h"
#include "tsn_drivers/uio.h"
#include "tsn_drivers/switch_rules.h"
#include "tsn_drivers/gpio_reset.h"
#include "log/log.h"


/******************** Constant Definitions **********************************/

pthread_t tid;
buffer_queue *queue;

/**************************** Type Definitions *******************************/

/***************** Macros (Inline Functions) Definitions *********************/

/************************** Function Prototypes ******************************/

// Start developing 802.1AS
int TimeSyncMainLoop(void);
void set_default_config(SystemIdentity* system_identity,
        int *ptp_ports,
        bool *externalPortConfigurationEnabled);

/************************** Variable Definitions *****************************/

// definition from cpp code
extern void get_ptp_ports(int *ptp_ports);
extern void get_clock_identity(ClockIdentity clock_identity);
extern void get_priority1(uint8_t* priority1);
extern void get_config_from_json(
        SystemIdentity* system_identity,
        int *ptp_ports,
        bool *externalPortConfigurationEnabled);

void set_default_config(SystemIdentity* system_identity,
        int *ptp_ports,
        bool *externalPortConfigurationEnabled)
{
    system_identity->priority1 = 254;
    system_identity->clockClass = 248;
    system_identity->clockAccuracy = 254;
    system_identity->offsetScaledLogVariance = 17258;
    system_identity->priority2 = 247;
    system_identity->clockIdentity[0] = 0;
    system_identity->clockIdentity[1] = 0;
    system_identity->clockIdentity[2] = 0;
    system_identity->clockIdentity[3] = 0;
    system_identity->clockIdentity[4] = 0;
    system_identity->clockIdentity[5] = 0;
    system_identity->clockIdentity[6] = 0;
    system_identity->clockIdentity[7] = 0;

    *externalPortConfigurationEnabled = 0;   
}
/*
 * This is the first attempt to construct the main loop function for time_sync
 * after we have finished PdelayReqSM.
 */
int TimeSyncMainLoop() {
	// Global variables
	PerPTPInstanceGlobal per_ptp_instance_global;
	PerPortGlobal per_port_global[4];
	MDEntityGlobal md_entity_global[4];

	// Init global variables
	per_ptp_instance_global.BEGIN = 0;
	per_ptp_instance_global.instanceEnable = 1;
	per_ptp_instance_global.gmPresent = 1;
    
    // configuration variables
    SystemIdentity config_system_identity;
    int config_ptp_ports[N_PORTS+1];
    bool config_externalPortConfigurationEnabled;
    config_ptp_ports[0] = -1;

    set_default_config(&config_system_identity,
        config_ptp_ports,
        &config_externalPortConfigurationEnabled);

    get_config_from_json(
        &config_system_identity,
        config_ptp_ports,
        &config_externalPortConfigurationEnabled
    );

    log_info("Get 802.1AS Configuration:");
    
    log_info("%-50s: %d", "config_system_identity.priority1", config_system_identity.priority1);
    log_info("%-50s: %d", "config_system_identity.clockClass", config_system_identity.clockClass);
    log_info("%-50s: %d", "config_system_identity.clockAccuracy", config_system_identity.clockAccuracy);
    log_info("%-50s: %d", "config_system_identity.offsetScaledLogVariance", config_system_identity.offsetScaledLogVariance);
    log_info("%-50s: %d", "config_system_identity.priority2", config_system_identity.priority2);
    log_info("%-50s: %02X%02X%02X%02X%02X%02X%02X%02X", "config_system_identity.clockIdentity", 
        config_system_identity.clockIdentity[0],
        config_system_identity.clockIdentity[1],
        config_system_identity.clockIdentity[2],
        config_system_identity.clockIdentity[3],
        config_system_identity.clockIdentity[4],
        config_system_identity.clockIdentity[5],
        config_system_identity.clockIdentity[6],
        config_system_identity.clockIdentity[7]);

    log_info("%-50s: %d", "config_externalPortConfigurationEnabled", config_externalPortConfigurationEnabled);
    for (int i = 0; i < N_PORTS+1; ++i) {
        log_info("ptp ports[%d]: %s", i, lookup_port_state_name((PortState)config_ptp_ports[i]));
    }

    // set_default_clock_identity(per_ptp_instance_global.thisClock);
    memcpy(&per_ptp_instance_global.thisClock, &config_system_identity.clockIdentity, sizeof(ClockIdentity));

	// 0: local clock port; 
	// if 0 is slave port, then local clock is used as master

	// get ports state from config
	
	// flag to detect wether the values are set
	
	if (config_ptp_ports[0] == -1) {
		log_error("PTP ports not set.\n");
		exit(1);
	}

	for (int i = 0; i < 5; ++i) {
		per_ptp_instance_global.selectedState[i] = (PortState)config_ptp_ports[i];
	}
	
	per_ptp_instance_global.clockSourceTimeBaseIndicatorOld = 0;
	per_ptp_instance_global.clockSourceTimeBaseIndicator = 0;
	per_ptp_instance_global.clockSourcePhaseOffset.subns = 0;
	per_ptp_instance_global.clockSourcePhaseOffset.nsec = 0;
	per_ptp_instance_global.clockSourcePhaseOffset.nsec_msb = 0;
	per_ptp_instance_global.clockSourceFreqOffset = 0.0;
	per_ptp_instance_global.clockMasterSyncInterval.subns = 0;
	per_ptp_instance_global.clockMasterSyncInterval.nsec = ONE_SEC_NS;
	per_ptp_instance_global.clockMasterSyncInterval.nsec_msb = 0;
    per_ptp_instance_global.externalPortConfigurationEnabled = config_externalPortConfigurationEnabled; // 0: bmca, 1: external config

    // Info for transmitting Announce messages, if there is no SLAVE_PORT, the
    // following values will be used, otherwise the values retrieved from the
    // Announce message on the SLAVE_PORT will be used.
    per_ptp_instance_global.leap61 = 0;
    per_ptp_instance_global.leap59 = 0;
    per_ptp_instance_global.currentUtcOffsetValid = 0;
    per_ptp_instance_global.currentUtcOffset = 0;
    per_ptp_instance_global.ptpTimescale = 0;
    per_ptp_instance_global.timeTraceable = 0;
    per_ptp_instance_global.frequencyTraceable = 0;
    per_ptp_instance_global.timeSource = 0xA0;  // 8.6.2.7

    per_ptp_instance_global.systemPriority.rootSystemIdentity.priority1 = config_system_identity.priority1 ;  // 8.6.2.1
    per_ptp_instance_global.systemPriority.rootSystemIdentity.clockClass = config_system_identity.clockClass;  // 8.6.2.2
    per_ptp_instance_global.systemPriority.rootSystemIdentity.clockAccuracy = config_system_identity.clockAccuracy;  // 8.6.2.3
    per_ptp_instance_global.systemPriority.rootSystemIdentity.offsetScaledLogVariance = config_system_identity.offsetScaledLogVariance;  // 8.6.2.4
    per_ptp_instance_global.systemPriority.rootSystemIdentity.priority2 = config_system_identity.priority2;  // 8.6.2.5
    // set_default_clock_identity(per_ptp_instance_global.systemPriority.rootSystemIdentity.clockIdentity); // 10.3.4
    memcpy(&per_ptp_instance_global.systemPriority.rootSystemIdentity.clockIdentity, &config_system_identity.clockIdentity, sizeof(ClockIdentity));

    per_ptp_instance_global.systemPriority.stepsRemoved = 0;  // 10.3.4
    // set_default_clock_identity(per_ptp_instance_global.systemPriority.sourcePortClockIdentity);       // 10.3.4
    memcpy(&per_ptp_instance_global.systemPriority.sourcePortClockIdentity, &config_system_identity.clockIdentity, sizeof(ClockIdentity));
    per_ptp_instance_global.systemPriority.sourcePortNumber = 0;  // 10.3.4
    per_ptp_instance_global.systemPriority.portNumber = 0;        // 10.3.4

    per_ptp_instance_global.gmPriority.rootSystemIdentity.priority1 = config_system_identity.priority1;  // 8.6.2.1
    per_ptp_instance_global.gmPriority.rootSystemIdentity.clockClass = config_system_identity.clockClass;  // 8.6.2.2
    per_ptp_instance_global.gmPriority.rootSystemIdentity.clockAccuracy = config_system_identity.clockAccuracy;  // 8.6.2.3
    per_ptp_instance_global.gmPriority.rootSystemIdentity.offsetScaledLogVariance = config_system_identity.offsetScaledLogVariance;  // 8.6.2.4
    per_ptp_instance_global.gmPriority.rootSystemIdentity.priority2 = config_system_identity.priority2;  // 8.6.2.5
    // set_default_clock_identity(per_ptp_instance_global.gmPriority.rootSystemIdentity.clockIdentity); // 10.3.4
    memcpy(&per_ptp_instance_global.gmPriority.rootSystemIdentity.clockIdentity, &config_system_identity.clockIdentity, sizeof(ClockIdentity));
    per_ptp_instance_global.gmPriority.stepsRemoved = 0;  // 10.3.4
    // set_default_clock_identity(per_ptp_instance_global.gmPriority.sourcePortClockIdentity);       // 10.3.4
    memcpy(&per_ptp_instance_global.gmPriority.sourcePortClockIdentity, &config_system_identity.clockIdentity, sizeof(ClockIdentity));
    per_ptp_instance_global.gmPriority.sourcePortNumber = 0;  // 10.3.4
    per_ptp_instance_global.gmPriority.portNumber = 0;        // 10.3.4
    per_ptp_instance_global.gmStepsRemoved = 0;
    per_ptp_instance_global.nPathTrace = per_ptp_instance_global.gmPriority.stepsRemoved + 1;
    // set_default_clock_identity(per_ptp_instance_global.pathTrace[0]);
    memcpy(&per_ptp_instance_global.pathTrace[0], &config_system_identity.clockIdentity, sizeof(ClockIdentity));

    per_ptp_instance_global.domainNumber = 0;

	
	for (int i = 0; i < 4; i++) {
		per_port_global[i].asCapable = 1;
		// per_port_global[i].syncReceiptTimeout = 10;
		per_port_global[i].syncReceiptTimeoutTimeInterval.subns = 0;
		per_port_global[i].syncReceiptTimeoutTimeInterval.nsec = ONE_SEC_NS;
		per_port_global[i].syncReceiptTimeoutTimeInterval.nsec_msb = 0;

		per_port_global[i].syncInterval.subns = 0;
		per_port_global[i].syncInterval.nsec_msb = 0;
		per_port_global[i].syncInterval.nsec = ONE_SEC_NS;
		per_port_global[i].oldSyncInterval.subns = 0;
		per_port_global[i].oldSyncInterval.nsec_msb = 0;
		per_port_global[i].oldSyncInterval.nsec = ONE_SEC_NS;

		per_port_global[i].asymmetryMeasurementMode = 0;
		per_port_global[i].computeMeanLinkDelay = 1;
		per_port_global[i].computeNeighborRateRatio = 1;
		per_port_global[i].meanLinkDelay.nsec_msb = 0;
		per_port_global[i].meanLinkDelay.nsec = 0;
		per_port_global[i].meanLinkDelay.subns = 0;
		per_port_global[i].neighborRateRatio = 1.0;
		per_port_global[i].portOper = 0;
		per_port_global[i].ptpPortEnabled = 0;
		per_port_global[i].thisPort = i + 1;

        // Added for Announce message.
        per_port_global[i].announceInterval.subns = 0;
        per_port_global[i].announceInterval.nsec_msb = 0;
        per_port_global[i].announceInterval.nsec = ONE_SEC_NS;
        per_port_global[i].currentLogAnnounceInterval = 0;
        per_port_global[i].initialLogAnnounceInterval = 0;
        per_port_global[i].announceReceiptTimeout = 3;
        per_port_global[i].syncReceiptTimeout = 3;
        per_port_global[i].currentLogSyncInterval = 3;
        per_port_global[i].rcvdMsg = 0;
	}
	
	for (int i = 0; i < 4; i++) {
		// if the port is disabled, then the value is 0, otherwise it is 1
		if (per_ptp_instance_global.selectedState[i + 1] == DISABLED_PORT) continue;
		// the port is not disabled
		per_port_global[i].portOper = 1;
		per_port_global[i].ptpPortEnabled = 1;
	}

	for (int i = 0; i < 4; i++) {
		md_entity_global[i].allowedFaults = 255;
		md_entity_global[i].allowedLostResponses = 255;
		md_entity_global[i].asCapableAcrossDomains = 0;
		md_entity_global[i].isMeasuringDelay = 1;
		md_entity_global[i].meanLinkDelayThresh.nsec_msb = 0xFFFF;
		md_entity_global[i].meanLinkDelayThresh.nsec = 0;
		md_entity_global[i].meanLinkDelayThresh.subns = 0;
		md_entity_global[i].pdelayReqInterval.nsec_msb = 0;
		md_entity_global[i].pdelayReqInterval.nsec = ONE_SEC_NS;
		md_entity_global[i].pdelayReqInterval.subns = 0;
	}

	// State machines
	ClockMasterSyncReceiveSM clock_master_sync_receive_sm;
	ClockMasterSyncSendSM clock_master_sync_send_sm;
	SiteSyncSyncSM site_sync_sync_sm;
	ClockSlaveSyncSM clock_slave_sync_sm;
    PortStateSelectionSM port_state_selection_sm;
	MDPdelayReqSM md_pdelay_req_sms[N_PORTS];
	MDPdelayRespSM md_pdelay_resp_sms[N_PORTS];
	PortSyncSyncReceiveSM port_sync_sync_receive_sms[N_PORTS];
	PortSyncSyncSendSM port_sync_sync_send_sms[N_PORTS];
	MDSyncSendSM md_sync_send_sms[N_PORTS];
	MDSyncReceiveSM md_sync_receive_sms[N_PORTS];

    // State machines for Announce messages
    PortAnnounceInformationExtSM port_announce_information_ext_sms[N_PORTS];
    PortAnnounceInformationSM port_announce_information_sms[N_PORTS];
    PortAnnounceTransmitSM port_announce_transmit_sms[N_PORTS];

	// Init state machines
	init_clock_master_sync_receive_sm(&clock_master_sync_receive_sm, &per_ptp_instance_global);
	init_clock_master_sync_send_sm(&clock_master_sync_send_sm, &per_ptp_instance_global, &site_sync_sync_sm);
	init_site_sync_sync_sm(&site_sync_sync_sm, &per_ptp_instance_global, &clock_slave_sync_sm, port_sync_sync_send_sms);
	init_clock_slave_sync_sm(&clock_slave_sync_sm, &per_ptp_instance_global, per_port_global);
    if (!per_ptp_instance_global.externalPortConfigurationEnabled) {
        init_port_state_selection_sm(&port_state_selection_sm, &per_ptp_instance_global, per_port_global);
    }

	for (int i = 0; i < N_PORTS; i++) {
		init_port_sync_sync_receive_sm(&port_sync_sync_receive_sms[i], &per_ptp_instance_global, &per_port_global[i], &site_sync_sync_sm);
		init_port_sync_sync_send_sm(&port_sync_sync_send_sms[i], &per_ptp_instance_global, &per_port_global[i], &md_sync_send_sms[i]);
		init_md_pdelay_req_sm(&md_pdelay_req_sms[i], &per_port_global[i], &per_ptp_instance_global, &md_entity_global[i]);
		init_md_pdelay_resp_sm(&md_pdelay_resp_sms[i], &per_port_global[i], &per_ptp_instance_global, &md_entity_global[i]);
		init_md_sync_send_sm(&md_sync_send_sms[i], &per_ptp_instance_global, &per_port_global[i], &md_entity_global[i]);
		init_md_sync_receive_sm(&md_sync_receive_sms[i], &per_ptp_instance_global, &per_port_global[i], &port_sync_sync_receive_sms[i]);
        
        // Init state machines for Announce messages
        if (per_ptp_instance_global.externalPortConfigurationEnabled) {
            init_port_announce_information_ext_sm(&port_announce_information_ext_sms[i], &per_ptp_instance_global, &per_port_global[i]);
        } else {
            init_port_announce_information_sm(&port_announce_information_sms[i], &per_ptp_instance_global, &per_port_global[i]);
        }
        
        init_port_announce_transmit_sm(&port_announce_transmit_sms[i], &per_ptp_instance_global, &per_port_global[i]);
	}

	log_info("Init state machines done.");

	UScaledNs current_ts;
	uint8_t *recv_msg_ptr;
	TSUTimestamp *tsu_ts_ptr;
	PTPMsgType recv_status;
	uint16_t port_number;
	ClockSourceTimeInvoke *source_time_req_ptr;
	
	while (1) {
		// Update master time.
		source_time_req_ptr = malloc(sizeof(ClockSourceTimeInvoke));
		source_time_req_ptr->domainNumber = 0;
		source_time_req_ptr->lastGmFreqChange = 0.0;
		source_time_req_ptr->lastGmPhaseChange.subns = 0;
		source_time_req_ptr->lastGmPhaseChange.nsec = 0;
		source_time_req_ptr->lastGmPhaseChange.nsec_msb = 0;
		source_time_req_ptr->timeBaseIndicator = 0;
		current_ts = get_current_timestamp();
		source_time_req_ptr->sourceTime = (ExtendedTimestamp)current_ts;
        
		clock_master_sync_receive_sm_recv_source_time(&clock_master_sync_receive_sm, source_time_req_ptr, current_ts);

		// printf("Update master time done.\r\n");

		// Check for timeout events
		clock_master_sync_send_sm_run(&clock_master_sync_send_sm, current_ts);

        

        

		for (int i = 0; i < 4; i++) {
			md_pdelay_req_sm_run(&md_pdelay_req_sms[i], current_ts);
			md_sync_receive_sm_run(&md_sync_receive_sms[i], current_ts);

            // Announce messages, if new announce messages need to be
            // transmitted.
            if (!per_ptp_instance_global.externalPortConfigurationEnabled) {
                port_announce_information_sm_run(&port_announce_information_sms[i], current_ts);
            }
            port_announce_transmit_sm_run(&port_announce_transmit_sms[i], current_ts);
		}
		// printf("Timeout check done.\r\n");
		
		// Check for frame receive buffer
		recv_status = recv_ptp_frame(&recv_msg_ptr, &tsu_ts_ptr, &port_number, queue);
		if (recv_status != NO_FRAME) {
			if (md_pdelay_resp_sms[0].rcvdPdelayReqPtr != NULL) {
				printf("Check PDelayReq Seq ID: %d. \r\n", md_pdelay_resp_sms[0].rcvdPdelayReqPtr->head.sequenceId);
			} else {
				// printf("md_pdelay_resp_sms-0-rcvdPdelayReqPtr is NULL.\r\n");
			}
		}
		switch (recv_status)
		{
            case NO_FRAME:
                break;
            case PDELAY_REQ:
                md_pdelay_resp_sm_recv_req(&md_pdelay_resp_sms[port_number - 1], current_ts, tsu_ts_ptr, (PTPMsgPdelayReq *)recv_msg_ptr);
                break;
            case PDELAY_RESP:
                md_pdelay_req_sm_recv_resp(&md_pdelay_req_sms[port_number - 1], current_ts, tsu_ts_ptr, (PTPMsgPdelayResp *)recv_msg_ptr);
                break;
            case PDELAY_RESP_FOLLOW_UP:
                md_pdelay_req_sm_recv_resp_follow_up(&md_pdelay_req_sms[port_number - 1], current_ts, (PTPMsgPdelayRespFollowUp *)recv_msg_ptr);
                break;
            case SYNC:
                md_sync_receive_sm_recv_sync(&md_sync_receive_sms[port_number - 1], current_ts, tsu_ts_ptr, (PTPMsgSync *)recv_msg_ptr);
                break;
            case FOLLOW_UP:
                md_sync_receive_sm_recv_follow_up(&md_sync_receive_sms[port_number - 1], current_ts, (PTPMsgFollowUp *)recv_msg_ptr);
                break;
            case ANNOUNCE:
                if (per_ptp_instance_global.externalPortConfigurationEnabled) {
                    port_announce_information_ext_sm_recv_announce(&port_announce_information_ext_sms[port_number - 1], current_ts, (PTPMsgAnnounce *)recv_msg_ptr);
                } else {
                    port_announce_information_sm_recv_announce(&port_announce_information_sms[port_number - 1], current_ts, (PTPMsgAnnounce *)recv_msg_ptr);
                    // port state selection
                    if (!per_ptp_instance_global.externalPortConfigurationEnabled) { 
                        // port state selection
                        port_state_selection_sm_run(&port_state_selection_sm, current_ts);
                    }
                }
                break;
		}

        if (!per_ptp_instance_global.externalPortConfigurationEnabled) { 
            // port state selection
            port_state_selection_sm_run(&port_state_selection_sm, current_ts);
        }
		
		// Check for tx tsu timestamp
		int tx_ts_status;
		TSUTimestamp tsu_tx_ts;
		for (uint16_t port_i = 1; port_i < 5; port_i++) {
			tx_ts_status = tsu_tx_get_timestamp(port_i, &tsu_tx_ts);
			if (tx_ts_status == 0) {
				continue;
			} else {
				switch (tsu_tx_ts.msgType)
				{
                    case PDELAY_REQ:
                        md_pdelay_req_sm_txts(&md_pdelay_req_sms[port_i - 1], current_ts, tsu_tx_ts);
                        break;
                    case PDELAY_RESP:
                        md_pdelay_resp_sm_txts(&md_pdelay_resp_sms[port_i - 1], current_ts, tsu_tx_ts);
                        break;
                    case SYNC:
                        md_sync_send_sm_txts(&md_sync_send_sms[port_i - 1], current_ts, tsu_tx_ts);
                        break;
                    default:
                        printf("Unknown TX TSU MSG TYPE when check tx timestamp. \r\n");
                        break;
				}
			}
		}
	}
}

/*****************************************************************************/
/**
* The entry point for this example. It invokes the example function,
* and reports the execution status.
*
* @param	None.
*
* @return
*		- EXIT_SUCCESS if example finishes successfully
*		- EXIT_FAILURE if example fails.
*
* @note		None.
*
******************************************************************************/
int main(int argc,char * argv[])
{
    // FILE * fp;
    // fp = fopen ("debug_lg.log", "w");
    // log_add_fp(fp, LOG_DEBUG);
    // log_set_level(LOG_WARN);
    int opt = 0;
    int log_level = LOG_TRACE;
    while ((opt = getopt(argc, argv, "hl:")) != -1) {
        switch (opt) {
            case 'h':
                printf("Usage: ./time_sync -l <w/i/t>\n");
                printf("-l: log_level, w(warn), i(info), t(trace)\n");
                return 0;
            case 'l':
                if (strcmp(optarg, "w") == 0) {
                    log_level = LOG_WARN;
                } else if (strcmp(optarg, "i") == 0) {
                    log_level = LOG_INFO;
                } else if (strcmp(optarg, "t") == 0) {
                    log_level = LOG_TRACE;
                } else {
                    printf("Unknown Log level. Usage: ./time_sync -l <w/i/t>\n");
                    return 0;
                }
                break;
            default:
                printf("error opterr: %d\n", opterr);
                return 0;
        }
    }
    log_set_level(log_level);
    printf("Log level is [LOF_TRACE] by default.\n");
    printf("Usage: ./time_sync -l <w/i/t>\n");
    printf("-l: log_level, w(warn), i(info), t(trace)\n");


	reset_PL_by_GPIO("960");

	log_info("--- Entering main() ---");

	void *ptr, *ptr2;
	ptr = uio_init("/dev/uio0");
	gcl_init(ptr);
	rtc_init(ptr);
	tsu_init(ptr);

	ptr2 = switch_rule_uio_init();
	switch_rule_init(ptr2); // clear all existing rules.

	axi_dma_init();
	log_info("GCL, RTC, TSU, DMA, Switch Rule init complete.");

	log_info ("--- Start setting up Switch Rule. ---");
	set_switch_rule_with_init();
	log_info ("--- Finish setting up Switch Rule. ---");

	log_info ("--- Start setting up GCL. ---");
	set_gcl_with_init();
	log_info ("--- Finish setting up GCL. ---");

	log_info("--- Launching DMA receving thread --- ");
	// init RX buffer queue
	queue = malloc (sizeof(buffer_queue));
	init_queue (queue);
	// init buffer queue mutex
	if (pthread_mutex_init (&buf_queue_lock, NULL) != 0) {
		log_error ("Fail to initialize buffer queue mutex. ");
	}
	// launch rx thread
	pthread_create(&tid, NULL, (void *)DMA_rx_thread, (void *) queue);
	log_info("--- Launching DMA receving thread successfully ---");

	log_info ("--- Start time syncronization. ---");
	TimeSyncMainLoop();
	log_info ("--- Finish time syncronization. ---");


	log_info("--- Exiting main() --- ");

	return EXIT_SUCCESS;

}
