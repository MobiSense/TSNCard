# Time Sync + Pkt Gen for CaaS Device

This repo contains source code to enable TSN/CaaS Device' time synchronization logic and set up packet generation plan.

## Table of Content

- [1. Build](#1-build)
- [2. Config](#2-config)
- [3. Run](#3-run)
- [4. Analyze](#4-analyze)
  - [4.1 Device directly analyzes latency and jitter](#41-Device-directly-analyzes-latency-and-jitter)
  - [4.2 Offline analysis of latency and jitter](#42-offline-analysis-of-latency-and-jitter)

## 1. Build

```bash
mkdir build
cd build
cmake ..
make
```

After successfully build, there should be two executables: "time_sync" & "pkt_gen"

## 2. Config

The "build" directory contains topology & TSN/CaaS schedule results.

* config.json: topology file, contains node info (type, mac, ptp ports), link between nodes (with ports), and forwarding table.
* schedule.json: schedule file, contains each links' schedule time interval & each CaaS switch's computation time interval.

(Hints: This is similar to a Ziggo Switch)

## 3. Run

* Start time syncronization

```bash
./time_sync
```

* Start device critical packet generation

```bash
./pkt_gen
```

## 4. Analyze

During the operation of the  `time sync` program, after receiving the test data frame, the program will save the delay information of the data frame in the package under the `build/packet_log.csv`   file, save the batch statistics of latency and jitter in the critical directory under the build directory at the same time in the `build/critical_log.csv`.

You can display the content of the header and the last 5 lines using the following command:

```bash
cat critical.log | head -n1
cat critical.log | tail -n5
```

