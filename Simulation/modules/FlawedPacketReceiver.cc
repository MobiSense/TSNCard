//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

#include "../modules/FlawedPacketReceiver.h"

Define_Module(FlawedPacketReceiver);

void FlawedPacketReceiver::handleMessageWhenUp(cMessage *message) {
    // ------------------- Base method -------------------
    if(message->isPacket())
    {
        printLog(message);
    // ------------------- Base method -------------------

        if(errorSimulator != nullptr) {
            if(errorSimulator->shouldGeneratePacketLoss(switchName, message->getName())) {
                EV_WARN << "[Error Config] " << "(PacketLoss error) ";
                EV_WARN << switchName << ": ";
                EV_WARN << "Packet " << message->getName() << " lost" << EV_ENDL;

                delete message;
                return;
            }
        }

    // ------------------- Base method -------------------
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
    // ------------------- Base method -------------------
}

void FlawedPacketReceiver::setErrorSimulator(ErrorSimulator* sim) {
    errorSimulator = sim;
}

void FlawedPacketReceiver::setGateName(const char* swName) {
    switchName = swName;
}
