#include "port_announce_information_ext_sm.h"
#include "../log/log.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static const char *lookup_state_name(PortAnnounceInformationExtSMState state) {
    switch (state) {
        case PAIE_REACTION:
            return "PAIE_REACTION";
        case PAIE_BEFORE_INIT:
            return "PAIE_BEFORE_INIT";
        case PAIE_INIT:
            return "PAIE_INIT";
        case PAIE_INITIALIZE:
            return "PAIE_INITIALIZE";
        case PAIE_RECEIVE:
            return "PAIE_RECEIVE";
        default:
            return "UNKNOWN";
    }
}

static void print_state_change(
    uint16_t portNumber, PortAnnounceInformationExtSMState last_state,
    PortAnnounceInformationExtSMState current_state) {
    const char *last_state_name = lookup_state_name(last_state);
    const char *current_state_name = lookup_state_name(current_state);
    log_debug("PortAnnounceInformationExtSM[Port: %d]: state change from %s to %s.",
           portNumber, last_state_name, current_state_name);
}

static void rcvInfoExt(PortAnnounceInformationExtSM *sm) {
    // 10.3.14
    // In standard values are saved to port variables, here we save values to
    // PTP instance global variables based on port state.
    if (sm->perPTPInstanceGlobal->selectedState[sm->perPortGlobal->thisPort] == SLAVE_PORT) {
        // copy attributes of the received announce message to global variables
        // (gm) copy priority vector
        sm->perPTPInstanceGlobal->gmStepsRemoved = sm->rcvdAnnouncePtr->stepsRemoved + 1;
        sm->perPTPInstanceGlobal->gmPriority.rootSystemIdentity.priority1 = sm->rcvdAnnouncePtr->grandmasterPriority1;
        sm->perPTPInstanceGlobal->gmPriority.rootSystemIdentity.clockClass = sm->rcvdAnnouncePtr->grandmasterClockQuality.clockClass;
        sm->perPTPInstanceGlobal->gmPriority.rootSystemIdentity.clockAccuracy = sm->rcvdAnnouncePtr->grandmasterClockQuality.clockAccuracy;
        sm->perPTPInstanceGlobal->gmPriority.rootSystemIdentity.offsetScaledLogVariance = sm->rcvdAnnouncePtr->grandmasterClockQuality.offsetScaledLogVariance;
        sm->perPTPInstanceGlobal->gmPriority.rootSystemIdentity.priority2 = sm->rcvdAnnouncePtr->grandmasterPriority2;
        memcpy(sm->perPTPInstanceGlobal->gmPriority.rootSystemIdentity.clockIdentity, sm->rcvdAnnouncePtr->grandmasterIdentity, 8);
        sm->perPTPInstanceGlobal->gmPriority.stepsRemoved = sm->rcvdAnnouncePtr->stepsRemoved + 1;
        memcpy(sm->perPTPInstanceGlobal->gmPriority.sourcePortClockIdentity,sm->rcvdAnnouncePtr->head.sourcePortIdentity.clockIdentity, 8);
        sm->perPTPInstanceGlobal->gmPriority.portNumber = sm->rcvdAnnouncePtr->head.sourcePortIdentity.portNumber;
        // copy path TLV
        sm->perPTPInstanceGlobal->nPathTrace = sm->rcvdAnnouncePtr->pathTraceTLV.lengthField / 8;
        for (int i = 0; i < sm->perPTPInstanceGlobal->nPathTrace; i++) {
            memcpy(sm->perPTPInstanceGlobal->pathTrace[i], sm->rcvdAnnouncePtr->pathTraceTLV.pathSequence[i], 8);
        }
        // append lock clock identity
        memcpy(sm->perPTPInstanceGlobal->pathTrace[sm->perPTPInstanceGlobal->nPathTrace++], sm->perPTPInstanceGlobal->thisClock, 8);

        for (int i = 0; i < sm->perPTPInstanceGlobal->nPathTrace; i++) {
            // printf("#%d path trace(recv & append) is ", i);
            // print_path_trace(sm->perPTPInstanceGlobal->pathTrace[i]);
        }
    }
    // Do not process the announce message received on ports other than slave
    // port.
}

static void recordOtherAnnounceInfo(PortAnnounceInformationExtSM *sm) {
    if (sm->perPTPInstanceGlobal->selectedState[sm->perPortGlobal->thisPort] ==
        SLAVE_PORT) {
        sm->perPTPInstanceGlobal->leap61 =
            (sm->rcvdAnnouncePtr->head.flags[1] & 0x1) == 0x1;
        sm->perPTPInstanceGlobal->leap59 =
            (sm->rcvdAnnouncePtr->head.flags[1] & 0x2) == 0x2;
        sm->perPTPInstanceGlobal->currentUtcOffsetValid =
            (sm->rcvdAnnouncePtr->head.flags[1] & 0x4) == 0x4;
        sm->perPTPInstanceGlobal->ptpTimescale =
            (sm->rcvdAnnouncePtr->head.flags[1] & 0x8) == 0x8;
        sm->perPTPInstanceGlobal->timeTraceable =
            (sm->rcvdAnnouncePtr->head.flags[1] & 0x10) == 0x10;
        sm->perPTPInstanceGlobal->frequencyTraceable =
            (sm->rcvdAnnouncePtr->head.flags[1] & 0x20) == 0x20;
        sm->perPTPInstanceGlobal->currentUtcOffset =
            sm->rcvdAnnouncePtr->currentUtcOffset;
        sm->perPTPInstanceGlobal->timeSource = sm->rcvdAnnouncePtr->timeSource;
    }
    // If no port is slave port, then this PTP instance is the grandmaster. The
    // fields of the above two functions should be specified during
    // initialization.
}

static PortAnnounceInformationExtSMState all_state_transition(PortAnnounceInformationExtSM *sm) {
    bool tricon = (!sm->perPortGlobal->portOper || !sm->perPortGlobal->ptpPortEnabled || !sm->perPortGlobal->asCapable);

    if ((tricon || sm->perPTPInstanceGlobal->BEGIN ||
         !sm->perPTPInstanceGlobal->instanceEnable) &&
        sm->perPTPInstanceGlobal->externalPortConfigurationEnabled) {
        return PAIE_INITIALIZE;
    }

    return sm->state;
}

static void initialize_action(PortAnnounceInformationExtSM *sm, UScaledNs ts) {
    sm->rcvdAnnouncePAIE = 0;
}

static PortAnnounceInformationExtSMState initialize_state_transition(PortAnnounceInformationExtSM *sm, UScaledNs ts) {
    bool portOper = sm->perPortGlobal->portOper;
    bool ptpPortEnabled = sm->perPortGlobal->ptpPortEnabled;
    bool asCapable = sm->perPortGlobal->asCapable;
    if (portOper && ptpPortEnabled && asCapable && sm->rcvdAnnouncePAIE) {
        return PAIE_RECEIVE;
    } else {
        return PAIE_INITIALIZE;
    }
}

static void receive_action(PortAnnounceInformationExtSM *sm, UScaledNs ts) {
    if (sm->perPTPInstanceGlobal->selectedState[sm->perPortGlobal->thisPort] == SLAVE_PORT) {
        rcvInfoExt(sm);
        recordOtherAnnounceInfo(sm);
        // portStepsRemoved = messageStepsRemoved + 1;
    }
    sm->rcvdAnnouncePAIE = 0;
}

static PortAnnounceInformationExtSMState receive_state_transition(PortAnnounceInformationExtSM *sm, UScaledNs ts) {
    bool portOper = sm->perPortGlobal->portOper;
    bool ptpPortEnabled = sm->perPortGlobal->ptpPortEnabled;
    bool asCapable = sm->perPortGlobal->asCapable;
    if (portOper && ptpPortEnabled && asCapable && sm->rcvdAnnouncePAIE) {
        sm->last_state = PAIE_REACTION;
        return PAIE_RECEIVE;
    }
    return PAIE_RECEIVE;
}

void port_announce_information_ext_sm_run(PortAnnounceInformationExtSM *sm, UScaledNs ts) {
    bool state_change;
    sm->state = all_state_transition(sm);
    while (1) {
        state_change = (sm->last_state != sm->state);
        sm->last_state = sm->state;
        switch (sm->state) {
            case PAIE_INIT:
                sm->state = PAIE_INITIALIZE;
                break;
            case PAIE_INITIALIZE:
                if (state_change) initialize_action(sm, ts);
                sm->state = initialize_state_transition(sm, ts);
                break;
            case PAIE_RECEIVE:
                if (state_change) receive_action(sm, ts);
                sm->state = receive_state_transition(sm, ts);
                break;
        }
        if (sm->last_state == sm->state)
            break;
        else
            print_state_change(sm->perPortGlobal->thisPort, sm->last_state, sm->state);
    }
}

void init_port_announce_information_ext_sm(
    PortAnnounceInformationExtSM *sm,
    PerPTPInstanceGlobal *per_ptp_instance_global,
    PerPortGlobal *per_port_global) {
    sm->perPTPInstanceGlobal = per_ptp_instance_global;
    sm->perPortGlobal = per_port_global;

    sm->rcvdAnnouncePAIE = 0;
    sm->rcvdAnnouncePtr = NULL;

    sm->state = PAIE_INIT;
    sm->last_state = PAIE_BEFORE_INIT;

    UScaledNs ts;
    ts.subns = 0;
    ts.nsec = 0;
    ts.nsec_msb = 0;

    port_announce_information_ext_sm_run(sm, ts);
}

void port_announce_information_ext_sm_recv_announce(
    PortAnnounceInformationExtSM *sm, UScaledNs ts,
    PTPMsgAnnounce *announce_msg) {
    if (sm->rcvdAnnouncePtr != NULL) {
        free(sm->rcvdAnnouncePtr);
    }
    sm->rcvdAnnouncePAIE = 1;
    sm->rcvdAnnouncePtr = announce_msg;
    port_announce_information_ext_sm_run(sm, ts);
}
