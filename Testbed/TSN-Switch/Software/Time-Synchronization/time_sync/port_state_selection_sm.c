#include "port_state_selection_sm.h"
#include "../log/log.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define RESELECT	      sm->perPTPInstanceGlobal->reselect
#define SELECTED	      sm->perPTPInstanceGlobal->selected
#define SELECTED_STATE    sm->perPTPInstanceGlobal->selectedState
#define LAST_GM_PRIORITY  sm->perPTPInstanceGlobal->lastGmPriority
#define GM_PRIORITY       sm->perPTPInstanceGlobal->gmPriority
#define SYSTEM_PRIORITY   sm->perPTPInstanceGlobal->systemPriority
#define PATH_TRACE        sm->perPTPInstanceGlobal->pathTrace

/* check for portPriority vector, any non-zero value is sufficient */
#define HAS_PORT_PRIORITY(pp) \
        (((pp).rootSystemIdentity.priority1 !=0) || \
         ((pp).rootSystemIdentity.clockClass != 0) || \
         ((pp).rootSystemIdentity.clockAccuracy != 0) || \
         ((pp).rootSystemIdentity.offsetScaledLogVariance != 0) || \
         ((pp).rootSystemIdentity.priority2 != 0) || \
         ((pp).stepsRemoved != 0))

static const char *lookup_state_name(PortStateSelectionSMState state) {
    switch (state) {
        case PSSEL_BEFORE_INIT:
            return "PSSEL_BEFORE_INIT";
        case PSSEL_INIT:
            return "PSSEL_INIT";
        case PSSEL_INIT_BRIDGE:
            return "PSSEL_INIT_BRIDGE";
        case PSSEL_STATE_SELECTION:
            return "PSSEL_STATE_SELECTION";
        case PSSEL_REACTION:
            return "PSSEL_REACTION";
        default:
            return "UNKNOWN";
    }
}

static void print_state_change(PortStateSelectionSMState last_state, PortStateSelectionSMState current_state) {
    const char *last_state_name = lookup_state_name(last_state);
    const char *current_state_name = lookup_state_name(current_state);
    log_debug("PortStateSelectionSM: state change from %s to %s.", last_state_name, current_state_name);
}

static PortStateSelectionSMState all_state_transition(PortStateSelectionSM *sm) {
    if ((sm->perPTPInstanceGlobal->BEGIN || !sm->perPTPInstanceGlobal->instanceEnable) &&
        !sm->perPTPInstanceGlobal->externalPortConfigurationEnabled) {
        return PSSEL_INIT_BRIDGE;
    }
    return sm->state;
}

static void updtStateDisabledTree(PortStateSelectionSM* sm, UScaledNs ts) {
    int i;
	for(i = 0; i < N_PORTS; i++){
		SELECTED_STATE[i+1] = DISABLED_PORT;
	}
    memset(&LAST_GM_PRIORITY, 1, sizeof(PriorityVector));
    memcpy(&PATH_TRACE[0], sm->perPTPInstanceGlobal->thisClock, 8);
    sm->perPTPInstanceGlobal->nPathTrace = 1;
}

static void* init_bridge_action(PortStateSelectionSM* sm, UScaledNs ts) {
    updtStateDisabledTree(sm, ts);
    return NULL;
}

static PortStateSelectionSMState init_bridge_state_transition(PortStateSelectionSM* sm, UScaledNs ts) {
    return PSSEL_STATE_SELECTION;
}

static void clearReselectTree(PortStateSelectionSM* sm) {
    /* 10.3.13.2.2 set all reselect element to false */
	int i;
	for(i = 0; i <= N_PORTS; i++){
		RESELECT[i] = false;
	}
}
static int portStateUpdate(PortStateSelectionSM* sm, PortState* selected_state, PerPortGlobal* perPortGlobal, PriorityVector* gmPathPriority) {
    Enumeration2 oldState;
	int N;

	oldState = *selected_state;
	if(perPortGlobal->infoIs == INFOIS_DISABLED) {
        /* f) 1) */
		*selected_state = DISABLED_PORT;
		perPortGlobal->updtInfo = false;
	} else if(perPortGlobal->asymmetryMeasurementMode == true) {
        /* f) 2) */
		*selected_state = PASSIVE_PORT;
		perPortGlobal->updtInfo = false;
	} else if(perPortGlobal->infoIs == INFOIS_AGED) {
        /* f) 3) */
		perPortGlobal->updtInfo = true;
		*selected_state = MASTER_PORT;
	} else if(perPortGlobal->infoIs == INFOIS_MINE) {
        /* f) 4) */
		*selected_state = MASTER_PORT;
		if ((memcmp(&perPortGlobal->masterPriority, &perPortGlobal->portPriority, sizeof(PriorityVector)) != 0) ||
		    (sm->perPTPInstanceGlobal->masterStepsRemoved != perPortGlobal->portStepsRemoved)){
			perPortGlobal->updtInfo = true;
		}
	} else if(perPortGlobal->infoIs == INFOIS_RECEIVED) {
        // gmPriority is derived from portPriority
		if (memcmp(&GM_PRIORITY, gmPathPriority, sizeof(PriorityVector)) == 0){
            /* f) 5) */
			*selected_state = SLAVE_PORT;
			perPortGlobal->updtInfo = false;
		}else{
            print_priority_vector("masterPriority", &perPortGlobal->masterPriority, __FILE__, __LINE__);
            print_priority_vector("portPriority", &perPortGlobal->portPriority, __FILE__, __LINE__);
			if (SUPERIOR_PRIORITY != compare_priority_vectors(&perPortGlobal->masterPriority, &perPortGlobal->portPriority)){
                /* f) 6) & f) 7) */
				*selected_state = PASSIVE_PORT;
				perPortGlobal->updtInfo = false;
			} else {
				/* f) 8) */
                // masterPriority is better than portPriority
				*selected_state = MASTER_PORT;
				perPortGlobal->updtInfo = true;
			}
		}
	}

    if ((*selected_state == SLAVE_PORT) && (oldState != SLAVE_PORT)){
		// ??? transition from none SlavePort to this port as SlavePort must
		// update the global pathTrace
		N = perPortGlobal->annPathSequenceCount < MAX_PATH_TRACE_N ?
			perPortGlobal->annPathSequenceCount : MAX_PATH_TRACE_N;
		if(N + 1 <= MAX_PATH_TRACE_N){
			// copy pathSequence to pathTrace
			memcpy(PATH_TRACE, &perPortGlobal->annPathSequence, sizeof(ClockIdentity) * N);
			// append thisClock to pathTrace
			memcpy(&(PATH_TRACE[N]), sm->perPTPInstanceGlobal->thisClock, sizeof(ClockIdentity));
			sm->perPTPInstanceGlobal->nPathTrace = N + 1;
		}else{
			/* 10.3.8.23 ... a path trace TLV is not appended to an Announce message
			   and the pathTrace array is empty, once appending a clockIdentity
			   to the TLV would cause the frame carrying the Announce to exceed
			   its maximum size. */
			sm->perPTPInstanceGlobal->nPathTrace = 0;
		}
	}

	if(oldState != *selected_state) return 1;
	return 0;
}

static void update_lastGmInfo(PortStateSelectionSM* sm)
{
	// sm->perPTPInstanceGlobal->gmTimeBaseIndicator++;
	// memset(&sm->perPTPInstanceGlobal->lastGmPhaseChange, 0, sizeof(ScaledNs));
	// if(gptpconf_get_intitem(CONF_RESET_FREQADJ_BECOMEGM))
	// 	sm->perPTPInstanceGlobal->lastGmFreqChange =
	// 		(double)(-gptpclock_get_adjppb(0, sm->perPTPInstanceGlobal->domainNumber))	/ 1.0E9;
	// else
	// 	sm->perPTPInstanceGlobal->lastGmFreqChange = 0.0;
}

// TODO: finish updtStatesTree()
static void* updtStatesTree(PortStateSelectionSM* sm) {
    int i;
    PriorityVector gmPathPriority[N_PORTS];
    bool slavePortAvail = false;
    Enumeration2 oldState;
    void *rval = NULL;
    bool gmchange = false;

    /* 10.3.12.2.4 */
	// a) compute gmPathPriority vector for each port
    for (i = 0; i < N_PORTS; i++) {
        // initialize gmPathPriority as inferior (set all to 0xFF)
        memset(&gmPathPriority[i], 0xFF, sizeof(PriorityVector));
        if (HAS_PORT_PRIORITY(sm->perPortGlobalArray[i].portPriority) && (sm->perPortGlobalArray[i].infoIs != INFOIS_AGED)) {
            // gmPathPriority = {RM: SRM+1: PM: PNS}
            memcpy(&gmPathPriority[i], &sm->perPortGlobalArray[i].portPriority, sizeof(PriorityVector));
            gmPathPriority[i].stepsRemoved += 1;
        }
    }

    // b) save gmPriority to lastGmPriority
    memcpy(&LAST_GM_PRIORITY, &GM_PRIORITY, sizeof(PriorityVector));

    // c) Sets the per PTP Instance global variables leap61, leap59, currentUtcOffsetValid, ptpTimescale, 
    //    timeTraceable, frequencyTraceable, currentUtcOffset, and timeSource
    // chose gmPriority as the best (superior) from the set of systemPriority and gmPathPriority
    memcpy(&GM_PRIORITY, &SYSTEM_PRIORITY, sizeof(PriorityVector));
    sm->perPTPInstanceGlobal->leap61                = sm->perPTPInstanceGlobal->sysLeap61;
	sm->perPTPInstanceGlobal->leap59                = sm->perPTPInstanceGlobal->sysLeap59;
	sm->perPTPInstanceGlobal->currentUtcOffsetValid = sm->perPTPInstanceGlobal->sysCurrentUTCOffsetValid;
	sm->perPTPInstanceGlobal->ptpTimescale          = sm->perPTPInstanceGlobal->sysPtpTimescale;
	sm->perPTPInstanceGlobal->timeTraceable         = sm->perPTPInstanceGlobal->sysTimeTraceable;
	sm->perPTPInstanceGlobal->frequencyTraceable    = sm->perPTPInstanceGlobal->sysFrequencyTraceable;
	sm->perPTPInstanceGlobal->currentUtcOffset      = sm->perPTPInstanceGlobal->sysCurrentUtcOffset;
	sm->perPTPInstanceGlobal->timeSource            = sm->perPTPInstanceGlobal->sysTimeSource;

    for (i = 0; i < N_PORTS; i++) {
        if (sm->perPortGlobalArray[i].infoIs == INFOIS_DISABLED) continue;
        if ((memcmp(gmPathPriority[i].sourcePortClockIdentity, &sm->perPTPInstanceGlobal->thisClock, 8) != 0) &&
            (SUPERIOR_PRIORITY == compare_priority_vectors(&gmPathPriority[i], &GM_PRIORITY))
        ) {
            // log_debug("new gmPriority from portIndex=%d", i);
            memcpy(&GM_PRIORITY, &gmPathPriority[i], sizeof(PriorityVector));
            sm->perPTPInstanceGlobal->leap61                = sm->perPortGlobalArray[i].annLeap61;
			sm->perPTPInstanceGlobal->leap59                = sm->perPortGlobalArray[i].annLeap59;
			sm->perPTPInstanceGlobal->currentUtcOffsetValid = sm->perPortGlobalArray[i].annCurrentUtcOffsetValid;
			sm->perPTPInstanceGlobal->ptpTimescale          = sm->perPortGlobalArray[i].annPtpTimescale;
			sm->perPTPInstanceGlobal->timeTraceable         = sm->perPortGlobalArray[i].annTimeTraceable;
			sm->perPTPInstanceGlobal->frequencyTraceable    = sm->perPortGlobalArray[i].annFrequencyTraceable;
			sm->perPTPInstanceGlobal->currentUtcOffset      = sm->perPortGlobalArray[i].annCurrentUtcOffset;
			sm->perPTPInstanceGlobal->timeSource            = sm->perPortGlobalArray[i].annTimeSource;
            // log_debug("new GM from domainIndex=%d portIndex=%d, state=%s", sm->perPTPInstanceGlobal->domainNumber, i, lookup_port_state_name(SELECTED_STATE[i]));
        }
    }

    if(memcmp(&LAST_GM_PRIORITY, &GM_PRIORITY, sizeof(PriorityVector))) {
        // TODO: gptpclock_set_gmchange
        // gptpclock_set_gmchange(sm->ptasg->domainNumber, GM_PRIORITY.rootSystemIdentity.clockIdentity);
        // log_debug("domainIndex=%d, GM changed", sm->perPTPInstanceGlobal->domainNumber);
        gmchange = true;
		rval = GM_PRIORITY.rootSystemIdentity.clockIdentity;
    }

    // d) compute masterPriority for each port
    for (i = 0; i < N_PORTS; i++) {
        // masterPriority Vector = { SS : 0: { CS: PNQ}: PNQ} or
		// masterPriority Vector = { RM : SRM+1: { CS: PNQ}: PNQ} or
        memcpy(&sm->perPortGlobalArray[i].masterPriority, &GM_PRIORITY, sizeof(PriorityVector));
		memcpy(&sm->perPortGlobalArray[i].masterPriority.sourcePortClockIdentity, &sm->perPTPInstanceGlobal->thisClock, 8);
		sm->perPortGlobalArray[i].masterPriority.sourcePortNumber = sm->perPortGlobalArray[i].thisPort;
		sm->perPortGlobalArray[i].masterPriority.portNumber = sm->perPortGlobalArray[i].thisPort;
    }

    // e) compute masterStepsRemoved
    sm->perPTPInstanceGlobal->masterStepsRemoved = GM_PRIORITY.stepsRemoved;

    // f) assign port state
    for (i = 1; i <= N_PORTS; i++) {
        oldState = SELECTED_STATE[i];
        portStateUpdate(sm, &SELECTED_STATE[i], &(sm->perPortGlobalArray[i-1]), &gmPathPriority[i-1]);
        // if (portStateUpdate(sm, &SELECTED_STATE[i], &(sm->perPortGlobalArray[i]), &gmPathPriority[i])) {
            
        //     if (oldState == SLAVE_PORT)
		// 		// gptpclock_reset_gmsync(0, sm->perPTPInstanceGlobal->domainNumber);
		// 	continue;
        // }
        // log_info("Port %d state: %s", i, lookup_port_state_name(SELECTED_STATE[i]));
    }

    // g) update gmPresent
	if (GM_PRIORITY.rootSystemIdentity.priority1 < 255){
		sm->perPTPInstanceGlobal->gmPresent = true;
	} else {
		sm->perPTPInstanceGlobal->gmPresent = false;
	}

	// h) assign portState for port 0
	for (i = 1; i <= N_PORTS; i++){
		if (SELECTED_STATE[i] == SLAVE_PORT){
			slavePortAvail = true;
			break;
		}
	}

    // update master port
	oldState = SELECTED_STATE[0];
	if(slavePortAvail){
		SELECTED_STATE[0] = MASTER_PORT; // we are not GM
	}else{
		SELECTED_STATE[0] = SLAVE_PORT; // we are GM
		// if(gmchange) 
        //     update_lastGmInfo(sm->perPTPInstanceGlobal);
	}
    // log_info("Port %d state: %s", 0, lookup_port_state_name(SELECTED_STATE[0]));

    if (gmchange) {
        log_info("Port state changed.");
        for (i = 0; i <= N_PORTS; i++) {
            log_info("Port %d state: %s", i, lookup_port_state_name(SELECTED_STATE[i]));
        }
    }
	// if(oldState != SELECTED_STATE[0]){
	// 	if(SELECTED_STATE[0] == SLAVE_PORT){
	// 		/* we are GM and the clock doesn't have to sync to the other,
	// 		   which means the master clock is synced status.
	// 		   if init_slave_ts is set, defer gptpclock_set_gmsync */
	// 		if(!sm->deferred_gmsync) {
    //             gptpclock_set_gmsync(0, sm->perPTPInstanceGlobal->domainNumber, sm->perPTPInstanceGlobal->thisClock, true);
    //         }
				
	// 	} else{
	// 		gptpclock_reset_gmsync(0, sm->perPTPInstanceGlobal->domainNumber);
	// 	}
	// }

	// i) system is the grandmaster, set pathTrace to thisClock
	if (memcmp(&sm->perPTPInstanceGlobal->thisClock, &GM_PRIORITY.rootSystemIdentity.clockIdentity, 8) == 0){
		memcpy(&PATH_TRACE[0], &sm->perPTPInstanceGlobal->thisClock, 8);
		sm->perPTPInstanceGlobal->nPathTrace = 1;
	}
	
    return rval;
}

static void setSelectedTree(PortStateSelectionSM* sm) {
    /* 10.3.13.2.3 set all selected element to true */
	int i;
	for(i = 0; i <= N_PORTS; i++){
		SELECTED[i] = true;
	}
}


static void* state_selection_action(PortStateSelectionSM* sm, UScaledNs ts) {
    void *rval;

    sm->systemIdentityChange = 0;
    sm->asymmetryMeasurementModeChange = 0;
    clearReselectTree(sm);
    rval = updtStatesTree(sm);
    setSelectedTree(sm);
    return rval;
}

static PortStateSelectionSMState state_selection_state_transition(PortStateSelectionSM* sm, UScaledNs ts) {
	bool reselected = false;
	for (int i = 0; i <= N_PORTS; i++) {
		if (RESELECT[i]) reselected = true;
	}
	if ((reselected) || (sm->systemIdentityChange) ||
	    (sm->asymmetryMeasurementModeChange)){
		sm->last_state = PSSEL_REACTION;
		return PSSEL_STATE_SELECTION;
	}
	return sm->state;
}

// return clockIdentity when GM has changed
void *port_state_selection_sm_run(PortStateSelectionSM *sm, UScaledNs ts) {
    bool state_change;
    void *retp = NULL;

    sm->state = all_state_transition(sm);
    while (1) {
        state_change = (sm->last_state != sm->state);
        sm->last_state = sm->state;
        switch (sm->state){
            case PSSEL_BEFORE_INIT:
                break;
            case PSSEL_INIT:
                sm->state = PSSEL_INIT_BRIDGE;
                break;
            case PSSEL_INIT_BRIDGE:
                if (state_change) 
                    retp = init_bridge_action(sm, ts);
                sm->state = init_bridge_state_transition(sm, ts);
                break;
            case PSSEL_STATE_SELECTION:
                if (state_change) 
                    retp = state_selection_action(sm, ts);
                sm->state = state_selection_state_transition(sm, ts);
                break;
            case PSSEL_REACTION:
                break;
        }
        if (retp) return retp;
        if (sm->last_state == sm->state)
            break;
        else
            print_state_change(sm->last_state, sm->state);
    } 
    return retp;
}

void init_port_state_selection_sm(PortStateSelectionSM *sm, PerPTPInstanceGlobal *per_ptp_instance_global, PerPortGlobal *per_port_global_array) {
    sm->perPTPInstanceGlobal = per_ptp_instance_global;
    sm->perPortGlobalArray = per_port_global_array;

    sm->systemIdentityChange = 0;
    sm->asymmetryMeasurementModeChange = 0;

    sm->state = PSSEL_INIT;
    sm->last_state = PSSEL_BEFORE_INIT;

    UScaledNs ts;
    ts.subns = 0;
    ts.nsec = 0;
    ts.nsec_msb = 0;

    port_state_selection_sm_run(sm, ts);
}