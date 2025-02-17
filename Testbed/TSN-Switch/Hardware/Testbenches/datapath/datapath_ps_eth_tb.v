`timescale 1ns/1ps

module datapath_ps_eth_tb ();

// Local parameters
localparam ONE_NS = 1;
localparam time PER_125M_clk = 8*ONE_NS; // 8 ns period
localparam time PER_50M_clk = 20*ONE_NS; // 20 ns period

localparam AXIS_DATA_WIDTH = 256;
localparam AXIS_TUSER_WIDTH = 128;
localparam NUM_PATHS = 7;

// Reg declarations
reg clk = 1;
reg gcl_clk = 1;
reg reset = 1;
reg [31:0] sync_time_ptp_ns;
reg [63:0] sync_time_ptp_ns_mini;

// Clock signals
always begin
    clk = #(PER_125M_clk/2) ~clk;
end

always begin
    gcl_clk = #(PER_50M_clk/2) ~gcl_clk;
end

always @(posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
        sync_time_ptp_ns <= 0;
    end
    else begin
        sync_time_ptp_ns <= (sync_time_ptp_ns + 8) % 1_000_000_000;
    end
end

always @(posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
        sync_time_ptp_ns_mini = 0;
    end
    else begin
        sync_time_ptp_ns_mini = sync_time_ptp_ns_mini + 8;
    end
end

wire [AXIS_DATA_WIDTH-1:0] s_axis_tdata[0:NUM_PATHS-1];
wire [(AXIS_DATA_WIDTH/8)-1:0] s_axis_tkeep[0:NUM_PATHS-1];
wire [AXIS_TUSER_WIDTH-1:0] s_axis_tuser[0:NUM_PATHS-1];
wire [NUM_PATHS-1:0] s_axis_tvalid;
wire [NUM_PATHS-1:0] s_axis_tready;
wire [NUM_PATHS-1:0] s_axis_tlast;

wire [AXIS_DATA_WIDTH-1:0]          m_axis_tdata[0:NUM_PATHS-1];
wire [(AXIS_DATA_WIDTH/8)-1:0]      m_axis_tkeep[0:NUM_PATHS-1];
wire [AXIS_TUSER_WIDTH-1:0]         m_axis_tuser[0:NUM_PATHS-1];
wire [NUM_PATHS-1:0]                          m_axis_tvalid;
reg  [NUM_PATHS-1:0]                          m_axis_tready;
wire [NUM_PATHS-1:0]                          m_axis_tlast;

wire [11:0]   M01_AXI_araddr_0 = 12'b0;
wire [2:0]    M01_AXI_arprot_0;
wire [0:0]    M01_AXI_arready_0;
wire [0:0]    M01_AXI_arvalid_0 = 1'b0;
wire [11:0]   M01_AXI_awaddr_0 = 12'b0;
wire [2:0]    M01_AXI_awprot_0;
wire [0:0]    M01_AXI_awready_0;
wire [0:0]    M01_AXI_awvalid_0 = 1'b0;
wire [0:0]    M01_AXI_bready_0 = 1'b0;
wire [1:0]    M01_AXI_bresp_0;
wire [0:0]    M01_AXI_bvalid_0;
wire [31:0]   M01_AXI_rdata_0;
wire [0:0]    M01_AXI_rready_0 = 1'b0;
wire [1:0]    M01_AXI_rresp_0;
wire [0:0]    M01_AXI_rvalid_0;
wire [31:0]   M01_AXI_wdata_0 = 32'b0;
wire [0:0]    M01_AXI_wready_0;
wire [3:0]    M01_AXI_wstrb_0 = 4'b0;
wire [0:0]    M01_AXI_wvalid_0 = 1'b0;

wire [11:0]   M02_AXI_araddr_0 = 12'b0;
wire [2:0]    M02_AXI_arprot_0;
wire [0:0]    M02_AXI_arready_0;
wire [0:0]    M02_AXI_arvalid_0 = 1'b0;
wire [11:0]   M02_AXI_awaddr_0 = 12'b0;
wire [2:0]    M02_AXI_awprot_0;
wire [0:0]    M02_AXI_awready_0;
wire [0:0]    M02_AXI_awvalid_0 = 1'b0;
wire [0:0]    M02_AXI_bready_0 = 1'b0;
wire [1:0]    M02_AXI_bresp_0;
wire [0:0]    M02_AXI_bvalid_0;
wire [31:0]   M02_AXI_rdata_0;
wire [0:0]    M02_AXI_rready_0 = 1'b0;
wire [1:0]    M02_AXI_rresp_0;
wire [0:0]    M02_AXI_rvalid_0;
wire [31:0]   M02_AXI_wdata_0 = 32'b0;
wire [0:0]    M02_AXI_wready_0;
wire [3:0]    M02_AXI_wstrb_0 = 4'b0;
wire [0:0]    M02_AXI_wvalid_0 = 1'b0;

wire [11:0]   M03_AXI_araddr_0 = 12'b0;
wire [2:0]    M03_AXI_arprot_0;
wire [0:0]    M03_AXI_arready_0;
wire [0:0]    M03_AXI_arvalid_0 = 1'b0;
wire [11:0]   M03_AXI_awaddr_0 = 12'b0;
wire [2:0]    M03_AXI_awprot_0;
wire [0:0]    M03_AXI_awready_0;
wire [0:0]    M03_AXI_awvalid_0 = 1'b0;
wire [0:0]    M03_AXI_bready_0 = 1'b0;
wire [1:0]    M03_AXI_bresp_0;
wire [0:0]    M03_AXI_bvalid_0;
wire [31:0]   M03_AXI_rdata_0;
wire [0:0]    M03_AXI_rready_0 = 1'b0;
wire [1:0]    M03_AXI_rresp_0;
wire [0:0]    M03_AXI_rvalid_0;
wire [31:0]   M03_AXI_wdata_0 = 32'b0;
wire [0:0]    M03_AXI_wready_0;
wire [3:0]    M03_AXI_wstrb_0 = 4'b0;
wire [0:0]    M03_AXI_wvalid_0 = 1'b0;

initial begin
    m_axis_tready = {NUM_PATHS{1'b0}};
    reset = 1;
    #(PER_125M_clk*16);
    reset = 0;
    #(PER_125M_clk*16);
    m_axis_tready = {NUM_PATHS{1'b1}};
end

datapath_v3
#(
    .C_S_AXI_ADDR_WIDTH (12),
    .C_M_AXIS_DATA_WIDTH (AXIS_DATA_WIDTH),
    .C_S_AXIS_DATA_WIDTH (AXIS_DATA_WIDTH),
    .C_M_AXIS_TUSER_WIDTH (AXIS_TUSER_WIDTH),
    .C_S_AXIS_TUSER_WIDTH (AXIS_TUSER_WIDTH)
)
dut 
(
    .axis_aclk                      (clk),
    .axis_resetn                    (~reset),
    
    // Slave Stream Ports (interface from Rx queues)
    .s_axis_0_tdata                 (s_axis_tdata[0]),  
    .s_axis_0_tkeep                 (s_axis_tkeep[0]),  
    .s_axis_0_tuser                 (s_axis_tuser[0]),  
    .s_axis_0_tvalid                (s_axis_tvalid[0]), 
    .s_axis_0_tready                (s_axis_tready[0]), 
    .s_axis_0_tlast                 (s_axis_tlast[0]),  
    .s_axis_1_tdata                 (s_axis_tdata[1]),  
    .s_axis_1_tkeep                 (s_axis_tkeep[1]),  
    .s_axis_1_tuser                 (s_axis_tuser[1]),  
    .s_axis_1_tvalid                (s_axis_tvalid[1]), 
    .s_axis_1_tready                (s_axis_tready[1]), 
    .s_axis_1_tlast                 (s_axis_tlast[1]),  
    .s_axis_2_tdata                 (s_axis_tdata[2]),  
    .s_axis_2_tkeep                 (s_axis_tkeep[2]),  
    .s_axis_2_tuser                 (s_axis_tuser[2]),  
    .s_axis_2_tvalid                (s_axis_tvalid[2]), 
    .s_axis_2_tready                (s_axis_tready[2]), 
    .s_axis_2_tlast                 (s_axis_tlast[2]),  
    .s_axis_3_tdata                 (s_axis_tdata[3]),  
    .s_axis_3_tkeep                 (s_axis_tkeep[3]),  
    .s_axis_3_tuser                 (s_axis_tuser[3]),  
    .s_axis_3_tvalid                (s_axis_tvalid[3]), 
    .s_axis_3_tready                (s_axis_tready[3]), 
    .s_axis_3_tlast                 (s_axis_tlast[3]),  
    .s_axis_4_tdata                 (s_axis_tdata[4]), 
    .s_axis_4_tkeep                 (s_axis_tkeep[4]), 
    .s_axis_4_tuser                 (s_axis_tuser[4]), 
    .s_axis_4_tvalid                (s_axis_tvalid[4]),
    .s_axis_4_tready                (s_axis_tready[4]), 
    .s_axis_4_tlast                 (s_axis_tlast[4]),  
    .s_axis_5_tdata                 (s_axis_tdata[5]), 
    .s_axis_5_tkeep                 (s_axis_tkeep[5]), 
    .s_axis_5_tuser                 (s_axis_tuser[5]), 
    .s_axis_5_tvalid                (s_axis_tvalid[5]),
    .s_axis_5_tready                (s_axis_tready[5]), 
    .s_axis_5_tlast                 (s_axis_tlast[5]),  
    .s_axis_6_tdata                 (s_axis_tdata[6]), 
    .s_axis_6_tkeep                 (s_axis_tkeep[6]), 
    .s_axis_6_tuser                 (s_axis_tuser[6]), 
    .s_axis_6_tvalid                (s_axis_tvalid[6]),
    .s_axis_6_tready                (s_axis_tready[6]), 
    .s_axis_6_tlast                 (s_axis_tlast[6]),  

    // Master Stream Ports (interface to TX queues)
    .m_axis_0_tdata                (m_axis_tdata[0]),
    .m_axis_0_tkeep                (m_axis_tkeep[0]),
    .m_axis_0_tuser                (m_axis_tuser[0]),
    .m_axis_0_tvalid               (m_axis_tvalid[0]),
    .m_axis_0_tready               (m_axis_tready[0]),
    .m_axis_0_tlast                (m_axis_tlast[0]),
    .m_axis_1_tdata                (m_axis_tdata[1]), 
    .m_axis_1_tkeep                (m_axis_tkeep[1]), 
    .m_axis_1_tuser                (m_axis_tuser[1]), 
    .m_axis_1_tvalid               (m_axis_tvalid[1]),
    .m_axis_1_tready               (m_axis_tready[1]),
    .m_axis_1_tlast                (m_axis_tlast[1]), 
    .m_axis_2_tdata                (m_axis_tdata[2]), 
    .m_axis_2_tkeep                (m_axis_tkeep[2]), 
    .m_axis_2_tuser                (m_axis_tuser[2]), 
    .m_axis_2_tvalid               (m_axis_tvalid[2]),
    .m_axis_2_tready               (m_axis_tready[2]),
    .m_axis_2_tlast                (m_axis_tlast[2]), 
    .m_axis_3_tdata                (m_axis_tdata[3]), 
    .m_axis_3_tkeep                (m_axis_tkeep[3]), 
    .m_axis_3_tuser                (m_axis_tuser[3]), 
    .m_axis_3_tvalid               (m_axis_tvalid[3]),
    .m_axis_3_tready               (m_axis_tready[3]),
    .m_axis_3_tlast                (m_axis_tlast[3]), 
    .m_axis_cpu_tdata              (m_axis_tdata[4]),
    .m_axis_cpu_tkeep              (m_axis_tkeep[4]),
    .m_axis_cpu_tuser              (m_axis_tuser[4]),
    .m_axis_cpu_tvalid             (m_axis_tvalid[4]),
    .m_axis_cpu_tready             (m_axis_tready[4]),
    .m_axis_cpu_tlast              (m_axis_tlast[4]),
    .m_axis_plc_tdata              (m_axis_tdata[5]),
    .m_axis_plc_tkeep              (m_axis_tkeep[5]),
    .m_axis_plc_tuser              (m_axis_tuser[5]),
    .m_axis_plc_tvalid             (m_axis_tvalid[5]),
    .m_axis_plc_tready             (m_axis_tready[5]),
    .m_axis_plc_tlast              (m_axis_tlast[5]),
    .m_axis_6_tdata                (m_axis_tdata[6]),
    .m_axis_6_tkeep                (m_axis_tkeep[6]),
    .m_axis_6_tuser                (m_axis_tuser[6]),
    .m_axis_6_tvalid               (m_axis_tvalid[6]),
    .m_axis_6_tready               (m_axis_tready[6]),
    .m_axis_6_tlast                (m_axis_tlast[6]),
    
    // Time sync info
    .sync_time_ptp_sec             (),
    .sync_time_ptp_ns              (),
    .sync_time_ptp_ns_mini         (sync_time_ptp_ns_mini),

    // GCL
    .gcl_clk_in                    (gcl_clk),
    .gcl_data_flat                 (),
    .gcl_ld                        (4'd0),
    .gcl_id                        (),
    .gcl_ld_data                   (),
    .gcl_time_ld                   (4'd0),
    .gcl_time_id                   (),
    .gcl_ld_time                   (),
    
    //AXI-Lite interface  
    .S_AXI_ACLK                    (gcl_clk),
    .S_AXI_ARESETN                 (~reset),
    .S_AXI_AWADDR                  (M01_AXI_awaddr_0), 
    .S_AXI_AWPROT                  (M01_AXI_awprot_0),
    .S_AXI_AWVALID                 (M01_AXI_awvalid_0),
    .S_AXI_AWREADY                 (M01_AXI_awready_0),
    .S_AXI_WDATA                   (M01_AXI_wdata_0),  
    .S_AXI_WSTRB                   (M01_AXI_wstrb_0),  
    .S_AXI_WVALID                  (M01_AXI_wvalid_0), 
    .S_AXI_WREADY                  (M01_AXI_wready_0), 
    .S_AXI_BRESP                   (M01_AXI_bresp_0),  
    .S_AXI_BVALID                  (M01_AXI_bvalid_0), 
    .S_AXI_BREADY                  (M01_AXI_bready_0), 
    .S_AXI_ARADDR                  (M01_AXI_araddr_0), 
    .S_AXI_ARPROT                  (M01_AXI_arprot_0),
    .S_AXI_ARVALID                 (M01_AXI_arvalid_0),
    .S_AXI_ARREADY                 (M01_AXI_arready_0),
    .S_AXI_RDATA                   (M01_AXI_rdata_0),  
    .S_AXI_RRESP                   (M01_AXI_rresp_0),  
    .S_AXI_RVALID                  (M01_AXI_rvalid_0), 
    .S_AXI_RREADY                  (M01_AXI_rready_0)
);

// Path 0 from 0000_0000_0001 to 0000_0000_0002
packet_generator #(
    .AXIS_DATA_WIDTH(AXIS_DATA_WIDTH),
    .AXIS_TUSER_WIDTH(AXIS_TUSER_WIDTH),
    .DST_MAC_ADDR(48'h0000_0000_0002),
    .SRC_MAC_ADDR(48'h0000_0000_0001),
    .VLAN(1'b0),
    .SRC_PORT(0)
) packet_generator_0 (
    .axis_aclk(clk),
    .axis_reset(reset),
    .s_axis_tdata(s_axis_tdata[0]),
    .s_axis_tkeep(s_axis_tkeep[0]),
    .s_axis_tuser(s_axis_tuser[0]),
    .s_axis_tvalid(s_axis_tvalid[0]),
    .s_axis_tready(s_axis_tready[0]),
    .s_axis_tlast(s_axis_tlast[0])
);

// Path 1 from 0000_0000_0002 to 0000_0000_0003
packet_generator #(
    .AXIS_DATA_WIDTH(AXIS_DATA_WIDTH),
    .AXIS_TUSER_WIDTH(AXIS_TUSER_WIDTH),
    .DST_MAC_ADDR(48'h0000_0000_0003),
    .SRC_MAC_ADDR(48'h0000_0000_0002),
    .VLAN(1'b0),
    .SRC_PORT(1)
) packet_generator_1 (
    .axis_aclk(clk),
    .axis_reset(reset),
    .s_axis_tdata(s_axis_tdata[1]),
    .s_axis_tkeep(s_axis_tkeep[1]),
    .s_axis_tuser(s_axis_tuser[1]),
    .s_axis_tvalid(s_axis_tvalid[1]),
    .s_axis_tready(s_axis_tready[1]),
    .s_axis_tlast(s_axis_tlast[1])
);

// Path 2 from 0000_0000_0003 to 0000_0000_0101
packet_generator #(
    .AXIS_DATA_WIDTH(AXIS_DATA_WIDTH),
    .AXIS_TUSER_WIDTH(AXIS_TUSER_WIDTH),
    .DST_MAC_ADDR(48'h0000_0000_0101),
    .SRC_MAC_ADDR(48'h0000_0000_0003),
    .VLAN(1'b0),
    .SRC_PORT(2)
) packet_generator_2 (
    .axis_aclk(clk),
    .axis_reset(reset),
    .s_axis_tdata(s_axis_tdata[2]),
    .s_axis_tkeep(s_axis_tkeep[2]),
    .s_axis_tuser(s_axis_tuser[2]),
    .s_axis_tvalid(s_axis_tvalid[2]),
    .s_axis_tready(s_axis_tready[2]),
    .s_axis_tlast(s_axis_tlast[2])
);

// Path 3 from 0000_0000_0004 to 0000_0000_0201
packet_generator #(
    .AXIS_DATA_WIDTH(AXIS_DATA_WIDTH),
    .AXIS_TUSER_WIDTH(AXIS_TUSER_WIDTH),
    .DST_MAC_ADDR(48'h0000_0000_0201),
    .SRC_MAC_ADDR(48'h0000_0000_0004),
    .VLAN(1'b0),
    .SRC_PORT(3)
) packet_generator_3 (
    .axis_aclk(clk),
    .axis_reset(reset),
    .s_axis_tdata(s_axis_tdata[3]),
    .s_axis_tkeep(s_axis_tkeep[3]),
    .s_axis_tuser(s_axis_tuser[3]),
    .s_axis_tvalid(s_axis_tvalid[3]),
    .s_axis_tready(s_axis_tready[3]),
    .s_axis_tlast(s_axis_tlast[3])
);

// Path 4 omitted for Time Sync DMA
// packet_generator #(
//     .AXIS_DATA_WIDTH(AXIS_DATA_WIDTH),
//     .AXIS_TUSER_WIDTH(AXIS_TUSER_WIDTH),
//     .DST_MAC_ADDR(48'h1111_1111_1111),
//     .SRC_MAC_ADDR(48'h4444_4444_4444),
//     .VLAN(1'b1),
//     .PRI(3'b011),
//     .SRC_PORT(4)
// ) packet_generator_4 (
//     .axis_aclk(clk),
//     .axis_reset(reset),
//     .s_axis_tdata(s_axis_tdata[4]),
//     .s_axis_tkeep(s_axis_tkeep[4]),
//     .s_axis_tuser(s_axis_tuser[4]),
//     .s_axis_tvalid(s_axis_tvalid[4]),
//     .s_axis_tready(s_axis_tready[4]),
//     .s_axis_tlast(s_axis_tlast[4])
// );
assign s_axis_tdata[4] = {AXIS_DATA_WIDTH{1'b0}};
assign s_axis_tkeep[4] = {(AXIS_DATA_WIDTH/8-1){1'b0}};
assign s_axis_tuser[4] = {AXIS_TUSER_WIDTH{1'b0}};
assign s_axis_tvalid[4] = 1'b0;
assign s_axis_tlast[4] = 1'b0;

// Path 5 for PLC DMA from 0000_0000_0101 to 0000_0000_0004
packet_generator #(
    .AXIS_DATA_WIDTH(AXIS_DATA_WIDTH),
    .AXIS_TUSER_WIDTH(AXIS_TUSER_WIDTH),
    .DST_MAC_ADDR(48'h0000_0000_0004),
    .SRC_MAC_ADDR(48'h0000_0000_0101),
    .VLAN(1'b0),
    .SRC_PORT(3) // SRC_PORT is used to learn switch rules or to determine the output ports of Time Sync frames, so in this test, it does not matter what SRC_PORT is.
) packet_generator_5 (
    .axis_aclk(clk),
    .axis_reset(reset),
    .s_axis_tdata(s_axis_tdata[5]),
    .s_axis_tkeep(s_axis_tkeep[5]),
    .s_axis_tuser(s_axis_tuser[5]),
    .s_axis_tvalid(s_axis_tvalid[5]),
    .s_axis_tready(s_axis_tready[5]),
    .s_axis_tlast(s_axis_tlast[5])
);

// Path 6 for PS ETH from 0000_0000_0201 to 0000_0000_0001
packet_generator #(
    .AXIS_DATA_WIDTH(AXIS_DATA_WIDTH),
    .AXIS_TUSER_WIDTH(AXIS_TUSER_WIDTH),
    .DST_MAC_ADDR(48'h0000_0000_0001),
    .SRC_MAC_ADDR(48'h0000_0000_0201),
    .VLAN(1'b0),
    .SRC_PORT(3) // SRC_PORT is used to learn switch rules or to determine the output ports of Time Sync frames, so in this test, it does not matter what SRC_PORT is.
) packet_generator_6 (
    .axis_aclk(clk),
    .axis_reset(reset),
    .s_axis_tdata(s_axis_tdata[6]),
    .s_axis_tkeep(s_axis_tkeep[6]),
    .s_axis_tuser(s_axis_tuser[6]),
    .s_axis_tvalid(s_axis_tvalid[6]),
    .s_axis_tready(s_axis_tready[6]),
    .s_axis_tlast(s_axis_tlast[6])
);

endmodule