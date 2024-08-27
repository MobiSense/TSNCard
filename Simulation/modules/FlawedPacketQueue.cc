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

#include "../modules/FlawedPacketQueue.h"

Define_Module(FlawedPacketQueue);

void FlawedPacketQueue::pushPacket(Packet *packet, cGate *gate) {
    // ------------------- Base method -------------------
    Enter_Method("pushPacket");
    take(packet);
    cNamedObject packetPushStartedDetails("atomicOperationStarted");
    emit(packetPushStartedSignal, packet, &packetPushStartedDetails);
    EV_INFO << "Pushing packet" << EV_FIELD(packet) << EV_ENDL;
    // ------------------- Base method -------------------

    // Derived from:
    // queue.insert(packet);
    if(errorSimulator != nullptr && queue.getLength() > 0) {
        if(errorSimulator->shouldGenerateQueueFlaw(gateName, packet->getName())) {
            cPacket* queueFront = queue.front();

            EV_WARN << "[Error Config] " << "(Queue error) ";
            EV_WARN << gateName << ": ";
            EV_WARN << "Packet " << packet->getName() << " <---> Packet " << queueFront->getName() << EV_ENDL;

            queue.insertBefore(queueFront, packet);
        }
        else {
            queue.insert(packet);
        }
    }
    else {
        queue.insert(packet);
    }

    // ------------------- Base method -------------------
    if (buffer != nullptr)
        buffer->addPacket(packet);
    else if (packetDropperFunction != nullptr) {
        while (isOverloaded()) {
            auto packet = packetDropperFunction->selectPacket(this);
            EV_INFO << "Dropping packet" << EV_FIELD(packet) << EV_ENDL;
            queue.remove(packet);
            dropPacket(packet, QUEUE_OVERFLOW);
        }
    }
    ASSERT(!isOverloaded());
    if (collector != nullptr && getNumPackets() != 0)
        collector->handleCanPullPacketChanged(outputGate->getPathEndGate());
    cNamedObject packetPushEndedDetails("atomicOperationEnded");
    emit(packetPushEndedSignal, nullptr, &packetPushEndedDetails);
    updateDisplayString();
    // ------------------- Base method -------------------
}

void FlawedPacketQueue::setErrorSimulator(ErrorSimulator* sim) {
    errorSimulator = sim;
}

void FlawedPacketQueue::setGateName(const char* switchName, int gateIndex) {
    gateName = "";
    gateName += switchName;
    gateName += ".eth";
    gateName += std::to_string(gateIndex);
}
