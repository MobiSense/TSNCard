// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Tue Mar 28 14:56:09 2023
// Host        : Horace-TNS-win10 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Data/TSN_development/tns-tsn-switch/IP/input_arbiter_fifo/input_arbiter_fifo_sim_netlist.v
// Design      : input_arbiter_fifo
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "input_arbiter_fifo,axis_data_fifo_v2_0_3_top,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* X_CORE_INFO = "axis_data_fifo_v2_0_3_top,Vivado 2020.1" *) 
(* NotValidForBitStream *)
module input_arbiter_fifo
   (s_axis_aresetn,
    s_axis_aclk,
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tdata,
    s_axis_tkeep,
    s_axis_tlast,
    s_axis_tuser,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tdata,
    m_axis_tkeep,
    m_axis_tlast,
    m_axis_tuser);
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S_RSTIF RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_RSTIF, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input s_axis_aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S_CLKIF CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_CLKIF, ASSOCIATED_BUSIF S_AXIS, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *) input s_axis_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TVALID" *) input s_axis_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TREADY" *) output s_axis_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TDATA" *) input [255:0]s_axis_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TKEEP" *) input [31:0]s_axis_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TLAST" *) input s_axis_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TUSER" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS, TDATA_NUM_BYTES 32, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 128, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0" *) input [127:0]s_axis_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TVALID" *) output m_axis_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TREADY" *) input m_axis_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TDATA" *) output [255:0]m_axis_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TKEEP" *) output [31:0]m_axis_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TLAST" *) output m_axis_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TUSER" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS, TDATA_NUM_BYTES 32, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 128, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0" *) output [127:0]m_axis_tuser;

  wire [255:0]m_axis_tdata;
  wire [31:0]m_axis_tkeep;
  wire m_axis_tlast;
  wire m_axis_tready;
  wire [127:0]m_axis_tuser;
  wire m_axis_tvalid;
  wire s_axis_aclk;
  wire s_axis_aresetn;
  wire [255:0]s_axis_tdata;
  wire [31:0]s_axis_tkeep;
  wire s_axis_tlast;
  wire s_axis_tready;
  wire [127:0]s_axis_tuser;
  wire s_axis_tvalid;
  wire NLW_inst_almost_empty_UNCONNECTED;
  wire NLW_inst_almost_full_UNCONNECTED;
  wire NLW_inst_dbiterr_UNCONNECTED;
  wire NLW_inst_prog_empty_UNCONNECTED;
  wire NLW_inst_prog_full_UNCONNECTED;
  wire NLW_inst_sbiterr_UNCONNECTED;
  wire [31:0]NLW_inst_axis_rd_data_count_UNCONNECTED;
  wire [31:0]NLW_inst_axis_wr_data_count_UNCONNECTED;
  wire [0:0]NLW_inst_m_axis_tdest_UNCONNECTED;
  wire [0:0]NLW_inst_m_axis_tid_UNCONNECTED;
  wire [31:0]NLW_inst_m_axis_tstrb_UNCONNECTED;

  (* C_ACLKEN_CONV_MODE = "0" *) 
  (* C_AXIS_SIGNAL_SET = "32'b00000000000000000000000010011011" *) 
  (* C_AXIS_TDATA_WIDTH = "256" *) 
  (* C_AXIS_TDEST_WIDTH = "1" *) 
  (* C_AXIS_TID_WIDTH = "1" *) 
  (* C_AXIS_TUSER_WIDTH = "128" *) 
  (* C_ECC_MODE = "0" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_FIFO_DEPTH = "64" *) 
  (* C_FIFO_MEMORY_TYPE = "auto" *) 
  (* C_FIFO_MODE = "2" *) 
  (* C_IS_ACLK_ASYNC = "0" *) 
  (* C_PROG_EMPTY_THRESH = "5" *) 
  (* C_PROG_FULL_THRESH = "11" *) 
  (* C_SYNCHRONIZER_STAGE = "3" *) 
  (* C_USE_ADV_FEATURES = "825765944" *) 
  (* G_INDX_SS_TDATA = "1" *) 
  (* G_INDX_SS_TDEST = "6" *) 
  (* G_INDX_SS_TID = "5" *) 
  (* G_INDX_SS_TKEEP = "3" *) 
  (* G_INDX_SS_TLAST = "4" *) 
  (* G_INDX_SS_TREADY = "0" *) 
  (* G_INDX_SS_TSTRB = "2" *) 
  (* G_INDX_SS_TUSER = "7" *) 
  (* G_MASK_SS_TDATA = "2" *) 
  (* G_MASK_SS_TDEST = "64" *) 
  (* G_MASK_SS_TID = "32" *) 
  (* G_MASK_SS_TKEEP = "8" *) 
  (* G_MASK_SS_TLAST = "16" *) 
  (* G_MASK_SS_TREADY = "1" *) 
  (* G_MASK_SS_TSTRB = "4" *) 
  (* G_MASK_SS_TUSER = "128" *) 
  (* G_TASK_SEVERITY_ERR = "2" *) 
  (* G_TASK_SEVERITY_INFO = "0" *) 
  (* G_TASK_SEVERITY_WARNING = "1" *) 
  (* LP_CDC_SYNC_STAGES = "3" *) 
  (* LP_CLOCKING_MODE = "common_clock" *) 
  (* LP_ECC_MODE = "no_ecc" *) 
  (* LP_FIFO_DEPTH = "64" *) 
  (* LP_FIFO_MEMORY_TYPE = "auto" *) 
  (* LP_M_ACLKEN_CAN_TOGGLE = "0" *) 
  (* LP_PACKET_FIFO = "true" *) 
  (* LP_PROG_EMPTY_THRESH = "5" *) 
  (* LP_PROG_FULL_THRESH = "11" *) 
  (* LP_RD_DATA_COUNT_WIDTH = "7" *) 
  (* LP_RELATED_CLOCKS = "0" *) 
  (* LP_S_ACLKEN_CAN_TOGGLE = "0" *) 
  (* LP_TDATA_WIDTH = "256" *) 
  (* LP_TDEST_WIDTH = "1" *) 
  (* LP_TID_WIDTH = "1" *) 
  (* LP_TUSER_WIDTH = "128" *) 
  (* LP_USE_ADV_FEATURES = "825765944" *) 
  (* LP_WR_DATA_COUNT_WIDTH = "7" *) 
  input_arbiter_fifo_axis_data_fifo_v2_0_3_top inst
       (.almost_empty(NLW_inst_almost_empty_UNCONNECTED),
        .almost_full(NLW_inst_almost_full_UNCONNECTED),
        .axis_rd_data_count(NLW_inst_axis_rd_data_count_UNCONNECTED[31:0]),
        .axis_wr_data_count(NLW_inst_axis_wr_data_count_UNCONNECTED[31:0]),
        .dbiterr(NLW_inst_dbiterr_UNCONNECTED),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .m_axis_aclk(1'b0),
        .m_axis_aclken(1'b1),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tdest(NLW_inst_m_axis_tdest_UNCONNECTED[0]),
        .m_axis_tid(NLW_inst_m_axis_tid_UNCONNECTED[0]),
        .m_axis_tkeep(m_axis_tkeep),
        .m_axis_tlast(m_axis_tlast),
        .m_axis_tready(m_axis_tready),
        .m_axis_tstrb(NLW_inst_m_axis_tstrb_UNCONNECTED[31:0]),
        .m_axis_tuser(m_axis_tuser),
        .m_axis_tvalid(m_axis_tvalid),
        .prog_empty(NLW_inst_prog_empty_UNCONNECTED),
        .prog_full(NLW_inst_prog_full_UNCONNECTED),
        .s_axis_aclk(s_axis_aclk),
        .s_axis_aclken(1'b1),
        .s_axis_aresetn(s_axis_aresetn),
        .s_axis_tdata(s_axis_tdata),
        .s_axis_tdest(1'b0),
        .s_axis_tid(1'b0),
        .s_axis_tkeep(s_axis_tkeep),
        .s_axis_tlast(s_axis_tlast),
        .s_axis_tready(s_axis_tready),
        .s_axis_tstrb({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .s_axis_tuser(s_axis_tuser),
        .s_axis_tvalid(s_axis_tvalid),
        .sbiterr(NLW_inst_sbiterr_UNCONNECTED));
endmodule

(* C_ACLKEN_CONV_MODE = "0" *) (* C_AXIS_SIGNAL_SET = "32'b00000000000000000000000010011011" *) (* C_AXIS_TDATA_WIDTH = "256" *) 
(* C_AXIS_TDEST_WIDTH = "1" *) (* C_AXIS_TID_WIDTH = "1" *) (* C_AXIS_TUSER_WIDTH = "128" *) 
(* C_ECC_MODE = "0" *) (* C_FAMILY = "zynq" *) (* C_FIFO_DEPTH = "64" *) 
(* C_FIFO_MEMORY_TYPE = "auto" *) (* C_FIFO_MODE = "2" *) (* C_IS_ACLK_ASYNC = "0" *) 
(* C_PROG_EMPTY_THRESH = "5" *) (* C_PROG_FULL_THRESH = "11" *) (* C_SYNCHRONIZER_STAGE = "3" *) 
(* C_USE_ADV_FEATURES = "825765944" *) (* G_INDX_SS_TDATA = "1" *) (* G_INDX_SS_TDEST = "6" *) 
(* G_INDX_SS_TID = "5" *) (* G_INDX_SS_TKEEP = "3" *) (* G_INDX_SS_TLAST = "4" *) 
(* G_INDX_SS_TREADY = "0" *) (* G_INDX_SS_TSTRB = "2" *) (* G_INDX_SS_TUSER = "7" *) 
(* G_MASK_SS_TDATA = "2" *) (* G_MASK_SS_TDEST = "64" *) (* G_MASK_SS_TID = "32" *) 
(* G_MASK_SS_TKEEP = "8" *) (* G_MASK_SS_TLAST = "16" *) (* G_MASK_SS_TREADY = "1" *) 
(* G_MASK_SS_TSTRB = "4" *) (* G_MASK_SS_TUSER = "128" *) (* G_TASK_SEVERITY_ERR = "2" *) 
(* G_TASK_SEVERITY_INFO = "0" *) (* G_TASK_SEVERITY_WARNING = "1" *) (* LP_CDC_SYNC_STAGES = "3" *) 
(* LP_CLOCKING_MODE = "common_clock" *) (* LP_ECC_MODE = "no_ecc" *) (* LP_FIFO_DEPTH = "64" *) 
(* LP_FIFO_MEMORY_TYPE = "auto" *) (* LP_M_ACLKEN_CAN_TOGGLE = "0" *) (* LP_PACKET_FIFO = "true" *) 
(* LP_PROG_EMPTY_THRESH = "5" *) (* LP_PROG_FULL_THRESH = "11" *) (* LP_RD_DATA_COUNT_WIDTH = "7" *) 
(* LP_RELATED_CLOCKS = "0" *) (* LP_S_ACLKEN_CAN_TOGGLE = "0" *) (* LP_TDATA_WIDTH = "256" *) 
(* LP_TDEST_WIDTH = "1" *) (* LP_TID_WIDTH = "1" *) (* LP_TUSER_WIDTH = "128" *) 
(* LP_USE_ADV_FEATURES = "825765944" *) (* LP_WR_DATA_COUNT_WIDTH = "7" *) (* ORIG_REF_NAME = "axis_data_fifo_v2_0_3_top" *) 
module input_arbiter_fifo_axis_data_fifo_v2_0_3_top
   (s_axis_aclk,
    s_axis_aresetn,
    s_axis_aclken,
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tdata,
    s_axis_tstrb,
    s_axis_tkeep,
    s_axis_tlast,
    s_axis_tid,
    s_axis_tdest,
    s_axis_tuser,
    almost_full,
    prog_full,
    axis_wr_data_count,
    injectsbiterr,
    injectdbiterr,
    m_axis_aclk,
    m_axis_aclken,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tdata,
    m_axis_tstrb,
    m_axis_tkeep,
    m_axis_tlast,
    m_axis_tid,
    m_axis_tdest,
    m_axis_tuser,
    almost_empty,
    prog_empty,
    axis_rd_data_count,
    sbiterr,
    dbiterr);
  input s_axis_aclk;
  input s_axis_aresetn;
  input s_axis_aclken;
  input s_axis_tvalid;
  output s_axis_tready;
  input [255:0]s_axis_tdata;
  input [31:0]s_axis_tstrb;
  input [31:0]s_axis_tkeep;
  input s_axis_tlast;
  input [0:0]s_axis_tid;
  input [0:0]s_axis_tdest;
  input [127:0]s_axis_tuser;
  output almost_full;
  output prog_full;
  output [31:0]axis_wr_data_count;
  input injectsbiterr;
  input injectdbiterr;
  input m_axis_aclk;
  input m_axis_aclken;
  output m_axis_tvalid;
  input m_axis_tready;
  output [255:0]m_axis_tdata;
  output [31:0]m_axis_tstrb;
  output [31:0]m_axis_tkeep;
  output m_axis_tlast;
  output [0:0]m_axis_tid;
  output [0:0]m_axis_tdest;
  output [127:0]m_axis_tuser;
  output almost_empty;
  output prog_empty;
  output [31:0]axis_rd_data_count;
  output sbiterr;
  output dbiterr;

  wire \<const0> ;
  wire \<const1> ;
  wire almost_empty;
  wire almost_full;
  wire [6:0]\^axis_rd_data_count ;
  wire [6:0]\^axis_wr_data_count ;
  wire dbiterr;
  wire injectdbiterr;
  wire injectsbiterr;
  wire [255:0]m_axis_tdata;
  wire [31:0]m_axis_tkeep;
  wire m_axis_tlast;
  wire m_axis_tready;
  wire [127:0]m_axis_tuser;
  wire m_axis_tvalid;
  wire prog_empty;
  wire prog_full;
  wire s_axis_aclk;
  wire s_axis_aresetn;
  wire [255:0]s_axis_tdata;
  wire [31:0]s_axis_tkeep;
  wire s_axis_tlast;
  wire s_axis_tready;
  wire [127:0]s_axis_tuser;
  wire s_axis_tvalid;
  wire sbiterr;
  wire [0:0]\NLW_gen_fifo.xpm_fifo_axis_inst_m_axis_tdest_UNCONNECTED ;
  wire [0:0]\NLW_gen_fifo.xpm_fifo_axis_inst_m_axis_tid_UNCONNECTED ;
  wire [31:0]\NLW_gen_fifo.xpm_fifo_axis_inst_m_axis_tstrb_UNCONNECTED ;

  assign axis_rd_data_count[31] = \<const0> ;
  assign axis_rd_data_count[30] = \<const0> ;
  assign axis_rd_data_count[29] = \<const0> ;
  assign axis_rd_data_count[28] = \<const0> ;
  assign axis_rd_data_count[27] = \<const0> ;
  assign axis_rd_data_count[26] = \<const0> ;
  assign axis_rd_data_count[25] = \<const0> ;
  assign axis_rd_data_count[24] = \<const0> ;
  assign axis_rd_data_count[23] = \<const0> ;
  assign axis_rd_data_count[22] = \<const0> ;
  assign axis_rd_data_count[21] = \<const0> ;
  assign axis_rd_data_count[20] = \<const0> ;
  assign axis_rd_data_count[19] = \<const0> ;
  assign axis_rd_data_count[18] = \<const0> ;
  assign axis_rd_data_count[17] = \<const0> ;
  assign axis_rd_data_count[16] = \<const0> ;
  assign axis_rd_data_count[15] = \<const0> ;
  assign axis_rd_data_count[14] = \<const0> ;
  assign axis_rd_data_count[13] = \<const0> ;
  assign axis_rd_data_count[12] = \<const0> ;
  assign axis_rd_data_count[11] = \<const0> ;
  assign axis_rd_data_count[10] = \<const0> ;
  assign axis_rd_data_count[9] = \<const0> ;
  assign axis_rd_data_count[8] = \<const0> ;
  assign axis_rd_data_count[7] = \<const0> ;
  assign axis_rd_data_count[6:0] = \^axis_rd_data_count [6:0];
  assign axis_wr_data_count[31] = \<const0> ;
  assign axis_wr_data_count[30] = \<const0> ;
  assign axis_wr_data_count[29] = \<const0> ;
  assign axis_wr_data_count[28] = \<const0> ;
  assign axis_wr_data_count[27] = \<const0> ;
  assign axis_wr_data_count[26] = \<const0> ;
  assign axis_wr_data_count[25] = \<const0> ;
  assign axis_wr_data_count[24] = \<const0> ;
  assign axis_wr_data_count[23] = \<const0> ;
  assign axis_wr_data_count[22] = \<const0> ;
  assign axis_wr_data_count[21] = \<const0> ;
  assign axis_wr_data_count[20] = \<const0> ;
  assign axis_wr_data_count[19] = \<const0> ;
  assign axis_wr_data_count[18] = \<const0> ;
  assign axis_wr_data_count[17] = \<const0> ;
  assign axis_wr_data_count[16] = \<const0> ;
  assign axis_wr_data_count[15] = \<const0> ;
  assign axis_wr_data_count[14] = \<const0> ;
  assign axis_wr_data_count[13] = \<const0> ;
  assign axis_wr_data_count[12] = \<const0> ;
  assign axis_wr_data_count[11] = \<const0> ;
  assign axis_wr_data_count[10] = \<const0> ;
  assign axis_wr_data_count[9] = \<const0> ;
  assign axis_wr_data_count[8] = \<const0> ;
  assign axis_wr_data_count[7] = \<const0> ;
  assign axis_wr_data_count[6:0] = \^axis_wr_data_count [6:0];
  assign m_axis_tdest[0] = \<const0> ;
  assign m_axis_tid[0] = \<const0> ;
  assign m_axis_tstrb[31] = \<const1> ;
  assign m_axis_tstrb[30] = \<const1> ;
  assign m_axis_tstrb[29] = \<const1> ;
  assign m_axis_tstrb[28] = \<const1> ;
  assign m_axis_tstrb[27] = \<const1> ;
  assign m_axis_tstrb[26] = \<const1> ;
  assign m_axis_tstrb[25] = \<const1> ;
  assign m_axis_tstrb[24] = \<const1> ;
  assign m_axis_tstrb[23] = \<const1> ;
  assign m_axis_tstrb[22] = \<const1> ;
  assign m_axis_tstrb[21] = \<const1> ;
  assign m_axis_tstrb[20] = \<const1> ;
  assign m_axis_tstrb[19] = \<const1> ;
  assign m_axis_tstrb[18] = \<const1> ;
  assign m_axis_tstrb[17] = \<const1> ;
  assign m_axis_tstrb[16] = \<const1> ;
  assign m_axis_tstrb[15] = \<const1> ;
  assign m_axis_tstrb[14] = \<const1> ;
  assign m_axis_tstrb[13] = \<const1> ;
  assign m_axis_tstrb[12] = \<const1> ;
  assign m_axis_tstrb[11] = \<const1> ;
  assign m_axis_tstrb[10] = \<const1> ;
  assign m_axis_tstrb[9] = \<const1> ;
  assign m_axis_tstrb[8] = \<const1> ;
  assign m_axis_tstrb[7] = \<const1> ;
  assign m_axis_tstrb[6] = \<const1> ;
  assign m_axis_tstrb[5] = \<const1> ;
  assign m_axis_tstrb[4] = \<const1> ;
  assign m_axis_tstrb[3] = \<const1> ;
  assign m_axis_tstrb[2] = \<const1> ;
  assign m_axis_tstrb[1] = \<const1> ;
  assign m_axis_tstrb[0] = \<const1> ;
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  (* AXIS_DATA_WIDTH = "451" *) 
  (* AXIS_FINAL_DATA_WIDTH = "451" *) 
  (* CASCADE_HEIGHT = "0" *) 
  (* CDC_SYNC_STAGES = "3" *) 
  (* CLOCKING_MODE = "common_clock" *) 
  (* ECC_MODE = "no_ecc" *) 
  (* EN_ADV_FEATURE_AXIS = "16'b0001100000001000" *) 
  (* EN_ADV_FEATURE_AXIS_INT = "16'b0001100000001000" *) 
  (* EN_ALMOST_EMPTY_INT = "1'b1" *) 
  (* EN_ALMOST_FULL_INT = "1'b1" *) 
  (* EN_DATA_VALID_INT = "1'b1" *) 
  (* FIFO_DEPTH = "64" *) 
  (* FIFO_MEMORY_TYPE = "auto" *) 
  (* LOG_DEPTH_AXIS = "6" *) 
  (* PACKET_FIFO = "true" *) 
  (* PKT_SIZE_LT8 = "1'b0" *) 
  (* PROG_EMPTY_THRESH = "5" *) 
  (* PROG_FULL_THRESH = "11" *) 
  (* P_COMMON_CLOCK = "1" *) 
  (* P_ECC_MODE = "0" *) 
  (* P_FIFO_MEMORY_TYPE = "0" *) 
  (* P_PKT_MODE = "1" *) 
  (* RD_DATA_COUNT_WIDTH = "7" *) 
  (* RELATED_CLOCKS = "0" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* TDATA_OFFSET = "256" *) 
  (* TDATA_WIDTH = "256" *) 
  (* TDEST_OFFSET = "322" *) 
  (* TDEST_WIDTH = "1" *) 
  (* TID_OFFSET = "321" *) 
  (* TID_WIDTH = "1" *) 
  (* TKEEP_OFFSET = "320" *) 
  (* TSTRB_OFFSET = "288" *) 
  (* TUSER_MAX_WIDTH = "3773" *) 
  (* TUSER_OFFSET = "450" *) 
  (* TUSER_WIDTH = "128" *) 
  (* USE_ADV_FEATURES = "825765944" *) 
  (* USE_ADV_FEATURES_INT = "825765944" *) 
  (* WR_DATA_COUNT_WIDTH = "7" *) 
  (* XPM_MODULE = "TRUE" *) 
  input_arbiter_fifo_xpm_fifo_axis \gen_fifo.xpm_fifo_axis_inst 
       (.almost_empty_axis(almost_empty),
        .almost_full_axis(almost_full),
        .dbiterr_axis(dbiterr),
        .injectdbiterr_axis(injectdbiterr),
        .injectsbiterr_axis(injectsbiterr),
        .m_aclk(s_axis_aclk),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tdest(\NLW_gen_fifo.xpm_fifo_axis_inst_m_axis_tdest_UNCONNECTED [0]),
        .m_axis_tid(\NLW_gen_fifo.xpm_fifo_axis_inst_m_axis_tid_UNCONNECTED [0]),
        .m_axis_tkeep(m_axis_tkeep),
        .m_axis_tlast(m_axis_tlast),
        .m_axis_tready(m_axis_tready),
        .m_axis_tstrb(\NLW_gen_fifo.xpm_fifo_axis_inst_m_axis_tstrb_UNCONNECTED [31:0]),
        .m_axis_tuser(m_axis_tuser),
        .m_axis_tvalid(m_axis_tvalid),
        .prog_empty_axis(prog_empty),
        .prog_full_axis(prog_full),
        .rd_data_count_axis(\^axis_rd_data_count ),
        .s_aclk(s_axis_aclk),
        .s_aresetn(s_axis_aresetn),
        .s_axis_tdata(s_axis_tdata),
        .s_axis_tdest(1'b0),
        .s_axis_tid(1'b0),
        .s_axis_tkeep(s_axis_tkeep),
        .s_axis_tlast(s_axis_tlast),
        .s_axis_tready(s_axis_tready),
        .s_axis_tstrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_tuser(s_axis_tuser),
        .s_axis_tvalid(s_axis_tvalid),
        .sbiterr_axis(sbiterr),
        .wr_data_count_axis(\^axis_wr_data_count ));
endmodule

(* DEF_VAL = "1'b0" *) (* DEST_SYNC_FF = "4" *) (* INIT = "0" *) 
(* INIT_SYNC_FF = "1" *) (* ORIG_REF_NAME = "xpm_cdc_sync_rst" *) (* SIM_ASSERT_CHK = "0" *) 
(* VERSION = "0" *) (* XPM_MODULE = "TRUE" *) (* keep_hierarchy = "true" *) 
(* xpm_cdc = "SYNC_RST" *) 
module input_arbiter_fifo_xpm_cdc_sync_rst
   (src_rst,
    dest_clk,
    dest_rst);
  input src_rst;
  input dest_clk;
  output dest_rst;

  wire dest_clk;
  wire src_rst;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "SYNC_RST" *) wire [3:0]syncstages_ff;

  assign dest_rst = syncstages_ff[3];
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b0)) 
    \syncstages_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(src_rst),
        .Q(syncstages_ff[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b0)) 
    \syncstages_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[0]),
        .Q(syncstages_ff[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b0)) 
    \syncstages_ff_reg[2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[1]),
        .Q(syncstages_ff[2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b0)) 
    \syncstages_ff_reg[3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[2]),
        .Q(syncstages_ff[3]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xpm_counter_updn" *) 
module input_arbiter_fifo_xpm_counter_updn__parameterized0
   (Q,
    wr_en,
    \count_value_i_reg[5]_0 ,
    \count_value_i_reg[1]_0 ,
    rst_d1,
    ram_wr_en_i,
    wr_clk);
  output [5:0]Q;
  input wr_en;
  input \count_value_i_reg[5]_0 ;
  input [0:0]\count_value_i_reg[1]_0 ;
  input rst_d1;
  input ram_wr_en_i;
  input wr_clk;

  wire [5:0]Q;
  wire \count_value_i[0]_i_1__1_n_0 ;
  wire \count_value_i[1]_i_1__1_n_0 ;
  wire \count_value_i[2]_i_1__1_n_0 ;
  wire \count_value_i[3]_i_1__1_n_0 ;
  wire \count_value_i[4]_i_1__1_n_0 ;
  wire \count_value_i[5]_i_1_n_0 ;
  wire \count_value_i[5]_i_2_n_0 ;
  wire [0:0]\count_value_i_reg[1]_0 ;
  wire \count_value_i_reg[5]_0 ;
  wire ram_wr_en_i;
  wire rst_d1;
  wire wr_clk;
  wire wr_en;

  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \count_value_i[0]_i_1__1 
       (.I0(Q[0]),
        .O(\count_value_i[0]_i_1__1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \count_value_i[1]_i_1__1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(\count_value_i[1]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \count_value_i[2]_i_1__1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(Q[2]),
        .O(\count_value_i[2]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \count_value_i[3]_i_1__1 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[3]),
        .O(\count_value_i[3]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count_value_i[4]_i_1__1 
       (.I0(Q[2]),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(Q[3]),
        .I4(Q[4]),
        .O(\count_value_i[4]_i_1__1_n_0 ));
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count_value_i[5]_i_1 
       (.I0(Q[3]),
        .I1(\count_value_i[5]_i_2_n_0 ),
        .I2(Q[2]),
        .I3(Q[4]),
        .I4(Q[5]),
        .O(\count_value_i[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000800000000)) 
    \count_value_i[5]_i_2 
       (.I0(Q[1]),
        .I1(wr_en),
        .I2(\count_value_i_reg[5]_0 ),
        .I3(\count_value_i_reg[1]_0 ),
        .I4(rst_d1),
        .I5(Q[0]),
        .O(\count_value_i[5]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[0] 
       (.C(wr_clk),
        .CE(ram_wr_en_i),
        .D(\count_value_i[0]_i_1__1_n_0 ),
        .Q(Q[0]),
        .R(\count_value_i_reg[1]_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \count_value_i_reg[1] 
       (.C(wr_clk),
        .CE(ram_wr_en_i),
        .D(\count_value_i[1]_i_1__1_n_0 ),
        .Q(Q[1]),
        .S(\count_value_i_reg[1]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[2] 
       (.C(wr_clk),
        .CE(ram_wr_en_i),
        .D(\count_value_i[2]_i_1__1_n_0 ),
        .Q(Q[2]),
        .R(\count_value_i_reg[1]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[3] 
       (.C(wr_clk),
        .CE(ram_wr_en_i),
        .D(\count_value_i[3]_i_1__1_n_0 ),
        .Q(Q[3]),
        .R(\count_value_i_reg[1]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[4] 
       (.C(wr_clk),
        .CE(ram_wr_en_i),
        .D(\count_value_i[4]_i_1__1_n_0 ),
        .Q(Q[4]),
        .R(\count_value_i_reg[1]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[5] 
       (.C(wr_clk),
        .CE(ram_wr_en_i),
        .D(\count_value_i[5]_i_1_n_0 ),
        .Q(Q[5]),
        .R(\count_value_i_reg[1]_0 ));
endmodule

(* ORIG_REF_NAME = "xpm_counter_updn" *) 
module input_arbiter_fifo_xpm_counter_updn__parameterized2
   (going_afull,
    \FSM_sequential_gen_fwft.curr_fwft_state_reg[1] ,
    Q,
    leaving_empty0,
    going_full1,
    \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg ,
    \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_0 ,
    ram_wr_en_i,
    \count_value_i_reg[0]_0 ,
    rd_en,
    ram_empty_i,
    \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_3_0 ,
    \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_4_0 ,
    \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0 ,
    \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_1 ,
    clr_full,
    \count_value_i_reg[5]_0 ,
    wr_clk);
  output going_afull;
  output \FSM_sequential_gen_fwft.curr_fwft_state_reg[1] ;
  output [5:0]Q;
  output leaving_empty0;
  output going_full1;
  output \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg ;
  output \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_0 ;
  input ram_wr_en_i;
  input [1:0]\count_value_i_reg[0]_0 ;
  input rd_en;
  input ram_empty_i;
  input [5:0]\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_3_0 ;
  input [5:0]\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_4_0 ;
  input [5:0]\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0 ;
  input \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_1 ;
  input clr_full;
  input [0:0]\count_value_i_reg[5]_0 ;
  input wr_clk;

  wire \FSM_sequential_gen_fwft.curr_fwft_state_reg[1] ;
  wire [5:0]Q;
  wire clr_full;
  wire \count_value_i[0]_i_1__2_n_0 ;
  wire \count_value_i[1]_i_1__2_n_0 ;
  wire \count_value_i[2]_i_1__2_n_0 ;
  wire \count_value_i[3]_i_1__2_n_0 ;
  wire \count_value_i[4]_i_1__2_n_0 ;
  wire \count_value_i[5]_i_1__2_n_0 ;
  wire \count_value_i[5]_i_2__2_n_0 ;
  wire [1:0]\count_value_i_reg[0]_0 ;
  wire [0:0]\count_value_i_reg[5]_0 ;
  wire [5:0]\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0 ;
  wire \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_5_n_0 ;
  wire \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_6_n_0 ;
  wire \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg ;
  wire \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_0 ;
  wire \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_1 ;
  wire [5:0]\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_3_0 ;
  wire [5:0]\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_4_0 ;
  wire \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_5_n_0 ;
  wire \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_6_n_0 ;
  wire \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_7_n_0 ;
  wire \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_8_n_0 ;
  wire going_afull;
  wire going_full1;
  wire leaving_empty0;
  wire ram_empty_i;
  wire ram_wr_en_i;
  wire rd_en;
  wire wr_clk;

  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h10EF)) 
    \count_value_i[0]_i_1__2 
       (.I0(rd_en),
        .I1(\count_value_i_reg[0]_0 [0]),
        .I2(\count_value_i_reg[0]_0 [1]),
        .I3(Q[0]),
        .O(\count_value_i[0]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h02FFFD00)) 
    \count_value_i[1]_i_1__2 
       (.I0(\count_value_i_reg[0]_0 [1]),
        .I1(\count_value_i_reg[0]_0 [0]),
        .I2(rd_en),
        .I3(Q[0]),
        .I4(Q[1]),
        .O(\count_value_i[1]_i_1__2_n_0 ));
  LUT3 #(
    .INIT(8'h78)) 
    \count_value_i[2]_i_1__2 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(Q[2]),
        .O(\count_value_i[2]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \count_value_i[3]_i_1__2 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[3]),
        .O(\count_value_i[3]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count_value_i[4]_i_1__2 
       (.I0(Q[2]),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(Q[3]),
        .I4(Q[4]),
        .O(\count_value_i[4]_i_1__2_n_0 ));
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count_value_i[5]_i_1__2 
       (.I0(Q[3]),
        .I1(\count_value_i[5]_i_2__2_n_0 ),
        .I2(Q[2]),
        .I3(Q[4]),
        .I4(Q[5]),
        .O(\count_value_i[5]_i_1__2_n_0 ));
  LUT6 #(
    .INIT(64'h0000AAA200000000)) 
    \count_value_i[5]_i_2__2 
       (.I0(Q[1]),
        .I1(\count_value_i_reg[0]_0 [1]),
        .I2(\count_value_i_reg[0]_0 [0]),
        .I3(rd_en),
        .I4(ram_empty_i),
        .I5(Q[0]),
        .O(\count_value_i[5]_i_2__2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[0] 
       (.C(wr_clk),
        .CE(\FSM_sequential_gen_fwft.curr_fwft_state_reg[1] ),
        .D(\count_value_i[0]_i_1__2_n_0 ),
        .Q(Q[0]),
        .R(\count_value_i_reg[5]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[1] 
       (.C(wr_clk),
        .CE(\FSM_sequential_gen_fwft.curr_fwft_state_reg[1] ),
        .D(\count_value_i[1]_i_1__2_n_0 ),
        .Q(Q[1]),
        .R(\count_value_i_reg[5]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[2] 
       (.C(wr_clk),
        .CE(\FSM_sequential_gen_fwft.curr_fwft_state_reg[1] ),
        .D(\count_value_i[2]_i_1__2_n_0 ),
        .Q(Q[2]),
        .R(\count_value_i_reg[5]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[3] 
       (.C(wr_clk),
        .CE(\FSM_sequential_gen_fwft.curr_fwft_state_reg[1] ),
        .D(\count_value_i[3]_i_1__2_n_0 ),
        .Q(Q[3]),
        .R(\count_value_i_reg[5]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[4] 
       (.C(wr_clk),
        .CE(\FSM_sequential_gen_fwft.curr_fwft_state_reg[1] ),
        .D(\count_value_i[4]_i_1__2_n_0 ),
        .Q(Q[4]),
        .R(\count_value_i_reg[5]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[5] 
       (.C(wr_clk),
        .CE(\FSM_sequential_gen_fwft.curr_fwft_state_reg[1] ),
        .D(\count_value_i[5]_i_1__2_n_0 ),
        .Q(Q[5]),
        .R(\count_value_i_reg[5]_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3 
       (.I0(\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_5_n_0 ),
        .I1(\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_6_n_0 ),
        .I2(\FSM_sequential_gen_fwft.curr_fwft_state_reg[1] ),
        .I3(ram_wr_en_i),
        .O(going_afull));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_5 
       (.I0(Q[3]),
        .I1(\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0 [3]),
        .I2(\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0 [5]),
        .I3(Q[5]),
        .I4(\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0 [4]),
        .I5(Q[4]),
        .O(\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_6 
       (.I0(Q[0]),
        .I1(\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0 [0]),
        .I2(\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0 [2]),
        .I3(Q[2]),
        .I4(\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0 [1]),
        .I5(Q[1]),
        .O(\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h000000000FFF0088)) 
    \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_i_1 
       (.I0(ram_wr_en_i),
        .I1(going_full1),
        .I2(leaving_empty0),
        .I3(\FSM_sequential_gen_fwft.curr_fwft_state_reg[1] ),
        .I4(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_1 ),
        .I5(clr_full),
        .O(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg ));
  LUT6 #(
    .INIT(64'hFABAFBBBFBBBFBBB)) 
    \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_1 
       (.I0(clr_full),
        .I1(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_1 ),
        .I2(\FSM_sequential_gen_fwft.curr_fwft_state_reg[1] ),
        .I3(leaving_empty0),
        .I4(going_full1),
        .I5(ram_wr_en_i),
        .O(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_3 
       (.I0(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_5_n_0 ),
        .I1(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_6_n_0 ),
        .O(leaving_empty0));
  LUT2 #(
    .INIT(4'h8)) 
    \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_4 
       (.I0(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_7_n_0 ),
        .I1(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_8_n_0 ),
        .O(going_full1));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_5 
       (.I0(Q[0]),
        .I1(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_3_0 [0]),
        .I2(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_3_0 [2]),
        .I3(Q[2]),
        .I4(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_3_0 [1]),
        .I5(Q[1]),
        .O(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_6 
       (.I0(Q[3]),
        .I1(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_3_0 [3]),
        .I2(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_3_0 [5]),
        .I3(Q[5]),
        .I4(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_3_0 [4]),
        .I5(Q[4]),
        .O(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_7 
       (.I0(Q[0]),
        .I1(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_4_0 [0]),
        .I2(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_4_0 [2]),
        .I3(Q[2]),
        .I4(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_4_0 [1]),
        .I5(Q[1]),
        .O(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_8 
       (.I0(Q[3]),
        .I1(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_4_0 [3]),
        .I2(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_4_0 [5]),
        .I3(Q[5]),
        .I4(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_4_0 [4]),
        .I5(Q[4]),
        .O(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_8_n_0 ));
  LUT4 #(
    .INIT(16'h00FD)) 
    \gen_sdpram.xpm_memory_base_inst_i_2 
       (.I0(\count_value_i_reg[0]_0 [1]),
        .I1(\count_value_i_reg[0]_0 [0]),
        .I2(rd_en),
        .I3(ram_empty_i),
        .O(\FSM_sequential_gen_fwft.curr_fwft_state_reg[1] ));
endmodule

(* ORIG_REF_NAME = "xpm_counter_updn" *) 
module input_arbiter_fifo_xpm_counter_updn__parameterized2_0
   (Q,
    ram_empty_i0,
    wr_en,
    \count_value_i_reg[5]_0 ,
    \count_value_i_reg[0]_0 ,
    rst_d1,
    \gen_pntr_flags_cc.ram_empty_i_reg ,
    leaving_empty0,
    ram_wr_en_i,
    ram_empty_i,
    \gen_pntr_flags_cc.ram_empty_i_reg_0 ,
    wr_clk);
  output [5:0]Q;
  output ram_empty_i0;
  input wr_en;
  input \count_value_i_reg[5]_0 ;
  input [0:0]\count_value_i_reg[0]_0 ;
  input rst_d1;
  input \gen_pntr_flags_cc.ram_empty_i_reg ;
  input leaving_empty0;
  input ram_wr_en_i;
  input ram_empty_i;
  input [5:0]\gen_pntr_flags_cc.ram_empty_i_reg_0 ;
  input wr_clk;

  wire [5:0]Q;
  wire \count_value_i[0]_i_1_n_0 ;
  wire \count_value_i[1]_i_1_n_0 ;
  wire \count_value_i[2]_i_1_n_0 ;
  wire \count_value_i[3]_i_1_n_0 ;
  wire \count_value_i[4]_i_1_n_0 ;
  wire \count_value_i[5]_i_1__0_n_0 ;
  wire \count_value_i[5]_i_2__0_n_0 ;
  wire [0:0]\count_value_i_reg[0]_0 ;
  wire \count_value_i_reg[5]_0 ;
  wire \gen_pntr_flags_cc.ram_empty_i_i_2_n_0 ;
  wire \gen_pntr_flags_cc.ram_empty_i_i_3_n_0 ;
  wire \gen_pntr_flags_cc.ram_empty_i_reg ;
  wire [5:0]\gen_pntr_flags_cc.ram_empty_i_reg_0 ;
  wire leaving_empty0;
  wire ram_empty_i;
  wire ram_empty_i0;
  wire ram_wr_en_i;
  wire rst_d1;
  wire wr_clk;
  wire wr_en;

  LUT1 #(
    .INIT(2'h1)) 
    \count_value_i[0]_i_1 
       (.I0(Q[0]),
        .O(\count_value_i[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \count_value_i[1]_i_1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(\count_value_i[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \count_value_i[2]_i_1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(Q[2]),
        .O(\count_value_i[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \count_value_i[3]_i_1 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[3]),
        .O(\count_value_i[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count_value_i[4]_i_1 
       (.I0(Q[2]),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(Q[3]),
        .I4(Q[4]),
        .O(\count_value_i[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count_value_i[5]_i_1__0 
       (.I0(Q[3]),
        .I1(\count_value_i[5]_i_2__0_n_0 ),
        .I2(Q[2]),
        .I3(Q[4]),
        .I4(Q[5]),
        .O(\count_value_i[5]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h0000000800000000)) 
    \count_value_i[5]_i_2__0 
       (.I0(Q[1]),
        .I1(wr_en),
        .I2(\count_value_i_reg[5]_0 ),
        .I3(\count_value_i_reg[0]_0 ),
        .I4(rst_d1),
        .I5(Q[0]),
        .O(\count_value_i[5]_i_2__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[0] 
       (.C(wr_clk),
        .CE(ram_wr_en_i),
        .D(\count_value_i[0]_i_1_n_0 ),
        .Q(Q[0]),
        .R(\count_value_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[1] 
       (.C(wr_clk),
        .CE(ram_wr_en_i),
        .D(\count_value_i[1]_i_1_n_0 ),
        .Q(Q[1]),
        .R(\count_value_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[2] 
       (.C(wr_clk),
        .CE(ram_wr_en_i),
        .D(\count_value_i[2]_i_1_n_0 ),
        .Q(Q[2]),
        .R(\count_value_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[3] 
       (.C(wr_clk),
        .CE(ram_wr_en_i),
        .D(\count_value_i[3]_i_1_n_0 ),
        .Q(Q[3]),
        .R(\count_value_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[4] 
       (.C(wr_clk),
        .CE(ram_wr_en_i),
        .D(\count_value_i[4]_i_1_n_0 ),
        .Q(Q[4]),
        .R(\count_value_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[5] 
       (.C(wr_clk),
        .CE(ram_wr_en_i),
        .D(\count_value_i[5]_i_1__0_n_0 ),
        .Q(Q[5]),
        .R(\count_value_i_reg[0]_0 ));
  LUT6 #(
    .INIT(64'h00FFFFFF00008080)) 
    \gen_pntr_flags_cc.ram_empty_i_i_1 
       (.I0(\gen_pntr_flags_cc.ram_empty_i_reg ),
        .I1(\gen_pntr_flags_cc.ram_empty_i_i_2_n_0 ),
        .I2(\gen_pntr_flags_cc.ram_empty_i_i_3_n_0 ),
        .I3(leaving_empty0),
        .I4(ram_wr_en_i),
        .I5(ram_empty_i),
        .O(ram_empty_i0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pntr_flags_cc.ram_empty_i_i_2 
       (.I0(Q[0]),
        .I1(\gen_pntr_flags_cc.ram_empty_i_reg_0 [0]),
        .I2(\gen_pntr_flags_cc.ram_empty_i_reg_0 [2]),
        .I3(Q[2]),
        .I4(\gen_pntr_flags_cc.ram_empty_i_reg_0 [1]),
        .I5(Q[1]),
        .O(\gen_pntr_flags_cc.ram_empty_i_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pntr_flags_cc.ram_empty_i_i_3 
       (.I0(Q[3]),
        .I1(\gen_pntr_flags_cc.ram_empty_i_reg_0 [3]),
        .I2(\gen_pntr_flags_cc.ram_empty_i_reg_0 [5]),
        .I3(Q[5]),
        .I4(\gen_pntr_flags_cc.ram_empty_i_reg_0 [4]),
        .I5(Q[4]),
        .O(\gen_pntr_flags_cc.ram_empty_i_i_3_n_0 ));
endmodule

(* ORIG_REF_NAME = "xpm_counter_updn" *) 
module input_arbiter_fifo_xpm_counter_updn__parameterized3
   (Q,
    \count_value_i_reg[1]_0 ,
    rd_en,
    ram_empty_i,
    \count_value_i_reg[1]_1 ,
    E,
    wr_clk);
  output [5:0]Q;
  input [1:0]\count_value_i_reg[1]_0 ;
  input rd_en;
  input ram_empty_i;
  input [0:0]\count_value_i_reg[1]_1 ;
  input [0:0]E;
  input wr_clk;

  wire [0:0]E;
  wire [5:0]Q;
  wire \count_value_i[0]_i_1__3_n_0 ;
  wire \count_value_i[1]_i_1__3_n_0 ;
  wire \count_value_i[2]_i_1__3_n_0 ;
  wire \count_value_i[3]_i_1__3_n_0 ;
  wire \count_value_i[4]_i_1__3_n_0 ;
  wire \count_value_i[5]_i_1__3_n_0 ;
  wire \count_value_i[5]_i_2__3_n_0 ;
  wire [1:0]\count_value_i_reg[1]_0 ;
  wire [0:0]\count_value_i_reg[1]_1 ;
  wire ram_empty_i;
  wire rd_en;
  wire wr_clk;

  LUT4 #(
    .INIT(16'h10EF)) 
    \count_value_i[0]_i_1__3 
       (.I0(rd_en),
        .I1(\count_value_i_reg[1]_0 [0]),
        .I2(\count_value_i_reg[1]_0 [1]),
        .I3(Q[0]),
        .O(\count_value_i[0]_i_1__3_n_0 ));
  LUT5 #(
    .INIT(32'h02FFFD00)) 
    \count_value_i[1]_i_1__3 
       (.I0(\count_value_i_reg[1]_0 [1]),
        .I1(\count_value_i_reg[1]_0 [0]),
        .I2(rd_en),
        .I3(Q[0]),
        .I4(Q[1]),
        .O(\count_value_i[1]_i_1__3_n_0 ));
  LUT3 #(
    .INIT(8'h78)) 
    \count_value_i[2]_i_1__3 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(Q[2]),
        .O(\count_value_i[2]_i_1__3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \count_value_i[3]_i_1__3 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[3]),
        .O(\count_value_i[3]_i_1__3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count_value_i[4]_i_1__3 
       (.I0(Q[2]),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(Q[3]),
        .I4(Q[4]),
        .O(\count_value_i[4]_i_1__3_n_0 ));
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count_value_i[5]_i_1__3 
       (.I0(Q[3]),
        .I1(\count_value_i[5]_i_2__3_n_0 ),
        .I2(Q[2]),
        .I3(Q[4]),
        .I4(Q[5]),
        .O(\count_value_i[5]_i_1__3_n_0 ));
  LUT6 #(
    .INIT(64'h0000AAA200000000)) 
    \count_value_i[5]_i_2__3 
       (.I0(Q[1]),
        .I1(\count_value_i_reg[1]_0 [1]),
        .I2(\count_value_i_reg[1]_0 [0]),
        .I3(rd_en),
        .I4(ram_empty_i),
        .I5(Q[0]),
        .O(\count_value_i[5]_i_2__3_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \count_value_i_reg[0] 
       (.C(wr_clk),
        .CE(E),
        .D(\count_value_i[0]_i_1__3_n_0 ),
        .Q(Q[0]),
        .S(\count_value_i_reg[1]_1 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[1] 
       (.C(wr_clk),
        .CE(E),
        .D(\count_value_i[1]_i_1__3_n_0 ),
        .Q(Q[1]),
        .R(\count_value_i_reg[1]_1 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[2] 
       (.C(wr_clk),
        .CE(E),
        .D(\count_value_i[2]_i_1__3_n_0 ),
        .Q(Q[2]),
        .R(\count_value_i_reg[1]_1 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[3] 
       (.C(wr_clk),
        .CE(E),
        .D(\count_value_i[3]_i_1__3_n_0 ),
        .Q(Q[3]),
        .R(\count_value_i_reg[1]_1 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[4] 
       (.C(wr_clk),
        .CE(E),
        .D(\count_value_i[4]_i_1__3_n_0 ),
        .Q(Q[4]),
        .R(\count_value_i_reg[1]_1 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[5] 
       (.C(wr_clk),
        .CE(E),
        .D(\count_value_i[5]_i_1__3_n_0 ),
        .Q(Q[5]),
        .R(\count_value_i_reg[1]_1 ));
endmodule

(* ORIG_REF_NAME = "xpm_counter_updn" *) 
module input_arbiter_fifo_xpm_counter_updn__parameterized3_1
   (Q,
    wr_en,
    \count_value_i_reg[5]_0 ,
    \count_value_i_reg[1]_0 ,
    rst_d1,
    ram_wr_en_i,
    wr_clk);
  output [5:0]Q;
  input wr_en;
  input \count_value_i_reg[5]_0 ;
  input [0:0]\count_value_i_reg[1]_0 ;
  input rst_d1;
  input ram_wr_en_i;
  input wr_clk;

  wire [5:0]Q;
  wire \count_value_i[0]_i_1__0_n_0 ;
  wire \count_value_i[1]_i_1__0_n_0 ;
  wire \count_value_i[2]_i_1__0_n_0 ;
  wire \count_value_i[3]_i_1__0_n_0 ;
  wire \count_value_i[4]_i_1__0_n_0 ;
  wire \count_value_i[5]_i_1__1_n_0 ;
  wire \count_value_i[5]_i_2__1_n_0 ;
  wire [0:0]\count_value_i_reg[1]_0 ;
  wire \count_value_i_reg[5]_0 ;
  wire ram_wr_en_i;
  wire rst_d1;
  wire wr_clk;
  wire wr_en;

  LUT1 #(
    .INIT(2'h1)) 
    \count_value_i[0]_i_1__0 
       (.I0(Q[0]),
        .O(\count_value_i[0]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \count_value_i[1]_i_1__0 
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(\count_value_i[1]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \count_value_i[2]_i_1__0 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(Q[2]),
        .O(\count_value_i[2]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \count_value_i[3]_i_1__0 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[3]),
        .O(\count_value_i[3]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count_value_i[4]_i_1__0 
       (.I0(Q[2]),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(Q[3]),
        .I4(Q[4]),
        .O(\count_value_i[4]_i_1__0_n_0 ));
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count_value_i[5]_i_1__1 
       (.I0(Q[3]),
        .I1(\count_value_i[5]_i_2__1_n_0 ),
        .I2(Q[2]),
        .I3(Q[4]),
        .I4(Q[5]),
        .O(\count_value_i[5]_i_1__1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000800000000)) 
    \count_value_i[5]_i_2__1 
       (.I0(Q[1]),
        .I1(wr_en),
        .I2(\count_value_i_reg[5]_0 ),
        .I3(\count_value_i_reg[1]_0 ),
        .I4(rst_d1),
        .I5(Q[0]),
        .O(\count_value_i[5]_i_2__1_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \count_value_i_reg[0] 
       (.C(wr_clk),
        .CE(ram_wr_en_i),
        .D(\count_value_i[0]_i_1__0_n_0 ),
        .Q(Q[0]),
        .S(\count_value_i_reg[1]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[1] 
       (.C(wr_clk),
        .CE(ram_wr_en_i),
        .D(\count_value_i[1]_i_1__0_n_0 ),
        .Q(Q[1]),
        .R(\count_value_i_reg[1]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[2] 
       (.C(wr_clk),
        .CE(ram_wr_en_i),
        .D(\count_value_i[2]_i_1__0_n_0 ),
        .Q(Q[2]),
        .R(\count_value_i_reg[1]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[3] 
       (.C(wr_clk),
        .CE(ram_wr_en_i),
        .D(\count_value_i[3]_i_1__0_n_0 ),
        .Q(Q[3]),
        .R(\count_value_i_reg[1]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[4] 
       (.C(wr_clk),
        .CE(ram_wr_en_i),
        .D(\count_value_i[4]_i_1__0_n_0 ),
        .Q(Q[4]),
        .R(\count_value_i_reg[1]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[5] 
       (.C(wr_clk),
        .CE(ram_wr_en_i),
        .D(\count_value_i[5]_i_1__1_n_0 ),
        .Q(Q[5]),
        .R(\count_value_i_reg[1]_0 ));
endmodule

(* AXIS_DATA_WIDTH = "451" *) (* AXIS_FINAL_DATA_WIDTH = "451" *) (* CASCADE_HEIGHT = "0" *) 
(* CDC_SYNC_STAGES = "3" *) (* CLOCKING_MODE = "common_clock" *) (* ECC_MODE = "no_ecc" *) 
(* EN_ADV_FEATURE_AXIS = "16'b0001100000001000" *) (* EN_ADV_FEATURE_AXIS_INT = "16'b0001100000001000" *) (* EN_ALMOST_EMPTY_INT = "1'b1" *) 
(* EN_ALMOST_FULL_INT = "1'b1" *) (* EN_DATA_VALID_INT = "1'b1" *) (* FIFO_DEPTH = "64" *) 
(* FIFO_MEMORY_TYPE = "auto" *) (* LOG_DEPTH_AXIS = "6" *) (* ORIG_REF_NAME = "xpm_fifo_axis" *) 
(* PACKET_FIFO = "true" *) (* PKT_SIZE_LT8 = "1'b0" *) (* PROG_EMPTY_THRESH = "5" *) 
(* PROG_FULL_THRESH = "11" *) (* P_COMMON_CLOCK = "1" *) (* P_ECC_MODE = "0" *) 
(* P_FIFO_MEMORY_TYPE = "0" *) (* P_PKT_MODE = "1" *) (* RD_DATA_COUNT_WIDTH = "7" *) 
(* RELATED_CLOCKS = "0" *) (* SIM_ASSERT_CHK = "0" *) (* TDATA_OFFSET = "256" *) 
(* TDATA_WIDTH = "256" *) (* TDEST_OFFSET = "322" *) (* TDEST_WIDTH = "1" *) 
(* TID_OFFSET = "321" *) (* TID_WIDTH = "1" *) (* TKEEP_OFFSET = "320" *) 
(* TSTRB_OFFSET = "288" *) (* TUSER_MAX_WIDTH = "3773" *) (* TUSER_OFFSET = "450" *) 
(* TUSER_WIDTH = "128" *) (* USE_ADV_FEATURES = "825765944" *) (* USE_ADV_FEATURES_INT = "825765944" *) 
(* WR_DATA_COUNT_WIDTH = "7" *) (* XPM_MODULE = "TRUE" *) (* dont_touch = "true" *) 
module input_arbiter_fifo_xpm_fifo_axis
   (s_aresetn,
    s_aclk,
    m_aclk,
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tdata,
    s_axis_tstrb,
    s_axis_tkeep,
    s_axis_tlast,
    s_axis_tid,
    s_axis_tdest,
    s_axis_tuser,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tdata,
    m_axis_tstrb,
    m_axis_tkeep,
    m_axis_tlast,
    m_axis_tid,
    m_axis_tdest,
    m_axis_tuser,
    prog_full_axis,
    wr_data_count_axis,
    almost_full_axis,
    prog_empty_axis,
    rd_data_count_axis,
    almost_empty_axis,
    injectsbiterr_axis,
    injectdbiterr_axis,
    sbiterr_axis,
    dbiterr_axis);
  input s_aresetn;
  input s_aclk;
  input m_aclk;
  input s_axis_tvalid;
  output s_axis_tready;
  input [255:0]s_axis_tdata;
  input [31:0]s_axis_tstrb;
  input [31:0]s_axis_tkeep;
  input s_axis_tlast;
  input [0:0]s_axis_tid;
  input [0:0]s_axis_tdest;
  input [127:0]s_axis_tuser;
  output m_axis_tvalid;
  input m_axis_tready;
  output [255:0]m_axis_tdata;
  output [31:0]m_axis_tstrb;
  output [31:0]m_axis_tkeep;
  output m_axis_tlast;
  output [0:0]m_axis_tid;
  output [0:0]m_axis_tdest;
  output [127:0]m_axis_tuser;
  output prog_full_axis;
  output [6:0]wr_data_count_axis;
  output almost_full_axis;
  output prog_empty_axis;
  output [6:0]rd_data_count_axis;
  output almost_empty_axis;
  input injectsbiterr_axis;
  input injectdbiterr_axis;
  output sbiterr_axis;
  output dbiterr_axis;

  wire \<const0> ;
  wire almost_empty_axis;
  wire almost_full_axis;
  wire axis_pkt_read;
  wire axis_rd_eop1;
  wire axis_wr_eop_d1;
  wire data_valid_axis;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_3_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_4_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_5_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_6_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_2_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_3_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_4_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_5_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_2_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_3_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_4_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_5_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_2_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_3_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_4_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_5_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_2_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_3_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_4_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_5_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_2_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_3_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_4_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_5_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_2_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_3_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_4_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_5_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_2_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_3_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_4_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_5_n_0 ;
  wire [31:0]\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_1 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_2 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_3 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_4 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_5 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_6 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_7 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_1 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_2 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_3 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_4 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_5 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_6 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_7 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_1 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_2 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_3 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_4 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_5 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_6 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_7 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_1 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_2 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_3 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_4 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_5 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_6 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_7 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_1 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_2 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_3 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_4 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_5 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_6 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_7 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_1 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_2 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_3 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_4 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_5 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_6 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_7 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_1 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_2 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_3 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_4 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_5 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_6 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_7 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_1 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_2 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_3 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_4 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_5 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_6 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_7 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_10_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_11_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_12_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_13_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_14_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_17_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_18_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_19_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_1_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_20_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_21_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_22_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_23_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_24_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_25_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_26_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_27_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_28_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_30_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_31_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_32_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_33_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_34_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_35_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_36_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_37_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_38_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_39_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_3_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_40_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_41_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_42_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_43_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_44_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_45_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_5_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_6_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_7_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_8_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_i_9_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16_n_1 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16_n_2 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16_n_3 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29_n_1 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29_n_2 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29_n_3 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2_n_1 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2_n_2 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2_n_3 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4_n_0 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4_n_1 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4_n_2 ;
  wire \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4_n_3 ;
  wire \gaxis_pkt_fifo_cc.axis_wr_eop_d1_i_1_n_0 ;
  wire \gaxis_rst_sync.xpm_cdc_sync_rst_inst_i_1_n_0 ;
  wire [255:0]m_axis_tdata;
  wire [31:0]m_axis_tkeep;
  wire m_axis_tlast;
  wire m_axis_tready;
  wire [127:0]m_axis_tuser;
  wire m_axis_tvalid;
  wire p_3_in;
  wire rst_axis;
  wire s_aclk;
  wire s_aresetn;
  wire [255:0]s_axis_tdata;
  wire [31:0]s_axis_tkeep;
  wire s_axis_tlast;
  wire s_axis_tready;
  wire [127:0]s_axis_tuser;
  wire s_axis_tvalid;
  wire [3:3]\NLW_gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16_O_UNCONNECTED ;
  wire [3:0]\NLW_gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2_O_UNCONNECTED ;
  wire [3:0]\NLW_gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29_O_UNCONNECTED ;
  wire [3:0]\NLW_gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4_O_UNCONNECTED ;
  wire NLW_xpm_fifo_base_inst_dbiterr_UNCONNECTED;
  wire NLW_xpm_fifo_base_inst_empty_UNCONNECTED;
  wire NLW_xpm_fifo_base_inst_full_UNCONNECTED;
  wire NLW_xpm_fifo_base_inst_overflow_UNCONNECTED;
  wire NLW_xpm_fifo_base_inst_prog_empty_UNCONNECTED;
  wire NLW_xpm_fifo_base_inst_prog_full_UNCONNECTED;
  wire NLW_xpm_fifo_base_inst_rd_rst_busy_UNCONNECTED;
  wire NLW_xpm_fifo_base_inst_sbiterr_UNCONNECTED;
  wire NLW_xpm_fifo_base_inst_underflow_UNCONNECTED;
  wire NLW_xpm_fifo_base_inst_wr_ack_UNCONNECTED;
  wire NLW_xpm_fifo_base_inst_wr_rst_busy_UNCONNECTED;
  wire [321:256]NLW_xpm_fifo_base_inst_dout_UNCONNECTED;
  wire [6:0]NLW_xpm_fifo_base_inst_rd_data_count_UNCONNECTED;
  wire [6:0]NLW_xpm_fifo_base_inst_wr_data_count_UNCONNECTED;

  assign dbiterr_axis = \<const0> ;
  assign m_axis_tdest[0] = \<const0> ;
  assign m_axis_tid[0] = \<const0> ;
  assign m_axis_tstrb[31] = \<const0> ;
  assign m_axis_tstrb[30] = \<const0> ;
  assign m_axis_tstrb[29] = \<const0> ;
  assign m_axis_tstrb[28] = \<const0> ;
  assign m_axis_tstrb[27] = \<const0> ;
  assign m_axis_tstrb[26] = \<const0> ;
  assign m_axis_tstrb[25] = \<const0> ;
  assign m_axis_tstrb[24] = \<const0> ;
  assign m_axis_tstrb[23] = \<const0> ;
  assign m_axis_tstrb[22] = \<const0> ;
  assign m_axis_tstrb[21] = \<const0> ;
  assign m_axis_tstrb[20] = \<const0> ;
  assign m_axis_tstrb[19] = \<const0> ;
  assign m_axis_tstrb[18] = \<const0> ;
  assign m_axis_tstrb[17] = \<const0> ;
  assign m_axis_tstrb[16] = \<const0> ;
  assign m_axis_tstrb[15] = \<const0> ;
  assign m_axis_tstrb[14] = \<const0> ;
  assign m_axis_tstrb[13] = \<const0> ;
  assign m_axis_tstrb[12] = \<const0> ;
  assign m_axis_tstrb[11] = \<const0> ;
  assign m_axis_tstrb[10] = \<const0> ;
  assign m_axis_tstrb[9] = \<const0> ;
  assign m_axis_tstrb[8] = \<const0> ;
  assign m_axis_tstrb[7] = \<const0> ;
  assign m_axis_tstrb[6] = \<const0> ;
  assign m_axis_tstrb[5] = \<const0> ;
  assign m_axis_tstrb[4] = \<const0> ;
  assign m_axis_tstrb[3] = \<const0> ;
  assign m_axis_tstrb[2] = \<const0> ;
  assign m_axis_tstrb[1] = \<const0> ;
  assign m_axis_tstrb[0] = \<const0> ;
  assign prog_empty_axis = \<const0> ;
  assign prog_full_axis = \<const0> ;
  assign rd_data_count_axis[6] = \<const0> ;
  assign rd_data_count_axis[5] = \<const0> ;
  assign rd_data_count_axis[4] = \<const0> ;
  assign rd_data_count_axis[3] = \<const0> ;
  assign rd_data_count_axis[2] = \<const0> ;
  assign rd_data_count_axis[1] = \<const0> ;
  assign rd_data_count_axis[0] = \<const0> ;
  assign sbiterr_axis = \<const0> ;
  assign wr_data_count_axis[6] = \<const0> ;
  assign wr_data_count_axis[5] = \<const0> ;
  assign wr_data_count_axis[4] = \<const0> ;
  assign wr_data_count_axis[3] = \<const0> ;
  assign wr_data_count_axis[2] = \<const0> ;
  assign wr_data_count_axis[1] = \<const0> ;
  assign wr_data_count_axis[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1 
       (.I0(axis_wr_eop_d1),
        .I1(m_axis_tready),
        .I2(data_valid_axis),
        .I3(m_axis_tlast),
        .I4(axis_pkt_read),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_3 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [3]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_4 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [2]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_5 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [1]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_6 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [0]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_2 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [15]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_3 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [14]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_4 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [13]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_5 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [12]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_2 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [19]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_3 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [18]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_4 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [17]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_5 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [16]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_2 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [23]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_3 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [22]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_4 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [21]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_5 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [20]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_2 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [27]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_3 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [26]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_4 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [25]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_5 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [24]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_2 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [31]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_3 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [30]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_4 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [29]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_5 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [28]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_2 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [7]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_3 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [6]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_4 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [5]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_5 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [4]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_2 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [11]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_3 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [10]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_4 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [9]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF00008000FFFF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_5 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .I4(axis_wr_eop_d1),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [8]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_5_n_0 ));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_7 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [0]),
        .R(rst_axis));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_1 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_2 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [3:1],1'b1}),
        .O({\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_4 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_5 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_6 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_7 }),
        .S({\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_3_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_4_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_5_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_6_n_0 }));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[10] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_5 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [10]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[11] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_4 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [11]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_7 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [12]),
        .R(rst_axis));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1 
       (.CI(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_0 ),
        .CO({\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_1 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_2 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [15:12]),
        .O({\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_4 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_5 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_6 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_7 }),
        .S({\gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_2_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_3_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_4_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_5_n_0 }));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[13] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_6 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [13]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[14] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_5 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [14]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[15] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_4 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [15]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_7 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [16]),
        .R(rst_axis));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1 
       (.CI(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_0 ),
        .CO({\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_1 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_2 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [19:16]),
        .O({\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_4 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_5 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_6 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_7 }),
        .S({\gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_2_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_3_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_4_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_5_n_0 }));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[17] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_6 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [17]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[18] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_5 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [18]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[19] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_4 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [19]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[1] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_6 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [1]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_7 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [20]),
        .R(rst_axis));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1 
       (.CI(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_0 ),
        .CO({\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_1 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_2 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [23:20]),
        .O({\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_4 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_5 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_6 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_7 }),
        .S({\gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_2_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_3_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_4_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_5_n_0 }));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[21] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_6 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [21]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[22] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_5 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [22]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[23] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_4 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [23]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_7 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [24]),
        .R(rst_axis));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1 
       (.CI(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_0 ),
        .CO({\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_1 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_2 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [27:24]),
        .O({\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_4 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_5 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_6 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_7 }),
        .S({\gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_2_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_3_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_4_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_5_n_0 }));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[25] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_6 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [25]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[26] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_5 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [26]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[27] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_4 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [27]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_7 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [28]),
        .R(rst_axis));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1 
       (.CI(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_0 ),
        .CO({\NLW_gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_CO_UNCONNECTED [3],\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_1 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_2 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [30:28]}),
        .O({\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_4 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_5 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_6 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_7 }),
        .S({\gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_2_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_3_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_4_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_5_n_0 }));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[29] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_6 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [29]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[2] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_5 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [2]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[30] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_5 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [30]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[31] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_4 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [31]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[3] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_4 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [3]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_7 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [4]),
        .R(rst_axis));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1 
       (.CI(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_0 ),
        .CO({\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_1 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_2 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [7:4]),
        .O({\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_4 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_5 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_6 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_7 }),
        .S({\gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_2_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_3_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_4_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_5_n_0 }));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[5] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_6 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [5]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[6] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_5 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [6]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[7] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_4 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [7]),
        .R(rst_axis));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_7 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [8]),
        .R(rst_axis));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1 
       (.CI(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_0 ),
        .CO({\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_1 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_2 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [11:8]),
        .O({\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_4 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_5 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_6 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_7 }),
        .S({\gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_2_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_3_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_4_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_5_n_0 }));
  FDRE \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[9] 
       (.C(s_aclk),
        .CE(\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0 ),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_6 ),
        .Q(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [9]),
        .R(rst_axis));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'h0000FEEE)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_1 
       (.I0(axis_pkt_read),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2_n_0 ),
        .I2(data_valid_axis),
        .I3(almost_full_axis),
        .I4(\gaxis_pkt_fifo_cc.axis_pkt_read_i_3_n_0 ),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_10 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [28]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [29]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_10_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_11 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [26]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [27]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_11_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_12 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [24]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [25]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_12_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_13 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_read_i_25_n_0 ),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [30]),
        .I2(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [31]),
        .I3(\gaxis_pkt_fifo_cc.axis_pkt_read_i_26_n_0 ),
        .I4(\gaxis_pkt_fifo_cc.axis_pkt_read_i_27_n_0 ),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_read_i_28_n_0 ),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_13_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_14 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [24]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [25]),
        .I2(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [26]),
        .I3(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [27]),
        .I4(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [28]),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [29]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_14_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_15 
       (.I0(m_axis_tready),
        .I1(data_valid_axis),
        .I2(m_axis_tlast),
        .I3(axis_pkt_read),
        .O(p_3_in));
  LUT2 #(
    .INIT(4'hE)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_17 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [22]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [23]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_17_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_18 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [20]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [21]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_18_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_19 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [18]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [19]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_19_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_20 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [16]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [17]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_20_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_21 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [22]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [23]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_21_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_22 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [20]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [21]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_22_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_23 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [18]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [19]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_23_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_24 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [16]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [17]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_24_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFEF)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_25 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [1]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [2]),
        .I2(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [0]),
        .I3(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [3]),
        .I4(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [4]),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [5]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_25_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_26 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [12]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [13]),
        .I2(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [14]),
        .I3(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [15]),
        .I4(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [16]),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [17]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_26_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_27 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [18]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [19]),
        .I2(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [20]),
        .I3(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [21]),
        .I4(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [22]),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [23]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_27_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_28 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [6]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [7]),
        .I2(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [8]),
        .I3(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [9]),
        .I4(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [10]),
        .I5(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [11]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_28_n_0 ));
  LUT5 #(
    .INIT(32'hAAABAAAA)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_3 
       (.I0(rst_axis),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_read_i_13_n_0 ),
        .I2(\gaxis_pkt_fifo_cc.axis_pkt_read_i_14_n_0 ),
        .I3(axis_wr_eop_d1),
        .I4(p_3_in),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_3_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_30 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [14]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [15]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_30_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_31 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [12]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [13]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_31_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_32 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [10]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [11]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_32_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_33 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [8]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [9]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_33_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_34 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [14]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [15]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_34_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_35 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [12]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [13]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_35_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_36 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [10]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [11]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_36_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_37 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [8]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [9]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_37_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_38 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [6]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [7]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_38_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_39 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [4]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [5]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_39_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_40 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [2]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [3]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_40_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_41 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [0]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [1]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_41_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_42 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [6]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [7]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_42_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_43 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [4]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [5]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_43_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_44 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [2]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [3]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_44_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_45 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [0]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [1]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_45_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_5 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [30]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [31]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_5_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_6 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [28]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [29]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_6_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_7 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [26]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [27]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_7_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_8 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [24]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [25]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_i_9 
       (.I0(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [31]),
        .I1(\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg [30]),
        .O(\gaxis_pkt_fifo_cc.axis_pkt_read_i_9_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gaxis_pkt_fifo_cc.axis_pkt_read_reg 
       (.C(s_aclk),
        .CE(1'b1),
        .D(\gaxis_pkt_fifo_cc.axis_pkt_read_i_1_n_0 ),
        .Q(axis_pkt_read),
        .R(1'b0));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16 
       (.CI(\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29_n_0 ),
        .CO({\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16_n_1 ,\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16_n_2 ,\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16_n_3 }),
        .CYINIT(1'b0),
        .DI({\gaxis_pkt_fifo_cc.axis_pkt_read_i_30_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_31_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_32_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_33_n_0 }),
        .O(\NLW_gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16_O_UNCONNECTED [3:0]),
        .S({\gaxis_pkt_fifo_cc.axis_pkt_read_i_34_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_35_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_36_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_37_n_0 }));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2 
       (.CI(\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4_n_0 ),
        .CO({\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2_n_1 ,\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2_n_2 ,\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({\gaxis_pkt_fifo_cc.axis_pkt_read_i_5_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_6_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_7_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_8_n_0 }),
        .O(\NLW_gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2_O_UNCONNECTED [3:0]),
        .S({\gaxis_pkt_fifo_cc.axis_pkt_read_i_9_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_10_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_11_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_12_n_0 }));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29 
       (.CI(1'b0),
        .CO({\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29_n_1 ,\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29_n_2 ,\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29_n_3 }),
        .CYINIT(1'b0),
        .DI({\gaxis_pkt_fifo_cc.axis_pkt_read_i_38_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_39_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_40_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_41_n_0 }),
        .O(\NLW_gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29_O_UNCONNECTED [3:0]),
        .S({\gaxis_pkt_fifo_cc.axis_pkt_read_i_42_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_43_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_44_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_45_n_0 }));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4 
       (.CI(\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16_n_0 ),
        .CO({\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4_n_1 ,\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4_n_2 ,\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({\gaxis_pkt_fifo_cc.axis_pkt_read_i_17_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_18_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_19_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_20_n_0 }),
        .O(\NLW_gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4_O_UNCONNECTED [3:0]),
        .S({\gaxis_pkt_fifo_cc.axis_pkt_read_i_21_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_22_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_23_n_0 ,\gaxis_pkt_fifo_cc.axis_pkt_read_i_24_n_0 }));
  LUT4 #(
    .INIT(16'h0080)) 
    \gaxis_pkt_fifo_cc.axis_wr_eop_d1_i_1 
       (.I0(s_axis_tlast),
        .I1(s_axis_tready),
        .I2(s_axis_tvalid),
        .I3(rst_axis),
        .O(\gaxis_pkt_fifo_cc.axis_wr_eop_d1_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gaxis_pkt_fifo_cc.axis_wr_eop_d1_reg 
       (.C(s_aclk),
        .CE(1'b1),
        .D(\gaxis_pkt_fifo_cc.axis_wr_eop_d1_i_1_n_0 ),
        .Q(axis_wr_eop_d1),
        .R(1'b0));
  (* DEF_VAL = "1'b0" *) 
  (* DEST_SYNC_FF = "4" *) 
  (* INIT = "0" *) 
  (* INIT_SYNC_FF = "1" *) 
  (* KEEP_HIERARCHY = "true" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* VERSION = "0" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  (* XPM_MODULE = "TRUE" *) 
  input_arbiter_fifo_xpm_cdc_sync_rst \gaxis_rst_sync.xpm_cdc_sync_rst_inst 
       (.dest_clk(s_aclk),
        .dest_rst(rst_axis),
        .src_rst(\gaxis_rst_sync.xpm_cdc_sync_rst_inst_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \gaxis_rst_sync.xpm_cdc_sync_rst_inst_i_1 
       (.I0(s_aresetn),
        .O(\gaxis_rst_sync.xpm_cdc_sync_rst_inst_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h8)) 
    m_axis_tvalid_INST_0
       (.I0(data_valid_axis),
        .I1(axis_pkt_read),
        .O(m_axis_tvalid));
  (* CASCADE_HEIGHT = "0" *) 
  (* CDC_DEST_SYNC_FF = "3" *) 
  (* COMMON_CLOCK = "1" *) 
  (* DOUT_RESET_VALUE = "" *) 
  (* ECC_MODE = "0" *) 
  (* ENABLE_ECC = "0" *) 
  (* EN_ADV_FEATURE = "16'b0001100000001000" *) 
  (* EN_AE = "1'b1" *) 
  (* EN_AF = "1'b1" *) 
  (* EN_DVLD = "1'b1" *) 
  (* EN_OF = "1'b0" *) 
  (* EN_PE = "1'b0" *) 
  (* EN_PF = "1'b0" *) 
  (* EN_RDC = "1'b0" *) 
  (* EN_UF = "1'b0" *) 
  (* EN_WACK = "1'b0" *) 
  (* EN_WDC = "1'b0" *) 
  (* FG_EQ_ASYM_DOUT = "1'b0" *) 
  (* FIFO_MEMORY_TYPE = "0" *) 
  (* FIFO_MEM_TYPE = "0" *) 
  (* FIFO_READ_DEPTH = "64" *) 
  (* FIFO_READ_LATENCY = "0" *) 
  (* FIFO_SIZE = "28864" *) 
  (* FIFO_WRITE_DEPTH = "64" *) 
  (* FULL_RESET_VALUE = "1" *) 
  (* FULL_RST_VAL = "1'b1" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* PE_THRESH_ADJ = "3" *) 
  (* PE_THRESH_MAX = "59" *) 
  (* PE_THRESH_MIN = "5" *) 
  (* PF_THRESH_ADJ = "9" *) 
  (* PF_THRESH_MAX = "59" *) 
  (* PF_THRESH_MIN = "5" *) 
  (* PROG_EMPTY_THRESH = "5" *) 
  (* PROG_FULL_THRESH = "11" *) 
  (* RD_DATA_COUNT_WIDTH = "7" *) 
  (* RD_DC_WIDTH_EXT = "7" *) 
  (* RD_LATENCY = "2" *) 
  (* RD_MODE = "1" *) 
  (* RD_PNTR_WIDTH = "6" *) 
  (* READ_DATA_WIDTH = "451" *) 
  (* READ_MODE = "1" *) 
  (* RELATED_CLOCKS = "0" *) 
  (* REMOVE_WR_RD_PROT_LOGIC = "0" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* USE_ADV_FEATURES = "825765944" *) 
  (* VERSION = "0" *) 
  (* WAKEUP_TIME = "0" *) 
  (* WIDTH_RATIO = "1" *) 
  (* WRITE_DATA_WIDTH = "451" *) 
  (* WR_DATA_COUNT_WIDTH = "7" *) 
  (* WR_DC_WIDTH_EXT = "7" *) 
  (* WR_DEPTH_LOG = "6" *) 
  (* WR_PNTR_WIDTH = "6" *) 
  (* WR_RD_RATIO = "0" *) 
  (* WR_WIDTH_LOG = "9" *) 
  (* XPM_MODULE = "TRUE" *) 
  (* both_stages_valid = "3" *) 
  (* invalid = "0" *) 
  (* stage1_valid = "2" *) 
  (* stage2_valid = "1" *) 
  input_arbiter_fifo_xpm_fifo_base xpm_fifo_base_inst
       (.almost_empty(almost_empty_axis),
        .almost_full(almost_full_axis),
        .data_valid(data_valid_axis),
        .dbiterr(NLW_xpm_fifo_base_inst_dbiterr_UNCONNECTED),
        .din({s_axis_tlast,s_axis_tuser,1'b0,1'b0,s_axis_tkeep,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s_axis_tdata}),
        .dout({m_axis_tlast,m_axis_tuser,NLW_xpm_fifo_base_inst_dout_UNCONNECTED[321:320],m_axis_tkeep,NLW_xpm_fifo_base_inst_dout_UNCONNECTED[287:256],m_axis_tdata}),
        .empty(NLW_xpm_fifo_base_inst_empty_UNCONNECTED),
        .full(NLW_xpm_fifo_base_inst_full_UNCONNECTED),
        .full_n(s_axis_tready),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .overflow(NLW_xpm_fifo_base_inst_overflow_UNCONNECTED),
        .prog_empty(NLW_xpm_fifo_base_inst_prog_empty_UNCONNECTED),
        .prog_full(NLW_xpm_fifo_base_inst_prog_full_UNCONNECTED),
        .rd_clk(1'b0),
        .rd_data_count(NLW_xpm_fifo_base_inst_rd_data_count_UNCONNECTED[6:0]),
        .rd_en(axis_rd_eop1),
        .rd_rst_busy(NLW_xpm_fifo_base_inst_rd_rst_busy_UNCONNECTED),
        .rst(rst_axis),
        .sbiterr(NLW_xpm_fifo_base_inst_sbiterr_UNCONNECTED),
        .sleep(1'b0),
        .underflow(NLW_xpm_fifo_base_inst_underflow_UNCONNECTED),
        .wr_ack(NLW_xpm_fifo_base_inst_wr_ack_UNCONNECTED),
        .wr_clk(s_aclk),
        .wr_data_count(NLW_xpm_fifo_base_inst_wr_data_count_UNCONNECTED[6:0]),
        .wr_en(s_axis_tvalid),
        .wr_rst_busy(NLW_xpm_fifo_base_inst_wr_rst_busy_UNCONNECTED));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'h80)) 
    xpm_fifo_base_inst_i_1
       (.I0(axis_pkt_read),
        .I1(data_valid_axis),
        .I2(m_axis_tready),
        .O(axis_rd_eop1));
endmodule

(* CASCADE_HEIGHT = "0" *) (* CDC_DEST_SYNC_FF = "3" *) (* COMMON_CLOCK = "1" *) 
(* DOUT_RESET_VALUE = "" *) (* ECC_MODE = "0" *) (* ENABLE_ECC = "0" *) 
(* EN_ADV_FEATURE = "16'b0001100000001000" *) (* EN_AE = "1'b1" *) (* EN_AF = "1'b1" *) 
(* EN_DVLD = "1'b1" *) (* EN_OF = "1'b0" *) (* EN_PE = "1'b0" *) 
(* EN_PF = "1'b0" *) (* EN_RDC = "1'b0" *) (* EN_UF = "1'b0" *) 
(* EN_WACK = "1'b0" *) (* EN_WDC = "1'b0" *) (* FG_EQ_ASYM_DOUT = "1'b0" *) 
(* FIFO_MEMORY_TYPE = "0" *) (* FIFO_MEM_TYPE = "0" *) (* FIFO_READ_DEPTH = "64" *) 
(* FIFO_READ_LATENCY = "0" *) (* FIFO_SIZE = "28864" *) (* FIFO_WRITE_DEPTH = "64" *) 
(* FULL_RESET_VALUE = "1" *) (* FULL_RST_VAL = "1'b1" *) (* ORIG_REF_NAME = "xpm_fifo_base" *) 
(* PE_THRESH_ADJ = "3" *) (* PE_THRESH_MAX = "59" *) (* PE_THRESH_MIN = "5" *) 
(* PF_THRESH_ADJ = "9" *) (* PF_THRESH_MAX = "59" *) (* PF_THRESH_MIN = "5" *) 
(* PROG_EMPTY_THRESH = "5" *) (* PROG_FULL_THRESH = "11" *) (* RD_DATA_COUNT_WIDTH = "7" *) 
(* RD_DC_WIDTH_EXT = "7" *) (* RD_LATENCY = "2" *) (* RD_MODE = "1" *) 
(* RD_PNTR_WIDTH = "6" *) (* READ_DATA_WIDTH = "451" *) (* READ_MODE = "1" *) 
(* RELATED_CLOCKS = "0" *) (* REMOVE_WR_RD_PROT_LOGIC = "0" *) (* SIM_ASSERT_CHK = "0" *) 
(* USE_ADV_FEATURES = "825765944" *) (* VERSION = "0" *) (* WAKEUP_TIME = "0" *) 
(* WIDTH_RATIO = "1" *) (* WRITE_DATA_WIDTH = "451" *) (* WR_DATA_COUNT_WIDTH = "7" *) 
(* WR_DC_WIDTH_EXT = "7" *) (* WR_DEPTH_LOG = "6" *) (* WR_PNTR_WIDTH = "6" *) 
(* WR_RD_RATIO = "0" *) (* WR_WIDTH_LOG = "9" *) (* XPM_MODULE = "TRUE" *) 
(* both_stages_valid = "3" *) (* invalid = "0" *) (* keep_hierarchy = "soft" *) 
(* stage1_valid = "2" *) (* stage2_valid = "1" *) 
module input_arbiter_fifo_xpm_fifo_base
   (sleep,
    rst,
    wr_clk,
    wr_en,
    din,
    full,
    full_n,
    prog_full,
    wr_data_count,
    overflow,
    wr_rst_busy,
    almost_full,
    wr_ack,
    rd_clk,
    rd_en,
    dout,
    empty,
    prog_empty,
    rd_data_count,
    underflow,
    rd_rst_busy,
    almost_empty,
    data_valid,
    injectsbiterr,
    injectdbiterr,
    sbiterr,
    dbiterr);
  input sleep;
  input rst;
  input wr_clk;
  input wr_en;
  input [450:0]din;
  output full;
  output full_n;
  output prog_full;
  output [6:0]wr_data_count;
  output overflow;
  output wr_rst_busy;
  output almost_full;
  output wr_ack;
  input rd_clk;
  input rd_en;
  output [450:0]dout;
  output empty;
  output prog_empty;
  output [6:0]rd_data_count;
  output underflow;
  output rd_rst_busy;
  output almost_empty;
  output data_valid;
  input injectsbiterr;
  input injectdbiterr;
  output sbiterr;
  output dbiterr;

  wire \<const0> ;
  wire aempty_fwft_i0;
  wire almost_empty;
  wire almost_full;
  wire clr_full;
  wire [5:0]count_value_i__0;
  wire [1:0]curr_fwft_state;
  wire data_valid;
  wire data_valid_fwft1;
  wire [450:0]din;
  wire [450:0]\^dout ;
  wire full_n;
  wire \gen_fwft.empty_fwft_i_reg_n_0 ;
  wire \gen_fwft.gdvld_fwft.data_valid_fwft_i_1_n_0 ;
  wire \gen_fwft.ram_regout_en ;
  wire \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_n_0 ;
  wire going_afull;
  wire going_full1;
  wire leaving_empty0;
  wire [1:0]next_fwft_state__0;
  wire ram_empty_i;
  wire ram_empty_i0;
  wire ram_wr_en_i;
  wire rd_en;
  wire [5:0]rd_pntr_ext;
  wire rdp_inst_n_1;
  wire rdp_inst_n_10;
  wire rdp_inst_n_11;
  wire rdpp1_inst_n_0;
  wire rdpp1_inst_n_1;
  wire rdpp1_inst_n_2;
  wire rdpp1_inst_n_3;
  wire rdpp1_inst_n_4;
  wire rdpp1_inst_n_5;
  wire rst;
  wire rst_d1;
  wire sleep;
  wire wr_clk;
  wire wr_en;
  wire [5:0]wr_pntr_ext;
  wire wrpp2_inst_n_0;
  wire wrpp2_inst_n_1;
  wire wrpp2_inst_n_2;
  wire wrpp2_inst_n_3;
  wire wrpp2_inst_n_4;
  wire wrpp2_inst_n_5;
  wire xpm_fifo_rst_inst_n_0;
  wire xpm_fifo_rst_inst_n_2;
  wire \NLW_gen_sdpram.xpm_memory_base_inst_dbiterra_UNCONNECTED ;
  wire \NLW_gen_sdpram.xpm_memory_base_inst_dbiterrb_UNCONNECTED ;
  wire \NLW_gen_sdpram.xpm_memory_base_inst_sbiterra_UNCONNECTED ;
  wire \NLW_gen_sdpram.xpm_memory_base_inst_sbiterrb_UNCONNECTED ;
  wire [450:0]\NLW_gen_sdpram.xpm_memory_base_inst_douta_UNCONNECTED ;
  wire [321:256]\NLW_gen_sdpram.xpm_memory_base_inst_doutb_UNCONNECTED ;

  assign dbiterr = \<const0> ;
  assign dout[450:322] = \^dout [450:322];
  assign dout[321] = \<const0> ;
  assign dout[320] = \<const0> ;
  assign dout[319:288] = \^dout [319:288];
  assign dout[287] = \<const0> ;
  assign dout[286] = \<const0> ;
  assign dout[285] = \<const0> ;
  assign dout[284] = \<const0> ;
  assign dout[283] = \<const0> ;
  assign dout[282] = \<const0> ;
  assign dout[281] = \<const0> ;
  assign dout[280] = \<const0> ;
  assign dout[279] = \<const0> ;
  assign dout[278] = \<const0> ;
  assign dout[277] = \<const0> ;
  assign dout[276] = \<const0> ;
  assign dout[275] = \<const0> ;
  assign dout[274] = \<const0> ;
  assign dout[273] = \<const0> ;
  assign dout[272] = \<const0> ;
  assign dout[271] = \<const0> ;
  assign dout[270] = \<const0> ;
  assign dout[269] = \<const0> ;
  assign dout[268] = \<const0> ;
  assign dout[267] = \<const0> ;
  assign dout[266] = \<const0> ;
  assign dout[265] = \<const0> ;
  assign dout[264] = \<const0> ;
  assign dout[263] = \<const0> ;
  assign dout[262] = \<const0> ;
  assign dout[261] = \<const0> ;
  assign dout[260] = \<const0> ;
  assign dout[259] = \<const0> ;
  assign dout[258] = \<const0> ;
  assign dout[257] = \<const0> ;
  assign dout[256] = \<const0> ;
  assign dout[255:0] = \^dout [255:0];
  assign empty = \<const0> ;
  assign full = \<const0> ;
  assign overflow = \<const0> ;
  assign prog_empty = \<const0> ;
  assign prog_full = \<const0> ;
  assign rd_data_count[6] = \<const0> ;
  assign rd_data_count[5] = \<const0> ;
  assign rd_data_count[4] = \<const0> ;
  assign rd_data_count[3] = \<const0> ;
  assign rd_data_count[2] = \<const0> ;
  assign rd_data_count[1] = \<const0> ;
  assign rd_data_count[0] = \<const0> ;
  assign rd_rst_busy = \<const0> ;
  assign sbiterr = \<const0> ;
  assign underflow = \<const0> ;
  assign wr_ack = \<const0> ;
  assign wr_data_count[6] = \<const0> ;
  assign wr_data_count[5] = \<const0> ;
  assign wr_data_count[4] = \<const0> ;
  assign wr_data_count[3] = \<const0> ;
  assign wr_data_count[2] = \<const0> ;
  assign wr_data_count[1] = \<const0> ;
  assign wr_data_count[0] = \<const0> ;
  assign wr_rst_busy = \<const0> ;
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'h6A85)) 
    \FSM_sequential_gen_fwft.curr_fwft_state[0]_i_1 
       (.I0(curr_fwft_state[0]),
        .I1(rd_en),
        .I2(curr_fwft_state[1]),
        .I3(ram_empty_i),
        .O(next_fwft_state__0[0]));
  LUT3 #(
    .INIT(8'h7C)) 
    \FSM_sequential_gen_fwft.curr_fwft_state[1]_i_1 
       (.I0(rd_en),
        .I1(curr_fwft_state[1]),
        .I2(curr_fwft_state[0]),
        .O(next_fwft_state__0[1]));
  (* FSM_ENCODED_STATES = "invalid:00,stage1_valid:01,both_stages_valid:10,stage2_valid:11" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_gen_fwft.curr_fwft_state_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(next_fwft_state__0[0]),
        .Q(curr_fwft_state[0]),
        .R(xpm_fifo_rst_inst_n_2));
  (* FSM_ENCODED_STATES = "invalid:00,stage1_valid:01,both_stages_valid:10,stage2_valid:11" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_gen_fwft.curr_fwft_state_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(next_fwft_state__0[1]),
        .Q(curr_fwft_state[1]),
        .R(xpm_fifo_rst_inst_n_2));
  GND GND
       (.G(\<const0> ));
  LUT4 #(
    .INIT(16'hF380)) 
    \gen_fwft.empty_fwft_i_i_1 
       (.I0(rd_en),
        .I1(curr_fwft_state[0]),
        .I2(curr_fwft_state[1]),
        .I3(\gen_fwft.empty_fwft_i_reg_n_0 ),
        .O(data_valid_fwft1));
  FDSE #(
    .INIT(1'b1)) 
    \gen_fwft.empty_fwft_i_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(data_valid_fwft1),
        .Q(\gen_fwft.empty_fwft_i_reg_n_0 ),
        .S(xpm_fifo_rst_inst_n_2));
  LUT5 #(
    .INIT(32'hFDDD4000)) 
    \gen_fwft.gae_fwft.aempty_fwft_i_i_1 
       (.I0(curr_fwft_state[0]),
        .I1(ram_empty_i),
        .I2(curr_fwft_state[1]),
        .I3(rd_en),
        .I4(almost_empty),
        .O(aempty_fwft_i0));
  FDSE #(
    .INIT(1'b1)) 
    \gen_fwft.gae_fwft.aempty_fwft_i_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(aempty_fwft_i0),
        .Q(almost_empty),
        .S(xpm_fifo_rst_inst_n_2));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'h3575)) 
    \gen_fwft.gdvld_fwft.data_valid_fwft_i_1 
       (.I0(\gen_fwft.empty_fwft_i_reg_n_0 ),
        .I1(curr_fwft_state[1]),
        .I2(curr_fwft_state[0]),
        .I3(rd_en),
        .O(\gen_fwft.gdvld_fwft.data_valid_fwft_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_fwft.gdvld_fwft.data_valid_fwft_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gen_fwft.gdvld_fwft.data_valid_fwft_i_1_n_0 ),
        .Q(data_valid),
        .R(xpm_fifo_rst_inst_n_2));
  FDSE #(
    .INIT(1'b1)) 
    \gen_pntr_flags_cc.gaf_cc.ram_afull_i_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(xpm_fifo_rst_inst_n_0),
        .Q(almost_full),
        .S(xpm_fifo_rst_inst_n_2));
  FDSE #(
    .INIT(1'b1)) 
    \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(rdp_inst_n_10),
        .Q(\gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_n_0 ),
        .S(xpm_fifo_rst_inst_n_2));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(rdp_inst_n_11),
        .Q(full_n),
        .R(xpm_fifo_rst_inst_n_2));
  FDSE #(
    .INIT(1'b1)) 
    \gen_pntr_flags_cc.ram_empty_i_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(ram_empty_i0),
        .Q(ram_empty_i),
        .S(xpm_fifo_rst_inst_n_2));
  (* ADDR_WIDTH_A = "6" *) 
  (* ADDR_WIDTH_B = "6" *) 
  (* AUTO_SLEEP_TIME = "0" *) 
  (* BYTE_WRITE_WIDTH_A = "451" *) 
  (* BYTE_WRITE_WIDTH_B = "451" *) 
  (* CASCADE_HEIGHT = "0" *) 
  (* CLOCKING_MODE = "0" *) 
  (* ECC_MODE = "0" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* MAX_NUM_CHAR = "0" *) 
  (* \MEM.ADDRESS_SPACE  *) 
  (* \MEM.ADDRESS_SPACE_BEGIN  = "0" *) 
  (* \MEM.ADDRESS_SPACE_DATA_LSB  = "0" *) 
  (* \MEM.ADDRESS_SPACE_DATA_MSB  = "416" *) 
  (* \MEM.ADDRESS_SPACE_END  = "511" *) 
  (* \MEM.CORE_MEMORY_WIDTH  = "417" *) 
  (* MEMORY_INIT_FILE = "none" *) 
  (* MEMORY_INIT_PARAM = "" *) 
  (* MEMORY_OPTIMIZATION = "true" *) 
  (* MEMORY_PRIMITIVE = "0" *) 
  (* MEMORY_SIZE = "28864" *) 
  (* MEMORY_TYPE = "1" *) 
  (* MESSAGE_CONTROL = "0" *) 
  (* NUM_CHAR_LOC = "0" *) 
  (* P_ECC_MODE = "no_ecc" *) 
  (* P_ENABLE_BYTE_WRITE_A = "0" *) 
  (* P_ENABLE_BYTE_WRITE_B = "0" *) 
  (* P_MAX_DEPTH_DATA = "64" *) 
  (* P_MEMORY_OPT = "yes" *) 
  (* P_MEMORY_PRIMITIVE = "auto" *) 
  (* P_MIN_WIDTH_DATA = "451" *) 
  (* P_MIN_WIDTH_DATA_A = "451" *) 
  (* P_MIN_WIDTH_DATA_B = "451" *) 
  (* P_MIN_WIDTH_DATA_ECC = "451" *) 
  (* P_MIN_WIDTH_DATA_LDW = "4" *) 
  (* P_MIN_WIDTH_DATA_SHFT = "451" *) 
  (* P_NUM_COLS_WRITE_A = "1" *) 
  (* P_NUM_COLS_WRITE_B = "1" *) 
  (* P_NUM_ROWS_READ_A = "1" *) 
  (* P_NUM_ROWS_READ_B = "1" *) 
  (* P_NUM_ROWS_WRITE_A = "1" *) 
  (* P_NUM_ROWS_WRITE_B = "1" *) 
  (* P_SDP_WRITE_MODE = "yes" *) 
  (* P_WIDTH_ADDR_LSB_READ_A = "0" *) 
  (* P_WIDTH_ADDR_LSB_READ_B = "0" *) 
  (* P_WIDTH_ADDR_LSB_WRITE_A = "0" *) 
  (* P_WIDTH_ADDR_LSB_WRITE_B = "0" *) 
  (* P_WIDTH_ADDR_READ_A = "6" *) 
  (* P_WIDTH_ADDR_READ_B = "6" *) 
  (* P_WIDTH_ADDR_WRITE_A = "6" *) 
  (* P_WIDTH_ADDR_WRITE_B = "6" *) 
  (* P_WIDTH_COL_WRITE_A = "451" *) 
  (* P_WIDTH_COL_WRITE_B = "451" *) 
  (* READ_DATA_WIDTH_A = "451" *) 
  (* READ_DATA_WIDTH_B = "451" *) 
  (* READ_LATENCY_A = "2" *) 
  (* READ_LATENCY_B = "2" *) 
  (* READ_RESET_VALUE_A = "0" *) 
  (* READ_RESET_VALUE_B = "" *) 
  (* RST_MODE_A = "SYNC" *) 
  (* RST_MODE_B = "SYNC" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* USE_EMBEDDED_CONSTRAINT = "0" *) 
  (* USE_MEM_INIT = "0" *) 
  (* USE_MEM_INIT_MMI = "0" *) 
  (* VERSION = "0" *) 
  (* WAKEUP_TIME = "0" *) 
  (* WRITE_DATA_WIDTH_A = "451" *) 
  (* WRITE_DATA_WIDTH_B = "451" *) 
  (* WRITE_MODE_A = "2" *) 
  (* WRITE_MODE_B = "2" *) 
  (* WRITE_PROTECT = "1" *) 
  (* XPM_MODULE = "TRUE" *) 
  (* rsta_loop_iter = "452" *) 
  (* rstb_loop_iter = "452" *) 
  input_arbiter_fifo_xpm_memory_base \gen_sdpram.xpm_memory_base_inst 
       (.addra(wr_pntr_ext),
        .addrb(rd_pntr_ext),
        .clka(wr_clk),
        .clkb(1'b0),
        .dbiterra(\NLW_gen_sdpram.xpm_memory_base_inst_dbiterra_UNCONNECTED ),
        .dbiterrb(\NLW_gen_sdpram.xpm_memory_base_inst_dbiterrb_UNCONNECTED ),
        .dina({din[450:322],1'b0,1'b0,din[319:288],1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,din[255:0]}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(\NLW_gen_sdpram.xpm_memory_base_inst_douta_UNCONNECTED [450:0]),
        .doutb(\^dout ),
        .ena(1'b0),
        .enb(rdp_inst_n_1),
        .injectdbiterra(1'b0),
        .injectdbiterrb(1'b0),
        .injectsbiterra(1'b0),
        .injectsbiterrb(1'b0),
        .regcea(1'b0),
        .regceb(\gen_fwft.ram_regout_en ),
        .rsta(1'b0),
        .rstb(xpm_fifo_rst_inst_n_2),
        .sbiterra(\NLW_gen_sdpram.xpm_memory_base_inst_sbiterra_UNCONNECTED ),
        .sbiterrb(\NLW_gen_sdpram.xpm_memory_base_inst_sbiterrb_UNCONNECTED ),
        .sleep(sleep),
        .wea(ram_wr_en_i),
        .web(1'b0));
  LUT3 #(
    .INIT(8'h62)) 
    \gen_sdpram.xpm_memory_base_inst_i_3 
       (.I0(curr_fwft_state[0]),
        .I1(curr_fwft_state[1]),
        .I2(rd_en),
        .O(\gen_fwft.ram_regout_en ));
  input_arbiter_fifo_xpm_counter_updn__parameterized2 rdp_inst
       (.\FSM_sequential_gen_fwft.curr_fwft_state_reg[1] (rdp_inst_n_1),
        .Q(rd_pntr_ext),
        .clr_full(clr_full),
        .\count_value_i_reg[0]_0 (curr_fwft_state),
        .\count_value_i_reg[5]_0 (xpm_fifo_rst_inst_n_2),
        .\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0 ({wrpp2_inst_n_0,wrpp2_inst_n_1,wrpp2_inst_n_2,wrpp2_inst_n_3,wrpp2_inst_n_4,wrpp2_inst_n_5}),
        .\gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg (rdp_inst_n_10),
        .\gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_0 (rdp_inst_n_11),
        .\gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_1 (\gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_n_0 ),
        .\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_3_0 (wr_pntr_ext),
        .\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_4_0 (count_value_i__0),
        .going_afull(going_afull),
        .going_full1(going_full1),
        .leaving_empty0(leaving_empty0),
        .ram_empty_i(ram_empty_i),
        .ram_wr_en_i(ram_wr_en_i),
        .rd_en(rd_en),
        .wr_clk(wr_clk));
  input_arbiter_fifo_xpm_counter_updn__parameterized3 rdpp1_inst
       (.E(rdp_inst_n_1),
        .Q({rdpp1_inst_n_0,rdpp1_inst_n_1,rdpp1_inst_n_2,rdpp1_inst_n_3,rdpp1_inst_n_4,rdpp1_inst_n_5}),
        .\count_value_i_reg[1]_0 (curr_fwft_state),
        .\count_value_i_reg[1]_1 (xpm_fifo_rst_inst_n_2),
        .ram_empty_i(ram_empty_i),
        .rd_en(rd_en),
        .wr_clk(wr_clk));
  input_arbiter_fifo_xpm_fifo_reg_bit rst_d1_inst
       (.Q(xpm_fifo_rst_inst_n_2),
        .clr_full(clr_full),
        .rst(rst),
        .rst_d1(rst_d1),
        .wr_clk(wr_clk));
  input_arbiter_fifo_xpm_counter_updn__parameterized2_0 wrp_inst
       (.Q(wr_pntr_ext),
        .\count_value_i_reg[0]_0 (xpm_fifo_rst_inst_n_2),
        .\count_value_i_reg[5]_0 (\gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_n_0 ),
        .\gen_pntr_flags_cc.ram_empty_i_reg (rdp_inst_n_1),
        .\gen_pntr_flags_cc.ram_empty_i_reg_0 ({rdpp1_inst_n_0,rdpp1_inst_n_1,rdpp1_inst_n_2,rdpp1_inst_n_3,rdpp1_inst_n_4,rdpp1_inst_n_5}),
        .leaving_empty0(leaving_empty0),
        .ram_empty_i(ram_empty_i),
        .ram_empty_i0(ram_empty_i0),
        .ram_wr_en_i(ram_wr_en_i),
        .rst_d1(rst_d1),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
  input_arbiter_fifo_xpm_counter_updn__parameterized3_1 wrpp1_inst
       (.Q(count_value_i__0),
        .\count_value_i_reg[1]_0 (xpm_fifo_rst_inst_n_2),
        .\count_value_i_reg[5]_0 (\gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_n_0 ),
        .ram_wr_en_i(ram_wr_en_i),
        .rst_d1(rst_d1),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
  input_arbiter_fifo_xpm_counter_updn__parameterized0 wrpp2_inst
       (.Q({wrpp2_inst_n_0,wrpp2_inst_n_1,wrpp2_inst_n_2,wrpp2_inst_n_3,wrpp2_inst_n_4,wrpp2_inst_n_5}),
        .\count_value_i_reg[1]_0 (xpm_fifo_rst_inst_n_2),
        .\count_value_i_reg[5]_0 (\gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_n_0 ),
        .ram_wr_en_i(ram_wr_en_i),
        .rst_d1(rst_d1),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
  input_arbiter_fifo_xpm_fifo_rst xpm_fifo_rst_inst
       (.Q(curr_fwft_state),
        .almost_full(almost_full),
        .\count_value_i_reg[5] (\gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_n_0 ),
        .\gen_rst_cc.fifo_wr_rst_cc_reg[2]_0 (xpm_fifo_rst_inst_n_2),
        .going_afull(going_afull),
        .going_full1(going_full1),
        .ram_empty_i(ram_empty_i),
        .ram_wr_en_i(ram_wr_en_i),
        .rd_en(rd_en),
        .rst(rst),
        .rst_d1(rst_d1),
        .\syncstages_ff_reg[3] (xpm_fifo_rst_inst_n_0),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
endmodule

(* ORIG_REF_NAME = "xpm_fifo_reg_bit" *) 
module input_arbiter_fifo_xpm_fifo_reg_bit
   (rst_d1,
    clr_full,
    Q,
    wr_clk,
    rst);
  output rst_d1;
  output clr_full;
  input [0:0]Q;
  input wr_clk;
  input rst;

  wire [0:0]Q;
  wire clr_full;
  wire rst;
  wire rst_d1;
  wire wr_clk;

  FDRE #(
    .INIT(1'b0)) 
    d_out_reg
       (.C(wr_clk),
        .CE(1'b1),
        .D(Q),
        .Q(rst_d1),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h04)) 
    \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_2 
       (.I0(rst),
        .I1(rst_d1),
        .I2(Q),
        .O(clr_full));
endmodule

(* ORIG_REF_NAME = "xpm_fifo_rst" *) 
module input_arbiter_fifo_xpm_fifo_rst
   (\syncstages_ff_reg[3] ,
    ram_wr_en_i,
    \gen_rst_cc.fifo_wr_rst_cc_reg[2]_0 ,
    going_full1,
    going_afull,
    rst,
    almost_full,
    ram_empty_i,
    rd_en,
    Q,
    wr_en,
    \count_value_i_reg[5] ,
    rst_d1,
    wr_clk);
  output \syncstages_ff_reg[3] ;
  output ram_wr_en_i;
  output [0:0]\gen_rst_cc.fifo_wr_rst_cc_reg[2]_0 ;
  input going_full1;
  input going_afull;
  input rst;
  input almost_full;
  input ram_empty_i;
  input rd_en;
  input [1:0]Q;
  input wr_en;
  input \count_value_i_reg[5] ;
  input rst_d1;
  input wr_clk;

  wire [1:0]Q;
  wire almost_full;
  wire \count_value_i_reg[5] ;
  wire \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_2_n_0 ;
  wire \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_4_n_0 ;
  wire [1:0]\gen_rst_cc.fifo_wr_rst_cc ;
  wire [0:0]\gen_rst_cc.fifo_wr_rst_cc_reg[2]_0 ;
  wire going_afull;
  wire going_full1;
  wire p_0_in;
  wire \power_on_rst_reg_n_0_[0] ;
  wire ram_empty_i;
  wire ram_wr_en_i;
  wire rd_en;
  wire rst;
  wire rst_d1;
  wire rst_i;
  wire \syncstages_ff_reg[3] ;
  wire wr_clk;
  wire wr_en;

  LUT6 #(
    .INIT(64'h00FF00F7000000F0)) 
    \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_1 
       (.I0(\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_2_n_0 ),
        .I1(going_full1),
        .I2(going_afull),
        .I3(\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_4_n_0 ),
        .I4(rst),
        .I5(almost_full),
        .O(\syncstages_ff_reg[3] ));
  LUT5 #(
    .INIT(32'h00005455)) 
    \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_2 
       (.I0(ram_empty_i),
        .I1(rd_en),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(ram_wr_en_i),
        .O(\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_4 
       (.I0(\gen_rst_cc.fifo_wr_rst_cc_reg[2]_0 ),
        .I1(rst_d1),
        .I2(rst),
        .O(\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_4_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \gen_rst_cc.fifo_wr_rst_cc[2]_i_1 
       (.I0(p_0_in),
        .I1(rst),
        .O(rst_i));
  FDSE #(
    .INIT(1'b0)) 
    \gen_rst_cc.fifo_wr_rst_cc_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(1'b0),
        .Q(\gen_rst_cc.fifo_wr_rst_cc [0]),
        .S(rst_i));
  FDSE #(
    .INIT(1'b0)) 
    \gen_rst_cc.fifo_wr_rst_cc_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gen_rst_cc.fifo_wr_rst_cc [0]),
        .Q(\gen_rst_cc.fifo_wr_rst_cc [1]),
        .S(rst_i));
  FDSE #(
    .INIT(1'b0)) 
    \gen_rst_cc.fifo_wr_rst_cc_reg[2] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gen_rst_cc.fifo_wr_rst_cc [1]),
        .Q(\gen_rst_cc.fifo_wr_rst_cc_reg[2]_0 ),
        .S(rst_i));
  LUT4 #(
    .INIT(16'h0002)) 
    \gen_sdpram.xpm_memory_base_inst_i_1 
       (.I0(wr_en),
        .I1(\count_value_i_reg[5] ),
        .I2(\gen_rst_cc.fifo_wr_rst_cc_reg[2]_0 ),
        .I3(rst_d1),
        .O(ram_wr_en_i));
  FDRE #(
    .INIT(1'b1)) 
    \power_on_rst_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(1'b0),
        .Q(\power_on_rst_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \power_on_rst_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\power_on_rst_reg_n_0_[0] ),
        .Q(p_0_in),
        .R(1'b0));
endmodule

(* ADDR_WIDTH_A = "6" *) (* ADDR_WIDTH_B = "6" *) (* AUTO_SLEEP_TIME = "0" *) 
(* BYTE_WRITE_WIDTH_A = "451" *) (* BYTE_WRITE_WIDTH_B = "451" *) (* CASCADE_HEIGHT = "0" *) 
(* CLOCKING_MODE = "0" *) (* ECC_MODE = "0" *) (* MAX_NUM_CHAR = "0" *) 
(* MEMORY_INIT_FILE = "none" *) (* MEMORY_INIT_PARAM = "" *) (* MEMORY_OPTIMIZATION = "true" *) 
(* MEMORY_PRIMITIVE = "0" *) (* MEMORY_SIZE = "28864" *) (* MEMORY_TYPE = "1" *) 
(* MESSAGE_CONTROL = "0" *) (* NUM_CHAR_LOC = "0" *) (* ORIG_REF_NAME = "xpm_memory_base" *) 
(* P_ECC_MODE = "no_ecc" *) (* P_ENABLE_BYTE_WRITE_A = "0" *) (* P_ENABLE_BYTE_WRITE_B = "0" *) 
(* P_MAX_DEPTH_DATA = "64" *) (* P_MEMORY_OPT = "yes" *) (* P_MEMORY_PRIMITIVE = "auto" *) 
(* P_MIN_WIDTH_DATA = "451" *) (* P_MIN_WIDTH_DATA_A = "451" *) (* P_MIN_WIDTH_DATA_B = "451" *) 
(* P_MIN_WIDTH_DATA_ECC = "451" *) (* P_MIN_WIDTH_DATA_LDW = "4" *) (* P_MIN_WIDTH_DATA_SHFT = "451" *) 
(* P_NUM_COLS_WRITE_A = "1" *) (* P_NUM_COLS_WRITE_B = "1" *) (* P_NUM_ROWS_READ_A = "1" *) 
(* P_NUM_ROWS_READ_B = "1" *) (* P_NUM_ROWS_WRITE_A = "1" *) (* P_NUM_ROWS_WRITE_B = "1" *) 
(* P_SDP_WRITE_MODE = "yes" *) (* P_WIDTH_ADDR_LSB_READ_A = "0" *) (* P_WIDTH_ADDR_LSB_READ_B = "0" *) 
(* P_WIDTH_ADDR_LSB_WRITE_A = "0" *) (* P_WIDTH_ADDR_LSB_WRITE_B = "0" *) (* P_WIDTH_ADDR_READ_A = "6" *) 
(* P_WIDTH_ADDR_READ_B = "6" *) (* P_WIDTH_ADDR_WRITE_A = "6" *) (* P_WIDTH_ADDR_WRITE_B = "6" *) 
(* P_WIDTH_COL_WRITE_A = "451" *) (* P_WIDTH_COL_WRITE_B = "451" *) (* READ_DATA_WIDTH_A = "451" *) 
(* READ_DATA_WIDTH_B = "451" *) (* READ_LATENCY_A = "2" *) (* READ_LATENCY_B = "2" *) 
(* READ_RESET_VALUE_A = "0" *) (* READ_RESET_VALUE_B = "" *) (* RST_MODE_A = "SYNC" *) 
(* RST_MODE_B = "SYNC" *) (* SIM_ASSERT_CHK = "0" *) (* USE_EMBEDDED_CONSTRAINT = "0" *) 
(* USE_MEM_INIT = "0" *) (* USE_MEM_INIT_MMI = "0" *) (* VERSION = "0" *) 
(* WAKEUP_TIME = "0" *) (* WRITE_DATA_WIDTH_A = "451" *) (* WRITE_DATA_WIDTH_B = "451" *) 
(* WRITE_MODE_A = "2" *) (* WRITE_MODE_B = "2" *) (* WRITE_PROTECT = "1" *) 
(* XPM_MODULE = "TRUE" *) (* keep_hierarchy = "soft" *) (* rsta_loop_iter = "452" *) 
(* rstb_loop_iter = "452" *) 
module input_arbiter_fifo_xpm_memory_base
   (sleep,
    clka,
    rsta,
    ena,
    regcea,
    wea,
    addra,
    dina,
    injectsbiterra,
    injectdbiterra,
    douta,
    sbiterra,
    dbiterra,
    clkb,
    rstb,
    enb,
    regceb,
    web,
    addrb,
    dinb,
    injectsbiterrb,
    injectdbiterrb,
    doutb,
    sbiterrb,
    dbiterrb);
  input sleep;
  input clka;
  input rsta;
  input ena;
  input regcea;
  input [0:0]wea;
  input [5:0]addra;
  input [450:0]dina;
  input injectsbiterra;
  input injectdbiterra;
  output [450:0]douta;
  output sbiterra;
  output dbiterra;
  input clkb;
  input rstb;
  input enb;
  input regceb;
  input [0:0]web;
  input [5:0]addrb;
  input [450:0]dinb;
  input injectsbiterrb;
  input injectdbiterrb;
  output [450:0]doutb;
  output sbiterrb;
  output dbiterrb;

  wire \<const0> ;
  wire [5:0]addra;
  wire [5:0]addrb;
  wire clka;
  wire [450:0]dina;
  wire [450:0]\^doutb ;
  wire enb;
  wire regceb;
  wire rstb;
  wire sleep;
  wire [0:0]wea;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_0_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_0_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_0_DBITERR_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_0_SBITERR_UNCONNECTED ;
  wire [7:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_RDADDRECC_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_1_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_1_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_1_DBITERR_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_1_SBITERR_UNCONNECTED ;
  wire [7:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_1_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_1_RDADDRECC_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_2_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_2_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_2_DBITERR_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_2_SBITERR_UNCONNECTED ;
  wire [7:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_2_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_2_RDADDRECC_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_3_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_3_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_3_DBITERR_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_3_SBITERR_UNCONNECTED ;
  wire [7:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_3_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_3_RDADDRECC_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_4_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_4_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_4_DBITERR_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_4_SBITERR_UNCONNECTED ;
  wire [7:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_4_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_4_RDADDRECC_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_5_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_5_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_5_DBITERR_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_5_SBITERR_UNCONNECTED ;
  wire [31:25]\NLW_gen_wr_a.gen_word_narrow.mem_reg_5_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_5_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_5_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_5_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_5_RDADDRECC_UNCONNECTED ;

  assign dbiterra = \<const0> ;
  assign dbiterrb = \<const0> ;
  assign douta[450] = \<const0> ;
  assign douta[449] = \<const0> ;
  assign douta[448] = \<const0> ;
  assign douta[447] = \<const0> ;
  assign douta[446] = \<const0> ;
  assign douta[445] = \<const0> ;
  assign douta[444] = \<const0> ;
  assign douta[443] = \<const0> ;
  assign douta[442] = \<const0> ;
  assign douta[441] = \<const0> ;
  assign douta[440] = \<const0> ;
  assign douta[439] = \<const0> ;
  assign douta[438] = \<const0> ;
  assign douta[437] = \<const0> ;
  assign douta[436] = \<const0> ;
  assign douta[435] = \<const0> ;
  assign douta[434] = \<const0> ;
  assign douta[433] = \<const0> ;
  assign douta[432] = \<const0> ;
  assign douta[431] = \<const0> ;
  assign douta[430] = \<const0> ;
  assign douta[429] = \<const0> ;
  assign douta[428] = \<const0> ;
  assign douta[427] = \<const0> ;
  assign douta[426] = \<const0> ;
  assign douta[425] = \<const0> ;
  assign douta[424] = \<const0> ;
  assign douta[423] = \<const0> ;
  assign douta[422] = \<const0> ;
  assign douta[421] = \<const0> ;
  assign douta[420] = \<const0> ;
  assign douta[419] = \<const0> ;
  assign douta[418] = \<const0> ;
  assign douta[417] = \<const0> ;
  assign douta[416] = \<const0> ;
  assign douta[415] = \<const0> ;
  assign douta[414] = \<const0> ;
  assign douta[413] = \<const0> ;
  assign douta[412] = \<const0> ;
  assign douta[411] = \<const0> ;
  assign douta[410] = \<const0> ;
  assign douta[409] = \<const0> ;
  assign douta[408] = \<const0> ;
  assign douta[407] = \<const0> ;
  assign douta[406] = \<const0> ;
  assign douta[405] = \<const0> ;
  assign douta[404] = \<const0> ;
  assign douta[403] = \<const0> ;
  assign douta[402] = \<const0> ;
  assign douta[401] = \<const0> ;
  assign douta[400] = \<const0> ;
  assign douta[399] = \<const0> ;
  assign douta[398] = \<const0> ;
  assign douta[397] = \<const0> ;
  assign douta[396] = \<const0> ;
  assign douta[395] = \<const0> ;
  assign douta[394] = \<const0> ;
  assign douta[393] = \<const0> ;
  assign douta[392] = \<const0> ;
  assign douta[391] = \<const0> ;
  assign douta[390] = \<const0> ;
  assign douta[389] = \<const0> ;
  assign douta[388] = \<const0> ;
  assign douta[387] = \<const0> ;
  assign douta[386] = \<const0> ;
  assign douta[385] = \<const0> ;
  assign douta[384] = \<const0> ;
  assign douta[383] = \<const0> ;
  assign douta[382] = \<const0> ;
  assign douta[381] = \<const0> ;
  assign douta[380] = \<const0> ;
  assign douta[379] = \<const0> ;
  assign douta[378] = \<const0> ;
  assign douta[377] = \<const0> ;
  assign douta[376] = \<const0> ;
  assign douta[375] = \<const0> ;
  assign douta[374] = \<const0> ;
  assign douta[373] = \<const0> ;
  assign douta[372] = \<const0> ;
  assign douta[371] = \<const0> ;
  assign douta[370] = \<const0> ;
  assign douta[369] = \<const0> ;
  assign douta[368] = \<const0> ;
  assign douta[367] = \<const0> ;
  assign douta[366] = \<const0> ;
  assign douta[365] = \<const0> ;
  assign douta[364] = \<const0> ;
  assign douta[363] = \<const0> ;
  assign douta[362] = \<const0> ;
  assign douta[361] = \<const0> ;
  assign douta[360] = \<const0> ;
  assign douta[359] = \<const0> ;
  assign douta[358] = \<const0> ;
  assign douta[357] = \<const0> ;
  assign douta[356] = \<const0> ;
  assign douta[355] = \<const0> ;
  assign douta[354] = \<const0> ;
  assign douta[353] = \<const0> ;
  assign douta[352] = \<const0> ;
  assign douta[351] = \<const0> ;
  assign douta[350] = \<const0> ;
  assign douta[349] = \<const0> ;
  assign douta[348] = \<const0> ;
  assign douta[347] = \<const0> ;
  assign douta[346] = \<const0> ;
  assign douta[345] = \<const0> ;
  assign douta[344] = \<const0> ;
  assign douta[343] = \<const0> ;
  assign douta[342] = \<const0> ;
  assign douta[341] = \<const0> ;
  assign douta[340] = \<const0> ;
  assign douta[339] = \<const0> ;
  assign douta[338] = \<const0> ;
  assign douta[337] = \<const0> ;
  assign douta[336] = \<const0> ;
  assign douta[335] = \<const0> ;
  assign douta[334] = \<const0> ;
  assign douta[333] = \<const0> ;
  assign douta[332] = \<const0> ;
  assign douta[331] = \<const0> ;
  assign douta[330] = \<const0> ;
  assign douta[329] = \<const0> ;
  assign douta[328] = \<const0> ;
  assign douta[327] = \<const0> ;
  assign douta[326] = \<const0> ;
  assign douta[325] = \<const0> ;
  assign douta[324] = \<const0> ;
  assign douta[323] = \<const0> ;
  assign douta[322] = \<const0> ;
  assign douta[321] = \<const0> ;
  assign douta[320] = \<const0> ;
  assign douta[319] = \<const0> ;
  assign douta[318] = \<const0> ;
  assign douta[317] = \<const0> ;
  assign douta[316] = \<const0> ;
  assign douta[315] = \<const0> ;
  assign douta[314] = \<const0> ;
  assign douta[313] = \<const0> ;
  assign douta[312] = \<const0> ;
  assign douta[311] = \<const0> ;
  assign douta[310] = \<const0> ;
  assign douta[309] = \<const0> ;
  assign douta[308] = \<const0> ;
  assign douta[307] = \<const0> ;
  assign douta[306] = \<const0> ;
  assign douta[305] = \<const0> ;
  assign douta[304] = \<const0> ;
  assign douta[303] = \<const0> ;
  assign douta[302] = \<const0> ;
  assign douta[301] = \<const0> ;
  assign douta[300] = \<const0> ;
  assign douta[299] = \<const0> ;
  assign douta[298] = \<const0> ;
  assign douta[297] = \<const0> ;
  assign douta[296] = \<const0> ;
  assign douta[295] = \<const0> ;
  assign douta[294] = \<const0> ;
  assign douta[293] = \<const0> ;
  assign douta[292] = \<const0> ;
  assign douta[291] = \<const0> ;
  assign douta[290] = \<const0> ;
  assign douta[289] = \<const0> ;
  assign douta[288] = \<const0> ;
  assign douta[287] = \<const0> ;
  assign douta[286] = \<const0> ;
  assign douta[285] = \<const0> ;
  assign douta[284] = \<const0> ;
  assign douta[283] = \<const0> ;
  assign douta[282] = \<const0> ;
  assign douta[281] = \<const0> ;
  assign douta[280] = \<const0> ;
  assign douta[279] = \<const0> ;
  assign douta[278] = \<const0> ;
  assign douta[277] = \<const0> ;
  assign douta[276] = \<const0> ;
  assign douta[275] = \<const0> ;
  assign douta[274] = \<const0> ;
  assign douta[273] = \<const0> ;
  assign douta[272] = \<const0> ;
  assign douta[271] = \<const0> ;
  assign douta[270] = \<const0> ;
  assign douta[269] = \<const0> ;
  assign douta[268] = \<const0> ;
  assign douta[267] = \<const0> ;
  assign douta[266] = \<const0> ;
  assign douta[265] = \<const0> ;
  assign douta[264] = \<const0> ;
  assign douta[263] = \<const0> ;
  assign douta[262] = \<const0> ;
  assign douta[261] = \<const0> ;
  assign douta[260] = \<const0> ;
  assign douta[259] = \<const0> ;
  assign douta[258] = \<const0> ;
  assign douta[257] = \<const0> ;
  assign douta[256] = \<const0> ;
  assign douta[255] = \<const0> ;
  assign douta[254] = \<const0> ;
  assign douta[253] = \<const0> ;
  assign douta[252] = \<const0> ;
  assign douta[251] = \<const0> ;
  assign douta[250] = \<const0> ;
  assign douta[249] = \<const0> ;
  assign douta[248] = \<const0> ;
  assign douta[247] = \<const0> ;
  assign douta[246] = \<const0> ;
  assign douta[245] = \<const0> ;
  assign douta[244] = \<const0> ;
  assign douta[243] = \<const0> ;
  assign douta[242] = \<const0> ;
  assign douta[241] = \<const0> ;
  assign douta[240] = \<const0> ;
  assign douta[239] = \<const0> ;
  assign douta[238] = \<const0> ;
  assign douta[237] = \<const0> ;
  assign douta[236] = \<const0> ;
  assign douta[235] = \<const0> ;
  assign douta[234] = \<const0> ;
  assign douta[233] = \<const0> ;
  assign douta[232] = \<const0> ;
  assign douta[231] = \<const0> ;
  assign douta[230] = \<const0> ;
  assign douta[229] = \<const0> ;
  assign douta[228] = \<const0> ;
  assign douta[227] = \<const0> ;
  assign douta[226] = \<const0> ;
  assign douta[225] = \<const0> ;
  assign douta[224] = \<const0> ;
  assign douta[223] = \<const0> ;
  assign douta[222] = \<const0> ;
  assign douta[221] = \<const0> ;
  assign douta[220] = \<const0> ;
  assign douta[219] = \<const0> ;
  assign douta[218] = \<const0> ;
  assign douta[217] = \<const0> ;
  assign douta[216] = \<const0> ;
  assign douta[215] = \<const0> ;
  assign douta[214] = \<const0> ;
  assign douta[213] = \<const0> ;
  assign douta[212] = \<const0> ;
  assign douta[211] = \<const0> ;
  assign douta[210] = \<const0> ;
  assign douta[209] = \<const0> ;
  assign douta[208] = \<const0> ;
  assign douta[207] = \<const0> ;
  assign douta[206] = \<const0> ;
  assign douta[205] = \<const0> ;
  assign douta[204] = \<const0> ;
  assign douta[203] = \<const0> ;
  assign douta[202] = \<const0> ;
  assign douta[201] = \<const0> ;
  assign douta[200] = \<const0> ;
  assign douta[199] = \<const0> ;
  assign douta[198] = \<const0> ;
  assign douta[197] = \<const0> ;
  assign douta[196] = \<const0> ;
  assign douta[195] = \<const0> ;
  assign douta[194] = \<const0> ;
  assign douta[193] = \<const0> ;
  assign douta[192] = \<const0> ;
  assign douta[191] = \<const0> ;
  assign douta[190] = \<const0> ;
  assign douta[189] = \<const0> ;
  assign douta[188] = \<const0> ;
  assign douta[187] = \<const0> ;
  assign douta[186] = \<const0> ;
  assign douta[185] = \<const0> ;
  assign douta[184] = \<const0> ;
  assign douta[183] = \<const0> ;
  assign douta[182] = \<const0> ;
  assign douta[181] = \<const0> ;
  assign douta[180] = \<const0> ;
  assign douta[179] = \<const0> ;
  assign douta[178] = \<const0> ;
  assign douta[177] = \<const0> ;
  assign douta[176] = \<const0> ;
  assign douta[175] = \<const0> ;
  assign douta[174] = \<const0> ;
  assign douta[173] = \<const0> ;
  assign douta[172] = \<const0> ;
  assign douta[171] = \<const0> ;
  assign douta[170] = \<const0> ;
  assign douta[169] = \<const0> ;
  assign douta[168] = \<const0> ;
  assign douta[167] = \<const0> ;
  assign douta[166] = \<const0> ;
  assign douta[165] = \<const0> ;
  assign douta[164] = \<const0> ;
  assign douta[163] = \<const0> ;
  assign douta[162] = \<const0> ;
  assign douta[161] = \<const0> ;
  assign douta[160] = \<const0> ;
  assign douta[159] = \<const0> ;
  assign douta[158] = \<const0> ;
  assign douta[157] = \<const0> ;
  assign douta[156] = \<const0> ;
  assign douta[155] = \<const0> ;
  assign douta[154] = \<const0> ;
  assign douta[153] = \<const0> ;
  assign douta[152] = \<const0> ;
  assign douta[151] = \<const0> ;
  assign douta[150] = \<const0> ;
  assign douta[149] = \<const0> ;
  assign douta[148] = \<const0> ;
  assign douta[147] = \<const0> ;
  assign douta[146] = \<const0> ;
  assign douta[145] = \<const0> ;
  assign douta[144] = \<const0> ;
  assign douta[143] = \<const0> ;
  assign douta[142] = \<const0> ;
  assign douta[141] = \<const0> ;
  assign douta[140] = \<const0> ;
  assign douta[139] = \<const0> ;
  assign douta[138] = \<const0> ;
  assign douta[137] = \<const0> ;
  assign douta[136] = \<const0> ;
  assign douta[135] = \<const0> ;
  assign douta[134] = \<const0> ;
  assign douta[133] = \<const0> ;
  assign douta[132] = \<const0> ;
  assign douta[131] = \<const0> ;
  assign douta[130] = \<const0> ;
  assign douta[129] = \<const0> ;
  assign douta[128] = \<const0> ;
  assign douta[127] = \<const0> ;
  assign douta[126] = \<const0> ;
  assign douta[125] = \<const0> ;
  assign douta[124] = \<const0> ;
  assign douta[123] = \<const0> ;
  assign douta[122] = \<const0> ;
  assign douta[121] = \<const0> ;
  assign douta[120] = \<const0> ;
  assign douta[119] = \<const0> ;
  assign douta[118] = \<const0> ;
  assign douta[117] = \<const0> ;
  assign douta[116] = \<const0> ;
  assign douta[115] = \<const0> ;
  assign douta[114] = \<const0> ;
  assign douta[113] = \<const0> ;
  assign douta[112] = \<const0> ;
  assign douta[111] = \<const0> ;
  assign douta[110] = \<const0> ;
  assign douta[109] = \<const0> ;
  assign douta[108] = \<const0> ;
  assign douta[107] = \<const0> ;
  assign douta[106] = \<const0> ;
  assign douta[105] = \<const0> ;
  assign douta[104] = \<const0> ;
  assign douta[103] = \<const0> ;
  assign douta[102] = \<const0> ;
  assign douta[101] = \<const0> ;
  assign douta[100] = \<const0> ;
  assign douta[99] = \<const0> ;
  assign douta[98] = \<const0> ;
  assign douta[97] = \<const0> ;
  assign douta[96] = \<const0> ;
  assign douta[95] = \<const0> ;
  assign douta[94] = \<const0> ;
  assign douta[93] = \<const0> ;
  assign douta[92] = \<const0> ;
  assign douta[91] = \<const0> ;
  assign douta[90] = \<const0> ;
  assign douta[89] = \<const0> ;
  assign douta[88] = \<const0> ;
  assign douta[87] = \<const0> ;
  assign douta[86] = \<const0> ;
  assign douta[85] = \<const0> ;
  assign douta[84] = \<const0> ;
  assign douta[83] = \<const0> ;
  assign douta[82] = \<const0> ;
  assign douta[81] = \<const0> ;
  assign douta[80] = \<const0> ;
  assign douta[79] = \<const0> ;
  assign douta[78] = \<const0> ;
  assign douta[77] = \<const0> ;
  assign douta[76] = \<const0> ;
  assign douta[75] = \<const0> ;
  assign douta[74] = \<const0> ;
  assign douta[73] = \<const0> ;
  assign douta[72] = \<const0> ;
  assign douta[71] = \<const0> ;
  assign douta[70] = \<const0> ;
  assign douta[69] = \<const0> ;
  assign douta[68] = \<const0> ;
  assign douta[67] = \<const0> ;
  assign douta[66] = \<const0> ;
  assign douta[65] = \<const0> ;
  assign douta[64] = \<const0> ;
  assign douta[63] = \<const0> ;
  assign douta[62] = \<const0> ;
  assign douta[61] = \<const0> ;
  assign douta[60] = \<const0> ;
  assign douta[59] = \<const0> ;
  assign douta[58] = \<const0> ;
  assign douta[57] = \<const0> ;
  assign douta[56] = \<const0> ;
  assign douta[55] = \<const0> ;
  assign douta[54] = \<const0> ;
  assign douta[53] = \<const0> ;
  assign douta[52] = \<const0> ;
  assign douta[51] = \<const0> ;
  assign douta[50] = \<const0> ;
  assign douta[49] = \<const0> ;
  assign douta[48] = \<const0> ;
  assign douta[47] = \<const0> ;
  assign douta[46] = \<const0> ;
  assign douta[45] = \<const0> ;
  assign douta[44] = \<const0> ;
  assign douta[43] = \<const0> ;
  assign douta[42] = \<const0> ;
  assign douta[41] = \<const0> ;
  assign douta[40] = \<const0> ;
  assign douta[39] = \<const0> ;
  assign douta[38] = \<const0> ;
  assign douta[37] = \<const0> ;
  assign douta[36] = \<const0> ;
  assign douta[35] = \<const0> ;
  assign douta[34] = \<const0> ;
  assign douta[33] = \<const0> ;
  assign douta[32] = \<const0> ;
  assign douta[31] = \<const0> ;
  assign douta[30] = \<const0> ;
  assign douta[29] = \<const0> ;
  assign douta[28] = \<const0> ;
  assign douta[27] = \<const0> ;
  assign douta[26] = \<const0> ;
  assign douta[25] = \<const0> ;
  assign douta[24] = \<const0> ;
  assign douta[23] = \<const0> ;
  assign douta[22] = \<const0> ;
  assign douta[21] = \<const0> ;
  assign douta[20] = \<const0> ;
  assign douta[19] = \<const0> ;
  assign douta[18] = \<const0> ;
  assign douta[17] = \<const0> ;
  assign douta[16] = \<const0> ;
  assign douta[15] = \<const0> ;
  assign douta[14] = \<const0> ;
  assign douta[13] = \<const0> ;
  assign douta[12] = \<const0> ;
  assign douta[11] = \<const0> ;
  assign douta[10] = \<const0> ;
  assign douta[9] = \<const0> ;
  assign douta[8] = \<const0> ;
  assign douta[7] = \<const0> ;
  assign douta[6] = \<const0> ;
  assign douta[5] = \<const0> ;
  assign douta[4] = \<const0> ;
  assign douta[3] = \<const0> ;
  assign douta[2] = \<const0> ;
  assign douta[1] = \<const0> ;
  assign douta[0] = \<const0> ;
  assign doutb[450:322] = \^doutb [450:322];
  assign doutb[321] = \<const0> ;
  assign doutb[320] = \<const0> ;
  assign doutb[319:288] = \^doutb [319:288];
  assign doutb[287] = \<const0> ;
  assign doutb[286] = \<const0> ;
  assign doutb[285] = \<const0> ;
  assign doutb[284] = \<const0> ;
  assign doutb[283] = \<const0> ;
  assign doutb[282] = \<const0> ;
  assign doutb[281] = \<const0> ;
  assign doutb[280] = \<const0> ;
  assign doutb[279] = \<const0> ;
  assign doutb[278] = \<const0> ;
  assign doutb[277] = \<const0> ;
  assign doutb[276] = \<const0> ;
  assign doutb[275] = \<const0> ;
  assign doutb[274] = \<const0> ;
  assign doutb[273] = \<const0> ;
  assign doutb[272] = \<const0> ;
  assign doutb[271] = \<const0> ;
  assign doutb[270] = \<const0> ;
  assign doutb[269] = \<const0> ;
  assign doutb[268] = \<const0> ;
  assign doutb[267] = \<const0> ;
  assign doutb[266] = \<const0> ;
  assign doutb[265] = \<const0> ;
  assign doutb[264] = \<const0> ;
  assign doutb[263] = \<const0> ;
  assign doutb[262] = \<const0> ;
  assign doutb[261] = \<const0> ;
  assign doutb[260] = \<const0> ;
  assign doutb[259] = \<const0> ;
  assign doutb[258] = \<const0> ;
  assign doutb[257] = \<const0> ;
  assign doutb[256] = \<const0> ;
  assign doutb[255:0] = \^doutb [255:0];
  assign sbiterra = \<const0> ;
  assign sbiterrb = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* \MEM.PORTA.ADDRESS_BEGIN  = "0" *) 
  (* \MEM.PORTA.ADDRESS_END  = "511" *) 
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p8_d64" *) 
  (* \MEM.PORTA.DATA_LSB  = "0" *) 
  (* \MEM.PORTA.DATA_MSB  = "71" *) 
  (* \MEM.PORTB.ADDRESS_BEGIN  = "0" *) 
  (* \MEM.PORTB.ADDRESS_END  = "511" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p8_d64" *) 
  (* \MEM.PORTB.DATA_LSB  = "0" *) 
  (* \MEM.PORTB.DATA_MSB  = "71" *) 
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "28864" *) 
  (* RTL_RAM_NAME = "gen_wr_a.gen_word_narrow.mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* bram_addr_begin = "0" *) 
  (* bram_addr_end = "511" *) 
  (* bram_slice_begin = "0" *) 
  (* bram_slice_end = "71" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "71" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(1),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("SDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(72),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(0),
    .WRITE_WIDTH_B(72)) 
    \gen_wr_a.gen_word_narrow.mem_reg_0 
       (.ADDRARDADDR({1'b1,1'b0,1'b0,1'b0,addrb,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,1'b0,1'b0,1'b0,addra,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_DBITERR_UNCONNECTED ),
        .DIADI(dina[31:0]),
        .DIBDI(dina[63:32]),
        .DIPADIP(dina[67:64]),
        .DIPBDIP(dina[71:68]),
        .DOADO(\^doutb [31:0]),
        .DOBDO(\^doutb [63:32]),
        .DOPADOP(\^doutb [67:64]),
        .DOPBDOP(\^doutb [71:68]),
        .ECCPARITY(\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(enb),
        .ENBWREN(1'b1),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(regceb),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(rstb),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({wea,wea,wea,wea,wea,wea,wea,wea}));
  (* \MEM.PORTA.ADDRESS_BEGIN  = "0" *) 
  (* \MEM.PORTA.ADDRESS_END  = "511" *) 
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p8_d64" *) 
  (* \MEM.PORTA.DATA_LSB  = "72" *) 
  (* \MEM.PORTA.DATA_MSB  = "143" *) 
  (* \MEM.PORTB.ADDRESS_BEGIN  = "0" *) 
  (* \MEM.PORTB.ADDRESS_END  = "511" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p8_d64" *) 
  (* \MEM.PORTB.DATA_LSB  = "72" *) 
  (* \MEM.PORTB.DATA_MSB  = "143" *) 
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "28864" *) 
  (* RTL_RAM_NAME = "gen_wr_a.gen_word_narrow.mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* bram_addr_begin = "0" *) 
  (* bram_addr_end = "511" *) 
  (* bram_slice_begin = "72" *) 
  (* bram_slice_end = "143" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "72" *) 
  (* ram_slice_end = "143" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(1),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("SDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(72),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(0),
    .WRITE_WIDTH_B(72)) 
    \gen_wr_a.gen_word_narrow.mem_reg_1 
       (.ADDRARDADDR({1'b1,1'b0,1'b0,1'b0,addrb,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,1'b0,1'b0,1'b0,addra,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_gen_wr_a.gen_word_narrow.mem_reg_1_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_gen_wr_a.gen_word_narrow.mem_reg_1_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_gen_wr_a.gen_word_narrow.mem_reg_1_DBITERR_UNCONNECTED ),
        .DIADI(dina[103:72]),
        .DIBDI(dina[135:104]),
        .DIPADIP(dina[139:136]),
        .DIPBDIP(dina[143:140]),
        .DOADO(\^doutb [103:72]),
        .DOBDO(\^doutb [135:104]),
        .DOPADOP(\^doutb [139:136]),
        .DOPBDOP(\^doutb [143:140]),
        .ECCPARITY(\NLW_gen_wr_a.gen_word_narrow.mem_reg_1_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(enb),
        .ENBWREN(1'b1),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_gen_wr_a.gen_word_narrow.mem_reg_1_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(regceb),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(rstb),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_gen_wr_a.gen_word_narrow.mem_reg_1_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({wea,wea,wea,wea,wea,wea,wea,wea}));
  (* \MEM.PORTA.ADDRESS_BEGIN  = "0" *) 
  (* \MEM.PORTA.ADDRESS_END  = "511" *) 
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p8_d64" *) 
  (* \MEM.PORTA.DATA_LSB  = "144" *) 
  (* \MEM.PORTA.DATA_MSB  = "215" *) 
  (* \MEM.PORTB.ADDRESS_BEGIN  = "0" *) 
  (* \MEM.PORTB.ADDRESS_END  = "511" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p8_d64" *) 
  (* \MEM.PORTB.DATA_LSB  = "144" *) 
  (* \MEM.PORTB.DATA_MSB  = "215" *) 
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "28864" *) 
  (* RTL_RAM_NAME = "gen_wr_a.gen_word_narrow.mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* bram_addr_begin = "0" *) 
  (* bram_addr_end = "511" *) 
  (* bram_slice_begin = "144" *) 
  (* bram_slice_end = "215" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "144" *) 
  (* ram_slice_end = "215" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(1),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("SDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(72),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(0),
    .WRITE_WIDTH_B(72)) 
    \gen_wr_a.gen_word_narrow.mem_reg_2 
       (.ADDRARDADDR({1'b1,1'b0,1'b0,1'b0,addrb,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,1'b0,1'b0,1'b0,addra,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_gen_wr_a.gen_word_narrow.mem_reg_2_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_gen_wr_a.gen_word_narrow.mem_reg_2_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_gen_wr_a.gen_word_narrow.mem_reg_2_DBITERR_UNCONNECTED ),
        .DIADI(dina[175:144]),
        .DIBDI(dina[207:176]),
        .DIPADIP(dina[211:208]),
        .DIPBDIP(dina[215:212]),
        .DOADO(\^doutb [175:144]),
        .DOBDO(\^doutb [207:176]),
        .DOPADOP(\^doutb [211:208]),
        .DOPBDOP(\^doutb [215:212]),
        .ECCPARITY(\NLW_gen_wr_a.gen_word_narrow.mem_reg_2_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(enb),
        .ENBWREN(1'b1),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_gen_wr_a.gen_word_narrow.mem_reg_2_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(regceb),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(rstb),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_gen_wr_a.gen_word_narrow.mem_reg_2_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({wea,wea,wea,wea,wea,wea,wea,wea}));
  (* \MEM.PORTA.ADDRESS_BEGIN  = "0" *) 
  (* \MEM.PORTA.ADDRESS_END  = "511" *) 
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p8_d64" *) 
  (* \MEM.PORTA.DATA_LSB  = "216" *) 
  (* \MEM.PORTA.DATA_MSB  = "287" *) 
  (* \MEM.PORTB.ADDRESS_BEGIN  = "0" *) 
  (* \MEM.PORTB.ADDRESS_END  = "511" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p8_d64" *) 
  (* \MEM.PORTB.DATA_LSB  = "216" *) 
  (* \MEM.PORTB.DATA_MSB  = "287" *) 
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "28864" *) 
  (* RTL_RAM_NAME = "gen_wr_a.gen_word_narrow.mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* bram_addr_begin = "0" *) 
  (* bram_addr_end = "511" *) 
  (* bram_slice_begin = "216" *) 
  (* bram_slice_end = "287" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "216" *) 
  (* ram_slice_end = "287" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(1),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("SDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(72),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(0),
    .WRITE_WIDTH_B(72)) 
    \gen_wr_a.gen_word_narrow.mem_reg_3 
       (.ADDRARDADDR({1'b1,1'b0,1'b0,1'b0,addrb,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,1'b0,1'b0,1'b0,addra,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_gen_wr_a.gen_word_narrow.mem_reg_3_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_gen_wr_a.gen_word_narrow.mem_reg_3_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_gen_wr_a.gen_word_narrow.mem_reg_3_DBITERR_UNCONNECTED ),
        .DIADI(dina[247:216]),
        .DIBDI({dina[311:288],dina[255:248]}),
        .DIPADIP(dina[315:312]),
        .DIPBDIP(dina[319:316]),
        .DOADO(\^doutb [247:216]),
        .DOBDO({\^doutb [311:288],\^doutb [255:248]}),
        .DOPADOP(\^doutb [315:312]),
        .DOPBDOP(\^doutb [319:316]),
        .ECCPARITY(\NLW_gen_wr_a.gen_word_narrow.mem_reg_3_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(enb),
        .ENBWREN(1'b1),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_gen_wr_a.gen_word_narrow.mem_reg_3_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(regceb),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(rstb),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_gen_wr_a.gen_word_narrow.mem_reg_3_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({wea,wea,wea,wea,wea,wea,wea,wea}));
  (* \MEM.PORTA.ADDRESS_BEGIN  = "0" *) 
  (* \MEM.PORTA.ADDRESS_END  = "511" *) 
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p8_d64" *) 
  (* \MEM.PORTA.DATA_LSB  = "288" *) 
  (* \MEM.PORTA.DATA_MSB  = "359" *) 
  (* \MEM.PORTB.ADDRESS_BEGIN  = "0" *) 
  (* \MEM.PORTB.ADDRESS_END  = "511" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p8_d64" *) 
  (* \MEM.PORTB.DATA_LSB  = "288" *) 
  (* \MEM.PORTB.DATA_MSB  = "359" *) 
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "28864" *) 
  (* RTL_RAM_NAME = "gen_wr_a.gen_word_narrow.mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* bram_addr_begin = "0" *) 
  (* bram_addr_end = "511" *) 
  (* bram_slice_begin = "288" *) 
  (* bram_slice_end = "359" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "288" *) 
  (* ram_slice_end = "359" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(1),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("SDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(72),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(0),
    .WRITE_WIDTH_B(72)) 
    \gen_wr_a.gen_word_narrow.mem_reg_4 
       (.ADDRARDADDR({1'b1,1'b0,1'b0,1'b0,addrb,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,1'b0,1'b0,1'b0,addra,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_gen_wr_a.gen_word_narrow.mem_reg_4_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_gen_wr_a.gen_word_narrow.mem_reg_4_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_gen_wr_a.gen_word_narrow.mem_reg_4_DBITERR_UNCONNECTED ),
        .DIADI(dina[353:322]),
        .DIBDI(dina[385:354]),
        .DIPADIP(dina[389:386]),
        .DIPBDIP(dina[393:390]),
        .DOADO(\^doutb [353:322]),
        .DOBDO(\^doutb [385:354]),
        .DOPADOP(\^doutb [389:386]),
        .DOPBDOP(\^doutb [393:390]),
        .ECCPARITY(\NLW_gen_wr_a.gen_word_narrow.mem_reg_4_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(enb),
        .ENBWREN(1'b1),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_gen_wr_a.gen_word_narrow.mem_reg_4_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(regceb),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(rstb),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_gen_wr_a.gen_word_narrow.mem_reg_4_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({wea,wea,wea,wea,wea,wea,wea,wea}));
  (* \MEM.PORTA.ADDRESS_BEGIN  = "0" *) 
  (* \MEM.PORTA.ADDRESS_END  = "511" *) 
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d57" *) 
  (* \MEM.PORTA.DATA_LSB  = "360" *) 
  (* \MEM.PORTA.DATA_MSB  = "416" *) 
  (* \MEM.PORTB.ADDRESS_BEGIN  = "0" *) 
  (* \MEM.PORTB.ADDRESS_END  = "511" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p0_d57" *) 
  (* \MEM.PORTB.DATA_LSB  = "360" *) 
  (* \MEM.PORTB.DATA_MSB  = "416" *) 
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "28864" *) 
  (* RTL_RAM_NAME = "gen_wr_a.gen_word_narrow.mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* bram_addr_begin = "0" *) 
  (* bram_addr_end = "511" *) 
  (* bram_slice_begin = "360" *) 
  (* bram_slice_end = "416" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "360" *) 
  (* ram_slice_end = "416" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(1),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("SDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(72),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(0),
    .WRITE_WIDTH_B(72)) 
    \gen_wr_a.gen_word_narrow.mem_reg_5 
       (.ADDRARDADDR({1'b1,1'b0,1'b0,1'b0,addrb,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,1'b0,1'b0,1'b0,addra,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_gen_wr_a.gen_word_narrow.mem_reg_5_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_gen_wr_a.gen_word_narrow.mem_reg_5_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_gen_wr_a.gen_word_narrow.mem_reg_5_DBITERR_UNCONNECTED ),
        .DIADI(dina[425:394]),
        .DIBDI({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,dina[450:426]}),
        .DIPADIP({1'b1,1'b1,1'b1,1'b1}),
        .DIPBDIP({1'b1,1'b1,1'b1,1'b1}),
        .DOADO(\^doutb [425:394]),
        .DOBDO({\NLW_gen_wr_a.gen_word_narrow.mem_reg_5_DOBDO_UNCONNECTED [31:25],\^doutb [450:426]}),
        .DOPADOP(\NLW_gen_wr_a.gen_word_narrow.mem_reg_5_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_gen_wr_a.gen_word_narrow.mem_reg_5_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_gen_wr_a.gen_word_narrow.mem_reg_5_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(enb),
        .ENBWREN(1'b1),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_gen_wr_a.gen_word_narrow.mem_reg_5_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(regceb),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(rstb),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_gen_wr_a.gen_word_narrow.mem_reg_5_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({wea,wea,wea,wea,wea,wea,wea,wea}));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
