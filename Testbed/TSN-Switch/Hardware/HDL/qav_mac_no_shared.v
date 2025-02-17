//------------------------------------------------------------------------------
// File       : qav_mac_no_shared.v
// Author     : Yi Zhao.
// -----------------------------------------------------------------------------
// Description: This is the MAC module that supports IEEE 802.1Qav.
// The source code is from xilinx example design of tri_mode_ethernet_mac and 
// revised by Yi Zhao.

`timescale 1 ps/1 ps


//------------------------------------------------------------------------------
// The module declaration for the Qav Ethernet MAC.
//------------------------------------------------------------------------------

module qav_mac_no_shared (
    input         gtx_clk,
    input         gtx_clk90,

    // asynchronous reset
    input         glbl_rstn,
    input         rx_axi_rstn,
    input         tx_axi_rstn,

    // Receiver Statistics Interface
    //---------------------------------------
    output        rx_mac_aclk,
    output        rx_reset,
    output [27:0] rx_statistics_vector,
    output        rx_statistics_valid,

    // Receiver (AXI-S) Interface
    //----------------------------------------
    input         rx_fifo_clock,
    input         rx_fifo_resetn,

    output [7:0]  rx_axis_fifo_tdata,

    output        rx_axis_fifo_tvalid,
    input         rx_axis_fifo_tready,
    output        rx_axis_fifo_tlast,
    // Transmitter Statistics Interface
    //------------------------------------------
    output        tx_mac_aclk,
    output        tx_reset,
    input  [7:0]  tx_ifg_delay,
    output [31:0] tx_statistics_vector,
    output        tx_statistics_valid,


    // Transmitter (AXI-S) Interface
    //-------------------------------------------
    input         tx_fifo_clock,
    input         tx_fifo_resetn,

    input  [7:0]  tx_axis_fifo_legacy_tdata,
    input         tx_axis_fifo_legacy_tvalid,
    output        tx_axis_fifo_legacy_tready,
    input         tx_axis_fifo_legacy_tlast,

    input  [7:0]  tx_axis_fifo_av_tdata,
    input         tx_axis_fifo_av_tvalid,
    output        tx_axis_fifo_av_tready,
    input         tx_axis_fifo_av_tlast,

    // MAC Control Interface
    //------------------------
    input         pause_req,
    input  [15:0] pause_val,

    // RGMII Interface
    //------------------
    output [3:0]  rgmii_txd,
    output        rgmii_tx_ctl,
    output        rgmii_txc,
    input  [3:0]  rgmii_rxd,
    input         rgmii_rx_ctl,
    input         rgmii_rxc,

    // output      [3:0]    rgmii_rxd_out,
    // output               rgmii_rx_ctl_out,
    // output               rgmii_rxc_out,
    // RGMII Inband Status Registers
    //--------------------------------
    output        inband_link_status,
    output [1:0]  inband_clock_speed,
    output        inband_duplex_status,

    // Configuration Vectors
    //-----------------------
    // input  [79:0] rx_configuration_vector,
    // input  [79:0] tx_configuration_vector

    inout         mdio,
    output        mdc,

    // AXI-Lite Interface
    input         s_axi_aclk,
    input         s_axi_resetn,

    input  [11:0] s_axi_awaddr,
    input         s_axi_awvalid,
    output        s_axi_awready,

    input  [31:0] s_axi_wdata,
    input         s_axi_wvalid,
    output        s_axi_wready,

    output [1:0]  s_axi_bresp,
    output        s_axi_bvalid,
    input         s_axi_bready,

    input  [11:0] s_axi_araddr,
    input         s_axi_arvalid,
    output        s_axi_arready,

    output [31:0] s_axi_rdata,
    output [1:0]  s_axi_rresp,
    output        s_axi_rvalid,
    input         s_axi_rready,

    output        mac_tx_axis_tvalid_out,
    output        mac_tx_axis_tready_out,
    output [7:0]  mac_tx_axis_tdata_out,
    output        mac_tx_axis_tlast_out,
     
    output        mac_rx_axis_tvalid_out,
    output        mac_rx_axis_tready_out,
    output [7:0]  mac_rx_axis_tdata_out,
    output        mac_rx_axis_tlast_out
);


    //----------------------------------------------------------------------------
    // Internal signals used in this fifo block level wrapper.
    //----------------------------------------------------------------------------

    wire       rx_mac_aclk_int;    // MAC Rx clock
    wire       tx_mac_aclk_int;    // MAC Tx clock
    wire       rx_reset_int;       // MAC Rx reset
    wire       tx_reset_int;       // MAC Tx reset

    // MAC receiver client I/F
    wire [7:0] rx_axis_mac_tdata;
    wire       rx_axis_mac_tvalid;
    wire       rx_axis_mac_tlast;
    wire       rx_axis_mac_tuser;

    // MAC transmitter client I/F
    wire [7:0] tx_axis_mac_tdata;
    wire       tx_axis_mac_tvalid;
    wire       tx_axis_mac_tready;
    wire       tx_axis_mac_tlast;
    wire       tx_axis_mac_tuser;

    // MAC transmitter legacy and av traffic channel (into qav credit based shaper).
    wire [7:0] tx_axis_mac_legacy_tdata;
    wire       tx_axis_mac_legacy_tvalid;
    wire       tx_axis_mac_legacy_tready;
    wire       tx_axis_mac_legacy_tlast;

    wire [7:0] tx_axis_mac_av_tdata;
    wire       tx_axis_mac_av_tvalid;
    wire       tx_axis_mac_av_tready;
    wire       tx_axis_mac_av_tlast;


    //----------------------------------------------------------------------------
    // Connect the output clock signals
    //----------------------------------------------------------------------------

    assign rx_mac_aclk          = rx_mac_aclk_int;
    assign tx_mac_aclk          = tx_mac_aclk_int;
    assign rx_reset             = rx_reset_int;
    assign tx_reset             = tx_reset_int;

    assign mac_rx_axis_tvalid_out = rx_axis_mac_tvalid;
    assign mac_rx_axis_tready_out = 1'b1;
    assign mac_rx_axis_tdata_out = rx_axis_mac_tdata;
    assign mac_rx_axis_tlast_out = rx_axis_mac_tlast;

    assign mac_tx_axis_tvalid_out = tx_axis_mac_tvalid;
    assign mac_tx_axis_tready_out = tx_axis_mac_tready;
    assign mac_tx_axis_tdata_out = tx_axis_mac_tdata;
    assign mac_tx_axis_tlast_out = tx_axis_mac_tlast;

  //----------------------------------------------------------------------------
  // Instantiate the Tri-Mode Ethernet MAC core
  //----------------------------------------------------------------------------
   tri_mode_ethernet_mac_1 tri_mode_ethernet_mac_i (
      .gtx_clk              (gtx_clk),
      .gtx_clk90            (gtx_clk90),
      // asynchronous reset
      .glbl_rstn            (glbl_rstn),
      .rx_axi_rstn          (rx_axi_rstn),
      .tx_axi_rstn          (tx_axi_rstn),

      // Receiver Interface
      .rx_enable            (),

      .rx_statistics_vector (rx_statistics_vector),
      .rx_statistics_valid  (rx_statistics_valid),

      .rx_mac_aclk          (rx_mac_aclk_int),
      .rx_reset             (rx_reset_int),
      .rx_axis_mac_tdata    (rx_axis_mac_tdata),
      .rx_axis_mac_tvalid   (rx_axis_mac_tvalid),
      .rx_axis_mac_tlast    (rx_axis_mac_tlast),
      .rx_axis_mac_tuser    (rx_axis_mac_tuser),

      // Transmitter Interface
      .tx_enable             (),

      .tx_ifg_delay         (tx_ifg_delay),
      .tx_statistics_vector (tx_statistics_vector),
      .tx_statistics_valid  (tx_statistics_valid),

      .tx_mac_aclk          (tx_mac_aclk_int),
      .tx_reset             (tx_reset_int),
      .tx_axis_mac_tdata    (tx_axis_mac_tdata ),
      .tx_axis_mac_tvalid   (tx_axis_mac_tvalid),
      .tx_axis_mac_tlast    (tx_axis_mac_tlast),
      .tx_axis_mac_tuser    (tx_axis_mac_tuser ),
      .tx_axis_mac_tready   (tx_axis_mac_tready),

      // Flow Control
      .pause_req            (pause_req),
      .pause_val            (pause_val),

      // Reference clock for IDELAYCTRL's

      // Speed Control
      .speedis100           (),
      .speedis10100         (),

      // RGMII Interface
      .rgmii_txd            (rgmii_txd),
      .rgmii_tx_ctl         (rgmii_tx_ctl),
      .rgmii_txc            (rgmii_txc),
      .rgmii_rxd            (rgmii_rxd),
      .rgmii_rx_ctl         (rgmii_rx_ctl),
      .rgmii_rxc            (rgmii_rxc),
      // .rgmii_rxd_out               (rgmii_rxd_out),
      // .rgmii_rx_ctl_out            (rgmii_rx_ctl_out),
      // .rgmii_rxc_out               (rgmii_rxc_out),
      .inband_link_status   (inband_link_status),
      .inband_clock_speed   (inband_clock_speed),
      .inband_duplex_status (inband_duplex_status),

      // Configuration Vector
      // .rx_configuration_vector (rx_configuration_vector),
      // .tx_configuration_vector (tx_configuration_vector)
      // MDIO Interface
      //---------------
      .mdio                 (mdio),
      .mdc                  (mdc),

      // AXI lite interface
      .s_axi_aclk           (s_axi_aclk),
      .s_axi_resetn         (s_axi_resetn),
      .s_axi_awaddr         (s_axi_awaddr),
      .s_axi_awvalid        (s_axi_awvalid),
      .s_axi_awready        (s_axi_awready),
      .s_axi_wdata          (s_axi_wdata),
      .s_axi_wvalid         (s_axi_wvalid),
      .s_axi_wready         (s_axi_wready),
      .s_axi_bresp          (s_axi_bresp),
      .s_axi_bvalid         (s_axi_bvalid),
      .s_axi_bready         (s_axi_bready),
      .s_axi_araddr         (s_axi_araddr),
      .s_axi_arvalid        (s_axi_arvalid),
      .s_axi_arready        (s_axi_arready),
      .s_axi_rdata          (s_axi_rdata),
      .s_axi_rresp          (s_axi_rresp),
      .s_axi_rvalid         (s_axi_rvalid),
      .s_axi_rready         (s_axi_rready),
      .mac_irq              ()
   );


   //----------------------------------------------------------------------------
   // Instantiate the user side FIFO
   //----------------------------------------------------------------------------

   // locally reset sync the mac generated resets - the resets are already fully sync
   // so adding a reset sync shouldn't change that
   tri_mode_ethernet_mac_0_reset_sync rx_mac_reset_gen (
      .clk                  (rx_mac_aclk_int),
      .enable               (1'b1),
      .reset_in             (rx_reset_int),
      .reset_out            (rx_mac_reset)
   );

   tri_mode_ethernet_mac_0_reset_sync tx_mac_reset_gen (
      .clk                  (tx_mac_aclk_int),
      .enable               (1'b1),
      .reset_in             (tx_reset_int),
      .reset_out            (tx_mac_reset)
   );

   // create inverted mac resets as the FIFO expects AXI compliant resets
   assign tx_mac_resetn = !tx_mac_reset;
   assign rx_mac_resetn = !rx_mac_reset;

   tri_mode_ethernet_mac_0_tx_client_fifo #
   (
      .FULL_DUPLEX_ONLY (1)
   )
   tx_fifo_legacy
   (
      .tx_fifo_aclk        (tx_fifo_clock),
      .tx_fifo_resetn      (tx_fifo_resetn),
      .tx_axis_fifo_tdata  (tx_axis_fifo_legacy_tdata),
      .tx_axis_fifo_tvalid (tx_axis_fifo_legacy_tvalid),
      .tx_axis_fifo_tlast  (tx_axis_fifo_legacy_tlast),
      .tx_axis_fifo_tready (tx_axis_fifo_legacy_tready),

      .tx_mac_aclk         (tx_mac_aclk),
      .tx_mac_resetn       (tx_mac_resetn),
      .tx_axis_mac_tdata   (tx_axis_mac_legacy_tdata),
      .tx_axis_mac_tvalid  (tx_axis_mac_legacy_tvalid),
      .tx_axis_mac_tlast   (tx_axis_mac_legacy_tlast),
      .tx_axis_mac_tready  (tx_axis_mac_legacy_tready),
      .tx_axis_mac_tuser   (),

      .fifo_overflow       (),
      .fifo_status         (),

      .tx_collision        (1'b0),
      .tx_retransmit       (1'b0)
   );
   
   tri_mode_ethernet_mac_0_tx_client_fifo #
   (
      .FULL_DUPLEX_ONLY (1)
   )
   tx_fifo_av
   (
      .tx_fifo_aclk        (tx_fifo_clock),
      .tx_fifo_resetn      (tx_fifo_resetn),
      .tx_axis_fifo_tdata  (tx_axis_fifo_av_tdata),
      .tx_axis_fifo_tvalid (tx_axis_fifo_av_tvalid),
      .tx_axis_fifo_tlast  (tx_axis_fifo_av_tlast),
      .tx_axis_fifo_tready (tx_axis_fifo_av_tready),

      .tx_mac_aclk         (tx_mac_aclk),
      .tx_mac_resetn       (tx_mac_resetn),
      .tx_axis_mac_tdata   (tx_axis_mac_av_tdata),
      .tx_axis_mac_tvalid  (tx_axis_mac_av_tvalid),
      .tx_axis_mac_tlast   (tx_axis_mac_av_tlast),
      .tx_axis_mac_tready  (tx_axis_mac_av_tready),
      .tx_axis_mac_tuser   (),

      .fifo_overflow       (),
      .fifo_status         (),

      .tx_collision        (1'b0),
      .tx_retransmit       (1'b0)
   );

   tri_mode_ethernet_mac_0_rx_client_fifo rx_fifo
   (
      .rx_fifo_aclk        (rx_fifo_clock),
      .rx_fifo_resetn      (rx_fifo_resetn),
      .rx_axis_fifo_tdata  (rx_axis_fifo_tdata),
      .rx_axis_fifo_tvalid (rx_axis_fifo_tvalid),
      .rx_axis_fifo_tlast  (rx_axis_fifo_tlast),
      .rx_axis_fifo_tready (rx_axis_fifo_tready),

      .rx_mac_aclk         (rx_mac_aclk),
      .rx_mac_resetn       (rx_mac_resetn),
      .rx_axis_mac_tdata   (rx_axis_mac_tdata),
      .rx_axis_mac_tvalid  (rx_axis_mac_tvalid),
      .rx_axis_mac_tlast   (rx_axis_mac_tlast),
      .rx_axis_mac_tuser   (rx_axis_mac_tuser),

      .fifo_status         (),
      .fifo_overflow       ()
   );

   qav_credit_based_shaper qav_credit_based_shaper_ins
   (
      .tx_mac_aclk              (tx_mac_aclk),
      .tx_reset                 (tx_mac_reset),
      
      .tx_axis_mac_legacy_tdata (tx_axis_mac_legacy_tdata),
      .tx_axis_mac_legacy_tvalid(tx_axis_mac_legacy_tvalid),
      .tx_axis_mac_legacy_tready(tx_axis_mac_legacy_tready),
      .tx_axis_mac_legacy_tlast (tx_axis_mac_legacy_tlast),

      .tx_axis_mac_av_tdata     (tx_axis_mac_av_tdata),
      .tx_axis_mac_av_tvalid    (tx_axis_mac_av_tvalid),
      .tx_axis_mac_av_tready    (tx_axis_mac_av_tready),
      .tx_axis_mac_av_tlast     (tx_axis_mac_av_tlast),

      .tx_axis_mac_tdata        (tx_axis_mac_tdata),
      .tx_axis_mac_tvalid       (tx_axis_mac_tvalid),
      .tx_axis_mac_tready       (tx_axis_mac_tready),
      .tx_axis_mac_tlast        (tx_axis_mac_tlast),
      .tx_axis_mac_tuser        (tx_axis_mac_tuser)
   );

endmodule
