package simulations;

import inet.node.tsn.TsnSwitch;
import inet.node.tsn.TsnDevice;
import inet.node.ethernet.EthernetLink;
import modules.ErrorSimulator;
import modules.TsnErrSimNetworkBase;

network Ring6 extends TsnErrSimNetworkBase
{
    submodules:
        sw0: TsnSwitch {
            numEthInterfaces = 3;
        }
        sw1: TsnSwitch {
            numEthInterfaces = 3;
        }
        sw2: TsnSwitch {
            numEthInterfaces = 3;
        }
        sw3: TsnSwitch {
            numEthInterfaces = 3;
        }
        sw4: TsnSwitch {
            numEthInterfaces = 3;
        }
        sw5: TsnSwitch {
            numEthInterfaces = 3;
        }
        de0: TsnDevice {
            numEthInterfaces = 1;
        }
        de1: TsnDevice {
            numEthInterfaces = 1;
        }
        de2: TsnDevice {
            numEthInterfaces = 1;
        }
        de3: TsnDevice {
            numEthInterfaces = 1;
        }
        de4: TsnDevice {
            numEthInterfaces = 1;
        }
        de5: TsnDevice {
            numEthInterfaces = 1;
        }
        errsim: ErrorSimulator;

    connections:
        de0.ethg[0] <--> EthernetLink <--> sw0.ethg[0];
        de1.ethg[0] <--> EthernetLink <--> sw1.ethg[0];
        de2.ethg[0] <--> EthernetLink <--> sw2.ethg[0];
        de3.ethg[0] <--> EthernetLink <--> sw3.ethg[0];
        de4.ethg[0] <--> EthernetLink <--> sw4.ethg[0];
        de5.ethg[0] <--> EthernetLink <--> sw5.ethg[0];
        sw0.ethg[1] <--> EthernetLink <--> sw1.ethg[2];
        sw0.ethg[2] <--> EthernetLink <--> sw5.ethg[1];
        sw1.ethg[1] <--> EthernetLink <--> sw2.ethg[2];
        sw2.ethg[1] <--> EthernetLink <--> sw3.ethg[2];
        sw3.ethg[1] <--> EthernetLink <--> sw4.ethg[2];
        sw4.ethg[1] <--> EthernetLink <--> sw5.ethg[2];
}
