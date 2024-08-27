from typing import Optional, List, Tuple, Dict, Union
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import json
import os


def gcd(a: int, b: int) -> int:
    if b == 0: return a
    return gcd(b, a % b)


def lcm(data: List[int]) -> int:
    if len(data) == 0:
        return 1
    if len(data) == 1:
        return data[0]
    if len(data) == 2:
        return data[0] * data[1] // gcd(data[0], data[1])
    x = data[0]
    for idx in range(1, len(data)):
        x = x * data[idx] // gcd(x, data[idx])
    return x


class FLOW:
    def __init__(self, id: int, job_id: int):
        self.id: int = id
        self.job_id: int = job_id
        self.link_list: List[Tuple] = []

    def add(self, src: int, dst: int,
            start: int, end: int, period: int) -> None:
        self.link_list.append((src, dst, start, end, period))

    def sort(self) -> None:
        # sort by topology order
        prev_map = {}
        link_map = {}
        for src, dst, start, end, period in self.link_list:
            prev_map[dst] = src
            link_map[src] = (src, dst, start, end ,period)
        k, _, _, _, _  = self.link_list[0]
        while k in prev_map:
            k = prev_map[k]
        self.link_list.clear()
        while k in link_map:
            self.link_list.append(link_map[k])
            k = link_map[k][1]


class JOB:
    def __init__(self, id: int):
        self.id: int = id
        self.device_list: List[Tuple] = []
        self.flow_list: List[FLOW] = []

    def add(self, device_id: int, start: int, end: int, period: int) -> None:
        self.device_list.append((device_id, start, end, period))

    def sort(self) -> None:
        # sort by start time
        self.device_list.sort(key=lambda device: device[1])
        for flow in self.flow_list:
            flow.sort()

    def add_flow(self, flow: FLOW) -> None:
        for fl in self.flow_list:
            if fl.id == flow.id:
                return
        self.flow_list.append(flow)

    def has_task(self, device_id: int) -> bool:
        for device_id_, _, _, _ in self.device_list:
            if device_id_ == device_id:
                return True
        return False

    def get_task(self, device_id) -> Tuple:
        for device_id_, start, end, period in self.device_list:
            if device_id_ == device_id:
                return start, end, period
        return None, None, None


def check(index_list: List[int], flow_list: List[FLOW]) -> bool:
    assert len(index_list) == len(flow_list)
    for i in range(len(flow_list)):
        if index_list[i] < len(flow_list[i].link_list):
            return True
    return False


class PLOTTED:
    def __init__(self, param: Union[List, str]):
        if isinstance(param, List):
            self.data = param
        elif isinstance(param, str):
            with open(param, 'r') as fp:
                self.data = json.load(fp=fp)
        else:
            raise Exception("Unknown data type for PLOTTED!")

        period_list = []
        self.flow_map: Dict[int, FLOW] = {}
        self.job_map: Dict[int, JOB] = {}
        for data in self.data:
            if data['type'] == 'switch':
                for schedule in data['schedule']:
                    if schedule['job_id'] not in self.job_map:
                        self.job_map[schedule['job_id']] = JOB(id=schedule['job_id'])
                    job = self.job_map[schedule['job_id']]
                    job.add(start=schedule['start'], end=schedule['end'],
                            device_id=data['id'], period=schedule['period'])
                    period_list += [schedule['period']]
            elif data['type'] == 'link':
                for schedule in data['schedule']:
                    if schedule['flow_id'] not in self.flow_map:
                        self.flow_map[schedule['flow_id']] = FLOW(id=schedule['flow_id'],
                                                                  job_id=schedule['job_id'])
                    if schedule['job_id'] not in self.job_map:
                        self.job_map[schedule['job_id']] = JOB(id=schedule['job_id'])
                    flow = self.flow_map[schedule['flow_id']]
                    job = self.job_map[schedule['job_id']]
                    assert flow.job_id == schedule['job_id']
                    flow.add(src=data['from'], dst=data['to'],
                             start=schedule['start'], end=schedule['end'],
                             period=schedule['period'])
                    job.add_flow(flow)
                    period_list += [schedule['period']]
            else:
                raise Exception(f"Unknown type {data['type']}")
        self.period = round(lcm(period_list) * 1.25)

    def draw_flow(self):
        pass

    def draw_job(self):
        pass

    def draw(self, link_grouped: bool = True):
        fig, ax = plt.subplots(figsize=(16, 16))

        if link_grouped:
            for job in self.job_map.values():
                job.sort()
                for (device_id, start, end, period) in job.device_list:
                    left = [i for i in range(start - period, self.period, period)]
                    y = [f'device: {device_id}'] * len(left)
                    width = [end - start] * len(left)
                    ax.barh(y=y, width=width, left=left,
                            label=f'job {job.id} on device {device_id}')
                for flow in job.flow_list:
                    left = []
                    y = []
                    width = []
                    for (src, dst, start, end, period) in flow.link_list:
                        tmp = [i for i in range(start - period, self.period, period)]
                        left += tmp
                        y += [f'({src}, {dst})'] * len(tmp)
                        width += [end - start] * len(tmp)
                    ax.barh(y=y, width=width, left=left,
                            label=f'flow {flow.id} (src:{flow.link_list[0][2]} dst{flow.link_list[-1][3]})')
        else:
            pos = 1
            label_list = []
            position_map = {}

            # get line id to draw
            for job in self.job_map.values():
                job.sort()
                index_list = [0, ] * len(job.flow_list)
                cp_set = {device_id_ for device_id_, _, _, _ in job.device_list}
                while check(index_list, job.flow_list):
                    cp = None
                    for i in range(len(job.flow_list)):
                        flow = job.flow_list[i]
                        idx = index_list[i]
                        while idx < len(flow.link_list):
                            src, dst, _, _, _ = flow.link_list[idx]
                            # computation point
                            if src in cp_set:
                                if cp is None:
                                    cp = src
                                else:
                                    assert cp == src
                                break
                            label_list += [f'({src}, {dst})']
                            position_map[flow.link_list[idx]] = pos
                            pos += 1
                            idx += 1
                        index_list[i] = idx
                    if cp is not None:
                        start, end, period = job.get_task(device_id=cp)
                        label_list += [f'device {cp}']
                        position_map[(cp, start, end, period)] = pos
                        pos += 1
                        cp_set.remove(cp)
            # drawing
            for job in self.job_map.values():
                for device_id, start, end, period in job.device_list:
                    left = [i for i in range(start - period, self.period, period)]
                    y = [position_map[(device_id, start, end, period)], ] * len(left)
                    width = [end - start] * len(left)
                    ax.barh(y=y, width=width, left=left,
                            label=f'job {job.id} on device {device_id}')
                for flow in job.flow_list:
                    left = []
                    y = []
                    width = []
                    for src, dst, start, end, period in flow.link_list:
                        tmp = [i for i in range(start - period, self.period, period)]
                        left += tmp
                        y += [position_map[(src, dst, start, end, period)], ] * len(tmp)
                        width += [end - start] * len(tmp)
                    ax.barh(y=y, width=width, left=left,
                            label=f'flow {flow.id} (src:{flow.link_list[0][2]} dst{flow.link_list[-1][3]})')

            ax.set_yticks([i for i in range(1, len(label_list)+1)])
            ax.set_yticklabels(tuple(label_list))

        plt.xlim(0, self.period)
        # plt.xlim(-self.period, self.period)
        # plt.xlim(290, 360)

        fig.tight_layout()
        ax.xaxis.grid(True, ls='--')
        ax.yaxis.grid(True, ls='--')
        ax.set_axisbelow(True)
        plt.show()


if __name__ == '__main__':
    print(os.getcwd())

    # plot = PLOTTED('../data/task_network_joint_scheduling/a380_sol_baseline_schedule.json')
    # plot = PLOTTED('../data/task_network_joint_scheduling/random_jobs/fast_exp-a380-groups_02-1_mtu-5_job-0.5_sjobt/a380_sol_15_baseline_schedule.json')
    # plot = PLOTTED('../data/task_network_joint_scheduling/random_jobs/fast_exp-a380-groups_02-1_mtu-10_job-0.5_sjobt-0_seqcons/a380_sol_0_baseline_schedule.json')
    # plot = PLOTTED('../data/cnc_scheduling/network_opt_01_schedule.json')
    plot = PLOTTED('../data/cnc_scheduling/network_1_opt_01_schedule.json')

    plot.draw(link_grouped=True)
