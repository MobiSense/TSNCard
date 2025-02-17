/*******************************************************************************
*
* Copyright (C) 2010, 2011 The Board of Trustees of The Leland Stanford
*                          Junior University
* Copyright (C) 2010, 2011 Muhammad Shahbaz
* Copyright (C) 2015 Noa Zilberman
* All rights reserved.
*
* This software was developed by
* Stanford University and the University of Cambridge Computer Laboratory
* under National Science Foundation under Grant No. CNS-0855268,
* the University of Cambridge Computer Laboratory under EPSRC INTERNET Project EP/H040536/1 and
* by the University of Cambridge Computer Laboratory under DARPA/AFRL contract FA8750-11-C-0249 ("MRC2"), 
* as part of the DARPA MRC research programme.
*
* @NETFPGA_LICENSE_HEADER_START@
*
* Licensed to NetFPGA C.I.C. (NetFPGA) under one or more contributor
* license agreements. See the NOTICE file distributed with this work for
* additional information regarding copyright ownership. NetFPGA licenses this
* file to you under the NetFPGA Hardware-Software License, Version 1.0 (the
* "License"); you may not use this file except in compliance with the
* License. You may obtain a copy of the License at:
*
* http://www.netfpga-cic.org
*
* Unless required by applicable law or agreed to in writing, Work distributed
* under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
* CONDITIONS OF ANY KIND, either express or implied. See the License for the
* specific language governing permissions and limitations under the License.
*
* @NETFPGA_LICENSE_HEADER_END@
*/
/******************************************************************************
*
*  File:
* 	mac_cam_lut.v
*
*  Module:
*        mac_cam_lut
*
*  Author:
*        Muhammad Shahbaz
*        Modified by Noa Zilberman
*
*  Description:
* 	learning CAM switch core functionality
*
*/

`timescale 1ns / 1ps

module mac_cam_lut #(
    parameter NUM_OUTPUT_QUEUES = 8,
    parameter LUT_DEPTH_BITS = 5,
    parameter LUT_DEPTH = 2 ** LUT_DEPTH_BITS,
    parameter DEFAULT_MISS_OUTPUT_PORTS = 8'h55,  // only send to the MAC txfifos not the cpu
    parameter AGE_TIME_BITS = 9,
    parameter EXPIRE_TIME = 9'd300,
    parameter PORT_LEARN_LIMIT = 6'd32,
    parameter VLAN_LEARN_LINIT = 6'd32,
    parameter NUM_VLAN = 8
) (
    // --- core functionality signals
    input      [                 47:0] dst_mac,
    input      [                 47:0] src_mac,
    input      [                 15:0] ether_type,
    input      [                 11:0] vlan_id,
    input      [NUM_OUTPUT_QUEUES-1:0] src_port,
    input                              lookup_req,
    output reg [NUM_OUTPUT_QUEUES-1:0] dst_ports,

    // --- lookup done signal
    output reg lookup_done,  // pulses high on lookup done
    output reg lut_miss,
    output reg lut_hit,

    // --- Misc
    input clk,
    input reset
);

  function integer log2;
    input integer number;
    begin
      log2 = 0;
      while (2 ** log2 < number) begin
        log2 = log2 + 1;
      end
    end
  endfunction  // log2

  //--------------------- Internal Parameter-------------------------

  //---------------------- Wires and regs----------------------------

  genvar i;

  // MAC address lookup table {vlan_id(NUM_VLAN bits), age_time(AGE_TIME_BITS bits), src_port(NUM_OUTPUT_QUEUES bits), mac_address(48 bits)}
  reg [NUM_VLAN+AGE_TIME_BITS+NUM_OUTPUT_QUEUES+48-1:0] lut[0:LUT_DEPTH-1];
  reg [LUT_DEPTH_BITS-1:0] lut_wr_addr;  // record the position of new LUT item next time
  reg [LUT_DEPTH-1:0] lut_state;  // lut_state[i]=1 means ith row has valid item in LUT
  reg [26:0] counter;  // MAC address age time counter
//   reg [5:0] port_mac_counter[0:NUM_OUTPUT_QUEUES-1]; // record mac num of each port, limit 32 in each port 
//   reg [5:0] vlan_mac_counter[0:NUM_VLAN-1]; // record mac num of each vlan, limit 32 in each vlan 


  //------------------------- Logic --------------------------------

  wire [NUM_OUTPUT_QUEUES-1:0] rd_oq[0:LUT_DEPTH-1];
  wire [0:LUT_DEPTH-1] lut_lookup_hit;
  reg [2:0] pre_port[0:LUT_DEPTH-1];
  reg [2:0] cur_port;

  reg [11:0] pre_vlan_id[0:LUT_DEPTH-1];
  reg [11:0] cur_vlan_id;
  wire [12:0] vlan_tag;


  always @(*) begin
    case (src_port)
      0'b00000001: cur_port = 3'd0;
      0'b00000010: cur_port = 3'd1;
      0'b00000100: cur_port = 3'd2;
      0'b00001000: cur_port = 3'd3;
      0'b00010000: cur_port = 3'd4;
      0'b00100000: cur_port = 3'd5;
      0'b01000000: cur_port = 3'd6;
      0'b10000000: cur_port = 3'd7;
      default: cur_port = 3'd0;
    endcase
  end

  // TODO: get VLAN id of normal ether frame without VLAN header, to be merged 
  // @Zeyu: vlan_tag of {1'b1, 11'b0} means no vlan

  //   get_vlan_tag get_vlan_tag_inst (
  //       // input
  //       .VLAN_MODE(VLAN_MODE),
  //       .dst_mac_w(dst_mac),
  //       .src_mac_w(src_mac),
  //       .ether_type_w(ether_type),
  //       .src_port_w(src_port),
  //       // output
  //       .VLAN_TAG(vlan_tag)
  //   );


  always @(*) begin
    if (ether_type == 16'h0081) begin
      cur_vlan_id = vlan_id;
    end else begin
      cur_vlan_id = 0;
      //   cur_vlan_id = vlan_tag[11:0]; // ether frame without VLAN header
    end
  end

  generate
    for (i = 0; i < LUT_DEPTH; i = i + 1) begin : PRE_PORT_RECORD
      always @(*) begin
        case (lut[i][NUM_OUTPUT_QUEUES+48-1:48])
          0'b00000001: pre_port[i] = 3'd0;
          0'b00000010: pre_port[i] = 3'd1;
          0'b00000100: pre_port[i] = 3'd2;
          0'b00001000: pre_port[i] = 3'd3;
          0'b00010000: pre_port[i] = 3'd4;
          0'b00100000: pre_port[i] = 3'd5;
          0'b01000000: pre_port[i] = 3'd6;
          0'b10000000: pre_port[i] = 3'd7;
          default: pre_port[i] = 3'd0;
        endcase
      end
    end

    for (i = 0; i < LUT_DEPTH; i = i + 1) begin : PRE_VLAN_RECORD
      always @(*) begin
        pre_vlan_id[i] = lut[i][NUM_VLAN+AGE_TIME_BITS+NUM_OUTPUT_QUEUES+48-1:AGE_TIME_BITS+NUM_OUTPUT_QUEUES+48];
      end
    end

    // for (i = 0; i < NUM_OUTPUT_QUEUES; i = i + 1) begin : PORT_COUNTER_INIT
    //   always @(posedge clk) begin
    //     if (reset) begin
    //       port_mac_counter[i] <= {6'b0};
    //     end
    //   end
    // end

    // for (i = 0; i < NUM_VLAN; i = i + 1) begin : VLAN_COUNTER_INIT
    //   always @(posedge clk) begin
    //     if (reset) begin
    //       vlan_mac_counter[i] <= {6'b0};
    //     end
    //   end
    // end


    // LUT Lookup
    for (i = 0; i < LUT_DEPTH; i = i + 1) begin : LUT_LOOKUP
      if (i == 0) begin : _0
        assign rd_oq[i][NUM_OUTPUT_QUEUES-1:0] = (lut[i][47:0] == dst_mac) ? lut[i][NUM_OUTPUT_QUEUES+48-1:48] 
		                                                       : {(NUM_OUTPUT_QUEUES){1'b0}};
        assign lut_lookup_hit[i] = (lut[i][47:0] == dst_mac) ? 1 : 0;
      end else begin : _N
        assign rd_oq[i][NUM_OUTPUT_QUEUES-1:0] = (lut[i][47:0] == dst_mac) ? lut[i][NUM_OUTPUT_QUEUES+48-1:48] 
		                                                       : rd_oq[i-1][NUM_OUTPUT_QUEUES-1:0];
        assign lut_lookup_hit[i] = (lut[i][47:0] == dst_mac) ? 1 : lut_lookup_hit[i-1];
      end
    end

    // LUT Learn
    wire [0:LUT_DEPTH-1] lut_learn_hit;
    for (i = 0; i < LUT_DEPTH; i = i + 1) begin : LUT_LEARN


      if (i == 0) begin : _0
        assign lut_learn_hit[i] = (lut[i][47:0] == src_mac) ? 1 : 0;
      end else begin : _N
        assign lut_learn_hit[i] = (lut[i][47:0] == src_mac) ? 1 : lut_learn_hit[i-1];
      end

      always @(posedge clk) begin : _A
        if (reset) begin
          lut[i] <= {(NUM_VLAN + AGE_TIME_BITS + NUM_OUTPUT_QUEUES + 48) {1'b0}};
        end else begin
          // no need to learn ptp port
          if (lookup_req && ~recv_ptp_message && ~send_ptp_message) begin
            if (lut[i][47:0] == src_mac) begin  // if src_mac matches in the LUT
            //   if (pre_port[i] != cur_port) begin
            //     port_mac_counter[pre_port[i]] <= port_mac_counter[pre_port[i]] - 1;
            //     port_mac_counter[cur_port] <= port_mac_counter[cur_port] + 1;
            //     vlan_mac_counter[pre_vlan_id[i]] <= vlan_mac_counter[pre_vlan_id[i]] - 1;
            //     vlan_mac_counter[cur_vlan_id] <= vlan_mac_counter[cur_vlan_id] + 1;
            //   end
              lut[i][NUM_OUTPUT_QUEUES+48-1:48] <= src_port;
              lut_state[i] <= 1;
            end else if (~lut_learn_hit[LUT_DEPTH-1] && (lut_wr_addr == i)) begin // if src_mac doesn't matches in the LUT 
            //   port_mac_counter[cur_port] <= port_mac_counter[cur_port] + 1;
            //   vlan_mac_counter[cur_vlan_id] <= vlan_mac_counter[cur_vlan_id] + 1;
              lut[i] <= {EXPIRE_TIME, src_port, src_mac};
              lut_state[i] <= 1;
            end
          end
          // age time counter update            
          if (counter == 27'd125000000) begin  // every second, clk=125Mhz
            if (lut[i][AGE_TIME_BITS+NUM_OUTPUT_QUEUES+48-1:NUM_OUTPUT_QUEUES+48] == 9'b0) begin
            //   port_mac_counter[pre_port[i]] <= port_mac_counter[pre_port[i]] - 1;
            //   vlan_mac_counter[pre_vlan_id[i]] <= vlan_mac_counter[pre_vlan_id[i]] - 1;
              lut[i][NUM_OUTPUT_QUEUES+48-1:0] <= {(NUM_OUTPUT_QUEUES + 48) {1'b0}};
              lut_state[i] <= 0;
            end else begin
              lut[i][AGE_TIME_BITS+NUM_OUTPUT_QUEUES+48-1:NUM_OUTPUT_QUEUES+48] <= lut[i][AGE_TIME_BITS+NUM_OUTPUT_QUEUES+48-1:NUM_OUTPUT_QUEUES+48] - 1;
            end
          end
        end
      end
    end
  endgenerate

  wire recv_ptp_message;
  wire send_ptp_message;
  assign recv_ptp_message = (dst_mac == 48'h0E_00_00_C2_80_01) && (ether_type == 16'hF7_88) && ((src_port & 8'haa) == 8'h00); // ptp messages from ports.
  assign send_ptp_message = (dst_mac == 48'h0E_00_00_C2_80_01) && (ether_type == 16'hF7_88) && ((src_port & 8'haa) != 8'h00); // ptp messages from cpu.

  always @(posedge clk) begin
    if (reset) begin
      counter <= 27'b0;
    end else begin
      if (counter == 27'd125000000) begin  // every second, clk=125Mhz
        counter <= 27'b0;
      end else begin
        counter <= counter + 1;
      end
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      lut_hit <= 0;
      lut_miss <= 0;

      lookup_done <= 0;
      dst_ports <= {NUM_OUTPUT_QUEUES{1'b0}};

      lut_wr_addr <= {LUT_DEPTH_BITS{1'b0}};
      lut_state <= {LUT_DEPTH{1'b0}};
    end else begin
      lut_hit     <= 0;
      lut_miss    <= 0;
      lookup_done <= 0;

      if (lookup_req) begin
        lut_hit  <= lut_lookup_hit[LUT_DEPTH-1];
        lut_miss <= ~lut_lookup_hit[LUT_DEPTH-1];

        /* if we get a miss then set the dst port to the default ports
         * without the source */
        dst_ports <= (lut_lookup_hit[LUT_DEPTH-1]) ? (rd_oq[LUT_DEPTH-1][NUM_OUTPUT_QUEUES-1:0] & ~src_port) : (DEFAULT_MISS_OUTPUT_PORTS     & ~src_port);
        lookup_done <= 1;
        // no need to learn ptp port
        if (~lut_learn_hit[LUT_DEPTH-1] && ~recv_ptp_message && ~send_ptp_message) lut_wr_addr <= lut_wr_addr + 1; 
      end
    end
  end

endmodule
