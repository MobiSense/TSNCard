#include "../modules/ErrorSimulator.h"

#include "../modules/FlawedPacketQueue.h"
#include "../modules/FlawedPacketReceiver.h"
#include "../modules/FlawedPacketTransmitter.h"

Define_Module(ErrorSimulator);

void ErrorSimulator::initialize()
{
    network = getParentModule();
    repetition = network->par("repetition").intValue();
    EV_WARN << "[Run ID] " << time(NULL) << "-" << repetition << EV_ENDL;

    if(repetition == 0) return;
    repetition--;

    auto probs = (cValueArray*)(network->par("errorProb").objectValue()->dup());
    errorProbVector = probs->asIntVector();
    for(int i = 1; i < errorProbVector.size(); i++) errorProbVector[i] += errorProbVector[i-1];

    findAllTasGates();

    srand(time(NULL) + repetition);
    if(repetition % 100 < errorProbVector[2]) {
        // Gate error
        generateGateError();
    }
    else if (repetition % 100 < errorProbVector[3]) {
        // Queue error
        generateQueueError();
    }
    else if (repetition % 100 < errorProbVector[4]) {
        // PacketDelay error
        generatePacketDelayError();
    }
    else {
        // PacketLoss error
        generatePacketLossError();
    }

    delete probs;
}

void ErrorSimulator::findAllTasGates() {
    // Find all TAS ports on all TsnSwitch in the network
    // For all TsnSwitch
    for(cModule::SubmoduleIterator it(network); !it.end(); ++it) {
        cModule* submodule = *it;
        if(strcmp(submodule->getModuleType()->getFullName(), "inet.node.tsn.TsnSwitch") == 0) {

            // For all Ethernet gate on TsnSwitch
            int ethGateCount = submodule->getSubmoduleVectorSize("eth");
            for(int i = 0; i < ethGateCount; i++) {
                cModule* ethGate = submodule->getSubmodule("eth", i);
                if(ethGate->par("hasTas").boolValue()) {

                    // Add to list
                    tsnSwitchGateList.push_back(ethGate);
                }
            }
        }
    }
}

// ------------------- Gate Error -------------------
void ErrorSimulator::generateGateError()
{
    if(tsnSwitchGateList.size() <= 0) return;

    // Determine error gate and error type
    int errorSwitchGateId = rand()*rand() % tsnSwitchGateList.size();
    int errorType = repetition % 100;

    cModule* errorGate = tsnSwitchGateList[errorSwitchGateId];
    cModule* errorSwitch = errorGate->getParentModule();
    cModule* transmissionGate = errorGate->getSubmodule("macLayer")->getSubmodule("queue")->getSubmodule("transmissionGate", 0);



    // Identity
    EV_WARN << "[Error Config] " << "(Gate error) ";
    EV_WARN << errorSwitch->getName() << "." << errorGate->getName() << errorGate->getIndex() << ":";

    // Original
    double offset = transmissionGate->par("offset").doubleValueInUnit("us");
    auto durations = (cValueArray*)(transmissionGate->par("durations").objectValue()->dup());
    auto durationsVector = durations->asDoubleVectorInUnit("us");

    double period = 0;
    for(double dur: durationsVector) period += dur;

    EV_WARN << " (Offset)" << offset << "us";
    EV_WARN << " (Durations)" << durations->str();

    // Generate random error
    double deltaRatio, delta;
    if(errorType < errorProbVector[0])
    {
        // 减短门控打开的时间
        for(int i = 1; i < durationsVector.size(); i += 2)
        {
            deltaRatio = 1e-3 * (rand()*rand() % 500 + 1); // (0, 0.5]
            delta = durationsVector[i-1] * deltaRatio;

            durations->set(i-1, cValue(durationsVector[i-1] - delta, "us"));
            durations->set(i,   cValue(durationsVector[i]   + delta, "us"));
        }
    }
    else if(errorType < errorProbVector[1])
    {
        // 推迟打开门控
        deltaRatio = 1e-3 * (rand()*rand() % 1500 + 500); // [0.5, 2)
        delta = durationsVector[0] * deltaRatio;

        offset -= delta;
        if(offset < 0) offset += period;
    }
    else
    {
        // 提前打开门控
        deltaRatio = 1e-3 * (rand()*rand() % 1500 + 500); // [0.5, 2)
        delta = durationsVector[0] * deltaRatio;

        offset += delta;
        if(offset >= period) offset -= period;
    }

    // Set new value with error
    transmissionGate->par("offset").setDoubleValue(offset*1e-6);
    transmissionGate->par("durations").setObjectValue(durations);

    EV_WARN << " -->";
    EV_WARN << " (Offset)" << offset << "us";
    EV_WARN << " (Durations)" << durations->str() << EV_ENDL;
}
// ------------------- Gate Error -------------------

// ------------------- Queue Error -------------------
void ErrorSimulator::generateQueueError() {
    hasQueueError = true;

    // Register flaw on all queues
    // For all TAS Ethernet gate
    for(auto ethGate : tsnSwitchGateList) {

        // For all TAS queue in Ethernet gate
        cModule* tas = ethGate->getSubmodule("macLayer")->getSubmodule("queue");
        int queueCount = tas->getSubmoduleVectorSize("queue");
        for(int j = 0; j < queueCount; j++) {
            FlawedPacketQueue* queue = check_and_cast<FlawedPacketQueue*>(tas->getSubmodule("queue", j));

            // Connect to ErrorSimulator
            queue->setErrorSimulator(this);
            queue->setGateName(ethGate->getParentModule()->getName(), ethGate->getIndex());
        }
    }

    // Generate error query ID
    int queueErrorMaxQuery = network->par("queueErrorMaxQuery").intValue();
    queueErrorId = rand()*rand() % queueErrorMaxQuery + 1;
}

bool ErrorSimulator::shouldGenerateQueueFlaw(const std::string& switchName, const std::string& packetName) {
    if(!hasQueueError) {
        return false;
    }
    if(!errorSwitchName.empty()) {
        return errorSwitchName == switchName && errorFlowName == packetName.substr(0, errorFlowName.length());
    }

    queueErrorQueryCount++;
    if(queueErrorQueryCount == queueErrorId) {
        errorSwitchName = switchName;
        errorFlowName = packetName.substr(0, packetName.find('_'));
        return true;
    }
    return false;
}
// ------------------- Queue Error -------------------

// ------------------- Packet Loss Error -------------------
void ErrorSimulator::generatePacketLossError() {
    hasPacketLossError = true;

    // Register flaw on all receivers
    for(cModule::SubmoduleIterator it(network); !it.end(); ++it) {
        cModule* submodule = *it;
        if(strcmp(submodule->getModuleType()->getFullName(), "inet.node.tsn.TsnSwitch") == 0) {

            // For all Ethernet gate on TsnSwitch
            int ethGateCount = submodule->getSubmoduleVectorSize("eth");
            for(int i = 0; i < ethGateCount; i++) {
                cModule* ethGate = submodule->getSubmodule("eth", i);

                // Find receiver on gate
                FlawedPacketReceiver* receiver = dynamic_cast<FlawedPacketReceiver*>(ethGate->getSubmodule("phyLayer")->getSubmodule("receiver"));
                if(receiver == nullptr) continue;

                // Connect to ErrorSimulator
                receiver->setErrorSimulator(this);
                receiver->setGateName(ethGate->getParentModule()->getName());
            }
        }
    }

    // Generate error query ID
    int packetErrorMaxQuery = network->par("packetErrorMaxQuery").intValue();
    packetLossErrorId = rand()*rand() % packetErrorMaxQuery + 1;
}

bool ErrorSimulator::shouldGeneratePacketLoss(const std::string& switchName, const std::string& packetName) {
    if(!hasPacketLossError) {
        return false;
    }
    if(!errorSwitchName.empty()) {
        return errorSwitchName == switchName && errorFlowName == packetName.substr(0, errorFlowName.length());
    }

    packetLossErrorQueryCount++;
    if(packetLossErrorQueryCount == packetLossErrorId) {
        errorSwitchName = switchName;
        errorFlowName = packetName.substr(0, packetName.find('_'));
        return true;
    }
    return false;
}
// ------------------- Packet Loss Error -------------------

// ------------------- Packet Delay Error -------------------
void ErrorSimulator::generatePacketDelayError() {
    hasPacketDelayError = true;

    // Register flaw on all transmitters
    // For all TAS Ethernet gate
    for(auto ethGate : tsnSwitchGateList) {

        // Find transmitter
        FlawedPacketTransmitter* transmitter = check_and_cast<FlawedPacketTransmitter*>(ethGate->getSubmodule("phyLayer")->getSubmodule("transmitter"));

        // Connect to ErrorSimulator
        transmitter->setErrorSimulator(this);
    }

    // Generate error query ID
    int packetErrorMaxQuery = network->par("packetErrorMaxQuery").intValue();
    packetDelayErrorId = rand()*rand() % packetErrorMaxQuery + 1;

    // Generate delay time
    packetDelayTime = (double)(rand()*rand() % 240 + 80) * 1e-7; // [8us, 32us)
}

bool ErrorSimulator::shouldGeneratePacketDelay(const std::string& switchName, const std::string& packetName) {
    if(!hasPacketDelayError) {
        return false;
    }
    if(!errorSwitchName.empty()) {
        return errorSwitchName == switchName && errorFlowName == packetName.substr(0, errorFlowName.length());
    }

    packetDelayErrorQueryCount++;
    if(packetDelayErrorQueryCount == packetDelayErrorId) {
        errorSwitchName = switchName;
        errorFlowName = packetName.substr(0, packetName.find('_'));
        return true;
    }
    return false;
}

double ErrorSimulator::getPacketDelayTime() {
    return packetDelayTime;
}
// ------------------- Packet Delay Error -------------------
