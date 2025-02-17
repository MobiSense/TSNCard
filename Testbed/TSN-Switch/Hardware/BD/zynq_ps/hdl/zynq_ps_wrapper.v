//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
//Date        : Wed Mar 30 20:08:17 2022
//Host        : 11-211-Lenovo running 64-bit major release  (build 9200)
//Command     : generate_target zynq_ps_wrapper.bd
//Design      : zynq_ps_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module zynq_ps_wrapper
   (DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    GMII_ETHERNET_1_0_col,
    GMII_ETHERNET_1_0_crs,
    GMII_ETHERNET_1_0_rx_clk,
    GMII_ETHERNET_1_0_rx_dv,
    GMII_ETHERNET_1_0_rx_er,
    GMII_ETHERNET_1_0_rxd,
    GMII_ETHERNET_1_0_tx_clk,
    GMII_ETHERNET_1_0_tx_en,
    GMII_ETHERNET_1_0_tx_er,
    GMII_ETHERNET_1_0_txd,
    M_AXIS_0_tdata,
    M_AXIS_0_tkeep,
    M_AXIS_0_tlast,
    M_AXIS_0_tready,
    M_AXIS_0_tvalid,
    M_AXIS_1_tdata,
    M_AXIS_1_tkeep,
    M_AXIS_1_tlast,
    M_AXIS_1_tready,
    M_AXIS_1_tvalid,
    M_AXIS_CLK,
    S_AXIS_0_tdata,
    S_AXIS_0_tkeep,
    S_AXIS_0_tlast,
    S_AXIS_0_tready,
    S_AXIS_0_tvalid,
    S_AXIS_1_tdata,
    S_AXIS_1_tkeep,
    S_AXIS_1_tlast,
    S_AXIS_1_tready,
    S_AXIS_1_tvalid,
    S_AXIS_CLK,
    axis_pl2ps_plc_resetn,
    axis_pl2ps_resetn,
    axis_ps2pl_plc_resetn,
    axis_ps2pl_resetn,
    external_pl_reset,
    s_axi_plc_araddr,
    s_axi_plc_arprot,
    s_axi_plc_arready,
    s_axi_plc_arvalid,
    s_axi_plc_awaddr,
    s_axi_plc_awprot,
    s_axi_plc_awready,
    s_axi_plc_awvalid,
    s_axi_plc_bready,
    s_axi_plc_bresp,
    s_axi_plc_bvalid,
    s_axi_plc_clk,
    s_axi_plc_rdata,
    s_axi_plc_rready,
    s_axi_plc_rresp,
    s_axi_plc_rvalid,
    s_axi_plc_wdata,
    s_axi_plc_wready,
    s_axi_plc_wstrb,
    s_axi_plc_wvalid,
    s_axi_time_sync_araddr,
    s_axi_time_sync_aresetn,
    s_axi_time_sync_arprot,
    s_axi_time_sync_arready,
    s_axi_time_sync_arvalid,
    s_axi_time_sync_awaddr,
    s_axi_time_sync_awprot,
    s_axi_time_sync_awready,
    s_axi_time_sync_awvalid,
    s_axi_time_sync_bready,
    s_axi_time_sync_bresp,
    s_axi_time_sync_bvalid,
    s_axi_time_sync_clk,
    s_axi_time_sync_rdata,
    s_axi_time_sync_rready,
    s_axi_time_sync_rresp,
    s_axi_time_sync_rvalid,
    s_axi_time_sync_wdata,
    s_axi_time_sync_wready,
    s_axi_time_sync_wstrb,
    s_axi_time_sync_wvalid);
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  input GMII_ETHERNET_1_0_col;
  input GMII_ETHERNET_1_0_crs;
  input GMII_ETHERNET_1_0_rx_clk;
  input GMII_ETHERNET_1_0_rx_dv;
  input GMII_ETHERNET_1_0_rx_er;
  input [7:0]GMII_ETHERNET_1_0_rxd;
  input GMII_ETHERNET_1_0_tx_clk;
  output [0:0]GMII_ETHERNET_1_0_tx_en;
  output [0:0]GMII_ETHERNET_1_0_tx_er;
  output [7:0]GMII_ETHERNET_1_0_txd;
  output [255:0]M_AXIS_0_tdata;
  output [31:0]M_AXIS_0_tkeep;
  output M_AXIS_0_tlast;
  input M_AXIS_0_tready;
  output M_AXIS_0_tvalid;
  output [255:0]M_AXIS_1_tdata;
  output [31:0]M_AXIS_1_tkeep;
  output M_AXIS_1_tlast;
  input M_AXIS_1_tready;
  output M_AXIS_1_tvalid;
  output M_AXIS_CLK;
  input [255:0]S_AXIS_0_tdata;
  input [31:0]S_AXIS_0_tkeep;
  input S_AXIS_0_tlast;
  output S_AXIS_0_tready;
  input S_AXIS_0_tvalid;
  input [255:0]S_AXIS_1_tdata;
  input [31:0]S_AXIS_1_tkeep;
  input S_AXIS_1_tlast;
  output S_AXIS_1_tready;
  input S_AXIS_1_tvalid;
  output S_AXIS_CLK;
  output axis_pl2ps_plc_resetn;
  output axis_pl2ps_resetn;
  output axis_ps2pl_plc_resetn;
  output axis_ps2pl_resetn;
  output [0:0]external_pl_reset;
  output [31:0]s_axi_plc_araddr;
  output [2:0]s_axi_plc_arprot;
  input [0:0]s_axi_plc_arready;
  output [0:0]s_axi_plc_arvalid;
  output [31:0]s_axi_plc_awaddr;
  output [2:0]s_axi_plc_awprot;
  input [0:0]s_axi_plc_awready;
  output [0:0]s_axi_plc_awvalid;
  output [0:0]s_axi_plc_bready;
  input [1:0]s_axi_plc_bresp;
  input [0:0]s_axi_plc_bvalid;
  output s_axi_plc_clk;
  input [31:0]s_axi_plc_rdata;
  output [0:0]s_axi_plc_rready;
  input [1:0]s_axi_plc_rresp;
  input [0:0]s_axi_plc_rvalid;
  output [31:0]s_axi_plc_wdata;
  input [0:0]s_axi_plc_wready;
  output [3:0]s_axi_plc_wstrb;
  output [0:0]s_axi_plc_wvalid;
  output [31:0]s_axi_time_sync_araddr;
  output [0:0]s_axi_time_sync_aresetn;
  output [2:0]s_axi_time_sync_arprot;
  input [0:0]s_axi_time_sync_arready;
  output [0:0]s_axi_time_sync_arvalid;
  output [31:0]s_axi_time_sync_awaddr;
  output [2:0]s_axi_time_sync_awprot;
  input [0:0]s_axi_time_sync_awready;
  output [0:0]s_axi_time_sync_awvalid;
  output [0:0]s_axi_time_sync_bready;
  input [1:0]s_axi_time_sync_bresp;
  input [0:0]s_axi_time_sync_bvalid;
  output s_axi_time_sync_clk;
  input [31:0]s_axi_time_sync_rdata;
  output [0:0]s_axi_time_sync_rready;
  input [1:0]s_axi_time_sync_rresp;
  input [0:0]s_axi_time_sync_rvalid;
  output [31:0]s_axi_time_sync_wdata;
  input [0:0]s_axi_time_sync_wready;
  output [3:0]s_axi_time_sync_wstrb;
  output [0:0]s_axi_time_sync_wvalid;

  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire GMII_ETHERNET_1_0_col;
  wire GMII_ETHERNET_1_0_crs;
  wire GMII_ETHERNET_1_0_rx_clk;
  wire GMII_ETHERNET_1_0_rx_dv;
  wire GMII_ETHERNET_1_0_rx_er;
  wire [7:0]GMII_ETHERNET_1_0_rxd;
  wire GMII_ETHERNET_1_0_tx_clk;
  wire [0:0]GMII_ETHERNET_1_0_tx_en;
  wire [0:0]GMII_ETHERNET_1_0_tx_er;
  wire [7:0]GMII_ETHERNET_1_0_txd;
  wire [255:0]M_AXIS_0_tdata;
  wire [31:0]M_AXIS_0_tkeep;
  wire M_AXIS_0_tlast;
  wire M_AXIS_0_tready;
  wire M_AXIS_0_tvalid;
  wire [255:0]M_AXIS_1_tdata;
  wire [31:0]M_AXIS_1_tkeep;
  wire M_AXIS_1_tlast;
  wire M_AXIS_1_tready;
  wire M_AXIS_1_tvalid;
  wire M_AXIS_CLK;
  wire [255:0]S_AXIS_0_tdata;
  wire [31:0]S_AXIS_0_tkeep;
  wire S_AXIS_0_tlast;
  wire S_AXIS_0_tready;
  wire S_AXIS_0_tvalid;
  wire [255:0]S_AXIS_1_tdata;
  wire [31:0]S_AXIS_1_tkeep;
  wire S_AXIS_1_tlast;
  wire S_AXIS_1_tready;
  wire S_AXIS_1_tvalid;
  wire S_AXIS_CLK;
  wire axis_pl2ps_plc_resetn;
  wire axis_pl2ps_resetn;
  wire axis_ps2pl_plc_resetn;
  wire axis_ps2pl_resetn;
  wire [0:0]external_pl_reset;
  wire [31:0]s_axi_plc_araddr;
  wire [2:0]s_axi_plc_arprot;
  wire [0:0]s_axi_plc_arready;
  wire [0:0]s_axi_plc_arvalid;
  wire [31:0]s_axi_plc_awaddr;
  wire [2:0]s_axi_plc_awprot;
  wire [0:0]s_axi_plc_awready;
  wire [0:0]s_axi_plc_awvalid;
  wire [0:0]s_axi_plc_bready;
  wire [1:0]s_axi_plc_bresp;
  wire [0:0]s_axi_plc_bvalid;
  wire s_axi_plc_clk;
  wire [31:0]s_axi_plc_rdata;
  wire [0:0]s_axi_plc_rready;
  wire [1:0]s_axi_plc_rresp;
  wire [0:0]s_axi_plc_rvalid;
  wire [31:0]s_axi_plc_wdata;
  wire [0:0]s_axi_plc_wready;
  wire [3:0]s_axi_plc_wstrb;
  wire [0:0]s_axi_plc_wvalid;
  wire [31:0]s_axi_time_sync_araddr;
  wire [0:0]s_axi_time_sync_aresetn;
  wire [2:0]s_axi_time_sync_arprot;
  wire [0:0]s_axi_time_sync_arready;
  wire [0:0]s_axi_time_sync_arvalid;
  wire [31:0]s_axi_time_sync_awaddr;
  wire [2:0]s_axi_time_sync_awprot;
  wire [0:0]s_axi_time_sync_awready;
  wire [0:0]s_axi_time_sync_awvalid;
  wire [0:0]s_axi_time_sync_bready;
  wire [1:0]s_axi_time_sync_bresp;
  wire [0:0]s_axi_time_sync_bvalid;
  wire s_axi_time_sync_clk;
  wire [31:0]s_axi_time_sync_rdata;
  wire [0:0]s_axi_time_sync_rready;
  wire [1:0]s_axi_time_sync_rresp;
  wire [0:0]s_axi_time_sync_rvalid;
  wire [31:0]s_axi_time_sync_wdata;
  wire [0:0]s_axi_time_sync_wready;
  wire [3:0]s_axi_time_sync_wstrb;
  wire [0:0]s_axi_time_sync_wvalid;

  zynq_ps zynq_ps_i
       (.DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .GMII_ETHERNET_1_0_col(GMII_ETHERNET_1_0_col),
        .GMII_ETHERNET_1_0_crs(GMII_ETHERNET_1_0_crs),
        .GMII_ETHERNET_1_0_rx_clk(GMII_ETHERNET_1_0_rx_clk),
        .GMII_ETHERNET_1_0_rx_dv(GMII_ETHERNET_1_0_rx_dv),
        .GMII_ETHERNET_1_0_rx_er(GMII_ETHERNET_1_0_rx_er),
        .GMII_ETHERNET_1_0_rxd(GMII_ETHERNET_1_0_rxd),
        .GMII_ETHERNET_1_0_tx_clk(GMII_ETHERNET_1_0_tx_clk),
        .GMII_ETHERNET_1_0_tx_en(GMII_ETHERNET_1_0_tx_en),
        .GMII_ETHERNET_1_0_tx_er(GMII_ETHERNET_1_0_tx_er),
        .GMII_ETHERNET_1_0_txd(GMII_ETHERNET_1_0_txd),
        .M_AXIS_0_tdata(M_AXIS_0_tdata),
        .M_AXIS_0_tkeep(M_AXIS_0_tkeep),
        .M_AXIS_0_tlast(M_AXIS_0_tlast),
        .M_AXIS_0_tready(M_AXIS_0_tready),
        .M_AXIS_0_tvalid(M_AXIS_0_tvalid),
        .M_AXIS_1_tdata(M_AXIS_1_tdata),
        .M_AXIS_1_tkeep(M_AXIS_1_tkeep),
        .M_AXIS_1_tlast(M_AXIS_1_tlast),
        .M_AXIS_1_tready(M_AXIS_1_tready),
        .M_AXIS_1_tvalid(M_AXIS_1_tvalid),
        .M_AXIS_CLK(M_AXIS_CLK),
        .S_AXIS_0_tdata(S_AXIS_0_tdata),
        .S_AXIS_0_tkeep(S_AXIS_0_tkeep),
        .S_AXIS_0_tlast(S_AXIS_0_tlast),
        .S_AXIS_0_tready(S_AXIS_0_tready),
        .S_AXIS_0_tvalid(S_AXIS_0_tvalid),
        .S_AXIS_1_tdata(S_AXIS_1_tdata),
        .S_AXIS_1_tkeep(S_AXIS_1_tkeep),
        .S_AXIS_1_tlast(S_AXIS_1_tlast),
        .S_AXIS_1_tready(S_AXIS_1_tready),
        .S_AXIS_1_tvalid(S_AXIS_1_tvalid),
        .S_AXIS_CLK(S_AXIS_CLK),
        .axis_pl2ps_plc_resetn(axis_pl2ps_plc_resetn),
        .axis_pl2ps_resetn(axis_pl2ps_resetn),
        .axis_ps2pl_plc_resetn(axis_ps2pl_plc_resetn),
        .axis_ps2pl_resetn(axis_ps2pl_resetn),
        .external_pl_reset(external_pl_reset),
        .s_axi_plc_araddr(s_axi_plc_araddr),
        .s_axi_plc_arprot(s_axi_plc_arprot),
        .s_axi_plc_arready(s_axi_plc_arready),
        .s_axi_plc_arvalid(s_axi_plc_arvalid),
        .s_axi_plc_awaddr(s_axi_plc_awaddr),
        .s_axi_plc_awprot(s_axi_plc_awprot),
        .s_axi_plc_awready(s_axi_plc_awready),
        .s_axi_plc_awvalid(s_axi_plc_awvalid),
        .s_axi_plc_bready(s_axi_plc_bready),
        .s_axi_plc_bresp(s_axi_plc_bresp),
        .s_axi_plc_bvalid(s_axi_plc_bvalid),
        .s_axi_plc_clk(s_axi_plc_clk),
        .s_axi_plc_rdata(s_axi_plc_rdata),
        .s_axi_plc_rready(s_axi_plc_rready),
        .s_axi_plc_rresp(s_axi_plc_rresp),
        .s_axi_plc_rvalid(s_axi_plc_rvalid),
        .s_axi_plc_wdata(s_axi_plc_wdata),
        .s_axi_plc_wready(s_axi_plc_wready),
        .s_axi_plc_wstrb(s_axi_plc_wstrb),
        .s_axi_plc_wvalid(s_axi_plc_wvalid),
        .s_axi_time_sync_araddr(s_axi_time_sync_araddr),
        .s_axi_time_sync_aresetn(s_axi_time_sync_aresetn),
        .s_axi_time_sync_arprot(s_axi_time_sync_arprot),
        .s_axi_time_sync_arready(s_axi_time_sync_arready),
        .s_axi_time_sync_arvalid(s_axi_time_sync_arvalid),
        .s_axi_time_sync_awaddr(s_axi_time_sync_awaddr),
        .s_axi_time_sync_awprot(s_axi_time_sync_awprot),
        .s_axi_time_sync_awready(s_axi_time_sync_awready),
        .s_axi_time_sync_awvalid(s_axi_time_sync_awvalid),
        .s_axi_time_sync_bready(s_axi_time_sync_bready),
        .s_axi_time_sync_bresp(s_axi_time_sync_bresp),
        .s_axi_time_sync_bvalid(s_axi_time_sync_bvalid),
        .s_axi_time_sync_clk(s_axi_time_sync_clk),
        .s_axi_time_sync_rdata(s_axi_time_sync_rdata),
        .s_axi_time_sync_rready(s_axi_time_sync_rready),
        .s_axi_time_sync_rresp(s_axi_time_sync_rresp),
        .s_axi_time_sync_rvalid(s_axi_time_sync_rvalid),
        .s_axi_time_sync_wdata(s_axi_time_sync_wdata),
        .s_axi_time_sync_wready(s_axi_time_sync_wready),
        .s_axi_time_sync_wstrb(s_axi_time_sync_wstrb),
        .s_axi_time_sync_wvalid(s_axi_time_sync_wvalid));
endmodule
