

<div align="center">


# ZIGGO TSNCard:  A comprehensive TSN traffic diagnostic system that can pinpoint the root cause of forwarding misbehavior

</div>

<h3 align="center">
    <a href="http://tns.thss.tsinghua.edu.cn/ziggo/">Project Page</a> |
    <a href="https://mobisense.github.io/ziggo_homepage/data/TSNCard.pdf">Paper</a> |
    <a href="https://mobisense.github.io/ziggo_book/">ZIGGO-BOOK</a> 
</h3>


![](figs/banner.jpg)

## Table of Contents

1. [Introduction](#introduction)
2. [Getting Start](#Getting-start)
3. [ZIGGO Open Platform](#ziggo-open-platform)
4. [Demo](#demo)
5. [Features](#features)
6. [License and Citation](#license-and-citation)
7. [Contributing](#Contributing)

## Introduction

ZIGGO is a `flexible`, `standard-compliant`, and `control-function-virtualized` TSN switch platform ready for **industrial control**, **automotive electronics**, and other **time-sensitive applications**.

This is the document for the ZIGGO TSNCard. (We also offer [ZIGGO-CaaS-Switch](https://github.com/MobiSense/Ziggo-CaaS-Switch), [ZIGGO-Device](https://github.com/MobiSense/Ziggo-Device), [ZIGGO-TSNPerf](https://github.com/MobiSense/Ziggo-TSNPerf) that comply with the IEEE 802.1 TSN standard.) 



## Getting Start

TSNCard paper presents two experimental setups. One relies on a **software-simulated TSN testing environment** using OMNet++, and the other uses a **real-world, physical TSN testbed**. Choose whichever suits your needs best.



Developers who want to use OMNet++ should refer to the `simulation` folder and follow the documentation provided. 

* [Getting start with OMNet++](./Simulation/readme.md)



For those looking to use the testbed, please be patient. The code is in the `testbed` folder.

In a real TSN network, we need at least  TSN switches, end devices, and a server (CNC). Both the switch and TSNPerf (end device) are developed based on ZYNQ, requiring hardware-software coordination. To this end, we provide detailed system design documents and software and hardware operation documents.The server-side software can run on any Linux system. 

* [Getting start with TSNPerf](./Testbed/TSNPerf/docs/readme.md)
* [Getting start with TSN Switch](./Testbed/TSN-Switch/docs/readme.md)
* [Getting start with server/CNC](./Testbed/server-CNC/readme.md)

To help everyone get started, we also provide a tutorial for building a simple TSN network, which we hope will be useful.

* [Demo tutorial](./Testbed/testbed-build/readme.md) 



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
  booktitle={IEEE/ACM IWQoS 2024 - IEEE/ACM International Symposium on Quality of Service}, 
  title={Enabling Network Diagnostics in Time-Sensitive Networking: Protocol, Algorithm, and Hardware}, 
  year={2024}
}
```



## Contributing

Please see the [guide](contributing.md) for information on how to ask for help or contribute to the development of ZIGGO!

> The development team will only answer questions on github issues and reject other forms of questions.

