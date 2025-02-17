#include "port_announce_transmit_sm.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "eth_frame.h"
#include "msg_frame.h"
#include "../log/log.h"

#define SELECTED        sm->perPTPInstanceGlobal->selected
#define UPDT_INFO       sm->perPortGlobal->updtInfo
#define SELECTED_STATE  sm->perPTPInstanceGlobal->selectedState
#define MASTER_PRIORITY	sm->perPortGlobal->masterPriority
#define PORT_PRIORITY	sm->perPortGlobal->portPriority

static const char *lookup_state_name(PortAnnounceTransmitSMState state) {
    switch (state) {
        case PAT_REACTION:
            return "PAT_REACTION";
        case PAT_BEFORE_INIT:
            return "PAT_BEFORE_INIT";
        case PAT_INIT:
            return "PAT_INIT";
        case PAT_TRANSMIT_INIT:
            return "PAT_TRANSMIT_INIT";
        case PAT_TRANSMIT_PERIODIC:
            return "PAT_TRANSMIT_PERIODIC";
        case PAT_IDLE:
            return "PAT_IDLE";
        case PAT_TRANSMIT_ANNOUNCE:
            return "PAT_TRANSMIT_ANNOUNCE";
        default:
            return "UNKNOWN";
    }
}

static void print_state_change(uint16_t portNumber,
                               PortAnnounceTransmitSMState last_state,
                               PortAnnounceTransmitSMState current_state) {
    const char *last_state_name = lookup_state_name(last_state);
    const char *current_state_name = lookup_state_name(current_state);
    log_debug("PortAnnounceTransmitSM-%d: state change from %s to %s.", portNumber, last_state_name, current_state_name);
}

// This function is not in the standard. We add it to be consistant with the
// sending of Sync/FollowUp messages. So we can follow the pattern of sending
// Sync/FollowUp messages.
static PTPMsgAnnounce *setAnnounce(PortAnnounceTransmitSM *sm) {
    int annMsgLength = sizeof(PTPFrameAnnounce) - 8 * (8 - sm->perPTPInstanceGlobal->nPathTrace);
    PTPMsgAnnounce *announce_ptr = malloc(sizeof(PTPMsgAnnounce));
    PortIdentity sourcePortIdentity;
    sourcePortIdentity.portNumber = sm->perPortGlobal->thisPort;
    // printf("Before memcpy from thisClock to clockIdentity\r\n");
    memcpy(sourcePortIdentity.clockIdentity, sm->perPTPInstanceGlobal->thisClock, 8);
    // printf("After memcpy from thisClock to clockIdentity\r\n");
    // printf("Before ptp_msg_ann_header_template\r\n");
    ptp_msg_ann_header_template(&announce_ptr->head, ANNOUNCE, annMsgLength, &sourcePortIdentity, sm->sequenceId, sm->perPortGlobal->currentLogAnnounceInterval, 0, sm->perPTPInstanceGlobal);
    // printf("After ptp_msg_ann_header_template\r\n");
    announce_ptr->currentUtcOffset = sm->perPTPInstanceGlobal->currentUtcOffset;
    announce_ptr->grandmasterPriority1 = MASTER_PRIORITY.rootSystemIdentity.priority1;
    announce_ptr->grandmasterClockQuality.clockClass = MASTER_PRIORITY.rootSystemIdentity.clockClass;
    announce_ptr->grandmasterClockQuality.clockAccuracy = MASTER_PRIORITY.rootSystemIdentity.clockAccuracy;
    announce_ptr->grandmasterClockQuality.offsetScaledLogVariance = MASTER_PRIORITY.rootSystemIdentity.offsetScaledLogVariance;
    announce_ptr->grandmasterPriority2 = MASTER_PRIORITY.rootSystemIdentity.priority2;
    print_priority_vector("send ann", &MASTER_PRIORITY, __FILE__, __LINE__);
    print_priority_vector("gm", &sm->perPTPInstanceGlobal->gmPriority, __FILE__, __LINE__);
    // printf("Before memcpy from rootSystemIdentity to
    // grandmasterIdentity\r\n");
    memcpy(announce_ptr->grandmasterIdentity, MASTER_PRIORITY.rootSystemIdentity.clockIdentity, 8);
    // printf("After memcpy from rootSystemIdentity to
    // grandmasterIdentity\r\n");
    announce_ptr->stepsRemoved = sm->perPTPInstanceGlobal->masterStepsRemoved;
    announce_ptr->timeSource = sm->perPTPInstanceGlobal->timeSource;
    announce_ptr->pathTraceTLV.tlvType = 0x8;
    announce_ptr->pathTraceTLV.lengthField = sm->perPTPInstanceGlobal->nPathTrace * sizeof(ClockIdentity);
    // printf("Before memcpy from pathTrace to pathSequence\r\n");
    for (int i = 0; i < sm->perPTPInstanceGlobal->nPathTrace; i++) {
        // printf("#%d path trace is ", i);
        // print_path_trace(sm->perPTPInstanceGlobal->pathTrace[i]);
    }
    memcpy(announce_ptr->pathTraceTLV.pathSequence, sm->perPTPInstanceGlobal->pathTrace, sm->perPTPInstanceGlobal->nPathTrace * 8 * sizeof(uint8_t));
    // printf("After memcpy from pathTrace to pathSequence\r\n");
    return announce_ptr;
}

static void txAnnounce(PortAnnounceTransmitSM *sm) {
    PTPFrameAnnounce ptpFrameAnnounce;
    memset(&ptpFrameAnnounce, 0, sizeof(PTPFrameAnnounce));
    set_ptp_frame_header(&ptpFrameAnnounce.head, &sm->txAnnouncePtr->head);

    ptpFrameAnnounce.currentUtcOffset = htons(sm->txAnnouncePtr->currentUtcOffset);
    ptpFrameAnnounce.grandmasterPriority1 = sm->txAnnouncePtr->grandmasterPriority1;
    ptpFrameAnnounce.grandmasterClockQuality.clockClass = sm->txAnnouncePtr->grandmasterClockQuality.clockClass;
    ptpFrameAnnounce.grandmasterClockQuality.clockAccuracy = sm->txAnnouncePtr->grandmasterClockQuality.clockAccuracy;
    ptpFrameAnnounce.grandmasterClockQuality.offsetScaledLogVariance = htons(sm->txAnnouncePtr->grandmasterClockQuality.offsetScaledLogVariance);
    ptpFrameAnnounce.grandmasterPriority2 = sm->txAnnouncePtr->grandmasterPriority2;
    memcpy(ptpFrameAnnounce.grandmasterIdentity, sm->txAnnouncePtr->grandmasterIdentity, 8);
    ptpFrameAnnounce.stepsRemoved = htons(sm->txAnnouncePtr->stepsRemoved);
    ptpFrameAnnounce.timeSource = sm->txAnnouncePtr->timeSource;
    ptpFrameAnnounce.pathTraceTLV.tlvType = htons(sm->txAnnouncePtr->pathTraceTLV.tlvType);
    ptpFrameAnnounce.pathTraceTLV.lengthField = htons(sm->txAnnouncePtr->pathTraceTLV.lengthField);
    // printf("lengthField = %d\r\n",
    // sm->txAnnouncePtr->pathTraceTLV.lengthField);
    memcpy(ptpFrameAnnounce.pathTraceTLV.pathSequence, sm->txAnnouncePtr->pathTraceTLV.pathSequence, sm->txAnnouncePtr->pathTraceTLV.lengthField * sizeof(uint8_t));

    log_debug("%-50s: %d", "tx_announce.currentUtcOffset", sm->txAnnouncePtr->currentUtcOffset);
    log_debug("%-50s: %d", "tx_announce.grandmasterPriority1", sm->txAnnouncePtr->grandmasterPriority1);
    log_debug("%-50s: %d", "tx_announce.clockClass", sm->txAnnouncePtr->grandmasterClockQuality.clockClass);
    log_debug("%-50s: %d", "tx_announce.clockAccuracy", sm->txAnnouncePtr->grandmasterClockQuality.clockAccuracy);
    log_debug("%-50s: %d", "tx_announce.offsetScaledLogVariance", sm->txAnnouncePtr->grandmasterClockQuality.offsetScaledLogVariance);
    log_debug("%-50s: %d", "tx_announce.grandmasterPriority2", sm->txAnnouncePtr->grandmasterPriority2);
    log_debug("%-50s: %d", "tx_announce.stepsRemoved", sm->txAnnouncePtr->stepsRemoved);

    // printf("size of PTPFrameAnnounce = %u\r\n", sizeof(PTPFrameAnnounce));
    // printf("size of PTPFrameHeader = %u\r\n", sizeof(PTPFrameHeader));
    // printf("size of PTPFrameClockQuality = %u\r\n",
    //        sizeof(PTPFrameClockQuality));
    // printf("size of PTPFramePathTraceTLV = %u\r\n",
    //        sizeof(PTPFramePathTraceTLV));
    // for (int i = 0; i < sm->txAnnouncePtr->pathTraceTLV.lengthField / 8; i++)
    // {
    //     printf("before send, #%d path trace is ", i);
    //     print_path_trace(ptpFrameAnnounce.pathTraceTLV.pathSequence[i]);
    // }

    // printf("before send_ptp_frame\r\n");
    send_ptp_frame((uint8_t*)&ptpFrameAnnounce, sizeof(PTPFrameAnnounce) - 8 * 8 + sm->txAnnouncePtr->pathTraceTLV.lengthField, sm->perPortGlobal->thisPort, "ANNOUNCE", sm->txAnnouncePtr->head.sequenceId);
    // printf("after send_ptp_frame\r\n");
}

static PortAnnounceTransmitSMState all_state_transition(
    PortAnnounceTransmitSM *sm) {
    if (sm->perPTPInstanceGlobal->BEGIN ||
        (!sm->perPTPInstanceGlobal->instanceEnable)) {
        return PAT_TRANSMIT_INIT;
    }
    return sm->state;
}

static void transmit_init_action(PortAnnounceTransmitSM *sm, UScaledNs ts) {
    sm->newInfo = 1;
    sm->announceSlowdown = 0;
    sm->numberAnnounceTransmission = 0;
}

static PortAnnounceTransmitSMState transmit_init_state_transition(PortAnnounceTransmitSM *sm, UScaledNs ts) {
    /* unconditional transfer (UCT) */
    return PAT_IDLE;
}

static void transmit_periodic_action(PortAnnounceTransmitSM *sm, UScaledNs ts) {
    sm->newInfo = 1 || (SELECTED_STATE[sm->perPortGlobal->thisPort]== MASTER_PORT);
}

static PortAnnounceTransmitSMState transmit_periodic_state_transition(PortAnnounceTransmitSM *sm, UScaledNs ts) {
    /* unconditional transfer (UCT) */
    return PAT_IDLE;
}

static void idle_action(PortAnnounceTransmitSM *sm, UScaledNs ts) {
    sm->announceSendTime = uscaledns_add(ts, sm->interval2);
}

static PortAnnounceTransmitSMState idle_state_transition(PortAnnounceTransmitSM *sm, UScaledNs ts) {
    if (sm->perPortGlobal->thisPort == 1 && SELECTED_STATE[sm->perPortGlobal->thisPort] == MASTER_PORT && (uscaledns_compare(ts, sm->announceSendTime) < 0)) {
        int i = 0;
    }
    if (uscaledns_compare(ts, sm->announceSendTime) >= 0 && 
        ((SELECTED[sm->perPortGlobal->thisPort] && !UPDT_INFO) || 
        sm->perPTPInstanceGlobal->externalPortConfigurationEnabled)) {
        return PAT_TRANSMIT_PERIODIC;
    }

    if (sm->newInfo && 
        (SELECTED_STATE[sm->perPortGlobal->thisPort] == MASTER_PORT) && 
        (uscaledns_compare(ts, sm->announceSendTime) < 0) && 
        ((SELECTED[sm->perPortGlobal->thisPort] && !UPDT_INFO) || sm->perPTPInstanceGlobal->externalPortConfigurationEnabled) && 
        !sm->perPortGlobal->asymmetryMeasurementMode) {
        return PAT_TRANSMIT_ANNOUNCE;
    }

    return sm->state;
}

static void transmit_announce_action(PortAnnounceTransmitSM *sm, UScaledNs ts) {
    sm->newInfo = 0;
    // printf("Before setAnnounce!\r\n");
    sm->txAnnouncePtr = setAnnounce(sm);
    // printf("After setAnnounce & Before txAnnounce!\r\n");
    txAnnounce(sm);
    // printf("After txAnnounce!\r\n");
    sm->interval2 = sm->perPortGlobal->announceInterval;

}

static PortAnnounceTransmitSMState transmit_announce_state_transition(
    PortAnnounceTransmitSM *sm, UScaledNs ts) {
    return PAT_IDLE;
}

void port_announce_transmit_sm_run(PortAnnounceTransmitSM *sm, UScaledNs ts) {
    bool state_change;
    sm->state = all_state_transition(sm);
    while (1) {
        // printf("At loop beginning, Current Announce State @port#%d: %s.\r\n",
        //        sm->perPortGlobal->thisPort, lookup_state_name(sm->state));
        state_change = (sm->state != sm->last_state);
        sm->last_state = sm->state;
        switch (sm->state) {
            case PAT_INIT:
                sm->state = PAT_TRANSMIT_INIT;
                break;
            case PAT_TRANSMIT_INIT:
                if (state_change) {
                    transmit_init_action(sm, ts);
                }
                sm->state = transmit_init_state_transition(sm, ts);
                break;
            case PAT_TRANSMIT_PERIODIC:
                if (state_change) {
                    transmit_periodic_action(sm, ts);
                }
                sm->state = transmit_periodic_state_transition(sm, ts);
                break;
            case PAT_IDLE:
                if (state_change) {
                    idle_action(sm, ts);
                }
                sm->state = idle_state_transition(sm, ts);
                break;
            case PAT_TRANSMIT_ANNOUNCE:
                if (state_change) {
                    transmit_announce_action(sm, ts);
                }
                sm->state = transmit_announce_state_transition(sm, ts);
                break;
        }
        if (sm->state != sm->last_state) {
            print_state_change(sm->perPortGlobal->thisPort, sm->last_state,
                               sm->state);
            // printf("At loop ending, Current Announce State @port#%d: %s.\r\n",
            //        sm->perPortGlobal->thisPort, lookup_state_name(sm->state));
        } else {
            // printf("At loop ending, Current Announce State @port#%d: %s.\r\n",
            //        sm->perPortGlobal->thisPort, lookup_state_name(sm->state));
            break;
        }
    }
}

void init_port_announce_transmit_sm(
    PortAnnounceTransmitSM *sm, PerPTPInstanceGlobal *per_ptp_instance_global,
    PerPortGlobal *per_port_global) {
    sm->perPTPInstanceGlobal = per_ptp_instance_global;
    sm->perPortGlobal = per_port_global;

    sm->interval2 = sm->perPortGlobal->announceInterval;
    sm->sequenceId = (uint16_t)(rand() & 0xFFFF);
    sm->txAnnouncePtr = NULL;
    sm->newInfo = 0;
    sm->announceSlowdown = 0;

    sm->state = PAT_INIT;
    sm->last_state = PAT_BEFORE_INIT;

    UScaledNs ts;
    ts.subns = 0;
    ts.nsec = 0;
    ts.nsec_msb = 0;

    port_announce_transmit_sm_run(sm, ts);
}
