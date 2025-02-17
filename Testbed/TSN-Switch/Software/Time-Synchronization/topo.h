#ifndef TOPO_H
#define TOPO_H

extern "C" {
    #include "tsn_drivers/ptp_types.h"
    void setup_topo();
    void setup_gcl();
    void get_ptp_ports(int *ptp_ports);
    void get_clock_identity(ClockIdentity clock_identity);
    void get_priority1(uint8_t* priority1);
    
    void get_config_from_json(
        SystemIdentity* system_identity,
        int *ptp_ports,
        bool *externalPortConfigurationEnabled);
}
#endif