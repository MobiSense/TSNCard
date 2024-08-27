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

#ifndef MODULES_FLAWEDPACKETQUEUE_H_
#define MODULES_FLAWEDPACKETQUEUE_H_

#include<inet/queueing/queue/PacketQueue.h>
#include "../modules/ErrorSimulator.h"

using namespace inet;
using namespace queueing;

class FlawedPacketQueue: public PacketQueue {
public:
    virtual void pushPacket(Packet *packet, cGate *gate) override;
    void setErrorSimulator(ErrorSimulator* sim);
    void setGateName(const char* switchName, int gateIndex);

private:
    std::string gateName;
    ErrorSimulator* errorSimulator = nullptr;
};

#endif /* MODULES_FLAWEDPACKETQUEUE_H_ */
