#ifndef PORT_ANNOUNCE_INFORMATION_SM_H
#define PORT_ANNOUNCE_INFORMATION_SM_H

#include "../tsn_drivers/ptp_types.h"
#include "md_sync_receive_sm.h"

typedef enum {
    PAI_BEFORE_INIT,
    PAI_INIT,
    PAI_DISABLED,
    PAI_AGED,
    PAI_UPDATE,
    PAI_CURRENT,
    PAI_RECEIVE,
    PAI_INFERIOR_MASTER_OR_OTHER_PORT,
    PAI_REPEATED_MASTER_PORT,
    PAI_SUPERIOR_MASTER_PORT
} PortAnnounceInformationSMState;

typedef struct PortAnnounceInformationSM {
    UScaledNs announceReceiptTimeoutTime; // 10.3.12.1.1
    PriorityVector messagePriorityPAI; // 10.3.12.1.2
    Enumeration2 rcvdInfo; // 10.3.12.1.3
    
    PTPMsgAnnounce *rcvdAnnouncePtr;

    PerPTPInstanceGlobal *perPTPInstanceGlobal;
    PerPortGlobal *perPortGlobal;

    PortAnnounceInformationSMState state;
    PortAnnounceInformationSMState last_state;
} PortAnnounceInformationSM;

void init_port_announce_information_sm(PortAnnounceInformationSM *sm, PerPTPInstanceGlobal *per_ptp_instance_global, PerPortGlobal *per_port_global);
void port_announce_information_sm_run(PortAnnounceInformationSM *sm, UScaledNs ts);
void port_announce_information_sm_recv_announce(PortAnnounceInformationSM *sm, UScaledNs ts, PTPMsgAnnounce *announce_msg);

#endif