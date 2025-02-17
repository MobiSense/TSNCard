#include "port_announce_information_sm.h"
#include "../log/log.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>

#define RESELECT	      sm->perPTPInstanceGlobal->reselect
#define SELECTED	      sm->perPTPInstanceGlobal->selected
#define SELECTED_STATE    sm->perPTPInstanceGlobal->selectedState
#define PORT_PRIORITY     sm->perPortGlobal->portPriority
#define MESSAGE_PRIORITY  sm->messagePriorityPAI
#define MASTER_PRIORITY   sm->perPortGlobal->masterPriority
#define RCVD_ANNOUNCE_PTR sm->rcvdAnnouncePtr

static const char *lookup_state_name(PortAnnounceInformationSMState state) {
    switch (state) {
        case PAI_BEFORE_INIT:
            return "PAI_BEFORE_INIT";
        case PAI_INIT:
            return "PAI_INIT";
        case PAI_DISABLED:
            return "PAI_DISABLED";
        case PAI_AGED:
            return "PAI_AGED";
        case PAI_UPDATE:
            return "PAI_UPDATE";
        case PAI_CURRENT:
            return "PAI_CURRENT";
        case PAI_RECEIVE:
            return "PAI_RECEIVE";
        case PAI_INFERIOR_MASTER_OR_OTHER_PORT:
            return "PAI_INFERIOR_MASTER_OR_OTHER_PORT";
        case PAI_REPEATED_MASTER_PORT:
            return "PAI_REPEATED_MASTER_PORT";
        case PAI_SUPERIOR_MASTER_PORT:
            return "PAI_SUPERIOR_MASTER_PORT";
        default:
            return "UNKNOWN";
    }
}

static void print_state_change(uint16_t portNumber, PortAnnounceInformationSMState last_state, 
    PortAnnounceInformationSMState current_state) 
{
    const char *last_state_name = lookup_state_name(last_state);
    const char *current_state_name = lookup_state_name(current_state);
    log_debug("PortAnnounceInformationSM[Port: %d]: state change from %s to %s.",
           portNumber, last_state_name, current_state_name);
}

static BmcsRcvdInfo rcvInfo(PortAnnounceInformationSM *sm) {
    
    sm->perPTPInstanceGlobal->gmStepsRemoved = RCVD_ANNOUNCE_PTR->stepsRemoved;

    MESSAGE_PRIORITY.rootSystemIdentity.priority1 = RCVD_ANNOUNCE_PTR->grandmasterPriority1;
    MESSAGE_PRIORITY.rootSystemIdentity.clockClass = RCVD_ANNOUNCE_PTR->grandmasterClockQuality.clockClass;
    MESSAGE_PRIORITY.rootSystemIdentity.clockAccuracy = RCVD_ANNOUNCE_PTR->grandmasterClockQuality.clockAccuracy;
    MESSAGE_PRIORITY.rootSystemIdentity.offsetScaledLogVariance = RCVD_ANNOUNCE_PTR->grandmasterClockQuality.offsetScaledLogVariance;
    MESSAGE_PRIORITY.rootSystemIdentity.priority2 = RCVD_ANNOUNCE_PTR->grandmasterPriority2;
    memcpy(MESSAGE_PRIORITY.rootSystemIdentity.clockIdentity, RCVD_ANNOUNCE_PTR->grandmasterIdentity, 8);
    MESSAGE_PRIORITY.stepsRemoved = RCVD_ANNOUNCE_PTR->stepsRemoved;
    memcpy(MESSAGE_PRIORITY.sourcePortClockIdentity, RCVD_ANNOUNCE_PTR->head.sourcePortIdentity.clockIdentity, 8);
    MESSAGE_PRIORITY.portNumber = RCVD_ANNOUNCE_PTR->head.sourcePortIdentity.portNumber;

    print_priority_vector("portPriority   ", &PORT_PRIORITY, __FILE__, __LINE__);
    print_priority_vector("messagePriority", &MESSAGE_PRIORITY, __FILE__, __LINE__);
    print_priority_vector("gmPriority     ", &sm->perPTPInstanceGlobal->gmPriority, __FILE__, __LINE__);

    if (SELECTED_STATE[sm->perPortGlobal->thisPort] != DISABLED_PORT) {
        if (memcmp(&PORT_PRIORITY, &MESSAGE_PRIORITY, sizeof(PriorityVector)) == 0) {
            log_debug("PORT_PRIORITY == MESSAGE_PRIORITY");
            return RCVDINFO_REPEATED_MASTER_INFO;
        }

        if (compare_priority_vectors(&MESSAGE_PRIORITY, &PORT_PRIORITY) == SUPERIOR_PRIORITY) {
            log_debug("MESSAGE_PRIORITY > PORT_PRIORITY");
            return RCVDINFO_SUPERIOR_MASTER_INFO;
        } else {
            log_debug("MESSAGE_PRIORITY < PORT_PRIORITY");
            return RCVDINFO_INFERIOR_MASTER_INFO;
        }

    }
    return RCVDINFO_OTHER_INFO;
}

static void recordOtherAnnounceInfo(PortAnnounceInformationSM *sm) {
    sm->perPortGlobal->annLeap61                   = (RCVD_ANNOUNCE_PTR->head.flags[1] & 0x1) == 0x1;
    sm->perPortGlobal->annLeap59                   = (RCVD_ANNOUNCE_PTR->head.flags[1] & 0x2) == 0x2;
    sm->perPortGlobal->annCurrentUtcOffsetValid    = (RCVD_ANNOUNCE_PTR->head.flags[1] & 0x4) == 0x4;
    sm->perPortGlobal->annPtpTimescale             = (RCVD_ANNOUNCE_PTR->head.flags[1] & 0x8) == 0x8;
    sm->perPortGlobal->annTimeTraceable            = (RCVD_ANNOUNCE_PTR->head.flags[1] & 0x10) == 0x10;
    sm->perPortGlobal->annFrequencyTraceable       = (RCVD_ANNOUNCE_PTR->head.flags[1] & 0x20) == 0x20;
    sm->perPortGlobal->annCurrentUtcOffset         = RCVD_ANNOUNCE_PTR->currentUtcOffset;
    sm->perPortGlobal->annTimeSource               = RCVD_ANNOUNCE_PTR->timeSource;

    // ??? Global pathTrace is updated only when portState is known
	// to be SlavePort, in the case when system is grandmaster (no SlavePort)
	// and the Announce received may convey transition of portState to SlavePort.
	// A copy of the announce pathSequence should be used for global pathTrace
	// and a copy of the GM clockIdentity should be placed in global gmIdentity.
	sm->perPortGlobal->annPathSequenceCount = RCVD_ANNOUNCE_PTR->pathTraceTLV.lengthField / sizeof(ClockIdentity);
	memcpy(&sm->perPortGlobal->annPathSequence, &RCVD_ANNOUNCE_PTR->pathTraceTLV.pathSequence, RCVD_ANNOUNCE_PTR->pathTraceTLV.lengthField);
	memcpy(sm->perPTPInstanceGlobal->gmIdentity, RCVD_ANNOUNCE_PTR->grandmasterIdentity, sizeof(ClockIdentity));
}
static PortAnnounceInformationSMState all_state_transition(PortAnnounceInformationSM *sm) {
    bool tricon = (!sm->perPortGlobal->portOper || !sm->perPortGlobal->ptpPortEnabled || !sm->perPortGlobal->asCapable);
    if (((tricon && sm->perPortGlobal->infoIs != INFOIS_DISABLED) || sm->perPTPInstanceGlobal->BEGIN ||
         !sm->perPTPInstanceGlobal->instanceEnable) &&
        !sm->perPTPInstanceGlobal->externalPortConfigurationEnabled) {
        return PAI_DISABLED;
    }
    return sm->state;
}

static void disabled_action(PortAnnounceInformationSM *sm, UScaledNs ts) {
    sm->perPortGlobal->rcvdMsg = 0;
    sm->perPortGlobal->infoIs = INFOIS_DISABLED;
    sm->announceReceiptTimeoutTime = ts;
    RESELECT[sm->perPortGlobal->thisPort] = 1;
    SELECTED[sm->perPortGlobal->thisPort] = 0;
}

static PortAnnounceInformationSMState disabled_state_transition(PortAnnounceInformationSM *sm, UScaledNs ts) {
    bool portOper = sm->perPortGlobal->portOper;
    bool ptpPortEnabled = sm->perPortGlobal->ptpPortEnabled;
    bool asCapable = sm->perPortGlobal->asCapable;
    
    if (portOper && ptpPortEnabled && asCapable) {
        // log_debug("PORT %d: portOper: %d, ptpPortEnabled: %d, asCapable: %d", sm->perPortGlobal->thisPort, sm->perPortGlobal->portOper, sm->perPortGlobal->ptpPortEnabled, sm->perPortGlobal->asCapable);
        return PAI_AGED;
    } 
    if (sm->perPortGlobal->rcvdMsg) {
        return PAI_DISABLED;
    }
    return sm->state;
}

static void aged_action(PortAnnounceInformationSM *sm, UScaledNs ts) {
    sm->perPortGlobal->infoIs = INFOIS_AGED;
    RESELECT[sm->perPortGlobal->thisPort] = 1;
    SELECTED[sm->perPortGlobal->thisPort] = 0;

    // Clear global copies of pathTrace and set gmIdentity to own clockIdentity
	sm->perPortGlobal->annPathSequenceCount = 0;
	memcpy(sm->perPTPInstanceGlobal->gmIdentity, sm->perPTPInstanceGlobal->thisClock, sizeof(ClockIdentity));
}

static PortAnnounceInformationSMState aged_state_transition(PortAnnounceInformationSM *sm, UScaledNs ts) {
    if (SELECTED[sm->perPortGlobal->thisPort] && sm->perPortGlobal->updtInfo){
        return PAI_UPDATE;
    } else {
        return PAI_AGED;
    }
}

static void update_action(PortAnnounceInformationSM *sm, UScaledNs ts) {
    memcpy(&PORT_PRIORITY, &MASTER_PRIORITY, sizeof(PriorityVector));
    sm->perPortGlobal->portStepsRemoved = sm->perPTPInstanceGlobal->masterStepsRemoved;
    sm->perPortGlobal->updtInfo = 0;
    sm->perPortGlobal->infoIs = INFOIS_MINE;
    sm->perPortGlobal->newInfo = 1;
}

static PortAnnounceInformationSMState update_state_transition(PortAnnounceInformationSM *sm, UScaledNs ts) {
    return PAI_CURRENT;
}

static void current_action(PortAnnounceInformationSM *sm, UScaledNs ts) {
    /* Do nothing */
    return;
}

static PortAnnounceInformationSMState current_state_transition(PortAnnounceInformationSM *sm, UScaledNs ts) {
    if (SELECTED[sm->perPortGlobal->thisPort] && sm->perPortGlobal->updtInfo) {
        return PAI_UPDATE;
    } else if (
        (sm->perPortGlobal->infoIs == INFOIS_RECEIVED &&
        (uscaledns_compare(ts, sm->announceReceiptTimeoutTime) >= 0) && !sm->perPortGlobal->updtInfo && !sm->perPortGlobal->rcvdMsg) || 
        (uscaledns_compare(ts, sm->perPTPInstanceGlobal->syncReceiptTimeoutTime) >= 0 && sm->perPTPInstanceGlobal->gmPresent)) {
        // if ((uscaledns_compare(ts, sm->announceReceiptTimeoutTime) >= 0) && !sm->perPortGlobal->updtInfo && !sm->perPortGlobal->rcvdMsg) {
        //     log_warn("announceReceipt Timeout! change to PAI_AGED");
        // }
        return PAI_AGED;
    } else if (sm->perPortGlobal->rcvdMsg && !sm->perPortGlobal->updtInfo) {
        return PAI_RECEIVE;
    } 
    return PAI_CURRENT;
    
}

static void receive_action(PortAnnounceInformationSM *sm, UScaledNs ts) {
    sm->rcvdInfo = rcvInfo(sm);
}

static PortAnnounceInformationSMState receive_state_transition(PortAnnounceInformationSM *sm, UScaledNs ts) {
    if ((sm->rcvdInfo == RCVDINFO_INFERIOR_MASTER_INFO || sm->rcvdInfo == RCVDINFO_OTHER_INFO) && 
        !sm->perPortGlobal->asymmetryMeasurementMode) {
        return PAI_INFERIOR_MASTER_OR_OTHER_PORT;
    } else if (sm->rcvdInfo == RCVDINFO_REPEATED_MASTER_INFO && 
        !sm->perPortGlobal->asymmetryMeasurementMode) {
        return PAI_REPEATED_MASTER_PORT;
    } else if (sm->rcvdInfo == RCVDINFO_SUPERIOR_MASTER_INFO && 
        !sm->perPortGlobal->asymmetryMeasurementMode) {
        return PAI_SUPERIOR_MASTER_PORT;
    } else {
        return PAI_RECEIVE;
    }
}

static void inferior_master_or_other_port_action(PortAnnounceInformationSM *sm, UScaledNs ts) {
    sm->perPortGlobal->rcvdMsg = 0;
    RCVD_ANNOUNCE_PTR = NULL;
}

static PortAnnounceInformationSMState inferior_master_or_other_port_state_transition(PortAnnounceInformationSM *sm, UScaledNs ts) {
    return PAI_CURRENT;
}

static void repeated_master_port_action(PortAnnounceInformationSM *sm, UScaledNs ts) {
    sm->announceReceiptTimeoutTime = uscaledns_add(ts, sm->perPortGlobal->announceReceiptTimeoutTimeInterval);
    
    recordOtherAnnounceInfo(sm);
    sm->perPortGlobal->rcvdMsg = 0;
    RCVD_ANNOUNCE_PTR = NULL;
}

static PortAnnounceInformationSMState repeated_master_port_state_transition(PortAnnounceInformationSM *sm, UScaledNs ts) {
    return PAI_CURRENT;
}

static void superior_master_port_action(PortAnnounceInformationSM *sm, UScaledNs ts) {
    /* Sending port is new master port */
    memcpy(&PORT_PRIORITY, &MESSAGE_PRIORITY, sizeof(PriorityVector));
    sm->perPortGlobal->portStepsRemoved = RCVD_ANNOUNCE_PTR->stepsRemoved;
    recordOtherAnnounceInfo(sm);

    int TEMP;
    /* since we do not use subns, we remove 16 bit shift */
    TEMP = RCVD_ANNOUNCE_PTR->head.logMessageInterval;
    sm->perPortGlobal->announceReceiptTimeoutTimeInterval.subns = 0;
    sm->perPortGlobal->announceReceiptTimeoutTimeInterval.nsec_msb = 0;
    
    sm->perPortGlobal->announceReceiptTimeoutTimeInterval.nsec = (uint64_t)sm->perPortGlobal->announceReceiptTimeout * ONE_SEC_NS * (1 << TEMP);
    sm->announceReceiptTimeoutTime = uscaledns_add(ts, sm->perPortGlobal->announceReceiptTimeoutTimeInterval);
    
    TEMP = sm->perPortGlobal->initialLogAnnounceInterval;
    sm->perPortGlobal->syncReceiptTimeoutTimeInterval.subns = 0;
    sm->perPortGlobal->syncReceiptTimeoutTimeInterval.nsec_msb = 0;
    sm->perPortGlobal->syncReceiptTimeoutTimeInterval.nsec = (uint64_t)sm->perPortGlobal->announceReceiptTimeout * ONE_SEC_NS * (1 << TEMP);
    sm->perPTPInstanceGlobal->syncReceiptTimeoutTime = uscaledns_add(ts, sm->perPortGlobal->syncReceiptTimeoutTimeInterval);

    // log_warn("syncReceiptTimeoutTime: is set to: [0x%016" PRIX64 "] ns", sm->perPTPInstanceGlobal->syncReceiptTimeoutTime.nsec);
    
    sm->perPortGlobal->infoIs = INFOIS_RECEIVED;
    RESELECT[sm->perPortGlobal->thisPort] = 1;
    SELECTED[sm->perPortGlobal->thisPort] = 0;
    sm->perPortGlobal->rcvdMsg = 0;
    RCVD_ANNOUNCE_PTR = NULL;
     
}

static PortAnnounceInformationSMState superior_master_port_state_transition(PortAnnounceInformationSM *sm, UScaledNs ts) {
    return PAI_CURRENT;
}

void port_announce_information_sm_run(PortAnnounceInformationSM *sm, UScaledNs ts) {
    bool state_change;
    sm->state = all_state_transition(sm);
    while (1) {
        state_change = (sm->last_state != sm->state);
        sm->last_state = sm->state;
        switch (sm->state) {
            case PAI_BEFORE_INIT:
                break;
            case PAI_INIT:
                sm->state = PAI_DISABLED;
                break;
            case PAI_DISABLED:
                if (state_change) disabled_action(sm, ts);
                sm->state = disabled_state_transition(sm, ts);
                break;
            case PAI_AGED:
                if (state_change) aged_action(sm, ts);
                sm->state = aged_state_transition(sm, ts);
                break;
            case PAI_UPDATE:
                if (state_change) update_action(sm, ts);
                sm->state = update_state_transition(sm, ts);
                break;
            case PAI_CURRENT:
                if (state_change) current_action(sm, ts);
                sm->state = current_state_transition(sm, ts);
                break;
            case PAI_RECEIVE:
                if (state_change) receive_action(sm, ts);
                sm->state = receive_state_transition(sm, ts);
                break;
            case PAI_INFERIOR_MASTER_OR_OTHER_PORT:
                if (state_change) inferior_master_or_other_port_action(sm, ts);
                sm->state = inferior_master_or_other_port_state_transition(sm, ts);
                break;
            case PAI_REPEATED_MASTER_PORT:
                if (state_change) repeated_master_port_action(sm, ts);
                sm->state = repeated_master_port_state_transition(sm, ts);
                break;
            case PAI_SUPERIOR_MASTER_PORT:
                if (state_change) superior_master_port_action(sm, ts);
                sm->state = superior_master_port_state_transition(sm, ts);
                break;
        }
        if (sm->last_state == sm->state)
            break;
        else
            print_state_change(sm->perPortGlobal->thisPort, sm->last_state, sm->state);
    }
}

void init_port_announce_information_sm(
    PortAnnounceInformationSM *sm,
    PerPTPInstanceGlobal *per_ptp_instance_global,
    PerPortGlobal *per_port_global) {
    sm->perPTPInstanceGlobal = per_ptp_instance_global;
    sm->perPortGlobal = per_port_global;
    
    RCVD_ANNOUNCE_PTR = NULL;

    sm->state = PAI_INIT;
    sm->last_state = PAI_BEFORE_INIT;

    UScaledNs ts;
    ts.subns = 0;
    ts.nsec = 0;
    ts.nsec_msb = 0;

    port_announce_information_sm_run(sm, ts);
}

void port_announce_information_sm_recv_announce(PortAnnounceInformationSM *sm, UScaledNs ts, PTPMsgAnnounce *announce_msg) {
    if (sm->rcvdAnnouncePtr != NULL) {
        free(sm->rcvdAnnouncePtr);
    }
    sm->perPortGlobal->rcvdMsg = 1;
    RCVD_ANNOUNCE_PTR = announce_msg;
    port_announce_information_sm_run(sm, ts);
}