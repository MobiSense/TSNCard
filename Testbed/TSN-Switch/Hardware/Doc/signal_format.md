# 交换机内部的信号含义定义
## TUSER信号
TUSER[31:24]：output_port_lookup模块修改此字段的值，用来告知output_queue模块该数据帧应该发往哪个端口。
* 0000_0001 对应Port 0。
* 0000_0100 对应Port 1。
* 0001_0000 对应Port 2。
* 0100_0000 对应Port 3。
* 0000_0010 对应发往PS的第一路DMA，用来传输时间同步有关的数据帧。
* 0000_1000 对应发往PS的第二路DMA，用来传输PLC控制有关的数据帧。

多个bit可以同时为1，表示同时发往不同队列。