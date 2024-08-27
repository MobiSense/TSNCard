from typing import Dict
import networkx as nx
from itertools import permutations
import random

class Network:
    def __init__(self, graph: nx.DiGraph, name: str):
        self.graph: nx.DiGraph
        self.name: str
        self.graph = graph
        self.shortest_path_map: Dict = {}  # {(src, dst): [(1, 2), (2, 3)]}
        self.shared_edges: Dict = {}
        self.name = name
        self.preprocessing()

    def get_shortest_path(self, src, dst):
        return self.shortest_path_map[(src, dst)]

    def get_shortest_path_len(self, src, dst):
        return nx.shortest_path_length(self.graph, src, dst)

    def preprocessing(self):
        # construct shortest_path_map and shared_edges
        for len in range(self.graph.number_of_nodes()):
            for x in self.graph.nodes():
                for y in self.graph.nodes():
                    if (self.get_shortest_path_len(x, y) == len):
                        if len == 0:
                            self.shortest_path_map[(x, y)] = []
                            break
                        for z in self.graph.nodes():
                            if self.graph.has_successor(z, y) and self.get_shortest_path_len(x, z) == len - 1:
                                self.shortest_path_map[(x, y)] = self.shortest_path_map[(x, z)] + [(z, y)]
                                break

        for src1 in self.graph.nodes():
            for dst1 in self.graph.nodes():
                # if src1 != dst1:
                if True:
                    s1 = set(self.shortest_path_map[(src1, dst1)])
                    for src2 in self.graph.nodes():
                        for dst2 in self.graph.nodes():
                            # if src2 != dst2:
                            if True:
                                s2 = set(self.shortest_path_map[(src2, dst2)])
                                self.shared_edges[(src1, dst1, src2, dst2)] = list(s1.intersection(s2))
    

    def get_nodes_list(self): # for json output
        node_list = []
        for id in self.graph.nodes():
            type = self.graph.nodes[id]['type'] if 'type' in self.graph.nodes[id] else 'unknown'
            mac = self.graph.nodes[id]['mac'] if 'mac' in self.graph.nodes[id] else 'unknown'
            if type == 'switch':
                ptp_ports = self.graph.nodes[id]['ptp_ports'] if 'ptp_ports' in self.graph.nodes[id] else []
                node_list.append({'id': id, 'type': type, 'mac': mac, 'ptp_ports': ptp_ports})
            else:
                node_list.append({'id': id, 'type': type, 'mac': mac})
        return node_list
    

    def get_links_list(self, isCaaS=False): # for json output
        link_list = []
        for src, dst in self.graph.edges():
            src_port = self.graph.edges[src, dst]['src_port'] if 'src_port' in self.graph.edges[src, dst] else -1
            dst_port = self.graph.edges[src, dst]['dst_port'] if 'dst_port' in self.graph.edges[src, dst] else -1
            id = self.graph.edges[src, dst]['id'] if 'id' in self.graph.edges[src, dst] else -1
            link_list.append({'id': id, 'src': src, 'src_port': src_port, 'dst': dst, 'dst_port': dst_port})

        id_cnt = len(link_list)
        for node in self.graph.nodes():
            link_list.append({
                'id': id_cnt,
                'src': node,
                'src_port': 4 if isCaaS else 5,
                'dst': node,
                'dst_port': 4 if isCaaS else 5
            })
            id_cnt += 1
        return link_list

    
    def get_fwdTable(self, isCaaS=False): # for json output
        forwarding_table = []
        id_cnt = 0
        for src in self.graph.nodes():
            for dst in self.graph.nodes():
                if src == dst:
                    if self.graph.has_edge(src, dst) and self.graph.has_edge(src, dst):
                        fwd_rule = {
                            'src': src,
                            'dst': dst,
                            'id': id_cnt,
                            'src_port': self.graph.edges[src, dst]['src_port']
                                        if 'src_port' in self.graph.edges[src, dst] else -1
                        }
                        id_cnt += 1
                        forwarding_table.append(fwd_rule)
                    continue
                # import pdb; pdb.set_trace()
                path = self.shortest_path_map[(src, dst)]
                first_link = path[0]
                assert src == first_link[0] and self.graph.has_edge(src, first_link[1])
                fwd_rule = {
                    'src': src,
                    'dst': dst,
                    'id': id_cnt,
                    'src_port': self.graph.edges[src, first_link[1]]['src_port']
                                if 'src_port' in self.graph.edges[src, first_link[1]] else -1
                }
                id_cnt += 1
                forwarding_table.append(fwd_rule)
        for node in self.graph.nodes():
            forwarding_table.append({
                'src': node,
                'dst': node,
                'src_port': 4 if isCaaS else 5,
                'id': id_cnt
            })
            id_cnt += 1
        return forwarding_table
    

    def get_graph_output(self, isCaaS=False): # json output
        node_list = self.get_nodes_list()
        link_list = self.get_links_list(isCaaS=isCaaS)
        forwarding_table = self.get_fwdTable(isCaaS=isCaaS)

        return {'nodes': node_list, 'links': link_list, 'fwd': forwarding_table}
    

    def output_as_ned_file(self, filename: str):
        header = '''package simulations;

import inet.node.tsn.TsnSwitch;
import inet.node.tsn.TsnDevice;
import inet.node.ethernet.EthernetLink;
import modules.ErrorSimulator;
import modules.TsnErrSimNetworkBase;
import modules.ManualTsnSwitch;
'''
        class_name = f'network {self.name.capitalize()} extends TsnErrSimNetworkBase'

        node_list = self.get_nodes_list()
        link_list = self.get_links_list()
        node_degree = {node['id']: 0 for node in node_list}
        for link in link_list:
            if link['src'] == link['dst']: continue
            node_degree[link['src']] += 1
        
        switch_list = [node for node in node_list if node['type'] == 'switch']
        device_list = [node for node in node_list if node['type'] == 'device']
        nodes_str: str = ''
        for node in switch_list:
            id = node['id']
            numIf = f'    numEthInterfaces = {node_degree[id]};\n'
            tmp = ['', 'sw' + str(id - len(device_list)) + ': ManualTsnSwitch {\n', numIf, '}\n']
            node_str = '        '.join(tmp)
            nodes_str += node_str
        for node in device_list:
            id = node['id']
            numIf = f'    numEthInterfaces = {node_degree[id]};\n'
            tmp = ['', 'de' + str(id) + ': TsnDevice {\n', numIf, '}\n']
            node_str = '        '.join(tmp)
            nodes_str += node_str
        nodes_str += '        errsim: ErrorSimulator;\n'

        link_str_list = []
        for link in link_list:
            if link['src'] < link['dst']:
                if link['src'] in [switch['id'] for switch in switch_list]:
                    src_str = 'sw' + str(link['src'] - len(device_list))
                else:
                    src_str = 'de' + str(link['src'])
                if link['dst'] in [switch['id'] for switch in switch_list]:
                    dst_str = 'sw' + str(link['dst'] - len(device_list))
                else:
                    dst_str = 'de' + str(link['dst'])
                assert link['src_port'] != -1 and link['dst_port'] != -1
                link_str_list.append(src_str + '.ethg[' + str(link['src_port']) + '] <--> EthernetLink <--> ' + dst_str + '.ethg[' + str(link['dst_port']) +'];\n')
        links_str = '        '.join(link_str_list)
        links_str = '        ' + links_str

        with open(filename, 'w') as fout:
            fout.write(header + '\n')
            fout.write(class_name + '\n')
            fout.write('{\n')
            fout.write('    submodules:\n')
            fout.write(nodes_str + '\n')
            fout.write('    connections:\n')
            fout.write(links_str)
            fout.write('}\n')
            # print(header)
            # print(class_name)
            # print('{')
            # print('    submodules:')
            # print(nodes_str)
            # print('    connections:')
            # print(links_str)
            # print('}')

    @staticmethod
    def random_topology(num_devices, num_switches, network_name: str):
        assert num_devices > 0 and num_switches > 0
        assert num_devices < 255 and num_switches < 255
        network_graph = nx.DiGraph()
        node_list = [(i, {'type': 'device', 'mac': f'00:0A:35:00:00:{(i+1):x}'}) for i in range(num_devices)] + \
                    [(i + num_devices, {'type': 'switch', 'mac': f'00:0A:35:00:01:{(i+1):x}'}) for i in range(num_switches)]
        network_graph.add_nodes_from(node_list)
        # random_links
        
        # Barabási–Albert model
        link_id = 0
        sw_degree = {sw+num_devices: 0 for sw in range(num_switches)}
        for device in range(num_devices):
            sw = random.randint(0, num_switches - 1) + num_devices
            network_graph.add_edge(device, sw, id = link_id,     src_port = 0, dst_port = sw_degree[sw])
            network_graph.add_edge(sw, device, id = link_id + 1, src_port = sw_degree[sw], dst_port = 0)
            
            link_id += 2
            sw_degree[sw] += 1
        
        sw_list = [num_devices, ]
        for sw in range(num_devices + 1, num_devices + num_switches):
            if len(sw_list) == 1 and sw_degree[sw] == 0:
                k = 1
            else:
                # print(max(1, 2 - sw_degree[sw]), min(len(sw_list), num_switches // 2))
                k = random.randint(max(1, 2 - sw_degree[sw]), min(len(sw_list), num_switches // 2))
            selected_switches = random.sample(sw_list, k)
            
            for y in selected_switches:
                network_graph.add_edge(sw, y, id = link_id,     src_port = sw_degree[sw], dst_port = sw_degree[y])
                network_graph.add_edge(y, sw, id = link_id + 1, src_port = sw_degree[y], dst_port = sw_degree[sw])
                
                link_id += 2
                sw_degree[sw] += 1
                sw_degree[y] += 1
            
            sw_list.append(sw)
            
        network = Network(network_graph, network_name)
        return network

    
    @staticmethod
    def four_in_line_topology():
        # refer to trilium note TSN / CaaS / 联合调度算法 / Development
        network_graph = nx.DiGraph()
        network_graph.add_nodes_from([
            (0, {'role': 'device', 'addr': '00:00:00:00:00:01'}),
            (1, {'role': 'device', 'addr': '00:00:00:00:00:02'}),
            (2, {'role': 'switch', 'addr': '00:00:00:00:01:01'}),
            (3, {'role': 'switch', 'addr': '00:00:00:00:01:02'})
        ])
        network_graph.add_edge(0, 2)
        network_graph.add_edge(2, 0)
        network_graph.add_edge(2, 3)
        network_graph.add_edge(3, 2)
        network_graph.add_edge(3, 1)
        network_graph.add_edge(1, 3)
        network = Network(network_graph, 2, 3)
        return network

    @staticmethod
    def ring_3_topology():
        # refer to trilium note TSN / CaaS / 联合调度算法 / Development
        network_graph = nx.DiGraph()
        network_graph.add_nodes_from([
            (0, {'role': 'device', 'addr': '00:00:00:00:00:01'}),
            (1, {'role': 'device', 'addr': '00:00:00:00:00:02'}),
            (2, {'role': 'device', 'addr': '00:00:00:00:00:03'}),
            (3, {'role': 'device', 'addr': '00:00:00:00:00:04'}),
            (4, {'role': 'device', 'addr': '00:00:00:00:00:05'}),
            (5, {'role': 'device', 'addr': '00:00:00:00:00:06'}),
            (6, {'role': 'switch', 'addr': '00:00:00:00:01:01'}),
            (7, {'role': 'switch', 'addr': '00:00:00:00:01:02'}),
            (8, {'role': 'switch', 'addr': '00:00:00:00:01:03'})
        ])
        network_graph.add_edge(0, 6)
        network_graph.add_edge(6, 0)
        network_graph.add_edge(1, 6)
        network_graph.add_edge(6, 1)

        network_graph.add_edge(2, 7)
        network_graph.add_edge(7, 2)
        network_graph.add_edge(3, 7)
        network_graph.add_edge(7, 3)

        network_graph.add_edge(4, 8)
        network_graph.add_edge(8, 4)
        network_graph.add_edge(5, 8)
        network_graph.add_edge(8, 5)

        network_graph.add_edge(6, 7)
        network_graph.add_edge(7, 6)
        network_graph.add_edge(7, 8)
        network_graph.add_edge(8, 7)
        network_graph.add_edge(6, 8)
        network_graph.add_edge(8, 6)

        network = Network(network_graph, 6, 8)
        return network

    @staticmethod
    def ring_6_topology():
        # refer to notion https://www.notion.so/f63f0e2b0db949a89c6c88de5483164b
        network_graph = nx.DiGraph()
        network_graph.add_nodes_from([
            (0, {'type': 'device', 'mac': '00:00:00:00:00:01'}),
            (1, {'type': 'device', 'mac': '00:00:00:00:00:02'}),
            (2, {'type': 'device', 'mac': '00:00:00:00:00:03'}),
            (3, {'type': 'device', 'mac': '00:00:00:00:00:04'}),
            (4, {'type': 'device', 'mac': '00:00:00:00:00:05'}),
            (5, {'type': 'device', 'mac': '00:00:00:00:00:06'}),

            (6, {'type': 'switch', 'mac': '00:00:00:00:01:01'}),
            (7, {'type': 'switch', 'mac': '00:00:00:00:01:02'}),
            (8, {'type': 'switch', 'mac': '00:00:00:00:01:03'}),
            (9, {'type': 'switch', 'mac': '00:00:00:00:01:04'}),
            (10, {'type': 'switch', 'mac': '00:00:00:00:01:05'}),
            (11, {'type': 'switch', 'mac': '00:00:00:00:01:06'})
        ])

        network_graph.add_edge(0, 6, id = 0, src_port = 0, dst_port = 0)
        network_graph.add_edge(6, 0, id = 1, src_port = 0, dst_port = 0)
        network_graph.add_edge(1, 7, id = 2, src_port = 0, dst_port = 0)
        network_graph.add_edge(7, 1, id = 3, src_port = 0, dst_port = 0)
        network_graph.add_edge(2, 8, id = 4, src_port = 0, dst_port = 0)
        network_graph.add_edge(8, 2, id = 5, src_port = 0, dst_port = 0)
        network_graph.add_edge(3, 9, id = 6, src_port = 0, dst_port = 0)
        network_graph.add_edge(9, 3, id = 7, src_port = 0, dst_port = 0)
        network_graph.add_edge(4, 10, id = 8, src_port= 0, dst_port = 0)
        network_graph.add_edge(10, 4, id = 9, src_port= 0, dst_port = 0)
        network_graph.add_edge(5, 11, id = 10, src_port= 0, dst_port = 0)
        network_graph.add_edge(11, 5, id = 11, src_port= 0, dst_port = 0)

        network_graph.add_edge(6, 7, id = 12, src_port = 1, dst_port = 2)
        network_graph.add_edge(7, 6, id = 13, src_port = 2, dst_port = 1)
        network_graph.add_edge(7, 8, id = 14, src_port = 1, dst_port = 2)
        network_graph.add_edge(8, 7, id = 15, src_port = 2, dst_port = 1)
        network_graph.add_edge(8, 9, id = 16, src_port = 1, dst_port = 2)
        network_graph.add_edge(9, 8, id = 17, src_port = 2, dst_port = 1)
        network_graph.add_edge(9, 10, id = 18, src_port = 1, dst_port = 2)
        network_graph.add_edge(10, 9, id = 19, src_port = 2, dst_port = 1)
        network_graph.add_edge(10, 11, id = 20, src_port = 1, dst_port = 2)
        network_graph.add_edge(11, 10, id = 21, src_port = 2, dst_port = 1)
        network_graph.add_edge(11, 6, id = 22, src_port = 1, dst_port = 2)
        network_graph.add_edge(6, 11, id = 23, src_port = 2, dst_port = 1)

        # network = Network(network_graph, 6, 11, 'ring6')
        network = Network(network_graph, 'ring6')
        return network

    @staticmethod
    def a380_topology():
        # refer to trilium note TSN / CaaS / Experiment / 调度算法理论分析 / 网络拓扑
        network_graph = nx.DiGraph()
        network_graph.add_nodes_from([
            (0, {'type': 'device', 'mac': '00:00:00:00:00:01'}),
            (1, {'type': 'device', 'mac': '00:00:00:00:00:02'}),
            (2, {'type': 'device', 'mac': '00:00:00:00:00:03'}),
            (3, {'type': 'device', 'mac': '00:00:00:00:00:04'}),
            (4, {'type': 'device', 'mac': '00:00:00:00:00:05'}),
            (5, {'type': 'device', 'mac': '00:00:00:00:00:06'}),
            (6, {'type': 'device', 'mac': '00:00:00:00:00:07'}),
            (7, {'type': 'device', 'mac': '00:00:00:00:00:08'}),
            (8, {'type': 'switch', 'mac': '00:00:00:00:01:01'}),
            (9, {'type': 'switch', 'mac': '00:00:00:00:01:02'}),
            (10, {'type': 'switch', 'mac': '00:00:00:00:01:03'}),
            (11, {'type': 'switch', 'mac': '00:00:00:00:01:04'}),
            (12, {'type': 'switch', 'mac': '00:00:00:00:01:05'}),
            (13, {'type': 'switch', 'mac': '00:00:00:00:01:06'}),
            (14, {'type': 'switch', 'mac': '00:00:00:00:01:07'}),
            (15, {'type': 'switch', 'mac': '00:00:00:00:01:08'}),
            (16, {'type': 'switch', 'mac': '00:00:00:00:01:09'}),
        ])
        
        network_graph.add_edge(0, 8, id = 0, src_port = 0, dst_port = 0)
        network_graph.add_edge(8, 0, id = 1, src_port = 0, dst_port = 0)
        network_graph.add_edge(1, 9, id = 2, src_port = 0, dst_port = 0)
        network_graph.add_edge(9, 1, id = 3, src_port = 0, dst_port = 0)
        network_graph.add_edge(2, 10, id = 4, src_port = 0, dst_port = 0)
        network_graph.add_edge(10, 2, id = 5, src_port = 0, dst_port = 0)
        network_graph.add_edge(3, 11, id = 6, src_port = 0, dst_port = 0)
        network_graph.add_edge(11, 3, id = 7, src_port = 0, dst_port = 0)
        network_graph.add_edge(4, 13, id = 8, src_port = 0, dst_port = 0)
        network_graph.add_edge(13, 4, id = 9, src_port = 0, dst_port = 0)
        network_graph.add_edge(5, 14, id = 10, src_port = 0, dst_port = 0)
        network_graph.add_edge(14, 5, id = 11, src_port = 0, dst_port = 0)
        network_graph.add_edge(6, 15, id = 12, src_port = 0, dst_port = 0)
        network_graph.add_edge(15, 6, id = 13, src_port = 0, dst_port = 0)
        network_graph.add_edge(7, 16, id = 14, src_port = 0, dst_port = 0)
        network_graph.add_edge(16, 7, id = 15, src_port = 0, dst_port = 0)

        network_graph.add_edge(8, 9, id = 16, src_port = 1, dst_port = 1)
        network_graph.add_edge(9, 8, id = 17, src_port = 1, dst_port = 1)
        network_graph.add_edge(8, 12, id = 18, src_port = 2, dst_port = 0)
        network_graph.add_edge(12, 8, id = 19, src_port = 0, dst_port = 2)
        network_graph.add_edge(8, 13, id = 20, src_port = 3, dst_port = 3)
        network_graph.add_edge(13, 8, id = 21, src_port = 3, dst_port = 3)
        
        network_graph.add_edge(9, 10, id = 22, src_port = 3, dst_port = 3)
        network_graph.add_edge(10, 9, id = 23, src_port = 3, dst_port = 3)
        network_graph.add_edge(9, 12, id = 24, src_port = 2, dst_port = 1)
        network_graph.add_edge(12, 9, id = 25, src_port = 1, dst_port = 2)
        
        network_graph.add_edge(10, 11, id = 26, src_port = 1, dst_port = 1)
        network_graph.add_edge(11, 10, id = 27, src_port = 1, dst_port = 1)
        network_graph.add_edge(10, 15, id = 28, src_port = 2, dst_port = 2)
        network_graph.add_edge(15, 10, id = 29, src_port = 2, dst_port = 2)

        network_graph.add_edge(11, 16, id = 30, src_port = 2, dst_port = 1)
        network_graph.add_edge(16, 11, id = 31, src_port = 1, dst_port = 2)
        
        network_graph.add_edge(12, 13, id = 32, src_port = 3, dst_port = 2)
        network_graph.add_edge(13, 12, id = 33, src_port = 2, dst_port = 3)
        network_graph.add_edge(12, 14, id = 34, src_port = 2, dst_port = 2)
        network_graph.add_edge(14, 12, id = 35, src_port = 2, dst_port = 2)
        
        network_graph.add_edge(13, 14, id = 36, src_port = 1, dst_port = 1)
        network_graph.add_edge(14, 13, id = 37, src_port = 1, dst_port = 1)

        network_graph.add_edge(14, 15, id = 38, src_port = 3, dst_port = 1)
        network_graph.add_edge(15, 14, id = 39, src_port = 1, dst_port = 3)
        
        network_graph.add_edge(15, 16, id = 40, src_port = 3, dst_port = 2)
        network_graph.add_edge(16, 15, id = 41, src_port = 2, dst_port = 3)

        network = Network(network_graph, 'a380')
        return network
    
    @staticmethod
    def cev_topology():
        network_graph = nx.DiGraph()
        network_graph.add_nodes_from([
            (0, {'type': 'device', 'mac': '00:00:00:00:00:01'}),
            (1, {'type': 'device', 'mac': '00:00:00:00:00:02'}),
            (2, {'type': 'device', 'mac': '00:00:00:00:00:03'}),
            (3, {'type': 'device', 'mac': '00:00:00:00:00:04'}),
            (4, {'type': 'device', 'mac': '00:00:00:00:00:05'}),
            (5, {'type': 'device', 'mac': '00:00:00:00:00:06'}),
            (6, {'type': 'device', 'mac': '00:00:00:00:00:07'}),
            (7, {'type': 'switch', 'mac': '00:00:00:00:01:01'}),
            (8, {'type': 'switch', 'mac': '00:00:00:00:01:02'}),
            (9, {'type': 'switch', 'mac': '00:00:00:00:01:03'}),
            (10, {'type': 'switch', 'mac': '00:00:00:00:01:04'}),
            (11, {'type': 'switch', 'mac': '00:00:00:00:01:05'}),
            (12, {'type': 'switch', 'mac': '00:00:00:00:01:06'}),
            (13, {'type': 'switch', 'mac': '00:00:00:00:01:07'}),
            (14, {'type': 'switch', 'mac': '00:00:00:00:01:08'}),
            (15, {'type': 'switch', 'mac': '00:00:00:00:01:09'}),
        ])
        
        network_graph.add_edge(0, 7, id = 0, src_port = 0, dst_port = 0)
        network_graph.add_edge(7, 0, id = 1, src_port = 0, dst_port = 0)
        network_graph.add_edge(1, 8, id = 2, src_port = 0, dst_port = 0)
        network_graph.add_edge(8, 1, id = 3, src_port = 0, dst_port = 0)
        network_graph.add_edge(2, 9, id = 4, src_port = 0, dst_port = 0)
        network_graph.add_edge(9, 2, id = 5, src_port = 0, dst_port = 0)
        network_graph.add_edge(3, 12, id = 6, src_port = 0, dst_port = 0)
        network_graph.add_edge(12, 3, id = 7, src_port = 0, dst_port = 0)
        network_graph.add_edge(4, 13, id = 8, src_port = 0, dst_port = 0)
        network_graph.add_edge(13, 4, id = 9, src_port = 0, dst_port = 0)
        network_graph.add_edge(5, 14, id = 10, src_port = 0, dst_port = 0)
        network_graph.add_edge(14, 5, id = 11, src_port = 0, dst_port = 0)
        network_graph.add_edge(6, 15, id = 12, src_port = 0, dst_port = 0)
        network_graph.add_edge(15, 6, id = 13, src_port = 0, dst_port = 0)
        
        network_graph.add_edge(7, 8, id = 14, src_port = 1, dst_port = 2)
        network_graph.add_edge(8, 7, id = 15, src_port = 2, dst_port = 1)
        network_graph.add_edge(7, 9, id = 16, src_port = 2, dst_port = 1)
        network_graph.add_edge(9, 7, id = 17, src_port = 1, dst_port = 2)
        
        network_graph.add_edge(8, 10, id = 18, src_port = 1, dst_port = 0)
        network_graph.add_edge(10, 8, id = 19, src_port = 0, dst_port = 1)
        
        network_graph.add_edge(9, 11, id = 20, src_port = 2, dst_port = 0)
        network_graph.add_edge(11, 9, id = 21, src_port = 0, dst_port = 2)
        
        network_graph.add_edge(10, 12, id = 22, src_port = 1, dst_port = 1)
        network_graph.add_edge(12, 10, id = 23, src_port = 1, dst_port = 1)
        network_graph.add_edge(10, 13, id = 24, src_port = 2, dst_port = 1)
        network_graph.add_edge(13, 10, id = 25, src_port = 1, dst_port = 2)
        network_graph.add_edge(10, 15, id = 26, src_port = 3, dst_port = 1)
        network_graph.add_edge(15, 10, id = 27, src_port = 1, dst_port = 3)
        
        network_graph.add_edge(11, 12, id = 28, src_port = 1, dst_port = 2)
        network_graph.add_edge(12, 11, id = 29, src_port = 2, dst_port = 1)
        network_graph.add_edge(11, 14, id = 30, src_port = 2, dst_port = 1)
        network_graph.add_edge(14, 11, id = 31, src_port = 1, dst_port = 2)
        network_graph.add_edge(11, 15, id = 32, src_port = 3, dst_port = 2)
        network_graph.add_edge(15, 11, id = 33, src_port = 2, dst_port = 3)
        
        network = Network(network_graph, 'cev')
        return network

    def all_consecutive_links(self):
        three = list(permutations(self.graph.nodes, 3))
        consecutive_links = []
        for seg in three:
            if (seg[0], seg[1]) in self.graph.edges and (seg[1], seg[2]) in self.graph.edges:
                consecutive_links.append(seg)
        return consecutive_links

    def get_msd(self, node):
        return 1

    def is_device(self, node):
        return self.graph.nodes[node]['type'] == 'device'
        
    def is_switch(self, node):
        return self.graph.nodes[node]['type'] == 'switch'

    def get_switches(self):
        return [node for node in self.graph.nodes if self.is_switch(node)]
    
    def get_devices(self):
        return [node for node in self.graph.nodes if self.is_device(node)]

    def draw_graph(self):
        nx.draw_networkx(self.graph)
