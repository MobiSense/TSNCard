//-
// Copyright (C) 2010, 2011 The Board of Trustees of The Leland Stanford
//                          Junior University
// Copyright (C) 2010, 2011 Muhammad Shahbaz
// Copyright (C) 2015 Gianni Antichi, Noa Zilberman
// All rights reserved.
//
// This software was developed by
// Stanford University and the University of Cambridge Computer Laboratory
// under National Science Foundation under Grant No. CNS-0855268,
// the University of Cambridge Computer Laboratory under EPSRC INTERNET Project EP/H040536/1 and
// by the University of Cambridge Computer Laboratory under DARPA/AFRL contract FA8750-11-C-0249 ("MRC2"), 
// as part of the DARPA MRC research programme.
//
// @NETFPGA_LICENSE_HEADER_START@
//
// Licensed to NetFPGA C.I.C. (NetFPGA) under one or more contributor
// license agreements.  See the NOTICE file distributed with this work for
// additional information regarding copyright ownership.  NetFPGA licenses this
// file to you under the NetFPGA Hardware-Software License, Version 1.0 (the
// "License"); you may not use this file except in compliance with the
// License.  You may obtain a copy of the License at:
//
//   http://www.netfpga-cic.org
//
// Unless required by applicable law or agreed to in writing, Work distributed
// under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.
//
// @NETFPGA_LICENSE_HEADER_END@
//
/*******************************************************************************
*  File:
*        switch_lite_output_port_lookup.v
*
*  Library:
*        hw/std/cores/switch_lite_output_port_lookup
*
*  Module:
*        switch_lite_output_port_lookup
*
*  Author:
*        Gianni Antichi, Muhammad Shahbaz
*        Modified by Noa Zilberman
* 		
*  Description:
*        Output port lookup for the reference Switch Lite project
*
*/

// `include "output_port_lookup_cpu_regs_defines.v"

module switch_lite_output_port_lookup
#(
   //Master AXI Stream Data Width
   parameter C_M_AXIS_DATA_WIDTH  = 256,
   parameter C_S_AXIS_DATA_WIDTH  = 256,
   parameter C_M_AXIS_TUSER_WIDTH = 128,
   parameter C_S_AXIS_TUSER_WIDTH = 128,
   parameter SRC_PORT_POS         = 16,
   parameter DST_PORT_POS         = 24,
   parameter NUM_OUTPUT_QUEUES    = 8,


// AXI Registers Data Width
   parameter C_S_AXI_DATA_WIDTH    = 32,          
   parameter C_S_AXI_ADDR_WIDTH    = 12,          
   parameter C_USE_WSTRB           = 0,	   
   parameter C_DPHASE_TIMEOUT      = 0,               
   parameter C_NUM_ADDRESS_RANGES = 1,
   parameter  C_TOTAL_NUM_CE       = 1,
   parameter  C_S_AXI_MIN_SIZE    = 32'h0000_FFFF,
   parameter [0:8*C_NUM_ADDRESS_RANGES-1] C_ARD_NUM_CE_ARRAY  = 
                                                {
                                                C_NUM_ADDRESS_RANGES{8'd1}
                                                },
   parameter     C_FAMILY            = "virtex7", 
   parameter C_BASEADDR            = 32'h00000000,
   parameter C_HIGHADDR            = 32'h0000FFFF


)
(
   // Global Ports
   input                                      axis_aclk,
   input                                      axis_resetn,

   // Master Stream Ports (interface to data path)
   output [C_M_AXIS_DATA_WIDTH - 1:0]         m_axis_tdata,
   output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tkeep,
   output reg [C_M_AXIS_TUSER_WIDTH-1:0]      m_axis_tuser,
   output                                     m_axis_tvalid,
   input                                      m_axis_tready,
   output                                     m_axis_tlast,

   // Slave Stream Ports (interface to RX queues)
   input [C_S_AXIS_DATA_WIDTH - 1:0]          s_axis_tdata,
   input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0]  s_axis_tkeep,
   input [C_S_AXIS_TUSER_WIDTH-1:0]           s_axis_tuser,
   input                                      s_axis_tvalid,
   output                                     s_axis_tready,
   input                                      s_axis_tlast
);

   function integer log2;
      input integer number;
      begin
         log2=0;
         while(2**log2<number) begin
            log2=log2+1;
         end
      end
   endfunction // log2

   //--------------------- Internal Parameter-------------------------
   localparam DEFAULT_MISS_OUTPUT_PORTS = 8'h55; // exclude the CPU queues

   localparam NUM_STATES                = 2;
   localparam WAIT_STATE                = 1;
   localparam SEND_STATE                = 2;

   //---------------------- Wires and Regs ----------------------------
   wire [47:0]			           dst_mac;
   wire [47:0]                     src_mac;
   wire [NUM_OUTPUT_QUEUES-1:0]    src_port;
   wire [15:0]                     ether_type;
   wire [11:0]                     vlan_id;
   wire                            eth_done;
   wire [NUM_OUTPUT_QUEUES-1:0]    dst_ports;
   
   wire                            lookup_done;
   reg				   send_packet;
   
   wire [C_S_AXIS_TUSER_WIDTH-1:0] tuser_fifo;

   wire                            in_fifo_rd_en;
   wire                            in_fifo_nearly_full;
   wire                            in_fifo_empty;

   wire [NUM_OUTPUT_QUEUES-1:0]    dst_ports_latched;
   reg                             dst_port_rd;
   wire                            dst_port_fifo_nearly_full;
   wire                            dst_port_fifo_empty;
   
   reg  [NUM_STATES-1:0]           state, state_next;

   wire reset_tables;
   
   //-------------------- Modules and Logic ---------------------------
   
   /* The size of this fifo has to be large enough to fit the previous modules' headers
   * and the ethernet header */
   fallthrough_small_fifo #(.WIDTH(C_M_AXIS_DATA_WIDTH+C_M_AXIS_TUSER_WIDTH+C_M_AXIS_DATA_WIDTH/8+1), .MAX_DEPTH_BITS(4))
      input_fifo
      (.din         ({s_axis_tlast, s_axis_tuser, s_axis_tkeep, s_axis_tdata}),     // Data in
         .wr_en       (s_axis_tvalid & s_axis_tready),                                // Write enable
         .rd_en       (in_fifo_rd_en),                                                // Read the next word
         .dout        ({m_axis_tlast, tuser_fifo, m_axis_tkeep, m_axis_tdata}),
         .full        (),
         .prog_full   (),
         .nearly_full (in_fifo_nearly_full),
         .empty       (in_fifo_empty),
         .reset       (~axis_resetn),
         .clk         (axis_aclk)
         );

   assign s_axis_tready = ~in_fifo_nearly_full;
   
   eth_parser #(
      .C_S_AXIS_DATA_WIDTH (C_S_AXIS_DATA_WIDTH),
      .C_S_AXIS_TUSER_WIDTH (C_S_AXIS_TUSER_WIDTH)
   )
      eth_parser
         (.tdata    (s_axis_tdata),
         .tuser    (s_axis_tuser),
         .valid    (s_axis_tvalid & s_axis_tready),
         .tlast    (s_axis_tlast),
         
      .dst_mac  (dst_mac),
         .src_mac  (src_mac),
         .ether_type (ether_type),
         .vlan_id  (vlan_id),
         .eth_done (eth_done),
         .src_port (src_port),
         .reset    (~axis_resetn),
         .clk      (axis_aclk));

   mac_cam_lut
   #(.NUM_OUTPUT_QUEUES(NUM_OUTPUT_QUEUES),
      .DEFAULT_MISS_OUTPUT_PORTS(DEFAULT_MISS_OUTPUT_PORTS))
   mac_cam_lut
   // --- lookup and learn port
   (.dst_mac      (dst_mac),
      .src_mac      (src_mac),
      .ether_type   (ether_type),
      .vlan_id      (vlan_id),
      .src_port     (src_port),
      .lookup_req   (eth_done),
      .dst_ports    (dst_ports),
      
      .lookup_done  (lookup_done),  // pulses high on lookup done
      .lut_hit      (),
      .lut_miss     (),

      // --- Misc
      .clk          (axis_aclk),
      .reset        (~axis_resetn | reset_tables));

   fallthrough_small_fifo #(.WIDTH(NUM_OUTPUT_QUEUES), .MAX_DEPTH_BITS(2))
      dst_port_fifo
      (.din (dst_ports),     // Data in
         .wr_en (lookup_done),             // Write enable
         .rd_en (dst_port_rd),       // Read the next word
         .dout (dst_ports_latched),
         .full (),
         .prog_full (),
         .nearly_full (dst_port_fifo_nearly_full),
         .empty (dst_port_fifo_empty),
         .reset (~axis_resetn),
         .clk (axis_aclk)
         );

   /*********************************************************************
   * Wait until the ethernet header has been decoded and the output
   * port is found, then write the module header and move the packet
   * to the output
   **********************************************************************/
   always @(*) begin
      m_axis_tuser = tuser_fifo;
      state_next   = state;
      dst_port_rd = 0;
      send_packet  = 1;

      case(state)
      WAIT_STATE: begin
         send_packet = 0;
      
         if(!dst_port_fifo_empty) begin
            state_next = SEND_STATE;
            send_packet = 1;
            dst_port_rd = 1;
            m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_ports_latched;
         end	
      end

      SEND_STATE: begin
         if(m_axis_tlast & m_axis_tvalid & m_axis_tready)
            state_next = WAIT_STATE;
      end
      endcase // case(state)
   end // always @ (*)

   always @(posedge axis_aclk) begin
      if(~axis_resetn) begin
         state <= WAIT_STATE;
      end
      else begin
         state <= state_next;
      end
   end

   // Control signals
   assign m_axis_tvalid = ~in_fifo_empty & send_packet;
   assign in_fifo_rd_en = m_axis_tready & m_axis_tvalid;

endmodule // output_port_lookup

