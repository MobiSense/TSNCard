

<div align="center">


# ZIGGO TSNCard:  A comprehensive TSN traffic diagnostic system that can pinpoint the root cause of forwarding misbehavior

</div>

<h3 align="center">
    <a href="http://tns.thss.tsinghua.edu.cn/ziggo/">Project Page</a> |
    <a href="https://mobisense.github.io/ziggo_homepage/data/TSNCard.pdf">Paper</a> |
    <a href="https://github.com/Mobisense/Ziggo-CaaS-Switch">ZIGGO-CaaS-Switch</a> |
    <a href="https://github.com/Mobisense/Ziggo-Evaluation-Toolkit">ZIGGO-TSNPerf</a> 
</h3>

![](figs/banner.jpg)

## Table of Contents

1. [Introduction](#introduction)
2. [File Structure Overview](#File-Structure-Overview)
3. [ZIGGO Open Platform](#ziggo-open-platform)
4. [Demo](#demo)
5. [Features](#features)
6. [License and Citation](#license-and-citation)
7. [Contributing](#Contributing)

## Introduction

ZIGGO is a `flexible`, `standard-compliant`, and `control-function-virtualized` TSN switch platform ready for **industrial control**, **automotive electronics**, and other **time-sensitive applications**.

This is the document for the ZIGGO TSNCard. (We also offer [ZIGGO-CaaS-Switch](https://github.com/MobiSense/Ziggo-CaaS-Switch), [ZIGGO-Device](https://github.com/MobiSense/Ziggo-Device), [ZIGGO-TSNPerf](https://github.com/MobiSense/Ziggo-TSNPerf) that comply with the IEEE 802.1 TSN standard.) 
## File Structure Overview

The `docs` folder contains the basic documentation.

The `figs` folder contains the images needed for the documentation.

The `Hardware` folder contains the TSN switch in Debug Mode.

The `Simulation` folder contains scripts for simulating errors in the TSN network using OMnet++.

The `Software` folder contains the three algorithms mentioned in the paper.

## ZIGGO Open Platform

![](figs/demo-app.png)

The construction of the ZIGGO Open Platform consists of three levels: network device, management tools, and a Demo App.

## Demo

We provide a demonstration video of the TSN switch. It demonstrates the superior performance of the `ZIGGO-CaaS-Switch` compared to the normal switch.

The left side of the picture is the ZYNQ development board we use, and the right side is the TSN display board we built.

[![Watch the video](figs/testbed.jpg)](https://cloud.tsinghua.edu.cn/f/b307da6840d84e5f9ff1/)

> Click the pic to watch the video! Or just click [here](https://cloud.tsinghua.edu.cn/f/b307da6840d84e5f9ff1/).

## Features

* ZIGGO supports the simultaneous transmission of both `Information Technology (IT)` and `Operation Technology (OT)` data traffic with QoS guarantee.

* ZIGGO complies with IEEE standards `802.1AS`, `Qav`, `Qbv`, and `Qcc`.

* ZIGGO provides `Real-time` and `Deterministic` Ethernet transport

  * ZIGGO achieve **Zero Packet Loss** , **Microsecond-level Latency** with **Nanosecond-level Jitter Gate Ability**.
  * ZIGGO guarantee **Gigabit Throughput**.
  * ZIGGO provide gate accuracy applicable to **All Ethernet Frame Sizes**.

## License and Citation

ZIGGO is released under a [MIT license](LICENSE.txt). 

Please consider citing our papers if the project helps your research with the following BibTex:

```bibtex
@inproceedings{tsncard,
  author={Wang, Zeyu and He, Xiaowu and Zhuge, Xiangwen and Xu, Shen and Dang, Fan and Xu, Jingao and Yang, Zheng},
  booktitle={IEEE/ACM IWQoS 2024 - EEE/ACM International Symposium on Quality of Service}, 
  title={Enabling Network Diagnostics in Time-Sensitive Networking: Protocol, Algorithm, and Hardware}, 
  year={2024}
}
```

## Contributing

Please see the [guide](docs/contributing.md) for information on how to ask for help or contribute to the development of ZIGGO!

> The development team will only answer questions on github issues and reject other forms of questions.

