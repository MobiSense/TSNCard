#ifndef MODULES_ERRORSIMULATOR_H_
#define MODULES_ERRORSIMULATOR_H_

#include<omnetpp/csimplemodule.h>
#include<omnetpp/ccomponenttype.h>
#include<omnetpp/cvaluearray.h>
#include<inet/common/INETDefs.h>

using namespace inet;

// Error Simulator
// Installed on TsnNetwork
class ErrorSimulator: public cSimpleModule
{
public:
    bool shouldGenerateQueueFlaw(const std::string& switchName, const std::string& packetName);
    bool shouldGeneratePacketLoss(const std::string& switchName, const std::string& packetName);
    bool shouldGeneratePacketDelay(const std::string& switchName, const std::string& packetName);
    double getPacketDelayTime();

protected:
    virtual void initialize() override;

private:
    int repetition = 0;
    cModule* network = nullptr;
    std::vector<cModule*> tsnSwitchGateList;
    std::vector<intval_t> errorProbVector;

    double timeUnit = 16.384;

    bool hasQueueError = false;
    int queueErrorQueryCount = 0;
    int queueErrorId = -1;

    bool hasPacketLossError = false;
    int packetLossErrorQueryCount = 0;
    int packetLossErrorId = -1;

    bool hasPacketDelayError = false;
    int packetDelayErrorQueryCount = 0;
    int packetDelayErrorId = -1;
    double packetDelayTime = 0;

    std::string errorSwitchName;
    std::string errorFlowName;

    void findAllTasGates();

    void generateGateError();
    void generateQueueError();
    void generatePacketLossError();
    void generatePacketDelayError();
};

#endif /* MODULES_ERRORSIMULATOR_H_ */
