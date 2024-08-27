#ifndef MODULES_DELAYEDPACKETRECEIVER_H_
#define MODULES_DELAYEDPACKETRECEIVER_H_

#include "../modules/LogComponents.h"

/**
 * Delayed LogPacketReceiver
 * Replacement for LogPacketReceiver
 */
class DelayedPacketReceiver: public LogPacketReceiver
{
protected:
    virtual void initialize(int stage) override;
    virtual void handleMessageWhenUp(cMessage *message) override;

    virtual ~DelayedPacketReceiver();

protected:
    cModule* ethernetGate = nullptr;
    ClockEvent* packetProcessTimer = nullptr;
    cMessage* storedSignal = nullptr;
};

#endif /* MODULES_DELAYEDPACKETRECEIVER_H_ */
