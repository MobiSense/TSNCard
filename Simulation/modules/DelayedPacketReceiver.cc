#include "../modules/DelayedPacketReceiver.h"

Define_Module(DelayedPacketReceiver);

DelayedPacketReceiver::~DelayedPacketReceiver()
{
    if(packetProcessTimer != nullptr)
        delete packetProcessTimer;
}

void DelayedPacketReceiver::initialize(int stage)
{
    LogPacketReceiver::initialize(stage);
    if(stage == INITSTAGE_LOCAL)
    {
        ethernetGate = getParentModule()->getParentModule();
        packetProcessTimer = new ClockEvent("PacketProcessTimer");
    }
}

void DelayedPacketReceiver::handleMessageWhenUp(cMessage *message)
{
    if(message->isPacket())
    {
        printLog(message);

        storedSignal = message;
        simtime_t processingTime = ethernetGate->par("processingTime");
        rescheduleAt(simTime() + processingTime, packetProcessTimer);
    }
    else if(message == packetProcessTimer)
    {
        if(storedSignal == nullptr)
            throw cRuntimeError("Stored signal lost");

        PacketReceiver::handleMessageWhenUp(storedSignal);
        storedSignal = nullptr;
    }
    else
    {
        PacketReceiver::handleMessageWhenUp(message);
    }
}
