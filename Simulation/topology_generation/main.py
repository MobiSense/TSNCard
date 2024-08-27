import random
import json
import networkx as nx
from Flow import Flow
from Network import Network
from scheduler import solve
from typing import List, Tuple
import z3

GENERATION_CONFIG = {
    'type': ['random'],
    'num_de': 30,
    'num_sw': 20,
    # 'num_flow': [30],
    # 'period': [64]
    'num_flow': [50, 100, 150, 200],
    'period': [128, 128, 256, 256]
    # 'num_flow': [10, 15, 20, 25, 30],
    # 'period': [24, 24, 48, 64, 64]
    
}

def random_flows(num_flows, network: Network, period = 12)->list :
    # print(network.graph.nodes[0])
    device_nodes = network.get_devices()
    # 2^20ns is about 1ms, that is 2^6 time units.
    # Allowed network delay is from 1*2^6 units to 10*2^6 units
    # NETWORK_ALLOWED_DELAY_LIST = [x * (2 ** 6) for x in range(1, 11)]
    NETWORK_ALLOWED_DELAY_LIST = [x for x in range(4, 8)]
    # print('device nodes: ', device_nodes)
    flow_exists = set()
    flows = []
    for i in range(num_flows):
        src, dst = random.sample(device_nodes, 2)
        while network.get_shortest_path_len(src, dst) >= period / 2 or \
                (src, dst) in flow_exists:
            src, dst = random.sample(device_nodes, 2)
        MD = random.randint(max(period / 4, network.get_shortest_path_len(src, dst) + 1),  period * 3 / 4) # random.choice(NETWORK_ALLOWED_DELAY_LIST)
        f = Flow(i = 0, k = i, src = src, dst = dst, flow_period = period, MD = MD)
        flows.append(f)
        flow_exists.add((src, dst))
    return flows


def get_tx_time(flow_id, schedule: List, network: Network):
    for single_schedule in schedule:
        if single_schedule['type'] != 'link': continue
        src = single_schedule['from']
        if not network.is_device(src): continue
        for x in single_schedule['schedule']:
            if x['flow_id'] == flow_id:
                return x['start']
    return None


def output_as_ini_file(schedule: List, flows: List[Flow], network: Network, filename: str, period = 12):
    config_name = "[General]"
    network_str = f'network = {network.name.capitalize()}'
    sim_time_str = f'sim-time-limit = 3*{period}*16.384us'
    bitrate_str = '**.eth[*].bitrate = 1000Mbps'
    
    repetition_str = 'repeat = 1 + 200\n*.repetition = ${repetition}'
    
    switch_list = network.get_switches()
    device_list = network.get_devices()
    
    macaddr_str_list = []
    for device_id in device_list:
        addr = network.graph.nodes[device_id]["mac"].replace(':', '-')
        macaddr_str_list.append(f'*.de{device_id}.eth[0].address = "{addr}"')
    macaddr_str = '\n'.join(macaddr_str_list)
    
    gcl_str_list = []
    for single_schedule in schedule:
        if single_schedule['type'] != 'link':
            continue
        src = single_schedule['from']
        port = single_schedule['from_port']
        if not network.is_switch(src): continue
        gcl = []
        for x in single_schedule['schedule']:
            assert x['start'] >= 0 and x['start'] < period
            assert x['end'] > x['start'] and x['end'] < period + period
            if x['end'] > period:
                gcl.append((x['start'], period))
                gcl.append((0, x['end']))
            else:
                gcl.append((x['start'], x['end']))
        if len(gcl) == 0: continue
        gcl.sort()
        
        combined_gcl = [gcl[0], ]
        for idx in range(1, len(gcl)):
            l, r = gcl[idx]
            l0, r0 = combined_gcl[-1]
            assert l0 <= l
            if l <= r0:
                combined_gcl[-1] = (l0, max(r, r0))
            else:
                combined_gcl.append((l, r))
        # print(src, port, sorted(gcl))
        gcl_comment_str = f'# gcl at sw{src - len(device_list)}, port{port}'
        
        durations = [t for gc in combined_gcl for t in gc]
        if durations[0] == 0 and durations[-1] == period:
            assert len(durations) >= 2
            # queueoffset_str = f'*.sw{src - len(device_list)}.eth[{port}].macLayer.queue.transmissionGate[0].offset = {durations[-2] if durations[-2] >= 0 else period + durations[-2]} * 16.384us'
            queueoffset_str = f'*.sw{src - len(device_list)}.eth[{port}].macLayer.queue.transmissionGate[0].offset = {period - durations[-2]} * 16.384us'
            durations_str_list = [f'{durations[idx] - durations[idx - 1]} * 16.384us' for idx in range(1, len(durations) - 1)]
            durations_str_list[0] = f'{durations[1] + period - durations[-2]} * 16.384us'
            durations_str = ', '.join(durations_str_list)
            durations_str = f'*.sw{src - len(device_list)}.eth[{port}].macLayer.queue.transmissionGate[0].durations = [' + durations_str + ']'
        else:
            queueoffset_str = f'*.sw{src - len(device_list)}.eth[{port}].macLayer.queue.transmissionGate[0].offset = {-durations[0] if durations[0] <= 0 else period - durations[0]} * 16.384us'
            durations_str_list = [f'{durations[idx] - durations[idx - 1]} * 16.384us' for idx in range(1, len(durations))]
            durations_str = ', '.join(durations_str_list)
            durations_str += f', {period - durations[-1] + durations[0]} * 16.384us'
            durations_str = f'*.sw{src - len(device_list)}.eth[{port}].macLayer.queue.transmissionGate[0].durations = [' + durations_str + ']'
        hastas_str = f'*.sw{src - len(device_list)}.eth[{port}].hasTas = true'
        single_gcl_str = '\n'.join([gcl_comment_str, queueoffset_str, durations_str, hastas_str])
        gcl_str_list.append(single_gcl_str)
    
    gcl_str = '\n'.join(gcl_str_list)
    
    forwarding_delay_str = '*.sw*.eth[*].typename = "DelayedLayeredEthernetInterface"\n*.sw*.eth[*].processingTime = 2us'
    
    numapps = {x: 0 for x in device_list}
    in_degree = {x: 0 for x in device_list}
    flow_list_str = []
    for flow in flows:
        tx = get_tx_time(flow_id=flow.k, schedule=schedule, network=network)
        
        comment_str = f'# Install LogUdpSourceApp on de{flow.src} and UdpSinkApp on de{flow.dst}, #flow{flow.k}'
        srctypename_str = f'*.de{flow.src}.app[{numapps[flow.src]}].typename = "LogUdpSourceApp"'
        display_str = f'*.de{flow.src}.app[{numapps[flow.src]}].display-name = "flow{flow.k}_{flow.src}to{flow.dst}"'
        flowid_str = f'*.de{flow.src}.app[{numapps[flow.src]}].flowId = {flow.k}'
        destaddr_str = f'*.de{flow.src}.app[{numapps[flow.src]}].io.destAddress = "de{flow.dst}"'
        destport_str = f'*.de{flow.src}.app[{numapps[flow.src]}].io.destPort = {1000 + in_degree[flow.dst]}'
        offset_str = f'*.de{flow.src}.app[{numapps[flow.src]}].source.initialProductionOffset = {tx} * 16.384us'
        
        dsttypename_str = f'*.de{flow.dst}.app[{numapps[flow.dst]}].typename = "UdpSinkApp"'
        localport_str = f'*.de{flow.dst}.app[{numapps[flow.dst]}].io.localPort = {1000 + in_degree[flow.dst]}'
        
        numapps[flow.src] += 1
        numapps[flow.dst] += 1
        in_degree[flow.dst] += 1
        
        flow_str = '\n'.join([comment_str,
                             srctypename_str,
                             display_str,
                             flowid_str,
                             destaddr_str,
                             destport_str,
                             offset_str,
                             dsttypename_str,
                             localport_str])
        flow_list_str.append(flow_str)
    numapps_str = '\n'.join([f'*.de{x}.numApps = {numapps[x]}' for x in device_list])
    flow_str = '\n'.join(flow_list_str)
    
    packetlength_str = '*.de*.app[*].source.packetLength = 1500B - 54B'
    productioninterval_str = f'*.de*.app[*].source.productionInterval = {period} * 16.384us'
    
    de_receiver_str = '*.de*.eth[*].phyLayer.receiver.typename = "LogPacketReceiver"'
    de_transmitter_str = '*.de*.eth[*].phyLayer.transmitter.typename = "LogPacketTransmitter"'
    
    sw_trafficshaper = '*.sw*.hasEgressTrafficShaping = true'
    sw_numtrafficclasses = '*.sw*.eth[*].macLayer.queue.numTrafficClasses = 1'
    sw_receiver_str = '*.sw*.eth[*].phyLayer.receiver.typename = "FlawedPacketReceiver"'
    sw_transmitter_str = '*.sw*.eth[*].phyLayer.transmitter.typename = "FlawedPacketTransmitter"'
    
    sw_packetqueue_str = '*.sw*.eth[*].macLayer.queue.queue[*].typename = "FlawedPacketQueue"'
    
    forwardingtableconfig_str = '*.macForwardingTableConfigurator.typename = ""'
    forwardingtable_str_list = []
    for switch_id in switch_list:
        leading_str = f'*.sw{switch_id - len(device_list)}.macTable.forwardingTable = ['
        entry_list = []
        for device_id in device_list:
            first_link_x, first_link_y = network.get_shortest_path(switch_id, device_id)[0]
            assert switch_id == first_link_x and network.graph.has_edge(first_link_x, first_link_y)
            port = network.graph.edges[first_link_x, first_link_y]['src_port']
            entry_list.append('{' + f'address: "de{device_id}", interface: "eth{port}"' + '}')
        forwardingtable_str_list.append( leading_str + (',\n' + ' ' * len(leading_str)).join(entry_list) + ']')
    forwardingtable_str = '\n'.join(forwardingtable_str_list)
    
    with open(filename, 'w') as fout:
        fout.write(config_name+ '\n')
        fout.write('# General configuration'+ '\n')
        fout.write(network_str+ '\n')
        fout.write(sim_time_str+ '\n')
        fout.write('# Network bitrate'+ '\n')
        fout.write(bitrate_str+ '\n')
        fout.write('\n')
        fout.write('# ---- NETWORK CONFIGURATION ----'+ '\n')
        
        fout.write('# Number of runs'+ '\n')
        fout.write(repetition_str+ '\n')
        fout.write('\n')
        
        fout.write('# Configuration for device mac address\n')
        fout.write(macaddr_str + '\n')
        fout.write('\n')
        
        fout.write('# Configuration for error generation\n')
        fout.write('# Probability for: short gate; late gate; early gate; queue disorder; packet delay; packet loss\n')
        fout.write('*.errorProb = [5, 15, 15, 5, 55, 5]\n')
        fout.write('*.queueErrorMaxQuery = 3\n')
        fout.write('*.packetLossErrorMaxQuery = 40\n')
        fout.write('\n')
        
        fout.write('# Configuration for switch gates'+ '\n')
        fout.write(gcl_str+ '\n')
        fout.write('\n')
        
        fout.write('# Configuration for switch forwarding latency'+ '\n')
        fout.write(forwarding_delay_str+ '\n')
        fout.write('\n')
        
        fout.write('# Configuration for flows'+ '\n')
        fout.write(numapps_str+ '\n')
        fout.write(flow_str+ '\n')
        fout.write('\n')
        
        fout.write('# Configuration for flow packets'+ '\n')
        fout.write(packetlength_str+ '\n')
        fout.write(productioninterval_str+ '\n')
        fout.write('\n')
        
        fout.write('# Install loggers on each device'+ '\n')
        fout.write(de_receiver_str+ '\n')
        fout.write(de_transmitter_str+ '\n')
        fout.write('\n')

        fout.write('# Install loggers on each switch'+ '\n')
        fout.write(sw_trafficshaper+ '\n')
        fout.write(sw_numtrafficclasses+ '\n')
        fout.write(sw_receiver_str+ '\n')
        fout.write(sw_transmitter_str+ '\n')
        fout.write('# Install flawed queue on each gate'+ '\n')
        fout.write(sw_packetqueue_str+ '\n')
        fout.write('\n')
        
        fout.write('# Static forwarding table'+ '\n')
        fout.write(forwardingtableconfig_str+ '\n')
        fout.write(forwardingtable_str + '\n')
        fout.write('*.sw*.bridging.interfaceRelay.learner.typename = "MuteLearner"\n')
        fout.write('\n')
        
        fout.write('# ---- END OF NETWORK CONFIGURATION ----'+ '\n')
        
        fout.write('# Visualization configuration'+ '\n')
        fout.write('**.displayGateSchedules = true'+ '\n')
        fout.write('\n')

        fout.write('# Output configuration'+ '\n')
        fout.write('cmdenv-express-mode = false'+ '\n')
        fout.write('cmdenv-event-banners = false'+ '\n')
        fout.write('**.cmdenv-log-level = "WARN"'+ '\n')
        fout.write('\n')

        fout.write('cmdenv-log-prefix = ""'+ '\n')
        fout.write('cmdenv-redirect-output = true'+ '\n')
        fout.write('cmdenv-output-file = "../log/${network}/flow' + str(len(flows)) + '/log_raw/log_${runnumber}.txt"'+ '\n')
        fout.write('\n')

        fout.write('**.vector-recording = false'+ '\n')
        fout.write('**.scalar-recording = false'+ '\n')
        fout.write('\n')
    

if __name__ == '__main__':
    # For each required type
    for ntype in GENERATION_CONFIG['type']:
        print('NETWORK ' + ntype)

        # 生成拓扑
        network = None
        if ntype == 'ring6':
            network = Network.ring_6_topology()
        elif ntype == 'a380':
            network = Network.a380_topology()
        elif ntype == 'cev':
            network = Network.cev_topology()
        else:
            network = Network.random_topology(GENERATION_CONFIG['num_de'], GENERATION_CONFIG['num_sw'], 'random')
        print('finish topology generation')

        # 把拓扑转化到ned
        network.output_as_ned_file(filename=ntype+'.ned')
        print('finish topology output')

        # Generate multiple sets of flows
        for i in range(len(GENERATION_CONFIG['num_flow'])):
            num_flow = GENERATION_CONFIG['num_flow'][i]
            period = GENERATION_CONFIG['period'][i]
            print(f'CASE num_flow = {num_flow}')

            # 随机生成流量
            flows = random_flows(num_flows=num_flow, network=network, period=period)
            # flows = [Flow(i = 0, k = 0, src = 0, dst = 3, flow_period=period, MD = period * 3 / 4), ]
            print('finish flow generation')

            # 根据流量、拓扑，生成gcl
            sat, schedule = solve(minimize_flag=True,
                                input_flows=flows,
                                input_network=network,
                                group_id="01",
                                output_schedule_name=ntype+'_'+str(GENERATION_CONFIG['num_flow'][i])+'flow')
            print('finish flow scheduling')

            # 把gcl转化成ini
            if sat == z3.sat:
                output_as_ini_file(schedule=schedule, flows=flows, network=network, filename=ntype+f'_flow{num_flow}.ini', period=period)
                print('finish schedule output')
