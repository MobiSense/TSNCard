#ifndef PORT_ANNOUNCE_INFORMATION_EXT_SM_H
#define PORT_ANNOUNCE_INFORMATION_EXT_SM_H

#include "../tsn_drivers/ptp_types.h"
#include "md_sync_receive_sm.h"

typedef enum {
    PAIE_REACTION,
    PAIE_BEFORE_INIT,
    PAIE_INIT,
    PAIE_INITIALIZE,
    PAIE_RECEIVE,
} PortAnnounceInformationExtSMState;

typedef struct PortAnnounceInformationExtSM {
    bool rcvdAnnouncePAIE;
    PriorityVector messagePriorityPAIE;
    PTPMsgAnnounce *rcvdAnnouncePtr;

    PerPTPInstanceGlobal *perPTPInstanceGlobal;
    PerPortGlobal *perPortGlobal;

    // Some state machine that this sm may need to communicate
    // PortSyncSyncReceiveSM *pssr_sm;

    PortAnnounceInformationExtSMState state;
    PortAnnounceInformationExtSMState last_state;
} PortAnnounceInformationExtSM;

void port_announce_information_ext_sm_run(PortAnnounceInformationExtSM *sm, UScaledNs ts);
void port_announce_information_ext_sm_recv_announce(PortAnnounceInformationExtSM *sm, UScaledNs ts, PTPMsgAnnounce *announce_msg);
void init_port_announce_information_ext_sm(PortAnnounceInformationExtSM *sm, PerPTPInstanceGlobal *per_ptp_instance_global, PerPortGlobal *per_port_global);

#endif