#ifndef PORT_ANNOUNCE_TRANSMIT_SM_H
#define PORT_ANNOUNCE_TRANSMIT_SM_H

#include "../tsn_drivers/ptp_types.h"

typedef enum {
    PAT_REACTION,
    PAT_BEFORE_INIT,
    PAT_INIT,
    PAT_TRANSMIT_INIT,
    PAT_TRANSMIT_PERIODIC,
    PAT_IDLE,
    PAT_TRANSMIT_ANNOUNCE,
} PortAnnounceTransmitSMState;

typedef struct PortAnnounceTransmitSM {
    UScaledNs announceSendTime;
    uint8_t numberAnnounceTransmission;
    UScaledNs interval2;

    PerPTPInstanceGlobal *perPTPInstanceGlobal;
    PerPortGlobal *perPortGlobal;

    uint16_t sequenceId;
    PTPMsgAnnounce *txAnnouncePtr;
    bool newInfo;
    bool announceSlowdown;

    PortAnnounceTransmitSMState state;
    PortAnnounceTransmitSMState last_state;
} PortAnnounceTransmitSM;

void init_port_announce_transmit_sm(PortAnnounceTransmitSM *sm, PerPTPInstanceGlobal *per_ptp_instance_global, PerPortGlobal *per_port_global);
void port_announce_transmit_sm_run(PortAnnounceTransmitSM *sm, UScaledNs ts);

#endif