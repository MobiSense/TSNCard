import os
import math
import argparse
import json
import time
from typing import List, Tuple

import networkx as nx
from z3 import *
from itertools import combinations
from datetime import datetime
import matplotlib.pyplot as plt
from Flow import Flow
from Network import Network
from visualization import lcm

import argparse
from shutil import copyfile

def constrain_flow_path(solver: Solver, f: Flow, x, network: Network):
    """
    Add the constraints about the path of flow f into solver
    :param solver: The z3 solver
    :param f: The flow
    :param x: The x matrix
    :param network: the network
    :return:
    """
    expr_list = []
    routing_path = network.shortest_path_map[(f.src, f.dst)]
    for edge in network.graph.edges:
        if edge in routing_path:
            expr_list.append(x[f.i, f.k, edge[0], edge[1]])
        else:
            expr_list.append(Not(x[f.i, f.k, edge[0], edge[1]]))
    solver.add(And(*expr_list))


def constrain_in_out_flow_timing(solver: Solver, f: Flow, x, network, all_consecutive_links, t, o):
    for three in all_consecutive_links:
        condition = And(x[f.i, f.k, three[0], three[1]], x[f.i, f.k, three[1], three[2]])
        msd = network.get_msd(three[1])
        result = (t[f.i, f.k, three[1], three[2]] + o[f.i, f.k, three[1], three[2]] * f.period) \
                 - (t[f.i, f.k, three[0], three[1]] + o[f.i, f.k, three[0], three[1]] * f.period) >= msd
        solver.add(Implies(condition, result))
    # out flow timing constraints
    for e in network.graph.edges:
        condition = Not(x[f.i, f.k, e[0], e[1]])
        result = And(t[f.i, f.k, e[0], e[1]] == 0, o[f.i, f.k, e[0], e[1]] == 0)
        solver.add(Implies(condition, result))


def constrain_flow_pair_overlap(solver: Solver, fp: Tuple[Flow, Flow], x, network, t):
    fa: Flow
    fb: Flow
    fa, fb = fp
    # super_period = math.lcm(fa.period, fb.period)
    super_period = lcm([fa.period, fb.period])
    # extra consider for fa should at least cover the extra period of fb
    U = int(super_period / fa.period) + math.ceil(fb.period / fa.period)
    V = int(super_period / fb.period) + math.ceil(fa.period / fb.period)
    for e in network.graph.edges:
        # if both fa and fb use edge e
        condition = And(x[fa.i, fa.k, e[0], e[1]], x[fb.i, fb.k, e[0], e[1]])
        for u in range(U):
            for v in range(V):
                # p1: fa is before fb
                p1 = (t[fb.i, fb.k, e[0], e[1]] + v * fb.period) - \
                     (t[fa.i, fa.k, e[0], e[1]] + u * fa.period) >= fa.trans_t
                # p2: fb is before fa
                p2 = (t[fa.i, fa.k, e[0], e[1]] + u * fa.period) - \
                     (t[fb.i, fb.k, e[0], e[1]] + v * fb.period) >= fb.trans_t
                solver.add(Implies(condition, Or(p1, p2)))
                # TODO: add flow isolation constraint -> once a flow arrives the device, no flow can arrive 
                #       with same egress port, until it is sent completely
                # TODO: 1. find next hop 


def constrain_flow_requirement(solver: Solver, flows: List[Flow], network: Network, t, o):
    for f in flows:
        f_path = network.shortest_path_map[(f.src, f.dst)]
        first_edge = f_path[0]
        last_edge = f_path[-1]
        src_time = t[f.i, f.k, first_edge[0], first_edge[1]] + o[f.i, f.k, first_edge[0], first_edge[1]] * f.period
        dst_time = t[f.i, f.k, last_edge[0], last_edge[1]] + o[f.i, f.k, last_edge[0], last_edge[1]] * f.period
        solver.add(dst_time - src_time <= f.MD - f.trans_t)


# strict overlap cons
# This is for CaaS
def constrain_overlap_flow_sequence(solver: Solver, fp: Tuple[Flow, Flow], x, network, t, o):
    fa: Flow
    fb: Flow
    fa, fb = fp
    # super_period = math.lcm(fa.period, fb.period)
    super_period = lcm([fa.period, fb.period])
    # extra consider for fa should at least cover the extra period of fb
    U = int(super_period / fa.period) + math.ceil(fb.period / fa.period)
    V = int(super_period / fb.period) + math.ceil(fa.period / fb.period)
    for host_value_0 in range(network.switch_min_index, network.switch_max_index + 1):
        if fa.type == Flow.SRC_FLOW:
            src1 = fa.src
            dst1 = host_value_0
        else:
            src1 = host_value_0
            dst1 = fa.dst
        for host_value_1 in range(network.switch_min_index, network.switch_max_index + 1):
            if fa.job.i == fb.job.i:
                if host_value_0 != host_value_1:
                    continue
                host_condition = fa.job.host == host_value_0
            else:
                host_condition = And(fa.job.host == host_value_0, fb.job.host == host_value_1)
            if fb.type == Flow.SRC_FLOW:
                src2 = fb.src
                dst2 = host_value_1
            else:
                src2 = host_value_1
                dst2 = fb.dst

            for e in network.shared_edges[(src1, dst1, src2, dst2)]:
                # if both fa and fb use edge e
                overlap_condition = And(x[fa.i, fa.k, e[0], e[1]], x[fb.i, fb.k, e[0], e[1]])
                both_from_out_condition = And(e[0] != fa.src, e[0] != fb.src)
                fa_int_fb_out_condition = And(e[0] == fa.src, e[0] != fb.src)  # e[0] must be a switch
                fa_out_fb_int_condition = And(e[0] != fa.src, e[0] == fb.src)  # e[0] must be a switch
                both_from_int_condition = And(e[0] == fa.src, e[0] == fb.src)  # e[0] is a switch or a device
                for u in range(U):
                    for v in range(V):
                        if network.is_device(e[0]):
                            # p1: fa is before fb
                            p1 = (t[fb.i, fb.k, e[0], e[1]] + v * fb.period) - \
                                 (t[fa.i, fa.k, e[0], e[1]] + u * fa.period) >= fa.trans_t
                            # p2: fb is before fa
                            p2 = (t[fa.i, fa.k, e[0], e[1]] + u * fa.period) - \
                                 (t[fb.i, fb.k, e[0], e[1]] + v * fb.period) >= fb.trans_t
                            solver.add(Implies(And(host_condition, overlap_condition), Or(p1, p2)))
                        else:
                            fa_int_arrival_start_t = fa.job.job_start + (fa.job.job_start_o + u) * fa.job.P + fa.job.T
                            fa_int_arrival_end_t = fa_int_arrival_start_t
                            fa_out_arrival_start_t = sum([t[fa.i, fa.k, node, e[0]] + o[fa.i, fa.k, node, e[0]] * fa.period for node in network.graph[e[0]]]) + u * fa.period
                            fa_out_arrival_end_t = fa_out_arrival_start_t + fa.trans_t
                            fb_int_arrival_start_t = fb.job.job_start + (fb.job.job_start_o + v) * fb.job.P + fb.job.T
                            fb_int_arrival_end_t = fb_int_arrival_start_t
                            fb_out_arrival_start_t = sum([t[fb.i, fb.k, node, e[0]] + o[fb.i, fb.k, node, e[0]] * fb.period for node in network.graph[e[0]]]) + v * fb.period
                            fb_out_arrival_end_t = fb_out_arrival_start_t + fb.trans_t

                            fa_leave_start_t = t[fa.i, fa.k, e[0], e[1]] + (o[fa.i, fa.k, e[0], e[1]] + u) * fa.period
                            fa_leave_end_t = fa_leave_start_t + fa.trans_t
                            fb_leave_start_t = t[fb.i, fb.k, e[0], e[1]] + (o[fb.i, fb.k, e[0], e[1]] + v) * fb.period
                            fb_leave_end_t = fb_leave_start_t + fb.trans_t

                            solver.add(Implies(And(host_condition, overlap_condition, both_from_out_condition), Or(And(fa_out_arrival_end_t <= fb_out_arrival_start_t, fa_leave_end_t <= fb_leave_start_t), And(fb_out_arrival_end_t <= fa_out_arrival_start_t, fb_leave_end_t <= fa_leave_start_t))))
                            solver.add(Implies(And(host_condition, overlap_condition, fa_int_fb_out_condition), Or(And(fa_int_arrival_end_t <= fb_out_arrival_start_t, fa_leave_end_t <= fb_leave_start_t), And(fb_out_arrival_end_t <= fa_int_arrival_start_t, fb_leave_end_t <= fa_leave_start_t))))
                            solver.add(Implies(And(host_condition, overlap_condition, fa_out_fb_int_condition), Or(And(fa_out_arrival_end_t <= fb_int_arrival_start_t, fa_leave_end_t <= fb_leave_start_t), And(fb_int_arrival_end_t <= fa_out_arrival_start_t, fb_leave_end_t <= fa_leave_start_t))))
                            solver.add(Implies(And(host_condition, overlap_condition, both_from_int_condition), Or(fa_leave_end_t <= fb_leave_start_t, fb_leave_end_t <= fa_leave_start_t)))


def construct_link_usage_matrix(flows: List[Flow], network: Network, solver):
    # Since there is no job in pure flow scheduling, job id (i) is always 0.
    x = {}
    for f in flows:
        for e in network.graph.edges:
            x[f.i, f.k, e[0], e[1]] = Bool("X_{}_{}_{}_{}".format(f.i, f.k, e[0], e[1]))
    return x


def construct_link_schedule_matrix(flows: List[Flow], network: Network, solver):
    t = {}
    o = {}
    for f in flows:
        for e in network.graph.edges:
            t[f.i, f.k, e[0], e[1]] = Int("T_{}_{}_{}_{}".format(f.i, f.k, e[0], e[1]))
            solver.add(And(t[f.i, f.k, e[0], e[1]] >= 0, t[f.i, f.k, e[0], e[1]] < f.period))
            # solver.add(t[f.i, f.k, e[0], e[1]] >= 0)
            o[f.i, f.k, e[0], e[1]] = Int("O_{}_{}_{}_{}".format(f.i, f.k, e[0], e[1]))
            solver.add(o[f.i, f.k, e[0], e[1]] >= 0)
            # Can offset be larger than 1 period?
            solver.add(o[f.i, f.k, e[0], e[1]] <= 1)
    return t, o


def max_int_expr(solver, expr_list, name):
    max_expr = Int(name)
    equal_expr_list = [max_expr == e for e in expr_list]
    solver.add(Or(*equal_expr_list))
    larger_expr_list = [max_expr >= e for e in expr_list]
    solver.add(And(*larger_expr_list))
    return max_expr


def min_int_expr(solver, expr_list, name):
    min_expr = Int(name)
    equal_expr_list = [min_expr == e for e in expr_list]
    solver.add(Or(*equal_expr_list))
    smaller_expr_list = [min_expr <= e for e in expr_list]
    solver.add(And(*smaller_expr_list))
    return min_expr


def get_flow_latency_expression(f: Flow, t, o, network: Network):
    f_path = network.shortest_path_map[(f.src, f.dst)]
    first_edge = f_path[0]
    last_edge = f_path[-1]
    src_time = t[f.i, f.k, first_edge[0], first_edge[1]] + o[f.i, f.k, first_edge[0], first_edge[1]] * f.period
    dst_time = t[f.i, f.k, last_edge[0], last_edge[1]] + o[f.i, f.k, last_edge[0], last_edge[1]] * f.period
    return dst_time - src_time + f.trans_t


def solve(minimize_flag, input_flows, input_network, group_id, output_schedule_name=None, timeout=None):
    """

    :param timeout:
    :param group_id:
    :param result_path:
    :param input_network:
    :param minimize_flag: If use Optimize.
    :param input_flows:
    :return:
    """
    strict_overlap_cons = False
    if minimize_flag:
        solver = Optimize()
    else:
        solver = Solver()
    network = input_network
    flows = input_flows
    # network.preprocessing()
    x = construct_link_usage_matrix(flows, network, solver)
    for f in flows:
        constrain_flow_path(solver, f, x, network)
    t, o = construct_link_schedule_matrix(flows, network, solver)
    all_consecutive_links = network.all_consecutive_links()
    for f in flows:
        constrain_in_out_flow_timing(solver, f, x, network, all_consecutive_links, t, o)

    flow_pair_list = combinations(flows, 2)
    # not strict overlap cons
    for fp in flow_pair_list:
        constrain_flow_pair_overlap(solver, fp, x, network, t)
    # strict overlap constraints, but takes much more time
    # for fp in flow_pair_list:
    #     constrain_overlap_flow_sequence(solver, fp, x, network, t, o)

    constrain_flow_requirement(solver, flows, network, t, o)

    sum_flow_latency = 0
    for f in flows:
        flow_latency = get_flow_latency_expression(f, t, o, network)
        sum_flow_latency = sum_flow_latency + flow_latency

    if minimize_flag:
        solver.minimize(sum_flow_latency)

    TotalLatency = Int("TotalLatency")
    solver.add(TotalLatency == sum_flow_latency)
    if timeout is not None:
        solver.set('timeout', timeout)  # unit ms
    print(datetime.now(), "Start check.")
    solve_result = solver.check()
    print(solve_result)
    # if solve_result == unsat:
    #     print(solver.unsat_core())
    # else:
    if solve_result == sat:
        m = solver.model()
        print("Total latency: ", m[TotalLatency].as_long())
        # for var in m:
        #     [print(name, m[name]) for name in sorted(m, key=lambda x: x.name())]
        schedule_result = []
        switches = network.get_switches()
        for sw in switches:
            sw_schedule = {
                "type": "switch",
                "id": sw,
                "mac": network.graph.nodes[sw]['mac'],
                "schedule": []
            }
            # empty switch schedule
            schedule_result.append(sw_schedule)
        for e in network.graph.edges:
            edge_schedule = {
                "type": "link",
                "from": e[0],
                "to": e[1],
                "from_port": network.graph.edges[e]['src_port'],
                "id": network.graph.edges[e]['id'],
                "schedule": []
            }
            for f in flows:
                if is_true(m[x[f.i, f.k, e[0], e[1]]]):
                    flow_start = m[t[f.i, f.k, e[0], e[1]]].as_long()
                    edge_schedule["schedule"].append({
                        "period": f.period,
                        "start": flow_start,
                        "end": flow_start + f.trans_t,
                        "job_id": f.i,  # always 0 for pure flow scheduling
                        "flow_id": f.k
                    })
            schedule_result.append(edge_schedule)
        method_name = "opt" if minimize_flag else "sol"
        # We assume result_path and group_id are both none or not none
        if output_schedule_name is not None:
            file_name = "config/{}-schedule.json".format(output_schedule_name)

            with open(file_name, "w") as f:
                f.write(json.dumps(schedule_result, indent=4))

            print(f'Saved in {file_name}')
        return solve_result, schedule_result
    return solve_result, None


def load_network(config_file):
    with open(config_file, 'r', encoding='utf-8') as f:
        network_config = json.load(f)
        network_graph = nx.DiGraph()
        for node in network_config['nodes']:
            network_graph.add_node(node['id'], type=node['type'], mac=node['mac'], 
                                   ptp_ports=node['ptp_ports'] if 'ptp_ports' in node else [])
        for link in network_config['links']:
            if link['src'] != link['dst']:
                network_graph.add_edge(link['src'], link['dst'], id=link['id'], src_port=link['src_port'], dst_port=link['dst_port'])
        network = Network(network_graph, config_file.split('.')[0])
        return network


def load_flows(flow_file):
    with open(flow_file, 'r', encoding='utf-8') as f:
        flows_config = json.load(f)
        flows = []
        for fc in flows_config:
            f = Flow(fc['job_id'], fc['flow_id'], fc['src'], fc['dst'], fc['period'], fc['MD'])
            flows.append(f)
        return flows


if __name__ == '__main__':
    # Create a ArgumentParser object
    parse = argparse.ArgumentParser(prog='CNC Scheduler', usage='%(prog)s [options] usage', description = 'TSN Scheduler', epilog = 'my - epilog')
    # Add argument

    parse.add_argument('input_flow_path',type=str, help='input flow path')
    parse.add_argument('input_config_path',type=str,help='input config path')
    parse.add_argument('output_schedule_name',type=str,help='output schedule name')

    args = parse.parse_args()
    
    print("flow path: ", args.input_flow_path)
    print("topo path: ", args.input_config_path)
    print("output schedule name: ", args.output_schedule_name)
    

    network = load_network(args.input_config_path)  # network topology config file, same format as https://gitlab.sense-lab.org/tsn-dev/tsn-cnc-scripts/-/blob/master/config/d2s1-config.json WITHOUT fwd !!!!!!!!
    with open("config/{}-config.json".format(args.output_schedule_name), "w") as f:
        f.write(json.dumps(network.get_graph_output(), indent=4))
    # copyfile(args.input_config_path, "config/{}-config.json".format(args.output_schedule_name))
    flows = load_flows(args.input_flow_path)  # flow requirement config file
    solve(True, flows, network, "01", args.output_schedule_name, None)  # write schedule results



    # case 1
    # network = load_network("network.json")  # network topology config file, same format as https://gitlab.sense-lab.org/tsn-dev/tsn-cnc-scripts/-/blob/master/config/d2s1-config.json WITHOUT fwd !!!!!!!!
    # flows = load_flows("flows.json")  # flow requirement config file
    # solve(True, flows, network, "01", None)  # write schedule results to ../data/cnc_scheduling/*, same format as https://gitlab.sense-lab.org/tsn-dev/tsn-cnc-scripts/-/blob/master/config/d2s1-schedule.json

    # case 2
    # network = load_network("network_1.json")
    # flows = load_flows("flows_1.json")
    # solve(True, flows, network, "01", None)
