import re
import json
import glob
import copy
import os

ANALYSIS_FOLDER = ['Ring6/flow25']

current_path = os.path.dirname(os.path.abspath(__file__))

class EventLog:
    def __init__(self, time, switch, gate, flow, pkt):
        self.time = time
        self.switch = switch
        self.gate = gate
        self.flow = flow
        self.pkt = pkt

def analysis_log(folder: str):
    global current_path
    
    pattern_runid = re.compile(r'^\[Run ID\] (\d+)-(\d+)\.$')
    
    pattern_gateconf =  re.compile(r'^\[Gate Config\] Gate ((\w+)\.(\w+)): \(Destination\)((\w+)\.(\w+))(?: \(Offset\)([-.\w]+) \(Durations\)\[([.\w,\s]+)\])?\.$')
    pattern_flowconf =  re.compile(r'^\[Flow Config\] Flow flow(\d+): From (\w+) to (\w+), period ([.\d]+)us\.$')
    pattern_packet =    re.compile(r'^\[Packet Info\] (\w+)\.(\w+): (Received|Transmitted) flow(\d+)_\w+-(\d+) at (\d+(?:\.\d+)?)\.$')
    
    pattern_error_gate =  re.compile(r'^\[Error Config\] \(Gate error\) (\w+)\.(\w+): \(Offset\)([-.\w]+) \(Durations\)\[([.\w,\s]+)\] --> \(Offset\)([-.\w]+) \(Durations\)\[([.\w,\s]+)\]\.$')
    pattern_error_queue = re.compile(r'^\[Error Config\] \(Queue error\) (\w+)\.(\w+): Packet flow(\d+)_\w+-(\d+) <---> Packet flow(\d+)_\w+-(\d+)\.$')
    pattern_error_delay = re.compile(r'^\[Error Config\] \(PacketDelay error\) (\w+)\.(\w+): Packet flow(\d+)_\w+-(\d+) delayed for ([.\d]+)us\.$')
    pattern_error_loss =  re.compile(r'^\[Error Config\] \(PacketLoss error\) (\w+): Packet flow(\d+)_\w+-(\d+) lost\.$')
    
    sim_stat_template = {}
    sim_stat_template["topology"] = []
    sim_stat_template["flow_schedule"] = []
    sim_stat_template["node_schedule"] = []
    sim_stat_template["errors"] = []
    sim_stat_template["postcards"] = []
    
    # 读取标准仿真，生成仿真统计模板
    template_path = os.path.join(current_path, folder, 'log_raw/log_0.txt')
    with open(template_path) as f_log_ref:
        topology = {}
        
        for line in f_log_ref:
            line = line.strip()
            
            # 端口规划
            if line.startswith('[Gate Config]'):
                match = re.match(pattern_gateconf, line)
                
                current_full =   match.group(1)
                current_switch = match.group(2)
                current_gate =   match.group(3)
                dest_full =      match.group(4)
                dest_switch =    match.group(5)
                dest_gate =      match.group(6)
                offset =         match.group(7)
                durations =      match.group(8)
                
                # 网络拓扑
                if current_full not in topology:
                    topology[current_full] = []
                if dest_full not in topology:
                    topology[dest_full] = []
                    
                if dest_full not in topology[current_full]:
                    topology[current_full].append(dest_full)
                    topology[dest_full].append(current_full)
                    
                    sim_stat_template["topology"].append({
                        "src_node_id": current_switch,
                        "dst_node_id": dest_switch,
                        "src_port":    current_gate,
                        "dst_port":    dest_gate
                    })
                    
                if offset != None:
                    # 节点规划
                    sim_stat_template["node_schedule"].append({
                        "node_id":   current_switch,
                        "port":      current_gate,
                        "offset":    offset,
                        "durations": durations.split(', ')
                    })
            
            # 流规划
            elif line.startswith('[Flow Config]'):
                match = re.match(pattern_flowconf, line)
                
                flow =     int(match.group(1))
                src =          match.group(2)
                dst =          match.group(3)
                period = float(match.group(4))
                
                sim_stat_template["flow_schedule"].append({
                    "flow_id":      flow,
                    "src_node_id":  src,
                    "dst_node_id":  dst,
                    "period":       period,
                    "deadline":     0,
                    "hop_schedule": []
                })
            
            # 仿真信息：根据仿真信息，生成正确规划中，流每一跳的发出时间
            elif line.startswith('[Packet Info]'):
                match = re.match(pattern_packet, line)
                
                switch =     match.group(1)
                gate =       match.group(2)
                type =       match.group(3)
                flow =   int(match.group(4))
                pkt =    int(match.group(5))
                time = round(float(match.group(6)) * 1e6, 3)
                    
                if type == 'Transmitted' and pkt == 1:
                    flow_schedule = [fs for fs in sim_stat_template["flow_schedule"] if fs["flow_id"] == flow][0]
                    flow_schedule["hop_schedule"].append({
                        "node_id":      switch,
                        "port":         gate,
                        "tx_timestamp": time
                    })
                    
                # 根据端到端延迟，确定deadline
                elif type == 'Received' and pkt == 1 and switch.startswith('de'):
                    flow_schedule = [fs for fs in sim_stat_template["flow_schedule"] if fs["flow_id"] == flow][0]
                    if flow_schedule["dst_node_id"] != switch:
                        continue
                    rx_timestamp = time
                    tx_timestamp = flow_schedule["hop_schedule"][0]["tx_timestamp"]
                    flow_schedule["deadline"] = int((rx_timestamp - tx_timestamp) * 1.05)
                    
                    # 校验：deadline不能大于period
                    assert flow_schedule["deadline"] <= flow_schedule["period"]
    
    # 生成仿真统计文件夹
    output_dir = os.path.join(current_path, folder, 'log_json')
    os.makedirs(output_dir, exist_ok=True)
    
    # 清除仿真统计文件夹中的所有文件
    for file in os.listdir(output_dir):
        os.remove(os.path.join(output_dir, file))
    
    # 读取带错误的仿真，生成仿真统计
    file_pattern = os.path.join(current_path, folder, 'log_raw/log_*.txt')
    file_list = glob.glob(file_pattern)
    
    for file in file_list:
        if file.endswith('log_0.txt'):
            continue
        
        runid = ""
        sim_statistic = copy.deepcopy(sim_stat_template)
        pending_events = []
        
        with open(file, 'r') as f_log:
            for line in f_log:
                line = line.strip()
                
                # Run ID
                if line.startswith('[Run ID]'):
                    match = re.match(pattern_runid, line)
                    runid = match.group(1) + match.group(2).zfill(3)
                
                
                # 错误信息
                if line.startswith('[Error Config]'):
                    
                    # 错误类型：门控错误
                    if line.find('(Gate error)') != -1:
                        match = re.match(pattern_error_gate, line)
                        
                        switch =       match.group(1)
                        gate =         match.group(2)
                        off_original = match.group(3)
                        dur_original = match.group(4)
                        off_new =      match.group(5)
                        dur_new =      match.group(6)
                        
                        sim_statistic["errors"].append({
                            "type":               "Gate",
                            "node_id":            switch,
                            "port":               gate,
                            "original_offset":    off_original,
                            "original_durations": dur_original.split(', '),
                            "new_offset":         off_new,
                            "new_durations":      dur_new.split(', ')
                        })
                    
                    # 错误类型：队列乱序
                    elif line.find('(Queue error)') != -1:
                        match = re.match(pattern_error_queue, line)
                        
                        switch =     match.group(1)
                        gate =       match.group(2)
                        flow_x = int(match.group(3))
                        pkt_x =  int(match.group(4))
                        flow_y = int(match.group(5))
                        pkt_y =  int(match.group(6))
                        
                        sim_statistic["errors"].append({
                            "type":      "Queue",
                            "node_id":   switch,
                            "port":      gate,
                            "flow_id_x": flow_x,
                            "pkt_id_x":  pkt_x,
                            "flow_id_y": flow_y,
                            "pkt_id_y":  pkt_y
                        })
                        
                    # 错误类型：延迟
                    elif line.find('(PacketDelay error)') != -1:
                        match = re.match(pattern_error_delay, line)
                        
                        switch =      match.group(1)
                        gate =        match.group(2)
                        flow =    int(match.group(3))
                        pkt =     int(match.group(4))
                        delay = round(float(match.group(5)), 3)
                        
                        sim_statistic["errors"].append({
                            "type":    "PacketDelay",
                            "node_id": switch,
                            "port":    gate,
                            "flow_id": flow,
                            "pkt_id":  pkt,
                            "delay":   delay
                        })
                    
                    # 错误类型：丢包
                    elif line.find('(PacketLoss error)') != -1:
                        match = re.match(pattern_error_loss, line)
                        
                        switch =     match.group(1)
                        flow =   int(match.group(2))
                        pkt =    int(match.group(3))
                        
                        sim_statistic["errors"].append({
                            "type":    "PacketLoss",
                            "node_id": switch,
                            "flow_id": flow,
                            "pkt_id":  pkt
                        })
                    
                    
                # 仿真信息
                elif line.startswith('[Packet Info]'):
                    match = re.match(pattern_packet, line)
                    
                    switch =           match.group(1)
                    gate =             match.group(2)
                    type =             match.group(3)
                    flow =         int(match.group(4))
                    pkt =          int(match.group(5))
                    time = round(float(match.group(6)) * 1e6, 3)
                    
                    event_log = EventLog(time, switch, gate, flow, pkt)
                    
                    if type == 'Received':
                        if switch.startswith('de'):
                            sim_statistic["postcards"].append({
                                "flow_id": flow,
                                "pkt_id":  pkt,
                                "node_id": switch,
                                "rx":      time
                            })
                        else:
                            pending_events.append(event_log)
                        
                    elif type == 'Transmitted':
                        if switch.startswith('de'):
                            sim_statistic["postcards"].append({
                                "flow_id": flow,
                                "pkt_id":  pkt,
                                "node_id": switch,
                                "tx":      time
                            })
                        else:
                            for pending in pending_events:
                                if pending.switch == event_log.switch and pending.flow == event_log.flow and pending.pkt == event_log.pkt:
                                    sim_statistic["postcards"].append({
                                        "flow_id": event_log.flow,
                                        "pkt_id":  event_log.pkt,
                                        "node_id": event_log.switch,
                                        "rx":      pending.time,
                                        "tx":      event_log.time
                                    })
                                    pending_events.remove(pending)
                                    break
        
        output_file = os.path.join(output_dir, f'log_{runid}.json')
        
        with open(output_file, 'w') as f_log_json:
            json.dump(sim_statistic, f_log_json, indent=4)
   
            
            
def extract_diffusion(folder: str):
    global current_path

    # 生成错误扩散记录文件夹
    diffusion_dir = os.path.join(current_path, folder, 'log_diffusion')
    os.makedirs(diffusion_dir, exist_ok=True)
    
    # 统计信息
    diffusion_stat = {
        "Gate_total": 0,
        "Gate_diffusion": 0,
        "Queue_total": 0,
        "Queue_diffusion": 0,
        "PacketDelay_total": 0,
        "PacketDelay_diffusion": 0,
        "PacketLoss_total": 0,
        "PacketLoss_diffusion": 0,
        "All_total": 0,
        "All_diffusion": 0
    }
    
    # 读取错误扩散记录
    json_pattern = os.path.join(current_path, folder, 'log_json/log_*.json')
    json_list = glob.glob(json_pattern)
    
    for json_file in json_list:
        json_file_name = os.path.basename(json_file)
        
        
        
        with open(json_file, 'r') as f_json:
            json_data = json.load(f_json)
            
            # 统计错误类型
            if len(json_data["errors"]) == 0:
                continue
            error_sample = json_data["errors"][0]
            if error_sample["type"] == "Gate":
                diffusion_stat["Gate_total"] += 1
            elif error_sample["type"] == "Queue":
                diffusion_stat["Queue_total"] += 1
            elif error_sample["type"] == "PacketDelay":
                diffusion_stat["PacketDelay_total"] += 1
            elif error_sample["type"] == "PacketLoss":
                diffusion_stat["PacketLoss_total"] += 1
            diffusion_stat["All_total"] += 1
            
            # 检查是否出现了扩散现象
            has_diffusion = False
            
            # 提取仿真数据
            # 错误节点
            error_port = {
                error["node_id"]
                    for error in json_data["errors"]
            }
            # flow经过所有的节点
            flow_ports = {
                flow["flow_id"]: {
                    hop["node_id"] for hop in flow["hop_schedule"] if hop["node_id"].startswith('sw')
                } for flow in json_data["flow_schedule"]
            }
            # 经过了错误端口的flow
            error_flow = {
                flow_id for flow_id, ports in flow_ports.items() if len(ports & error_port) > 0
            }
            
            # flow的deadline
            flow_deadline = {
                flow["flow_id"]: flow["deadline"] for flow in json_data["flow_schedule"]
            }
            # flow的实际发送接收时间
            for postcard in json_data["postcards"]:
                if postcard["flow_id"] in error_flow:
                    continue
                if postcard["node_id"].startswith('de') and "rx" in postcard:
                    postcard_tx = [pc for pc in json_data["postcards"] if pc["flow_id"] == postcard["flow_id"] and pc["pkt_id"] == postcard["pkt_id"] and pc["node_id"].startswith('de') and "tx" in pc][0]
                    if postcard["rx"] - postcard_tx["tx"] > flow_deadline[postcard["flow_id"]]:
                        has_diffusion = True
                        
                        json_data["diffusion"] = {
                            "error": json_data["errors"],
                            "flow_id": postcard["flow_id"],
                            "pkt_id":  postcard["pkt_id"],
                            "flow_schedule": [json_data["flow_schedule"][i] for i in range(len(json_data["flow_schedule"])) if json_data["flow_schedule"][i]["flow_id"] == postcard["flow_id"]][0],
                            "duration": round(postcard["rx"] - postcard_tx["tx"], 3),
                            "tx": postcard_tx,
                            "rx": postcard
                        }
                        
                        # 统计错误类型
                        error_sample = json_data["errors"][0]
                        if error_sample["type"] == "Gate":
                            diffusion_stat["Gate_diffusion"] += 1
                        elif error_sample["type"] == "Queue":
                            diffusion_stat["Queue_diffusion"] += 1
                        elif error_sample["type"] == "PacketDelay":
                            diffusion_stat["PacketDelay_diffusion"] += 1
                        elif error_sample["type"] == "PacketLoss":
                            diffusion_stat["PacketLoss_diffusion"] += 1
                        diffusion_stat["All_diffusion"] += 1
                        
                        break
            
            if not has_diffusion:
                continue
            
            # 出现了扩散现象，复制文件
            diffusion_file = os.path.join(diffusion_dir, json_file_name)
            if os.path.exists(diffusion_file):
                continue
            with open(diffusion_file, 'w') as f_diffusion:
                json.dump(json_data, f_diffusion, indent=4)
                
    # 打印统计信息
    print(f'[{folder}]')
    print(f'Diffusion rate: {diffusion_stat["All_diffusion"]}/{diffusion_stat["All_total"]}')
    print(f'    Gate: {diffusion_stat["Gate_diffusion"]}/{diffusion_stat["Gate_total"]}')
    print(f'    Queue: {diffusion_stat["Queue_diffusion"]}/{diffusion_stat["Queue_total"]}')
    print(f'    PacketDelay: {diffusion_stat["PacketDelay_diffusion"]}/{diffusion_stat["PacketDelay_total"]}')
    print(f'    PacketLoss: {diffusion_stat["PacketLoss_diffusion"]}/{diffusion_stat["PacketLoss_total"]}')
    print(f'Total data: {len(os.listdir(diffusion_dir))}')



if __name__ == '__main__':
    for folder in ANALYSIS_FOLDER:
        analysis_log(folder)
        extract_diffusion(folder)