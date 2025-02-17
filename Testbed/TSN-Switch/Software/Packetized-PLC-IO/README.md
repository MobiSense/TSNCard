# Packetized-PLC-IO

This repo is used to modify original OpenPLC project to support packetized PLC IO with TSN capability in the CaaS switch.

## Pre-requirements

Update certificates and upgrade pip.

```bash
sudo dnf install ca-certificates
sudo update-ca-certificates
python -m ensurepip --upgrade 
python3 -m ensurepip --upgrade
```

## Usage 

1. Download [OpenPLC_v3](https://github.com/thiagoralves/OpenPLC_v3).
    ```bash
    git clone https://github.com/thiagoralves/OpenPLC_v3.git
    cd OpenPLC_v3
    ```

2. Replace `webserver/core` with this part.
    ```bash
    rm -rf webserver/core
    cp -r Packetized-PLC-IO webserver/core
    ```

3. Install OpenPLC
    ```bash
    cd OpenPLC_v3
    pip install -r requirements.txt
    ./install.sh custom
    ```

4. Load libmodbus
    ```bash
    echo "/usr/local/lib" >> /etc/ld.so.conf
    sudo ldconfig
    ldconfig -p | grep libmodbus # success if has outputs
    ```
    
5. Run  
    - If you don't need web UI to operate, you can save your LD program(.st file) into `webserver/core/st_files/test.st`, then compile and run it as follows.

        ```bash
        cd webserver/core
        # compile
        taskset -c 1 ./compile_openplc.sh
        # run 
        taskset -c 1 ./openplc # specify dedicated core to run the program
        ```
    - If you need web UI to operate, you can run the server as follows, and then upload your prgram.
        ```bash
        ./start_openplc.sh
        ```
        or
        ```bash
        nohup ./start_openplc.sh > myout.file 2>&1 & # run in background
        ```

## Configuration

You can config parameters in [blank.cpp](./hardware_layers/blank.cpp).

Example:
```c++
/* ----------------------- CONFIG begin ----------------------------- */

/* output more info */
#define DEBUG_ENABLE 1

/* If just one input stream, this num is set to 1. 
 * if output depends on 2 streams(a+b), this num is set to 2.
 */
#define INPUT_STREAM_NUM 3

/* specific input sequence id, length of this array should be INPUT_STREAM_NUM
 * Examples:
 *  int input_seq_ids[INPUT_STREAM_NUM] = {0};
 *  int input_seq_ids[INPUT_STREAM_NUM] = {1,3,5};
 */
int input_seq_ids[INPUT_STREAM_NUM] = {1,3,4};

/* output streams number */
#define OUTPUT_STREAM_NUM 2

/* output stream's seq_id */
int output_seq_ids[OUTPUT_STREAM_NUM] = {3,5};

/* Destination MAC addresses in output frame*/
char output_dst_addresses[OUTPUT_STREAM_NUM][6] = {
    {0x00, 0x00, 0x00, 0x00, 0x00, 0x02},
    {0x00, 0x00, 0x00, 0x00, 0x00, 0x03}
};

/* Source MAC address in output frame */
char output_src_address[6] = {0x00, 0x00, 0x00, 0x00, 0x01, 0x01};

/* Cycle time of sending packet from device to switch（ns） 2^25 ns
 */
#define CYCLE_TIME (1 << 25)

/* Time offset between computation and packet receiving（ns）
 */
#define COMPUTE_OFFSET (4 * (1 << 14))

/* Task computation time（ns）
 */
#define COMPUTE_TIME (400 * (1 << 14))

/* Packet header structure (42 bytes):
 * destination ethernet address                          - 6 bytes
 * source ethernet address                               - 6 bytes
 * TPID                                                  - 2 bytes
 * vlan header: PCP(3 bits), CFI (1 bits), VID (12 bits) - 2 bytes
 * ether_length                                          - 2 bytes
 * unused                                                - 2 bytes
 * tx_timestamp                                          - 8 bytes
 * rx_timestamp                                          - 8 bytes
 * seq_id                                                - 2 bytes  
 * pkt_id                                                - 4 bytes
 */
#define PACKET_HEADER_SIZE  42 

/* After the critical content, each byte in buf[42:59] has value decrasing from 0x12 to 0x01
*/
#define PACKET_PAYLOAD_SIZE 18 /* 0x12, 0x11,..., 0x01 */

/* ----------------------- CONFIG  end  ----------------------------- */

```

