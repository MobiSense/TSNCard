#include "../modules/LogComponents.h"

// ------------------- LogPacketReceiver -------------------

Define_Module(LogPacketReceiver);

void LogPacketReceiver::initialize(int stage)
{
    PacketReceiver::initialize(stage);
    if(stage == INITSTAGE_LOCAL)
    {
        cModule* ethernetGate = getParentModule()->getParentModule();
        ethGateName =  ethernetGate->getParentModule()->getName();
        ethGateName += ".eth";
        ethGateName += std::to_string(ethernetGate->getIndex());
    }
}

void LogPacketReceiver::handleMessageWhenUp(cMessage *message)
{
    if(message->isPacket())
    {
        printLog(message);
    }
    PacketReceiver::handleMessageWhenUp(message);
}

void LogPacketReceiver::printLog(cMessage* message)
{
    EV_WARN << "[Packet Info] " << ethGateName << ": Received " << message->getName() << " at " << simTime() << EV_ENDL;
}

// ------------------- LogPacketReceiver -------------------



// ------------------- LogPacketTransmitter -------------------

Define_Module(LogPacketTransmitter);

void LogPacketTransmitter::initialize(int stage)
{
    PacketTransmitter::initialize(stage);
    if(stage == INITSTAGE_LOCAL)
    {
        cModule* ethernetGate = getParentModule()->getParentModule();
        ethGateName =  ethernetGate->getParentModule()->getName();
        ethGateName += ".eth";
        ethGateName += std::to_string(ethernetGate->getIndex());
    }
}

void LogPacketTransmitter::startTx(Packet *packet)
{
    EV_WARN << "[Packet Info] " << ethGateName << ": Transmitted " << packet->getName() << " at " << simTime() << EV_ENDL;
    PacketTransmitter::startTx(packet);
}

// ------------------- LogPacketTransmitter -------------------



// ------------------- EthernetGateLogger -------------------

Define_Module(EthernetGateLogger);

void EthernetGateLogger::initialize()
{
    cModule* ethernetGate = getParentModule();
    cModule* transmissionGate = ethernetGate -> getSubmodule("macLayer")->getSubmodule("queue")->getSubmodule("transmissionGate", 0);

    // Identity
    EV_WARN << "[Gate Config] Gate " << ethernetGate->getParentModule()->getName() << ".eth" << ethernetGate->getIndex() << ":";

    // Topology
    cModule* destReceiver = (cModule*)ethernetGate->gate("phys$o")->getPathEndGate()->getOwner();
    cModule* destEthernetGate = destReceiver->getParentModule()->getParentModule();
    EV_WARN << " (Destination)" << destEthernetGate->getParentModule()->getName() << ".eth" << destEthernetGate->getIndex();

    // Gate control
    if(ethernetGate->par("hasTas").boolValue()) {
        EV_WARN << " (Offset)" << transmissionGate->par("offset").doubleValue()*1e6 << "us";
        EV_WARN << " (Durations)" << transmissionGate->par("durations").objectValue()->str();
    }

    EV_WARN << EV_ENDL;
}

// ------------------- EthernetGateLogger -------------------



// ------------------- UdpSourceAppLogger -------------------

Define_Module(UdpSourceAppLogger);

void UdpSourceAppLogger::initialize()
{
    cModule* appModule = getParentModule();

    EV_WARN << "[Flow Config] Flow flow" << appModule->par("flowId").intValue() << ":";
    EV_WARN << " From " << appModule->getParentModule()->getName();
    EV_WARN << " to " << appModule->getSubmodule("io")->par("destAddress").stringValue();
    EV_WARN << ", period " << appModule->getSubmodule("source")->par("productionInterval").doubleValue()*1e6 << "us" << EV_ENDL;
}

// ------------------- UdpSourceAppLogger -------------------
