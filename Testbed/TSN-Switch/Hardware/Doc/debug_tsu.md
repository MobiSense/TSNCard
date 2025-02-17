# Debug TSU Module
## 在Vivado中进行硬件调试的一般步骤
请参考[Xilinx ug936](https://1drv.ms/b/s!AjPYGLMHVktQvFWMJ3omF_PrVtuv?e=2hADbX)中的Lab 1和Lab 5。
## 一个时间戳从获取到送往PS的过程，以及调试中应重点关注的模块和信号
### 模块tsu_axis
文件位置：HDL/hw_timestamp/tsu/tsu_axis.v
MAC IP收发的数据信号同时接入了tsu_axis模块，该模块监测数据信号中传输的是否是时间同步帧，如果是，则记录下当前时间，模块内部有一个队列，时间戳信息存储于此队列中，PS通过rgs.v，读取此队列中的时间戳信息。

需要注意的信号：
* mac_axis_*：是否有数据包的信号。
* ptp_msgid_mask：是否与我们从PS配置的一样。
* rtc_timer_*：时钟信号是否正常。
* q_rd_*：PS抓取时间戳时，此组信号是否有反应。

# Edit Log
2021/09/24 由于家行调试成功，剩下的部分先不写了。