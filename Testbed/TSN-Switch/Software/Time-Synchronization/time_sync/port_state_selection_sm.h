#ifndef PORT_STATE_SELECTION_SM_H
#define PORT_STATE_SELECTION_SM_H

#include "../tsn_drivers/ptp_types.h"
#include "md_sync_receive_sm.h"

typedef enum {
    PSSEL_BEFORE_INIT,
    PSSEL_INIT,
    PSSEL_INIT_BRIDGE,
    PSSEL_STATE_SELECTION,
    PSSEL_REACTION
} PortStateSelectionSMState;

typedef struct PortStateSelectionSM {
    bool systemIdentityChange; // 10.3.13.1.1
    bool asymmetryMeasurementModeChange; // 10.3.13.1.2

    bool deferred_gmsync;

    PerPTPInstanceGlobal *perPTPInstanceGlobal;
    PerPortGlobal *perPortGlobalArray;

    PortStateSelectionSMState state;
    PortStateSelectionSMState last_state;
} PortStateSelectionSM;

void init_port_state_selection_sm(PortStateSelectionSM *sm, PerPTPInstanceGlobal *per_ptp_instance_global, PerPortGlobal    *per_port_global_array);
void* port_state_selection_sm_run(PortStateSelectionSM *sm, UScaledNs ts);

#endif