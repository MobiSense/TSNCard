#ifndef MODULES_LOGCOMPONENTS_H_
#define MODULES_LOGCOMPONENTS_H_

#include<omnetpp/csimplemodule.h>
#include<inet/protocolelement/transceiver/PacketReceiver.h>
#include<inet/protocolelement/transceiver/PacketTransmitter.h>
#include<inet/linklayer/configurator/MacForwardingTableConfigurator.h>

using namespace inet;

/**
 * Logged PacketReceiver
 * Replacement for PacketReceiver
 */
class LogPacketReceiver: public PacketReceiver
{
protected:
    virtual void initialize(int stage) override;
    virtual void handleMessageWhenUp(cMessage *message) override;

    void printLog(cMessage* message);

    std::string ethGateName;
};


/**
 * Logged Transmitter
 * Replacement for PacketTransmitter
 */
class LogPacketTransmitter: public PacketTransmitter
{
protected:
    virtual void initialize(int stage) override;
    virtual void startTx(Packet *packet) override;

protected:
    std::string ethGateName;
};


/**
 * EthernetGate Logger
 * Installed on LayeredEthernetInterface
 */
class EthernetGateLogger: public cSimpleModule
{
protected:
    virtual void initialize() override;
};


/**
 * UdpSourceApp Logger
 * Installed on UdpSourceApp
 */
class UdpSourceAppLogger: public cSimpleModule
{
protected:
    virtual void initialize() override;
};


#endif /* MODULES_LOGCOMPONENTS_H_ */
