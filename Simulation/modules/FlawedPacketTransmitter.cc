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

#include "FlawedPacketTransmitter.h"

Define_Module(FlawedPacketTransmitter)

FlawedPacketTransmitter::~FlawedPacketTransmitter() {
    if(txDelayTimer != nullptr)
        delete txDelayTimer;
}

void FlawedPacketTransmitter::setErrorSimulator(ErrorSimulator* sim) {
    errorSimulator = sim;
}

void FlawedPacketTransmitter::initialize(int stage) {
    LogPacketTransmitter::initialize(stage);
    if(stage == INITSTAGE_LOCAL) {
        txDelayTimer = new ClockEvent("txDelayTimer");
    }
}

void FlawedPacketTransmitter::handleMessageWhenUp(cMessage *message) {
    if(message == txDelayTimer) {
        if(storedSignal == nullptr)
            throw cRuntimeError("Stored packet lost");

        // ------------------- Base method -------------------
        EV_INFO << "Transmitting signal to channel" << EV_FIELD(storedSignal) << EV_ENDL;
        // ------------------- Base method -------------------
        send(storedSignal, SendOptions().duration(storedSignal->getDuration()), outputGate);

        EV_WARN << "[Packet Info] " << ethGateName << ": Transmitted " << storedSignal->getName() << " at " << simTime() << EV_ENDL;
        storedSignal = nullptr;
    }
    else {
        LogPacketTransmitter::handleMessageWhenUp(message);
    }
}

void FlawedPacketTransmitter::startTx(Packet *packet) {
    if(errorSimulator != nullptr) {
        if(errorSimulator->shouldGeneratePacketDelay(ethGateName, packet->getName())) {

            // Inherited from PacketTransmitter

            // ------------------- Base method -------------------
            // 1. check current state
            ASSERT(!isTransmitting());
            // 2. store transmission progress
            txDatarate = bps(*dataratePar);
            txStartTime = simTime();
            txStartClockTime = getClockTime();
            // 3. create signal
            auto signal = encodePacket(packet);
            txSignal = signal->dup();
            // 4. send signal start and notify subscribers
            emit(transmissionStartedSignal, signal);
            prepareSignal(signal);
            // ------------------- Base method -------------------

            storedSignal = signal;
            simtime_t delayTime = errorSimulator->getPacketDelayTime();
            rescheduleAt(simTime() + delayTime, txDelayTimer);

            EV_WARN << "[Error Config] " << "(PacketDelay error) "
                    << ethGateName << ": "
                    << "Packet " << packet->getName()
                    << " delayed for " << (double)(delayTime.inUnit(SIMTIME_NS)) / 1e3 << "us" << EV_ENDL;

            // ------------------- Base method -------------------
            // 5. schedule transmission end timer
            // ------------------- Base method -------------------
            scheduleClockEventAfter(SIMTIME_AS_CLOCKTIME(signal->getDuration() + delayTime), txEndTimer);

        }
        else {
            LogPacketTransmitter::startTx(packet);
        }
    }
    else {
        LogPacketTransmitter::startTx(packet);
    }
}
