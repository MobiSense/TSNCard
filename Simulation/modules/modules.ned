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

package modules;

import inet.networks.base.TsnNetworkBase;
import inet.protocolelement.transceiver.PacketReceiver;
import inet.protocolelement.transceiver.PacketTransmitter;
import inet.linklayer.ethernet.LayeredEthernetInterface;
import inet.applications.udpapp.UdpSourceApp;
import inet.queueing.queue.PacketQueue;
import inet.linklayer.ethernet.common.RelayInterfaceLearner;


// ------------------- Log Components -------------------

// Log for PacketReceiver & Packet Transmitter
simple LogPacketReceiver extends PacketReceiver
{
    parameters:
        @class(LogPacketReceiver);
}
simple LogPacketTransmitter extends PacketTransmitter
{
    parameters:
        @class(LogPacketTransmitter);
}

// Log for ethernet gate
simple EthernetGateLogger
{
    parameters:
        @class(EthernetGateLogger);
}
module LogLayeredEthernetInterface extends LayeredEthernetInterface
{
    parameters:
        bool hasTas = default(false);
    submodules:
        logger: EthernetGateLogger;
}

// Log for flow app
simple UdpSourceAppLogger
{
	parameters:
	    @class(UdpSourceAppLogger);
}
module LogUdpSourceApp extends UdpSourceApp
{
    parameters:
        int flowId;
    submodules:
        logger: UdpSourceAppLogger;
}

// ------------------- Log Components -------------------


// ------------------- Error Simulator -------------------

// Error simulator
simple ErrorSimulator
{
	parameters:
	    @class(ErrorSimulator);
}

// ------------------- Error Simulator -------------------


// ------------------- Delayed Ethernet Interface -------------------

// Ethernet gate with latency
module DelayedLayeredEthernetInterface extends LogLayeredEthernetInterface
{
    parameters:
        double processingTime @mutable @unit(s) = default(0s);
}
simple DelayedPacketReceiver extends LogPacketReceiver
{
    parameters:
        @class(DelayedPacketReceiver);
}

// ------------------- Delayed Ethernet Interface -------------------


// ------------------- Flawed Components -------------------

// Flawed queue
simple FlawedPacketQueue extends PacketQueue
{
    parameters:
        @class(FlawedPacketQueue);
}

// Flawed receiver
simple FlawedPacketReceiver extends DelayedPacketReceiver
{
    parameters:
        @class(FlawedPacketReceiver);
}

// Flawed transmitter
simple FlawedPacketTransmitter extends LogPacketTransmitter
{
    parameters:
        @class(FlawedPacketTransmitter);
}

// ------------------- Flawed Components -------------------



// ------------------- MAC Related Components -------------------

// Mute RelayInterfaceLearner
simple MuteLearner extends RelayInterfaceLearner
{
    parameters:
        @class(MuteLearner);
}

// ------------------- MAC Related Components -------------------



// ------------------- TSN Error Simulation Network Base -------------------

// TSN Error Simulation Network Base
network TsnErrSimNetworkBase extends TsnNetworkBase
{
    parameters:
    	int repetition = default(0);
    	// Probability for: short gate; late gate; early gate; queue disorder; packet delay; packet loss
        object errorProb = default([10, 10, 10, 20, 30, 20]);
        // Queue error should appear before how many queries
        int queueErrorMaxQuery = default(5);
        // PacketDelay/PacketLoss error should appear before how many queries
        int packetErrorMaxQuery = default(15);
}

// ------------------- TSN Error Simulation Network Base -------------------