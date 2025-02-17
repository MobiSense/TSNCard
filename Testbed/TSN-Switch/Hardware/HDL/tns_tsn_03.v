`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/26 11:45:37
// Design Name: 
// Module Name: tns_tsn_03
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Top module of tns TSN switch.
// We implement our own qbv time aware shaper, while using the 
// licenseless TMEM IP.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tns_tsn_03 # 
    (
        // C_DATA_WIDTH should be big enough to hold the Ethernet header.
        parameter C_S_AXI_DATA_WIDTH    = 32,          
        parameter C_S_AXI_ADDR_WIDTH    = 16,          
        parameter C_DATA_WIDTH = 256,
        parameter C_TUSER_WIDTH = 128,
        parameter NUM_PORTS = 4
    )   
    (
        // asynchronous reset
        input           glbl_rstn,
        // inpu clock signal
        input           sys_clk,

        // simulation signal
        // output          gtx_clk_bufg_out,

        // RGMII Interface
        //----------------
        output [15:0]   rgmii_txd_flat,
        output [3:0]    rgmii_tx_ctl,
        output [3:0]    rgmii_txc,
        input  [15:0]   rgmii_rxd_flat,
        input  [3:0]    rgmii_rx_ctl,
        input  [3:0]    rgmii_rxc,
        
        output [3:0]    phy_resetn,
        inout  [3:0]    mdio,
        output [3:0]    mdc 
    );

    //----------------------------------------------------------------------------
    // internal signals used in this top level wrapper.
    //----------------------------------------------------------------------------

    // simulation signal
    wire                 gtx_clk_bufg_out;

    // example design clocks
    wire                 gtx_clk_bufg;
    wire                 refclk_bufg;
    wire                 s_axi_aclk;
    wire [4:0]           rx_mac_aclk;
    wire [4:0]           tx_mac_aclk;
    wire                 gtx_clk_out;
    wire                 gtx_clk90_out;

    // resets (and reset generation)
    wire                 glbl_rst = !glbl_rstn; 
   
    wire                 gtx_resetn;
   
    wire [4:0]           rx_reset;
    wire [4:0]           tx_reset;
   
    wire                 s_axi_resetn;
    wire                 phy_resetn_int;

    assign phy_resetn[0] = phy_resetn_int;
    assign phy_resetn[1] = phy_resetn_int;
    assign phy_resetn[2] = phy_resetn_int;
    assign phy_resetn[3] = phy_resetn_int;

    wire                 dcm_locked;
    wire                 glbl_rst_intn;
   
   
    // 1000M
    reg [1:0]            mac_speed = 2'b10;
    // 100M
    // reg [1:0]            mac_speed = 2'b01;
   
    // USER side RX AXI-S interface
    wire                 rx_fifo_clock;
    wire                 rx_fifo_resetn;
   
    wire  [7:0]          rx_axis_fifo_tdata [0:4];
    wire                 rx_axis_fifo_tvalid [0:4];
    wire                 rx_axis_fifo_tlast [0:4];
    wire                 rx_axis_fifo_tready [0:4];

    wire [C_DATA_WIDTH - 1: 0] rx_axis_fifo_tdata_w [0:3];
    wire                       rx_axis_fifo_tvalid_w [0:3];
    wire                       rx_axis_fifo_tlast_w [0:3];
    wire                       rx_axis_fifo_tready_w [0:3];
    wire [C_DATA_WIDTH/8-1: 0] rx_axis_fifo_tkeep_w [0:3];
   

    // USER side TX AXI-S interface
    wire                 tx_fifo_clock;
    wire                 tx_fifo_resetn;
   
     wire  [7:0]          tx_axis_fifo_legacy_tdata [0:4];
     wire                 tx_axis_fifo_legacy_tvalid [0:4];
     wire                 tx_axis_fifo_legacy_tlast [0:4];
     wire                 tx_axis_fifo_legacy_tready [0:4];

    wire [C_DATA_WIDTH-1:0]   tx_axis_fifo_legacy_tdata_w [0:3];
    wire                      tx_axis_fifo_legacy_tvalid_w [0:3];
    wire                      tx_axis_fifo_legacy_tlast_w [0:3];
    wire                      tx_axis_fifo_legacy_tready_w [0:3];
    wire [C_DATA_WIDTH/8-1:0] tx_axis_fifo_legacy_tkeep_w [0:3];
   
    // RX Statistics serialisation signals
    wire  [4:0]          rx_statistics_valid;
    wire  [27:0]         rx_statistics_vector [0:4];

    // TX Statistics serialisation signals
    wire  [4:0]          tx_statistics_valid;
    wire  [31:0]         tx_statistics_vector [0:4];

    wire  [3:0]          inband_link_status;
    wire  [1:0]          inband_clock_speed [0:3];
    wire  [3:0]          inband_duplex_status;

    // Pause interface DESerialisation
    reg   [4:0]          pause_req;
    reg   [15:0]         pause_val [0:4];

    wire  [79:0]         rx_configuration_vector [0:3];
    wire  [79:0]         tx_configuration_vector [0:3];
   
    wire  [3:0]          tx_statistics_s;
    wire  [3:0]          rx_statistics_s;

    wire  [3:0]          int_frame_error;
    wire  [3:0]          int_activity_flash;

    // set board defaults - only updated when reprogrammed
    reg                  gen_tx_data = 0;

    // signal tie offs
    wire  [7:0]          tx_ifg_delay = 0;    // not used in this example
   
    // rgmii data bus
    wire [3:0] rgmii_txd [0:3];
    wire [3:0] rgmii_rxd [0:3];
   
    assign {rgmii_rxd[3], rgmii_rxd[2], rgmii_rxd[1], rgmii_rxd[0]} = rgmii_rxd_flat;
    assign rgmii_txd_flat = {rgmii_txd[3], rgmii_txd[2], rgmii_txd[1], rgmii_txd[0]};

    wire [3:0] rgmii_rxd_out [0:3];
    wire [15:0] rgmii_rxd_out_flat;
    wire [3:0] rgmii_rx_ctl_out;
    wire [3:0] rgmii_rxc_out;

    // ps eth mac gmii signal
    wire [7:0] ps_eth_gmii_txd;
    wire ps_eth_gmii_tx_en;
    wire ps_eth_gmii_tx_er;
    wire ps_eth_gmii_tx_clk;
    wire [7:0] ps_eth_gmii_rxd;
    wire ps_eth_gmii_rx_dv;
    wire ps_eth_gmii_rx_er;
    wire ps_eth_gmii_rx_clk;
    
    // mac axis signal
    wire [3:0] mac_tx_axis_tvalid_out;
    wire [3:0] mac_tx_axis_tready_out;
    wire [7:0] mac_tx_axis_tdata_out [0:3];
    wire [31:0] mac_tx_axis_tdata_flat;
    wire [3:0] mac_tx_axis_tlast_out;

    wire [3:0] mac_rx_axis_tvalid_out;
    wire [3:0] mac_rx_axis_tready_out;
    wire [7:0] mac_rx_axis_tdata_out [0:3];
    wire [31:0] mac_rx_axis_tdata_flat;
    wire [3:0] mac_rx_axis_tlast_out;

    assign mac_tx_axis_tdata_flat = {mac_tx_axis_tdata_out[3], mac_tx_axis_tdata_out[2], mac_tx_axis_tdata_out[1], mac_tx_axis_tdata_out[0]};
    assign mac_rx_axis_tdata_flat = {mac_rx_axis_tdata_out[3], mac_rx_axis_tdata_out[2], mac_rx_axis_tdata_out[1], mac_rx_axis_tdata_out[0]};


    // mac axi signal, 0-3 for PHY, 4 for internal PS eth.
    wire [11:0]   s_axi_awaddr [0:4];
    wire          s_axi_awvalid [0:4];
    wire          s_axi_awready [0:4];
    wire [31:0]   s_axi_wdata [0:4];
    wire          s_axi_wvalid [0:4];
    wire          s_axi_wready [0:4];
    wire [1:0]    s_axi_bresp [0:4];
    wire          s_axi_bvalid [0:4];
    wire          s_axi_bready [0:4];
    wire [11:0]   s_axi_araddr [0:4];
    wire          s_axi_arvalid [0:4];
    wire          s_axi_arready [0:4];
    wire [31:0]   s_axi_rdata [0:4];
    wire [1:0]    s_axi_rresp [0:4];
    wire          s_axi_rvalid [0:4];
    wire          s_axi_rready [0:4];

    
    wire S_AXI_DATAPATH_ACLK;
    wire S_AXI_DATAPATH_ARESETN;
    wire [31 : 0] S_AXI_DATAPATH_AWADDR;
    wire [2 : 0] S_AXI_DATAPATH_AWPROT;
    wire S_AXI_DATAPATH_AWVALID;
    wire S_AXI_DATAPATH_AWREADY;
    wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_DATAPATH_WDATA;
    wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_DATAPATH_WSTRB;
    wire S_AXI_DATAPATH_WVALID;
    wire S_AXI_DATAPATH_WREADY;
    wire [1 : 0] S_AXI_DATAPATH_BRESP;
    wire S_AXI_DATAPATH_BVALID;
    wire S_AXI_DATAPATH_BREADY;
    wire [31 : 0] S_AXI_DATAPATH_ARADDR;
    wire [2 : 0] S_AXI_DATAPATH_ARPROT;
    wire S_AXI_DATAPATH_ARVALID;
    wire S_AXI_DATAPATH_ARREADY;
    wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_DATAPATH_RDATA;
    wire [1 : 0] S_AXI_DATAPATH_RRESP;
    wire S_AXI_DATAPATH_RVALID;
    wire S_AXI_DATAPATH_RREADY;
  
    // Clock signal.
    clk_wiz_0 clk_wiz_0_i(
            .sys_clk(sys_clk),
            .reset(glbl_rst),
            .locked(dcm_locked),
            .clk125(gtx_clk_bufg),
            .clk200(refclk_bufg),
            .clk50(s_axi_aclk)
    );
    // Pass the GTX clock to the Test Bench
    assign gtx_clk_bufg_out = gtx_clk_bufg;

    //----------------------------------------------------------------------------
    // Generate the user side clocks for the axi fifos
    //----------------------------------------------------------------------------
    
    assign tx_fifo_clock = gtx_clk_bufg;
    assign rx_fifo_clock = gtx_clk_bufg;
    

    //----------------------------------------------------------------------------
    // Generate resets required for the fifo side signals etc
    //----------------------------------------------------------------------------

    tri_mode_ethernet_mac_0_example_design_resets example_resets
    (
        // clocks
        .s_axi_aclk       (s_axi_aclk),
        .gtx_clk          (gtx_clk_bufg),
    
        // asynchronous resets
        .glbl_rst         (glbl_rst || external_pl_reset),
        .reset_error      (1'b0),
        .rx_reset         (|rx_reset),
        .tx_reset         (|tx_reset),
    
        .dcm_locked       (dcm_locked),
    
        // synchronous reset outputs
    
        .glbl_rst_intn    (glbl_rst_intn),
    
        .gtx_resetn       (gtx_resetn),
    
        .s_axi_resetn     (s_axi_resetn),
        .phy_resetn       (phy_resetn_int), // This is based on glbl_rst
        .chk_resetn       ()
    );

    // generate the user side resets for the axi fifos
   
    assign tx_fifo_resetn = gtx_resetn;
    assign rx_fifo_resetn = gtx_resetn;
   

    genvar i;
    generate
        for (i = 0; i < NUM_PORTS; i = i + 1)
        begin
            tri_mode_ethernet_mac_0_axi_lite_sm axi_lite_controller (
                .s_axi_aclk                   (s_axi_aclk),
                .s_axi_resetn                 (s_axi_resetn),
            
                .mac_speed                    (mac_speed),
                .update_speed                 (1'b0),   // may need glitch protection on this..
                .serial_command               (1'b0),
                .serial_response              (),
                      
                .phy_loopback                 (1'b0),
            
                .s_axi_awaddr                 (s_axi_awaddr[i]),
                .s_axi_awvalid                (s_axi_awvalid[i]),
                .s_axi_awready                (s_axi_awready[i]),
            
                .s_axi_wdata                  (s_axi_wdata[i]),
                .s_axi_wvalid                 (s_axi_wvalid[i]),
                .s_axi_wready                 (s_axi_wready[i]),
            
                .s_axi_bresp                  (s_axi_bresp[i]),
                .s_axi_bvalid                 (s_axi_bvalid[i]),
                .s_axi_bready                 (s_axi_bready[i]),
            
                .s_axi_araddr                 (s_axi_araddr[i]),
                .s_axi_arvalid                (s_axi_arvalid[i]),
                .s_axi_arready                (s_axi_arready[i]),
            
                .s_axi_rdata                  (s_axi_rdata[i]),
                .s_axi_rresp                  (s_axi_rresp[i]),
                .s_axi_rvalid                 (s_axi_rvalid[i]),
                .s_axi_rready                 (s_axi_rready[i])
            );
        end
    endgenerate

    tri_mode_ethernet_mac_2_axi_lite_sm axi_lite_controller_ps_eth (
        .s_axi_aclk                   (s_axi_aclk),
        .s_axi_resetn                 (s_axi_resetn),
    
        .mac_speed                    (mac_speed),
        .update_speed                 (1'b0),   // may need glitch protection on this..
        .serial_command               (1'b0),
        .serial_response              (),
                
        .phy_loopback                 (1'b0),
    
        .s_axi_awaddr                 (s_axi_awaddr[4]),
        .s_axi_awvalid                (s_axi_awvalid[4]),
        .s_axi_awready                (s_axi_awready[4]),
    
        .s_axi_wdata                  (s_axi_wdata[4]),
        .s_axi_wvalid                 (s_axi_wvalid[4]),
        .s_axi_wready                 (s_axi_wready[4]),
    
        .s_axi_bresp                  (s_axi_bresp[4]),
        .s_axi_bvalid                 (s_axi_bvalid[4]),
        .s_axi_bready                 (s_axi_bready[4]),
    
        .s_axi_araddr                 (s_axi_araddr[4]),
        .s_axi_arvalid                (s_axi_arvalid[4]),
        .s_axi_arready                (s_axi_arready[4]),
    
        .s_axi_rdata                  (s_axi_rdata[4]),
        .s_axi_rresp                  (s_axi_rresp[4]),
        .s_axi_rvalid                 (s_axi_rvalid[4]),
        .s_axi_rready                 (s_axi_rready[4])
    );

    // ptp time clock
    wire [31:0] time_ptp_ns;
    wire [47:0] time_ptp_sec;
    wire [31:0] sync_time_ptp_ns;
    wire [47:0] sync_time_ptp_sec;
    wire [63:0] sync_time_ptp_ns_mini;
    
    wire [575:0] gcl_data_flat;
    wire [  3:0] gcl_ld;
    wire [  3:0] gcl_id;
    wire [  8:0] gcl_ld_data;
    
    wire [  3:0] gcl_time_ld;
    wire [  3:0] gcl_time_id;
    wire [ 19:0] gcl_ld_time;

    // AXIS DMA interfaces
    // PL clock
    wire [255:0]   axis_dma_i_tdata_0;
    wire [31:0]    axis_dma_i_tkeep_0;
    wire [127:0]   axis_dma_i_tuser_0;
    wire           axis_dma_i_tlast_0;
    wire           axis_dma_i_tready_0;
    wire           axis_dma_i_tvalid_0;

    // DMA PLC
    wire [255:0]   axis_plc_i_tdata_0;
    wire [31:0]    axis_plc_i_tkeep_0;
    wire [127:0]   axis_plc_i_tuser_0;
    wire           axis_plc_i_tlast_0;
    wire           axis_plc_i_tready_0;
    wire           axis_plc_i_tvalid_0;

    // DMA PS ETH
    wire [255:0]   axis_pseth_i_tdata_0;
    wire [31:0]    axis_pseth_i_tkeep_0;
    wire [127:0]   axis_pseth_i_tuser_0;
    wire           axis_pseth_i_tlast_0;
    wire           axis_pseth_i_tready_0;
    wire           axis_pseth_i_tvalid_0;

    assign axis_pseth_i_tuser_0 = 128'd0;

    wire [255:0]   axis_dma_i_tdata_0_cpuheader;
    wire [31:0]    axis_dma_i_tkeep_0_cpuheader;
    wire           axis_dma_i_tlast_0_cpuheader;
    wire           axis_dma_i_tready_0_cpuheader;
    wire           axis_dma_i_tvalid_0_cpuheader;

    // PS clock
    wire [255:0]   axis_dma_i_tdata_ps;
    wire [31:0]    axis_dma_i_tkeep_ps;
    wire           axis_dma_i_tlast_ps;
    wire           axis_dma_i_tready_ps;
    wire           axis_dma_i_tvalid_ps;

    wire [255:0]   axis_plc_i_tdata_ps;
    wire [31:0]    axis_plc_i_tkeep_ps;
    wire           axis_plc_i_tlast_ps;
    wire           axis_plc_i_tready_ps;
    wire           axis_plc_i_tvalid_ps;

    //PL clock
    wire [255:0]  axis_dma_o_tdata_0;
    wire [127:0]  axis_dma_o_tuser_0;
    wire [31:0]   axis_dma_o_tkeep_0;
    wire          axis_dma_o_tlast_0;
    wire          axis_dma_o_tready_0;
    wire          axis_dma_o_tvalid_0;

    wire [255:0]  axis_plc_o_tdata_0;
    wire [127:0]  axis_plc_o_tuser_0;
    wire [31:0]   axis_plc_o_tkeep_0;
    wire          axis_plc_o_tlast_0;
    wire          axis_plc_o_tready_0;
    wire          axis_plc_o_tvalid_0;

    wire [255:0]  axis_pseth_o_tdata_0;
    wire [127:0]  axis_pseth_o_tuser_0;
    wire [31:0]   axis_pseth_o_tkeep_0;
    wire          axis_pseth_o_tlast_0;
    wire          axis_pseth_o_tready_0;
    wire          axis_pseth_o_tvalid_0;

    wire [255:0]  axis_dma_o_tdata_0_cpuheader;
    wire [31:0]   axis_dma_o_tkeep_0_cpuheader;
    wire          axis_dma_o_tlast_0_cpuheader;
    wire          axis_dma_o_tready_0_cpuheader;
    wire          axis_dma_o_tvalid_0_cpuheader;

    // PS clock
    wire [255:0]  axis_dma_o_tdata_ps;
    wire [31:0]   axis_dma_o_tkeep_ps;
    wire          axis_dma_o_tlast_ps;
    wire          axis_dma_o_tready_ps;
    wire          axis_dma_o_tvalid_ps;

    wire [255:0]  axis_plc_o_tdata_ps;
    wire [31:0]   axis_plc_o_tkeep_ps;
    wire          axis_plc_o_tlast_ps;
    wire          axis_plc_o_tready_ps;
    wire          axis_plc_o_tvalid_ps;

    // PS clock signal
    wire m_axis_ps_clk;
    wire s_axis_ps_clk;

    // PS resetn signl;
    wire axis_ps2pl_resetn;
    wire axis_pl2ps_resetn;
    wire axis_ps2pl_plc_resetn;
    wire axis_pl2ps_plc_resetn;

    //----------------------------------------------------------------------------
    // Instantiate the TRIMAC core fifo block wrapper
    //----------------------------------------------------------------------------
    simple_mac simple_mac_0 (
        .gtx_clk                      (gtx_clk_bufg),
        // Output clocks for share
        .gtx_clk_out                  (gtx_clk_out),
        .gtx_clk90_out                (gtx_clk90_out),
        
        // asynchronous reset
        .glbl_rstn                    (glbl_rst_intn),
        .rx_axi_rstn                  (1'b1),
        .tx_axi_rstn                  (1'b1),

        // Reference clock for IDELAYCTRL's
        .refclk                       (refclk_bufg),

        // Receiver Statistics Interface
        //---------------------------------------
        .rx_mac_aclk                  (rx_mac_aclk[0]),
        .rx_reset                     (rx_reset[0]),
        .rx_statistics_vector         (rx_statistics_vector[0]),
        .rx_statistics_valid          (rx_statistics_valid[0]),

        // Receiver (AXI-S) Interface
        //----------------------------------------
        .rx_fifo_clock                (rx_fifo_clock),
        .rx_fifo_resetn_in            (rx_fifo_resetn),
        .rx_axis_fifo_tdata           (rx_axis_fifo_tdata[0]),
        .rx_axis_fifo_tvalid          (rx_axis_fifo_tvalid[0]),
        .rx_axis_fifo_tready          (rx_axis_fifo_tready[0]),
        .rx_axis_fifo_tlast           (rx_axis_fifo_tlast[0]),
        
        // Transmitter Statistics Interface
        //------------------------------------------
        .tx_mac_aclk                  (tx_mac_aclk[0]),
        .tx_reset                     (tx_reset[0]),
        .tx_ifg_delay                 (tx_ifg_delay),
        .tx_statistics_vector         (tx_statistics_vector[0]),
        .tx_statistics_valid          (tx_statistics_valid[0]),

        // Transmitter (AXI-S) Interface
        //-------------------------------------------
        .tx_fifo_clock                (tx_fifo_clock),
        .tx_fifo_resetn_in            (tx_fifo_resetn),
        .tx_axis_fifo_legacy_tdata           (tx_axis_fifo_legacy_tdata[0]),
        .tx_axis_fifo_legacy_tvalid          (tx_axis_fifo_legacy_tvalid[0]),
        .tx_axis_fifo_legacy_tready          (tx_axis_fifo_legacy_tready[0]),
        .tx_axis_fifo_legacy_tlast           (tx_axis_fifo_legacy_tlast[0]),
        
        // MAC Control Interface
        //------------------------
        .pause_req                    (pause_req[0]),
        .pause_val                    (pause_val[0]),

        // RGMII Interface
        //------------------
        .rgmii_txd                    (rgmii_txd[0]),
        .rgmii_tx_ctl                 (rgmii_tx_ctl[0]),
        .rgmii_txc                    (rgmii_txc[0]),
        .rgmii_rxd                    (rgmii_rxd[0]),
        .rgmii_rx_ctl                 (rgmii_rx_ctl[0]),
        .rgmii_rxc                    (rgmii_rxc[0]),

        // .rgmii_rxd_out               (rgmii_rxd_out[0]),
        // .rgmii_rx_ctl_out            (rgmii_rx_ctl_out[0]),
        // .rgmii_rxc_out               (rgmii_rxc_out[0]),
        // RGMII Inband Status Registers
        //--------------------------------
        .inband_link_status           (inband_link_status[0]),
        .inband_clock_speed           (inband_clock_speed[0]),
        .inband_duplex_status         (inband_duplex_status[0]),
        // .rx_configuration_vector      (rx_configuration_vector[0]),
        // .tx_configuration_vector      (tx_configuration_vector[0])
      
        .mdio                         (mdio[0]),
        .mdc                          (mdc[0]),

        // AXI-Lite Interface
        //---------------
        .s_axi_aclk                   (s_axi_aclk),
        .s_axi_resetn                 (s_axi_resetn),

        .s_axi_awaddr                 (s_axi_awaddr[0]),
        .s_axi_awvalid                (s_axi_awvalid[0]),
        .s_axi_awready                (s_axi_awready[0]),

        .s_axi_wdata                  (s_axi_wdata[0]),
        .s_axi_wvalid                 (s_axi_wvalid[0]),
        .s_axi_wready                 (s_axi_wready[0]),

        .s_axi_bresp                  (s_axi_bresp[0]),
        .s_axi_bvalid                 (s_axi_bvalid[0]),
        .s_axi_bready                 (s_axi_bready[0]),

        .s_axi_araddr                 (s_axi_araddr[0]),
        .s_axi_arvalid                (s_axi_arvalid[0]),
        .s_axi_arready                (s_axi_arready[0]),

        .s_axi_rdata                  (s_axi_rdata[0]),
        .s_axi_rresp                  (s_axi_rresp[0]),
        .s_axi_rvalid                 (s_axi_rvalid[0]),
        .s_axi_rready                 (s_axi_rready[0]),

        .mac_tx_axis_tvalid_out       (mac_tx_axis_tvalid_out[0]),
        .mac_tx_axis_tready_out       (mac_tx_axis_tready_out[0]),
        .mac_tx_axis_tdata_out        (mac_tx_axis_tdata_out[0]),
        .mac_tx_axis_tlast_out        (mac_tx_axis_tlast_out[0]),

        .mac_rx_axis_tvalid_out       (mac_rx_axis_tvalid_out[0]),
        .mac_rx_axis_tready_out       (mac_rx_axis_tready_out[0]),
        .mac_rx_axis_tdata_out        (mac_rx_axis_tdata_out[0]),
        .mac_rx_axis_tlast_out        (mac_rx_axis_tlast_out[0])
    );
    genvar j;
    generate
        for (j = 1; j < NUM_PORTS; j = j + 1)
        begin
            simple_mac_no_shared simple_mac_no_shared_i (
                .gtx_clk                      (gtx_clk_out),
                .gtx_clk90                    (gtx_clk90_out),
                
                
                // asynchronous reset
                .glbl_rstn                    (glbl_rst_intn),
                .rx_axi_rstn                  (1'b1),
                .tx_axi_rstn                  (1'b1),
            
                // Receiver Statistics Interface
                //---------------------------------------
                .rx_mac_aclk                  (rx_mac_aclk[j]),
                .rx_reset                     (rx_reset[j]),
                .rx_statistics_vector         (rx_statistics_vector[j]),
                .rx_statistics_valid          (rx_statistics_valid[j]),
            
                // Receiver (AXI-S) Interface
                //----------------------------------------
                .rx_fifo_clock                (rx_fifo_clock),
                .rx_fifo_resetn_in            (rx_fifo_resetn),
                .rx_axis_fifo_tdata           (rx_axis_fifo_tdata[j]),
                .rx_axis_fifo_tvalid          (rx_axis_fifo_tvalid[j]),
                .rx_axis_fifo_tready          (rx_axis_fifo_tready[j]),
                .rx_axis_fifo_tlast           (rx_axis_fifo_tlast[j]),
                
                // Transmitter Statistics Interface
                //------------------------------------------
                .tx_mac_aclk                  (tx_mac_aclk[j]),
                .tx_reset                     (tx_reset[j]),
                .tx_ifg_delay                 (tx_ifg_delay),
                .tx_statistics_vector         (tx_statistics_vector[j]),
                .tx_statistics_valid          (tx_statistics_valid[j]),
            
                // Transmitter (AXI-S) Interface
                //-------------------------------------------
                .tx_fifo_clock                (tx_fifo_clock),
                .tx_fifo_resetn_in            (tx_fifo_resetn),
                .tx_axis_fifo_legacy_tdata           (tx_axis_fifo_legacy_tdata[j]),
                .tx_axis_fifo_legacy_tvalid          (tx_axis_fifo_legacy_tvalid[j]),
                .tx_axis_fifo_legacy_tready          (tx_axis_fifo_legacy_tready[j]),
                .tx_axis_fifo_legacy_tlast           (tx_axis_fifo_legacy_tlast[j]),
                
                // MAC Control Interface
                //------------------------
                .pause_req                    (pause_req[j]),
                .pause_val                    (pause_val[j]),
            
                // RGMII Interface
                //------------------
                .rgmii_txd                    (rgmii_txd[j]),
                .rgmii_tx_ctl                 (rgmii_tx_ctl[j]),
                .rgmii_txc                    (rgmii_txc[j]),
                .rgmii_rxd                    (rgmii_rxd[j]),
                .rgmii_rx_ctl                 (rgmii_rx_ctl[j]),
                .rgmii_rxc                    (rgmii_rxc[j]),

                // RGMII Inband Status Registers
                //--------------------------------
                .inband_link_status           (inband_link_status[j]),
                .inband_clock_speed           (inband_clock_speed[j]),
                .inband_duplex_status         (inband_duplex_status[j]),
                
                .mdio                         (mdio[j]),
                .mdc                          (mdc[j]),
                
                // AXI-Lite Interface
                //---------------
                .s_axi_aclk                   (s_axi_aclk),
                .s_axi_resetn                 (s_axi_resetn),
        
                .s_axi_awaddr                 (s_axi_awaddr[j]),
                .s_axi_awvalid                (s_axi_awvalid[j]),
                .s_axi_awready                (s_axi_awready[j]),
        
                .s_axi_wdata                  (s_axi_wdata[j]),
                .s_axi_wvalid                 (s_axi_wvalid[j]),
                .s_axi_wready                 (s_axi_wready[j]),
        
                .s_axi_bresp                  (s_axi_bresp[j]),
                .s_axi_bvalid                 (s_axi_bvalid[j]),
                .s_axi_bready                 (s_axi_bready[j]),
        
                .s_axi_araddr                 (s_axi_araddr[j]),
                .s_axi_arvalid                (s_axi_arvalid[j]),
                .s_axi_arready                (s_axi_arready[j]),
        
                .s_axi_rdata                  (s_axi_rdata[j]),
                .s_axi_rresp                  (s_axi_rresp[j]),
                .s_axi_rvalid                 (s_axi_rvalid[j]),
                .s_axi_rready                 (s_axi_rready[j]),
                
                .mac_tx_axis_tvalid_out       (mac_tx_axis_tvalid_out[j]),
                .mac_tx_axis_tready_out       (mac_tx_axis_tready_out[j]),
                .mac_tx_axis_tdata_out        (mac_tx_axis_tdata_out[j]),
                .mac_tx_axis_tlast_out        (mac_tx_axis_tlast_out[j]),

                .mac_rx_axis_tvalid_out       (mac_rx_axis_tvalid_out[j]),
                .mac_rx_axis_tready_out       (mac_rx_axis_tready_out[j]),
                .mac_rx_axis_tdata_out        (mac_rx_axis_tdata_out[j]),
                .mac_rx_axis_tlast_out        (mac_rx_axis_tlast_out[j])
            );
        end
    endgenerate

    simple_mac_no_shared_int simple_mac_no_shared_int_i (
        .gtx_clk                      (gtx_clk_out),
        .gtx_clk90                    (gtx_clk90_out),
        
        
        // asynchronous reset
        .glbl_rstn                    (glbl_rst_intn),
        .rx_axi_rstn                  (1'b1),
        .tx_axi_rstn                  (1'b1),
    
        // Receiver Statistics Interface
        //---------------------------------------
        .rx_mac_aclk                  (rx_mac_aclk[4]),
        .rx_reset                     (rx_reset[4]),
        .rx_statistics_vector         (rx_statistics_vector[4]),
        .rx_statistics_valid          (rx_statistics_valid[4]),
    
        // Receiver (AXI-S) Interface
        //----------------------------------------
        .rx_fifo_clock                (rx_fifo_clock),
        .rx_fifo_resetn_in            (rx_fifo_resetn),
        .rx_axis_fifo_tdata           (rx_axis_fifo_tdata[4]),
        .rx_axis_fifo_tvalid          (rx_axis_fifo_tvalid[4]),
        .rx_axis_fifo_tready          (rx_axis_fifo_tready[4]),
        .rx_axis_fifo_tlast           (rx_axis_fifo_tlast[4]),
        
        // Transmitter Statistics Interface
        //------------------------------------------
        .tx_mac_aclk                  (tx_mac_aclk[4]),
        .tx_reset                     (tx_reset[4]),
        .tx_ifg_delay                 (tx_ifg_delay),
        .tx_statistics_vector         (tx_statistics_vector[4]),
        .tx_statistics_valid          (tx_statistics_valid[4]),
    
        // Transmitter (AXI-S) Interface
        //-------------------------------------------
        .tx_fifo_clock                (tx_fifo_clock),
        .tx_fifo_resetn_in            (tx_fifo_resetn),
        .tx_axis_fifo_legacy_tdata    (tx_axis_fifo_legacy_tdata[4]),
        .tx_axis_fifo_legacy_tvalid   (tx_axis_fifo_legacy_tvalid[4]),
        .tx_axis_fifo_legacy_tready   (tx_axis_fifo_legacy_tready[4]),
        .tx_axis_fifo_legacy_tlast    (tx_axis_fifo_legacy_tlast[4]),
        
        // MAC Control Interface
        //------------------------
        .pause_req                    (pause_req[4]),
        .pause_val                    (pause_val[4]),

        .gmii_txd                     (ps_eth_gmii_txd),
        .gmii_tx_en                   (ps_eth_gmii_tx_en),
        .gmii_tx_er                   (ps_eth_gmii_tx_er),
        .gmii_rxd                     (ps_eth_gmii_rxd),
        .gmii_rx_dv                   (ps_eth_gmii_rx_dv),
        .gmii_rx_er                   (ps_eth_gmii_rx_er),
        
        // AXI-Lite Interface
        //---------------
        .s_axi_aclk                   (s_axi_aclk),
        .s_axi_resetn                 (s_axi_resetn),

        .s_axi_awaddr                 (s_axi_awaddr[4]),
        .s_axi_awvalid                (s_axi_awvalid[4]),
        .s_axi_awready                (s_axi_awready[4]),

        .s_axi_wdata                  (s_axi_wdata[4]),
        .s_axi_wvalid                 (s_axi_wvalid[4]),
        .s_axi_wready                 (s_axi_wready[4]),

        .s_axi_bresp                  (s_axi_bresp[4]),
        .s_axi_bvalid                 (s_axi_bvalid[4]),
        .s_axi_bready                 (s_axi_bready[4]),

        .s_axi_araddr                 (s_axi_araddr[4]),
        .s_axi_arvalid                (s_axi_arvalid[4]),
        .s_axi_arready                (s_axi_arready[4]),

        .s_axi_rdata                  (s_axi_rdata[4]),
        .s_axi_rresp                  (s_axi_rresp[4]),
        .s_axi_rvalid                 (s_axi_rvalid[4]),
        .s_axi_rready                 (s_axi_rready[4]),
        
        .mac_tx_axis_tvalid_out       (),
        .mac_tx_axis_tready_out       (),
        .mac_tx_axis_tdata_out        (),
        .mac_tx_axis_tlast_out        (),

        .mac_rx_axis_tvalid_out       (),
        .mac_rx_axis_tready_out       (),
        .mac_rx_axis_tdata_out        (),
        .mac_rx_axis_tlast_out        ()
    );
   
    localparam [0:639] TUSERARRAY = {
        128'h00000000000000000000000000010000, // ETH1
        128'h00000000000000000000000000040000, // ETH2
        128'h00000000000000000000000000100000, // ETH3
        128'h00000000000000000000000000400000, // ETH4
        128'h00000000000000000000000000200000  // PS_ETH
    };

    generate
        for (j = 0; j < NUM_PORTS; j = j + 1) begin
            axis_dwidth_converter_8_256 width_converter_8_256_legacy (
                .aclk(rx_fifo_clock),                    // input wire aclk
                .aresetn(rx_fifo_resetn),              // input wire aresetn
                .s_axis_tvalid(rx_axis_fifo_tvalid[j]),  // input wire s_axis_tvalid
                .s_axis_tready(rx_axis_fifo_tready[j]),  // output wire s_axis_tready
                .s_axis_tdata(rx_axis_fifo_tdata[j]),    // input wire [7 : 0] s_axis_tdata
                .s_axis_tlast(rx_axis_fifo_tlast[j]),    // input wire s_axis_tlast
                .m_axis_tvalid(rx_axis_fifo_tvalid_w[j]),  // output wire m_axis_tvalid
                .m_axis_tready(rx_axis_fifo_tready_w[j]),  // input wire m_axis_tready
                .m_axis_tdata(rx_axis_fifo_tdata_w[j]),    // output wire [255 : 0] m_axis_tdata
                .m_axis_tkeep(rx_axis_fifo_tkeep_w[j]),    // output wire [31 : 0] m_axis_tkeep
                .m_axis_tlast(rx_axis_fifo_tlast_w[j])    // output wire m_axis_tlast
            );

            axis_dwidth_converter_256_8 width_converter_256_8_legacy (
                .aclk(tx_fifo_clock),                    // input wire aclk
                .aresetn(tx_fifo_resetn),              // input wire aresetn
                .s_axis_tvalid(tx_axis_fifo_legacy_tvalid_w[j]),  // input wire s_axis_tvalid
                .s_axis_tready(tx_axis_fifo_legacy_tready_w[j]),  // output wire s_axis_tready
                .s_axis_tdata(tx_axis_fifo_legacy_tdata_w[j]),    // input wire [255 : 0] s_axis_tdata
                .s_axis_tkeep(tx_axis_fifo_legacy_tkeep_w[j]),    // input wire [31 : 0] s_axis_tkeep
                .s_axis_tlast(tx_axis_fifo_legacy_tlast_w[j]),    // input wire s_axis_tlast
                .m_axis_tvalid(tx_axis_fifo_legacy_tvalid[j]),  // output wire m_axis_tvalid
                .m_axis_tready(tx_axis_fifo_legacy_tready[j]),  // input wire m_axis_tready
                .m_axis_tdata(tx_axis_fifo_legacy_tdata[j]),    // output wire [7 : 0] m_axis_tdata
                .m_axis_tkeep(),    // output wire [0 : 0] m_axis_tkeep
                .m_axis_tlast(tx_axis_fifo_legacy_tlast[j])    // output wire m_axis_tlast
            );
        end
        
        // Unused ports.
        for (j = NUM_PORTS; j < 4; j = j + 1) begin
            assign rx_axis_fifo_tvalid_w[j] = 1'b0;
            assign rx_axis_fifo_tdata_w[j] = 256'd0;
            assign rx_axis_fifo_tkeep_w[j] = 32'd0;
            assign rx_axis_fifo_tlast_w[j] = 1'b0;
            
            assign tx_axis_fifo_legacy_tready_w[j] = 1'b1;
        end
    endgenerate

    // Width converter for PS ETH AXIS signals
    axis_dwidth_converter_8_256 width_converter_8_256_ps_eth (
        .aclk(rx_fifo_clock),                    // input wire aclk
        .aresetn(rx_fifo_resetn),              // input wire aresetn
        .s_axis_tvalid(rx_axis_fifo_tvalid[4]),  // input wire s_axis_tvalid
        .s_axis_tready(rx_axis_fifo_tready[4]),  // output wire s_axis_tready
        .s_axis_tdata(rx_axis_fifo_tdata[4]),    // input wire [7 : 0] s_axis_tdata
        .s_axis_tlast(rx_axis_fifo_tlast[4]),    // input wire s_axis_tlast
        .m_axis_tvalid(axis_pseth_i_tvalid_0),  // output wire m_axis_tvalid
        .m_axis_tready(axis_pseth_i_tready_0),  // input wire m_axis_tready
        .m_axis_tdata(axis_pseth_i_tdata_0),    // output wire [255 : 0] m_axis_tdata
        .m_axis_tkeep(axis_pseth_i_tkeep_0),    // output wire [31 : 0] m_axis_tkeep
        .m_axis_tlast(axis_pseth_i_tlast_0)    // output wire m_axis_tlast
    );

    axis_dwidth_converter_256_8 width_converter_256_8_ps_eth (
        .aclk(tx_fifo_clock),                    // input wire aclk
        .aresetn(tx_fifo_resetn),              // input wire aresetn
        .s_axis_tvalid(axis_pseth_o_tvalid_0),  // input wire s_axis_tvalid
        .s_axis_tready(axis_pseth_o_tready_0),  // output wire s_axis_tready
        .s_axis_tdata(axis_pseth_o_tdata_0),    // input wire [255 : 0] s_axis_tdata
        .s_axis_tkeep(axis_pseth_o_tkeep_0),    // input wire [31 : 0] s_axis_tkeep
        .s_axis_tlast(axis_pseth_o_tlast_0),    // input wire s_axis_tlast
        .m_axis_tvalid(tx_axis_fifo_legacy_tvalid[4]),  // output wire m_axis_tvalid
        .m_axis_tready(tx_axis_fifo_legacy_tready[4]),  // input wire m_axis_tready
        .m_axis_tdata(tx_axis_fifo_legacy_tdata[4]),    // output wire [7 : 0] m_axis_tdata
        .m_axis_tkeep(),    // output wire [0 : 0] m_axis_tkeep
        .m_axis_tlast(tx_axis_fifo_legacy_tlast[4])    // output wire m_axis_tlast
    );

    wire rx_axis_resetn = rx_fifo_resetn;
    wire tx_axis_resetn = tx_fifo_resetn;
    wire axis_resetn = rx_axis_resetn & tx_axis_resetn;

    localparam KEEPALL = {(C_DATA_WIDTH/8){1'b1}};

    // // with width converter
    // assign tx_axis_fifo_legacy_tdata_w[1] = rx_axis_fifo_tdata_w[0];
    // assign tx_axis_fifo_legacy_tkeep_w[1] = rx_axis_fifo_tkeep_w[0];
    // assign tx_axis_fifo_legacy_tvalid_w[1] = rx_axis_fifo_tvalid_w[0];
    // assign rx_axis_fifo_tready_w[0] = tx_axis_fifo_legacy_tready_w[1]; // LHS & RHS matters for assignment
    // assign tx_axis_fifo_legacy_tlast_w[1] = rx_axis_fifo_tlast_w[0];

    // assign tx_axis_fifo_legacy_tdata_w[0] = rx_axis_fifo_tdata_w[1];
    // assign tx_axis_fifo_legacy_tkeep_w[0] = rx_axis_fifo_tkeep_w[1];
    // assign tx_axis_fifo_legacy_tvalid_w[0] = rx_axis_fifo_tvalid_w[1];
    // assign rx_axis_fifo_tready_w[1] = tx_axis_fifo_legacy_tready_w[0];
    // assign tx_axis_fifo_legacy_tlast_w[0] = rx_axis_fifo_tlast_w[1];

    // // without width converter
    // assign tx_axis_fifo_legacy_tdata[1] = rx_axis_fifo_tdata[0];
    // assign tx_axis_fifo_legacy_tvalid[1] = rx_axis_fifo_tvalid[0];
    // assign tx_axis_fifo_legacy_tready[1] = rx_axis_fifo_tready[0];
    // assign tx_axis_fifo_legacy_tlast[1] = rx_axis_fifo_tlast[0];

    // assign tx_axis_fifo_legacy_tdata[0] = rx_axis_fifo_tdata[1];
    // assign tx_axis_fifo_legacy_tvalid[0] = rx_axis_fifo_tvalid[1];
    // assign tx_axis_fifo_legacy_tready[0] = rx_axis_fifo_tready[1];
    // assign tx_axis_fifo_legacy_tlast[0] = rx_axis_fifo_tlast[1];

    // // without width converter & without RX fifo
    // assign tx_axis_fifo_legacy_tdata[1]  = mac_rx_axis_tdata_out[0];
    // assign tx_axis_fifo_legacy_tvalid[1] = mac_rx_axis_tvalid_out[0];
    // assign tx_axis_fifo_legacy_tready[1] = mac_rx_axis_tready_out[0];
    // assign tx_axis_fifo_legacy_tlast[1]  = mac_rx_axis_tlast_out[0];

    // assign tx_axis_fifo_legacy_tdata[0]  = mac_rx_axis_tdata_out[1];
    // assign tx_axis_fifo_legacy_tvalid[0] = mac_rx_axis_tvalid_out[1];
    // assign tx_axis_fifo_legacy_tready[0] = mac_rx_axis_tready_out[1];
    // assign tx_axis_fifo_legacy_tlast[0]  = mac_rx_axis_tlast_out[1];

    datapath_v3 #(
        // Master AXI Stream Data Width
        .C_M_AXIS_DATA_WIDTH (C_DATA_WIDTH),
        .C_S_AXIS_DATA_WIDTH (C_DATA_WIDTH),
        .C_M_AXIS_TUSER_WIDTH (128),
        .C_S_AXIS_TUSER_WIDTH (128),
        .NUM_QUEUES_PORT (2),
        .NUM_PORTS (NUM_PORTS)
    )
    nf_datapath_i 
    (
        .axis_aclk                      (rx_fifo_clock),
        .axis_resetn                    (axis_resetn),
        // .axis_resetn                 (1'b1),
        
        // Slave Stream Ports (interface from Rx queues)
        .s_axis_0_tdata                 (rx_axis_fifo_tdata_w[0]),  
        .s_axis_0_tkeep                 (rx_axis_fifo_tkeep_w[0]),  
        .s_axis_0_tuser                 (TUSERARRAY[0:127]),  
        .s_axis_0_tvalid                (rx_axis_fifo_tvalid_w[0]), 
        .s_axis_0_tready                (rx_axis_fifo_tready_w[0]), 
        .s_axis_0_tlast                 (rx_axis_fifo_tlast_w[0]),  
        .s_axis_1_tdata                 (rx_axis_fifo_tdata_w[1]),  
        .s_axis_1_tkeep                 (rx_axis_fifo_tkeep_w[1]),  
        .s_axis_1_tuser                 (TUSERARRAY[128:255]),  
        .s_axis_1_tvalid                (rx_axis_fifo_tvalid_w[1]), 
        .s_axis_1_tready                (rx_axis_fifo_tready_w[1]), 
        .s_axis_1_tlast                 (rx_axis_fifo_tlast_w[1]),  
        .s_axis_2_tdata                 (rx_axis_fifo_tdata_w[2]),  
        .s_axis_2_tkeep                 (rx_axis_fifo_tkeep_w[2]),  
        .s_axis_2_tuser                 (TUSERARRAY[256:383]),  
        .s_axis_2_tvalid                (rx_axis_fifo_tvalid_w[2]), 
        .s_axis_2_tready                (rx_axis_fifo_tready_w[2]), 
        .s_axis_2_tlast                 (rx_axis_fifo_tlast_w[2]),  
        .s_axis_3_tdata                 (rx_axis_fifo_tdata_w[3]),  
        .s_axis_3_tkeep                 (rx_axis_fifo_tkeep_w[3]),  
        .s_axis_3_tuser                 (TUSERARRAY[384:511]),  
        .s_axis_3_tvalid                (rx_axis_fifo_tvalid_w[3]), 
        .s_axis_3_tready                (rx_axis_fifo_tready_w[3]), 
        .s_axis_3_tlast                 (rx_axis_fifo_tlast_w[3]),  
        .s_axis_4_tdata                 (axis_dma_i_tdata_0), 
        .s_axis_4_tkeep                 (axis_dma_i_tkeep_0), 
        .s_axis_4_tuser                 (axis_dma_i_tuser_0), 
        .s_axis_4_tvalid                (axis_dma_i_tvalid_0),
        .s_axis_4_tready                (axis_dma_i_tready_0), 
        .s_axis_4_tlast                 (axis_dma_i_tlast_0),  
        .s_axis_5_tdata                 (axis_plc_i_tdata_0), 
        .s_axis_5_tkeep                 (axis_plc_i_tkeep_0), 
        .s_axis_5_tuser                 (axis_plc_i_tuser_0), 
        .s_axis_5_tvalid                (axis_plc_i_tvalid_0),
        .s_axis_5_tready                (axis_plc_i_tready_0), 
        .s_axis_5_tlast                 (axis_plc_i_tlast_0),  
        .s_axis_6_tdata                 (axis_pseth_i_tdata_0), 
        .s_axis_6_tkeep                 (axis_pseth_i_tkeep_0), 
        .s_axis_6_tuser                 (TUSERARRAY[512:639]), 
        .s_axis_6_tvalid                (axis_pseth_i_tvalid_0),
        .s_axis_6_tready                (axis_pseth_i_tready_0), 
        .s_axis_6_tlast                 (axis_pseth_i_tlast_0),  
    
        // Master Stream Ports (interface to TX queues)
        .m_axis_0_tdata                (tx_axis_fifo_legacy_tdata_w[0]),
        .m_axis_0_tkeep                (tx_axis_fifo_legacy_tkeep_w[0]),
        .m_axis_0_tuser                (),
        .m_axis_0_tvalid               (tx_axis_fifo_legacy_tvalid_w[0]),
        .m_axis_0_tready               (tx_axis_fifo_legacy_tready_w[0]),
        .m_axis_0_tlast                (tx_axis_fifo_legacy_tlast_w[0]),
        .m_axis_1_tdata                (tx_axis_fifo_legacy_tdata_w[1]), 
        .m_axis_1_tkeep                (tx_axis_fifo_legacy_tkeep_w[1]), 
        .m_axis_1_tuser                (), 
        .m_axis_1_tvalid               (tx_axis_fifo_legacy_tvalid_w[1]),
        .m_axis_1_tready               (tx_axis_fifo_legacy_tready_w[1]),
        .m_axis_1_tlast                (tx_axis_fifo_legacy_tlast_w[1]), 
        .m_axis_2_tdata                (tx_axis_fifo_legacy_tdata_w[2]), 
        .m_axis_2_tkeep                (tx_axis_fifo_legacy_tkeep_w[2]), 
        .m_axis_2_tuser                (), 
        .m_axis_2_tvalid               (tx_axis_fifo_legacy_tvalid_w[2]),
        .m_axis_2_tready               (tx_axis_fifo_legacy_tready_w[2]),
        .m_axis_2_tlast                (tx_axis_fifo_legacy_tlast_w[2]), 
        .m_axis_3_tdata                (tx_axis_fifo_legacy_tdata_w[3]), 
        .m_axis_3_tkeep                (tx_axis_fifo_legacy_tkeep_w[3]), 
        .m_axis_3_tuser                (), 
        .m_axis_3_tvalid               (tx_axis_fifo_legacy_tvalid_w[3]),
        .m_axis_3_tready               (tx_axis_fifo_legacy_tready_w[3]),
        .m_axis_3_tlast                (tx_axis_fifo_legacy_tlast_w[3]), 
        .m_axis_cpu_tdata                (axis_dma_o_tdata_0),
        .m_axis_cpu_tkeep                (axis_dma_o_tkeep_0),
        .m_axis_cpu_tuser                (axis_dma_o_tuser_0),
        .m_axis_cpu_tvalid               (axis_dma_o_tvalid_0),
        .m_axis_cpu_tready               (axis_dma_o_tready_0),
        .m_axis_cpu_tlast                (axis_dma_o_tlast_0),
        .m_axis_plc_tdata                (axis_plc_o_tdata_0),
        .m_axis_plc_tkeep                (axis_plc_o_tkeep_0),
        .m_axis_plc_tuser                (axis_plc_o_tuser_0),
        .m_axis_plc_tvalid               (axis_plc_o_tvalid_0),
        .m_axis_plc_tready               (axis_plc_o_tready_0),
        .m_axis_plc_tlast                (axis_plc_o_tlast_0),
        .m_axis_6_tdata                (axis_pseth_o_tdata_0),
        .m_axis_6_tkeep                (axis_pseth_o_tkeep_0),
        .m_axis_6_tuser                (axis_pseth_o_tuser_0),
        .m_axis_6_tvalid               (axis_pseth_o_tvalid_0),
        .m_axis_6_tready               (axis_pseth_o_tready_0),
        .m_axis_6_tlast                (axis_pseth_o_tlast_0),

        .sync_time_ptp_sec               (sync_time_ptp_sec),
        .sync_time_ptp_ns                (sync_time_ptp_ns),
        .sync_time_ptp_ns_mini           (sync_time_ptp_ns_mini),
        
        .gcl_clk_in(gtx_clk_bufg),
        .gcl_data_flat                   (gcl_data_flat),
        .gcl_ld(gcl_ld),
        .gcl_id(gcl_id),
        .gcl_ld_data(gcl_ld_data),
        .gcl_time_ld(gcl_time_ld),
        .gcl_time_id(gcl_time_id),
        .gcl_ld_time(gcl_ld_time),

        .S_AXI_ACLK(S_AXI_DATAPATH_ACLK),
        .S_AXI_ARESETN(S_AXI_DATAPATH_ARESETN),
        .S_AXI_AWADDR(S_AXI_DATAPATH_AWADDR[C_S_AXI_ADDR_WIDTH-1:0]),
        .S_AXI_AWPROT(S_AXI_DATAPATH_AWPROT),
        .S_AXI_AWVALID(S_AXI_DATAPATH_AWVALID),
        .S_AXI_AWREADY(S_AXI_DATAPATH_AWREADY),
        .S_AXI_WDATA(S_AXI_DATAPATH_WDATA),
        .S_AXI_WSTRB(S_AXI_DATAPATH_WSTRB),
        .S_AXI_WVALID(S_AXI_DATAPATH_WVALID),
        .S_AXI_WREADY(S_AXI_DATAPATH_WREADY),
        .S_AXI_BRESP(S_AXI_DATAPATH_BRESP),
        .S_AXI_BVALID(S_AXI_DATAPATH_BVALID),
        .S_AXI_BREADY(S_AXI_DATAPATH_BREADY),
        .S_AXI_ARADDR(S_AXI_DATAPATH_ARADDR[C_S_AXI_ADDR_WIDTH-1:0]),
        .S_AXI_ARPROT(S_AXI_DATAPATH_ARPROT),
        .S_AXI_ARVALID(S_AXI_DATAPATH_ARVALID),
        .S_AXI_ARREADY(S_AXI_DATAPATH_ARREADY),
        .S_AXI_RDATA(S_AXI_DATAPATH_RDATA),
        .S_AXI_RRESP(S_AXI_DATAPATH_RRESP),
        .S_AXI_RVALID(S_AXI_DATAPATH_RVALID),
        .S_AXI_RREADY(S_AXI_DATAPATH_RREADY)
    );

    wire           s_axi_clk_time_sync;
    wire           s_axi_aresetn_time_sync;

    wire  [31:0]   s_axi_awaddr_time_sync;
    //(* mark_debug = "true" *) wire [11:0] s_axi_awaddr_time_sync_debug;
    wire [11:0] s_axi_awaddr_time_sync_debug;
    assign s_axi_awaddr_time_sync_debug[11:0] = s_axi_awaddr_time_sync[11:0];
    wire           s_axi_awvalid_time_sync;
    //(* mark_debug = "true" *) wire s_axi_awvalid_time_sync_debug;
    wire s_axi_awvalid_time_sync_debug;
    assign s_axi_awvalid_time_sync_debug = s_axi_awvalid_time_sync;
    wire                s_axi_awready_time_sync;
    //(* mark_debug = "true" *) wire s_axi_awready_time_sync_debug;
    wire s_axi_awready_time_sync_debug;
    assign s_axi_awready_time_sync_debug = s_axi_awready_time_sync;

    wire  [31:0]   s_axi_wdata_time_sync;
    //(* mark_debug = "true" *) wire [7:0] s_axi_wdata_time_sync_debug;
    wire [7:0] s_axi_wdata_time_sync_debug;
    assign s_axi_wdata_time_sync_debug[7:0] = s_axi_wdata_time_sync[7:0];
    wire           s_axi_wvalid_time_sync;
    //(* mark_debug = "true" *) wire s_axi_wvalid_time_sync_debug;
    wire s_axi_wvalid_time_sync_debug;
    assign s_axi_wvalid_time_sync_debug = s_axi_wvalid_time_sync;
    wire                s_axi_wready_time_sync;
    //(* mark_debug = "true" *) wire s_axi_wready_time_sync_debug;
    wire s_axi_wready_time_sync_debug;
    assign s_axi_wready_time_sync_debug = s_axi_wready_time_sync;

    wire       [1:0]    s_axi_bresp_time_sync;
    //(* mark_debug = "true" *) wire [1:0] s_axi_bresp_time_sync_debug;
    wire [1:0] s_axi_bresp_time_sync_debug;
    assign s_axi_bresp_time_sync_debug = s_axi_bresp_time_sync;
    wire                s_axi_bvalid_time_sync;
    //(* mark_debug = "true" *) wire s_axi_bvalid_time_sync_debug;
    wire s_axi_bvalid_time_sync_debug;
    assign s_axi_bvalid_time_sync_debug = s_axi_bvalid_time_sync;
    wire           s_axi_bready_time_sync;
    //(* mark_debug = "true" *) wire s_axi_bready_time_sync_debug;
    wire s_axi_bready_time_sync_debug;
    assign s_axi_bready_time_sync_debug = s_axi_bready_time_sync;

    wire  [31:0]   s_axi_araddr_time_sync;
    //(* mark_debug = "true" *) wire [11:0] s_axi_araddr_time_sync_debug;
    wire [11:0] s_axi_araddr_time_sync_debug;
    assign s_axi_araddr_time_sync_debug[11:0] = s_axi_araddr_time_sync[11:0];
    wire           s_axi_arvalid_time_sync;
    //(* mark_debug = "true" *) wire s_axi_arvalid_time_sync_debug;
    wire s_axi_arvalid_time_sync_debug;
    assign s_axi_arvalid_time_sync_debug = s_axi_arvalid_time_sync;
    wire                s_axi_arready_time_sync;
    //(* mark_debug = "true" *) wire s_axi_arready_time_sync_debug;
    wire s_axi_arready_time_sync_debug;
    assign s_axi_arready_time_sync_debug = s_axi_arready_time_sync;

    wire       [31:0]   s_axi_rdata_time_sync;
    //(* mark_debug = "true" *) wire [7:0] s_axi_rdata_time_sync_debug;
    wire [7:0] s_axi_rdata_time_sync_debug;
    assign s_axi_rdata_time_sync_debug[7:0] = s_axi_rdata_time_sync[7:0];
    wire       [1:0]    s_axi_rresp_time_sync;
    //(* mark_debug = "true" *) wire [1:0] s_axi_rresp_time_sync_debug;
    wire [1:0] s_axi_rresp_time_sync_debug;
    assign s_axi_rresp_time_sync_debug = s_axi_rresp_time_sync;
    wire                s_axi_rvalid_time_sync;
    //(* mark_debug = "true" *) wire s_axi_rvalid_time_sync_debug;
    wire s_axi_rvalid_time_sync_debug;
    assign s_axi_rvalid_time_sync_debug = s_axi_rvalid_time_sync;
    wire           s_axi_rready_time_sync;
    //(* mark_debug = "true" *) wire s_axi_rready_time_sync_debug;
    wire s_axi_rready_time_sync_debug;
    assign s_axi_rready_time_sync_debug = s_axi_rready_time_sync;
    wire external_pl_reset;

    zynq_ps_wrapper zynq_ps_i
    (
        .DDR_addr(),
        .DDR_ba(),
        .DDR_cas_n(),
        .DDR_ck_n(),
        .DDR_ck_p(),
        .DDR_cke(),
        .DDR_cs_n(),
        .DDR_dm(),
        .DDR_dq(),
        .DDR_dqs_n(),
        .DDR_dqs_p(),
        .DDR_odt(),
        .DDR_ras_n(),
        .DDR_reset_n(),
        .DDR_we_n(),
        .FIXED_IO_ddr_vrn(),
        .FIXED_IO_ddr_vrp(),
        .FIXED_IO_mio(),
        .FIXED_IO_ps_clk(),
        .FIXED_IO_ps_porb(),
        .FIXED_IO_ps_srstb(),
        .GMII_ETHERNET_1_0_col(1'b0),
        .GMII_ETHERNET_1_0_crs(1'b0),
        .GMII_ETHERNET_1_0_rx_clk(gtx_clk_out),
        .GMII_ETHERNET_1_0_rx_dv(ps_eth_gmii_tx_en),
        .GMII_ETHERNET_1_0_rx_er(ps_eth_gmii_tx_er),
        .GMII_ETHERNET_1_0_rxd(ps_eth_gmii_txd),
        .GMII_ETHERNET_1_0_tx_clk(gtx_clk_out),
        .GMII_ETHERNET_1_0_tx_en(ps_eth_gmii_rx_dv),
        .GMII_ETHERNET_1_0_tx_er(ps_eth_gmii_rx_er),
        .GMII_ETHERNET_1_0_txd(ps_eth_gmii_rxd),
        .M_AXIS_0_tdata(axis_dma_i_tdata_ps),
        .M_AXIS_0_tkeep(axis_dma_i_tkeep_ps),
        .M_AXIS_0_tlast(axis_dma_i_tlast_ps),
        .M_AXIS_0_tready(axis_dma_i_tready_ps),
        .M_AXIS_0_tvalid(axis_dma_i_tvalid_ps),
        .M_AXIS_1_tdata(axis_plc_i_tdata_ps),
        .M_AXIS_1_tkeep(axis_plc_i_tkeep_ps),
        .M_AXIS_1_tlast(axis_plc_i_tlast_ps),
        .M_AXIS_1_tready(axis_plc_i_tready_ps),
        .M_AXIS_1_tvalid(axis_plc_i_tvalid_ps),
        .M_AXIS_CLK(m_axis_ps_clk),
        .S_AXIS_0_tdata(axis_dma_o_tdata_ps),
        .S_AXIS_0_tkeep(axis_dma_o_tkeep_ps),
        .S_AXIS_0_tlast(axis_dma_o_tlast_ps),
        .S_AXIS_0_tready(axis_dma_o_tready_ps),
        .S_AXIS_0_tvalid(axis_dma_o_tvalid_ps),
        .S_AXIS_1_tdata(axis_plc_o_tdata_ps),
        .S_AXIS_1_tkeep(axis_plc_o_tkeep_ps),
        .S_AXIS_1_tlast(axis_plc_o_tlast_ps),
        .S_AXIS_1_tready(axis_plc_o_tready_ps),
        .S_AXIS_1_tvalid(axis_plc_o_tvalid_ps),
        .S_AXIS_CLK(s_axis_ps_clk),
        .axis_pl2ps_plc_resetn(axis_pl2ps_plc_resetn),
        .axis_pl2ps_resetn(axis_pl2ps_resetn),
        .axis_ps2pl_plc_resetn(axis_ps2pl_plc_resetn),
        .axis_ps2pl_resetn(axis_ps2pl_resetn),

        .s_axi_plc_clk(S_AXI_DATAPATH_ACLK),
        .external_pl_reset(external_pl_reset),
        .s_axi_plc_araddr(S_AXI_DATAPATH_ARADDR),
        .s_axi_plc_arprot(S_AXI_DATAPATH_ARPROT),
        .s_axi_plc_arready(S_AXI_DATAPATH_ARREADY),
        .s_axi_plc_arvalid(S_AXI_DATAPATH_ARVALID),
        .s_axi_plc_awaddr(S_AXI_DATAPATH_AWADDR),
        .s_axi_plc_awprot(S_AXI_DATAPATH_AWPROT),
        .s_axi_plc_awready(S_AXI_DATAPATH_AWREADY),
        .s_axi_plc_awvalid(S_AXI_DATAPATH_AWVALID),
        .s_axi_plc_bready(S_AXI_DATAPATH_BREADY),
        .s_axi_plc_bresp(S_AXI_DATAPATH_BRESP),
        .s_axi_plc_bvalid(S_AXI_DATAPATH_BVALID),
        .s_axi_plc_rdata(S_AXI_DATAPATH_RDATA),
        .s_axi_plc_rready(S_AXI_DATAPATH_RREADY),
        .s_axi_plc_rresp(S_AXI_DATAPATH_RRESP),
        .s_axi_plc_rvalid(S_AXI_DATAPATH_RVALID),
        .s_axi_plc_wdata(S_AXI_DATAPATH_WDATA),
        .s_axi_plc_wready(S_AXI_DATAPATH_WREADY),
        .s_axi_plc_wstrb(S_AXI_DATAPATH_WSTRB),
        .s_axi_plc_wvalid(S_AXI_DATAPATH_WVALID),

        .s_axi_time_sync_araddr(s_axi_araddr_time_sync),
        .s_axi_time_sync_aresetn(s_axi_aresetn_time_sync),
        .s_axi_time_sync_arprot(),
        .s_axi_time_sync_arready(s_axi_arready_time_sync),
        .s_axi_time_sync_arvalid(s_axi_arvalid_time_sync),
        .s_axi_time_sync_awaddr(s_axi_awaddr_time_sync),
        .s_axi_time_sync_awprot(),
        .s_axi_time_sync_awready(s_axi_awready_time_sync),
        .s_axi_time_sync_awvalid(s_axi_awvalid_time_sync),
        .s_axi_time_sync_bready(s_axi_bready_time_sync),
        .s_axi_time_sync_bresp(s_axi_bresp_time_sync),
        .s_axi_time_sync_bvalid(s_axi_bvalid_time_sync),
        .s_axi_time_sync_clk(s_axi_clk_time_sync),
        .s_axi_time_sync_rdata(s_axi_rdata_time_sync),
        .s_axi_time_sync_rready(s_axi_rready_time_sync),
        .s_axi_time_sync_rresp(s_axi_rresp_time_sync),
        .s_axi_time_sync_rvalid(s_axi_rvalid_time_sync),
        .s_axi_time_sync_wdata(s_axi_wdata_time_sync),
        .s_axi_time_sync_wready(s_axi_wready_time_sync),
        .s_axi_time_sync_wstrb(),
        .s_axi_time_sync_wvalid(s_axi_wvalid_time_sync)
    );

    assign S_AXI_DATAPATH_ARESETN = s_axi_aresetn_time_sync;

    axis_clock_converter_0 pl2ps_axis_clock_converter (
        .s_axis_aresetn(tx_axis_resetn),  // input wire s_axis_aresetn
        .m_axis_aresetn(axis_pl2ps_resetn),  // input wire m_axis_aresetn
        .s_axis_aclk(tx_fifo_clock),        // input wire s_axis_aclk
        .s_axis_tvalid(axis_dma_o_tvalid_0_cpuheader),    // input wire s_axis_tvalid
        .s_axis_tready(axis_dma_o_tready_0_cpuheader),    // output wire s_axis_tready
        .s_axis_tdata(axis_dma_o_tdata_0_cpuheader),      // input wire [255 : 0] s_axis_tdata
        .s_axis_tkeep(axis_dma_o_tkeep_0_cpuheader),      // input wire [31 : 0] s_axis_tkeep
        .s_axis_tlast(axis_dma_o_tlast_0_cpuheader),      // input wire s_axis_tlast
        .m_axis_aclk(s_axis_ps_clk),        // input wire m_axis_aclk
        .m_axis_tvalid(axis_dma_o_tvalid_ps),    // output wire m_axis_tvalid
        .m_axis_tready(axis_dma_o_tready_ps),    // input wire m_axis_tready
        .m_axis_tdata(axis_dma_o_tdata_ps),      // output wire [255 : 0] m_axis_tdata
        .m_axis_tkeep(axis_dma_o_tkeep_ps),      // output wire [31 : 0] m_axis_tkeep
        .m_axis_tlast(axis_dma_o_tlast_ps)      // output wire m_axis_tlast
    );

    axis_clock_converter_0 ps2pl_axis_clock_converter (
        .s_axis_aresetn(axis_ps2pl_resetn),  // input wire s_axis_aresetn
        .m_axis_aresetn(rx_axis_resetn),  // input wire m_axis_aresetn
        .s_axis_aclk(m_axis_ps_clk),        // input wire s_axis_aclk
        .s_axis_tvalid(axis_dma_i_tvalid_ps),    // input wire s_axis_tvalid
        .s_axis_tready(axis_dma_i_tready_ps),    // output wire s_axis_tready
        .s_axis_tdata(axis_dma_i_tdata_ps),      // input wire [255 : 0] s_axis_tdata
        .s_axis_tkeep(axis_dma_i_tkeep_ps),      // input wire [31 : 0] s_axis_tkeep
        .s_axis_tlast(axis_dma_i_tlast_ps),      // input wire s_axis_tlast
        .m_axis_aclk(rx_fifo_clock),        // input wire m_axis_aclk
        .m_axis_tvalid(axis_dma_i_tvalid_0_cpuheader),    // output wire m_axis_tvalid
        .m_axis_tready(axis_dma_i_tready_0_cpuheader),    // input wire m_axis_tready
        .m_axis_tdata(axis_dma_i_tdata_0_cpuheader),      // output wire [255 : 0] m_axis_tdata
        .m_axis_tkeep(axis_dma_i_tkeep_0_cpuheader),      // output wire [31 : 0] m_axis_tkeep
        .m_axis_tlast(axis_dma_i_tlast_0_cpuheader)      // output wire m_axis_tlast
    );

    axis_clock_converter_0 plc_pl2ps_axis_clock_converter (
        .s_axis_aresetn(tx_axis_resetn),  // input wire s_axis_aresetn
        .m_axis_aresetn(axis_pl2ps_plc_resetn),  // input wire m_axis_aresetn
        .s_axis_aclk(tx_fifo_clock),        // input wire s_axis_aclk
        .s_axis_tvalid(axis_plc_o_tvalid_0),    // input wire s_axis_tvalid
        .s_axis_tready(axis_plc_o_tready_0),    // output wire s_axis_tready
        .s_axis_tdata(axis_plc_o_tdata_0),      // input wire [255 : 0] s_axis_tdata
        .s_axis_tkeep(axis_plc_o_tkeep_0),      // input wire [31 : 0] s_axis_tkeep
        .s_axis_tlast(axis_plc_o_tlast_0),      // input wire s_axis_tlast
        .m_axis_aclk(s_axis_ps_clk),        // input wire m_axis_aclk
        .m_axis_tvalid(axis_plc_o_tvalid_ps),    // output wire m_axis_tvalid
        .m_axis_tready(axis_plc_o_tready_ps),    // input wire m_axis_tready
        .m_axis_tdata(axis_plc_o_tdata_ps),      // output wire [255 : 0] m_axis_tdata
        .m_axis_tkeep(axis_plc_o_tkeep_ps),      // output wire [31 : 0] m_axis_tkeep
        .m_axis_tlast(axis_plc_o_tlast_ps)      // output wire m_axis_tlast
    );

    axis_clock_converter_0 plc_ps2pl_axis_clock_converter (
        .s_axis_aresetn(axis_ps2pl_plc_resetn),  // input wire s_axis_aresetn
        .m_axis_aresetn(rx_axis_resetn),  // input wire m_axis_aresetn
        .s_axis_aclk(m_axis_ps_clk),        // input wire s_axis_aclk
        .s_axis_tvalid(axis_plc_i_tvalid_ps),    // input wire s_axis_tvalid
        .s_axis_tready(axis_plc_i_tready_ps),    // output wire s_axis_tready
        .s_axis_tdata(axis_plc_i_tdata_ps),      // input wire [255 : 0] s_axis_tdata
        .s_axis_tkeep(axis_plc_i_tkeep_ps),      // input wire [31 : 0] s_axis_tkeep
        .s_axis_tlast(axis_plc_i_tlast_ps),      // input wire s_axis_tlast
        .m_axis_aclk(rx_fifo_clock),        // input wire m_axis_aclk
        .m_axis_tvalid(axis_plc_i_tvalid_0),    // output wire m_axis_tvalid
        .m_axis_tready(axis_plc_i_tready_0),    // input wire m_axis_tready
        .m_axis_tdata(axis_plc_i_tdata_0),      // output wire [255 : 0] m_axis_tdata
        .m_axis_tkeep(axis_plc_i_tkeep_0),      // output wire [31 : 0] m_axis_tkeep
        .m_axis_tlast(axis_plc_i_tlast_0)      // output wire m_axis_tlast
    );

    // dma_o -> add header -> dma_o_cpuheader
    cpu_header_add #(
        .C_DATA_WIDTH(C_DATA_WIDTH),
        .C_TUSER_WIDTH(C_TUSER_WIDTH)
    )
    cpu_header_add_i (
        .clk(tx_fifo_clock),
        .rst(!tx_axis_resetn),

        .s_axis_tdata(axis_dma_o_tdata_0),
        .s_axis_tuser(axis_dma_o_tuser_0),
        .s_axis_tkeep(axis_dma_o_tkeep_0),
        .s_axis_tvalid(axis_dma_o_tvalid_0),
        .s_axis_tlast(axis_dma_o_tlast_0),
        .s_axis_tready(axis_dma_o_tready_0),

        .m_axis_tdata(axis_dma_o_tdata_0_cpuheader),
        .m_axis_tkeep(axis_dma_o_tkeep_0_cpuheader),
        .m_axis_tvalid(axis_dma_o_tvalid_0_cpuheader),
        .m_axis_tlast(axis_dma_o_tlast_0_cpuheader),
        .m_axis_tready(axis_dma_o_tready_0_cpuheader)
    );

    // dma_i_cpuheader -> remove header -> dma_i
    cpu_header_rm #(
        .C_DATA_WIDTH(C_DATA_WIDTH),
        .C_TUSER_WIDTH(C_TUSER_WIDTH)
    )
    cpu_header_rm_i (
        .clk(rx_fifo_clock),
        .rst(!rx_axis_resetn),

        .s_axis_tdata(axis_dma_i_tdata_0_cpuheader),
        .s_axis_tkeep(axis_dma_i_tkeep_0_cpuheader),
        .s_axis_tvalid(axis_dma_i_tvalid_0_cpuheader),
        .s_axis_tlast(axis_dma_i_tlast_0_cpuheader),
        .s_axis_tready(axis_dma_i_tready_0_cpuheader),

        .m_axis_tdata(axis_dma_i_tdata_0),
        .m_axis_tkeep(axis_dma_i_tkeep_0),
        .m_axis_tuser(axis_dma_i_tuser_0),
        .m_axis_tvalid(axis_dma_i_tvalid_0),
        .m_axis_tlast(axis_dma_i_tlast_0),
        .m_axis_tready(axis_dma_i_tready_0)
    );

    time_sync_hw time_sync_hw_i(
        .rst(!axis_resetn),
        .S_AXI_REG_ACLK(s_axi_clk_time_sync),
        // .S_AXI_REG_ACLK(s_axi_aclk),
        .S_AXI_REG_ARESETN(s_axi_aresetn_time_sync),
        // .S_AXI_REG_ARESETN(s_axi_resetn),

        .S_AXI_REG_AWADDR(s_axi_awaddr_time_sync),
        .S_AXI_REG_AWPROT(3'b0),
        .S_AXI_REG_AWVALID(s_axi_awvalid_time_sync),
        .S_AXI_REG_AWREADY(s_axi_awready_time_sync),

        .S_AXI_REG_WDATA(s_axi_wdata_time_sync),
        .S_AXI_REG_WSTRB(4'hf),
        .S_AXI_REG_WVALID(s_axi_wvalid_time_sync),
        .S_AXI_REG_WREADY(s_axi_wready_time_sync),
              
        .S_AXI_REG_BRESP(s_axi_bresp_time_sync),
        .S_AXI_REG_BVALID(s_axi_bvalid_time_sync),
        .S_AXI_REG_BREADY(s_axi_bready_time_sync),
              
        .S_AXI_REG_ARADDR(s_axi_araddr_time_sync),
        .S_AXI_REG_ARPROT(3'b0),
        .S_AXI_REG_ARVALID(s_axi_arvalid_time_sync),
        .S_AXI_REG_ARREADY(s_axi_arready_time_sync),
              
        .S_AXI_REG_RDATA(s_axi_rdata_time_sync),
        .S_AXI_REG_RRESP(s_axi_rresp_time_sync),
        .S_AXI_REG_RVALID(s_axi_rvalid_time_sync),
        .S_AXI_REG_RREADY(s_axi_rready_time_sync),

        .INTR_OUT(),
        
        .rtc_clk(gtx_clk_bufg),
        .time_ptp_ns(time_ptp_ns),
        .time_ptp_sec(time_ptp_sec),
        .sync_time_ptp_ns(sync_time_ptp_ns),
        .sync_time_ptp_sec(sync_time_ptp_sec),
        .sync_time_ptp_ns_mini(sync_time_ptp_ns_mini),
        .rtc_time_one_pps(),

        .mac_tx_axis_aclk(tx_mac_aclk),
        .mac_tx_axis_tvalid(mac_tx_axis_tvalid_out),
        .mac_tx_axis_tready(mac_tx_axis_tready_out),
        .mac_tx_axis_tdata_flat(mac_tx_axis_tdata_flat),
        .mac_tx_axis_tlast(mac_tx_axis_tlast_out),

        .mac_rx_axis_aclk(rx_mac_aclk),
        .mac_rx_axis_tvalid(mac_rx_axis_tvalid_out),
        .mac_rx_axis_tready(mac_rx_axis_tready_out),
        .mac_rx_axis_tdata_flat(mac_rx_axis_tdata_flat),
        .mac_rx_axis_tlast(mac_rx_axis_tlast_out),
        
        .gcl_clk_in(gtx_clk_bufg),
        .gcl_data_flat_in(gcl_data_flat),
        .gcl_ld(gcl_ld),
        .gcl_id(gcl_id),
        .gcl_ld_data(gcl_ld_data),
        .gcl_time_ld(gcl_time_ld),
        .gcl_time_id(gcl_time_id),
        .gcl_ld_time(gcl_ld_time)

    );

endmodule
