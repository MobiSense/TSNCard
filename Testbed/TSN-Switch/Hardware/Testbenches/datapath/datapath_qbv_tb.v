`timescale 1ns/1ps

module datapath_qbv_tb ();

// Local parameters
localparam ONE_NS = 1;
localparam time PER_125M_clk = 8 * ONE_NS;  // 8 ns clock
localparam time PER_50M_clk = 20 * ONE_NS;  // 20 ns clock

localparam AXIS_DATA_WIDTH  = 256;
localparam AXIS_TUSER_WIDTH = 128;
localparam NUM_PATHS = 7;

reg clk = 1;
reg gcl_clk = 1;
reg reset = 1;
reg [63:0] sync_time_ptp_ns_mini;

wire [AXIS_DATA_WIDTH-1:0]                  m_axis_tdata[0:NUM_PATHS-1];
wire [(AXIS_DATA_WIDTH/8)-1:0]              m_axis_tkeep[0:NUM_PATHS-1];
wire [AXIS_TUSER_WIDTH-1:0]                 m_axis_tuser[0:NUM_PATHS-1];
wire [NUM_PATHS-1:0]                        m_axis_tvalid;
reg  [NUM_PATHS-1:0]                        m_axis_tready;
wire [NUM_PATHS-1:0]                        m_axis_tlast;

wire [AXIS_DATA_WIDTH-1:0]                  s_axis_tdata[0:NUM_PATHS-1];
wire [(AXIS_DATA_WIDTH/8)-1:0]              s_axis_tkeep[0:NUM_PATHS-1];
wire [AXIS_TUSER_WIDTH-1:0]                 s_axis_tuser[0:NUM_PATHS-1];
wire [NUM_PATHS-1:0]                        s_axis_tvalid;
wire [NUM_PATHS-1:0]                        s_axis_tready;
wire [NUM_PATHS-1:0]                        s_axis_tlast;

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

reg  [3:0]    gcl_ld;
reg  [3:0]    gcl_id;
reg  [8:0]    gcl_ld_data;
reg  [3:0]    gcl_time_ld;
reg  [3:0]    gcl_time_id;
reg  [19:0]   gcl_ld_time;

// clock signals
always begin
    clk = #(PER_125M_clk / 2) ~clk;
end

always begin
    gcl_clk = #(PER_50M_clk / 2) ~clk;
end

always @(posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
        sync_time_ptp_ns_mini <= (1<<25) - 5000;
    end
    else begin
        sync_time_ptp_ns_mini <= sync_time_ptp_ns_mini + 8;
    end
end

// always begin
//     if (gcl_id == 0) begin
//         #(16 * 32'h8000);
//         gcl_id      = 1;
//         gcl_ld_data = 1;
//         gcl_time_id = 1;
//         gcl_ld_time = 24;
//     end
//     else if (gcl_id == 1) begin
//         #(24 * 32'h8000);
//         gcl_id      = 2;
//         gcl_ld_data = 258;
//         gcl_time_id = 2;
//         gcl_ld_time = 16344;
//     end
//     else if (gcl_id == 2) begin
//         #(16344 * 32'h8000);
//         gcl_id      = 0;
//         gcl_ld_data = 258;
//         gcl_time_id = 0;
//         gcl_ld_time = 16;
//     end
// end

initial begin
    m_axis_tready = {NUM_PATHS{1'b0}};
    reset = 1;
    gcl_ld      = 0;
    gcl_time_ld = 0;

    #(PER_125M_clk * 16);
    reset = 0;

    #(PER_125M_clk * 16);
    gcl_ld      = 4'b0100;
    gcl_time_ld = 4'b0100;
    gcl_id      = 0;
    gcl_ld_data = 258;
    gcl_time_id = 0;
    gcl_ld_time = 16;

    #(PER_125M_clk * 16);
    gcl_ld      = 0;
    gcl_time_ld = 0;

    #(PER_125M_clk * 16);
    gcl_ld      = 4'b0100;
    gcl_time_ld = 4'b0100;
    gcl_id      = 1;
    gcl_ld_data = 1;
    gcl_time_id = 1;
    gcl_ld_time = 24;

    #(PER_125M_clk * 16);
    gcl_ld      = 0;
    gcl_time_ld = 0;

    #(PER_125M_clk * 16);
    gcl_ld      = 4'b0100;
    gcl_time_ld = 4'b0100;
    gcl_id      = 2;
    gcl_ld_data = 258;
    gcl_time_id = 2;
    gcl_ld_time = 16344;

    #(PER_125M_clk * 16);
    gcl_ld      = 0;
    gcl_time_ld = 0;

    m_axis_tready = {NUM_PATHS{1'b1}};
end

datapath_v3
#(
    .C_S_AXI_ADDR_WIDTH (12),
    .C_M_AXIS_DATA_WIDTH (AXIS_DATA_WIDTH),
    .C_S_AXIS_DATA_WIDTH (AXIS_DATA_WIDTH),
    .C_M_AXIS_TUSER_WIDTH (AXIS_TUSER_WIDTH),
    .C_S_AXIS_TUSER_WIDTH (AXIS_TUSER_WIDTH),
    .NUM_PORTS(4),
    .NUM_QUEUES_PORT(2)
)
dp_tb
(
    .axis_aclk                      (clk),
    .axis_resetn                    (~reset),

    // slave stream ports (interface from rx queues)
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

    // master stream ports (interface to tx queues)
    .m_axis_0_tdata                 (m_axis_tdata[0]),
    .m_axis_0_tkeep                 (m_axis_tkeep[0]),
    .m_axis_0_tuser                 (m_axis_tuser[0]),
    .m_axis_0_tvalid                (m_axis_tvalid[0]),
    .m_axis_0_tready                (m_axis_tready[0]),
    .m_axis_0_tlast                 (m_axis_tlast[0]),
    .m_axis_1_tdata                 (m_axis_tdata[1]),
    .m_axis_1_tkeep                 (m_axis_tkeep[1]),
    .m_axis_1_tuser                 (m_axis_tuser[1]),
    .m_axis_1_tvalid                (m_axis_tvalid[1]),
    .m_axis_1_tready                (m_axis_tready[1]),
    .m_axis_1_tlast                 (m_axis_tlast[1]),
    .m_axis_2_tdata                 (m_axis_tdata[2]),
    .m_axis_2_tkeep                 (m_axis_tkeep[2]),
    .m_axis_2_tuser                 (m_axis_tuser[2]),
    .m_axis_2_tvalid                (m_axis_tvalid[2]),
    .m_axis_2_tready                (m_axis_tready[2]),
    .m_axis_2_tlast                 (m_axis_tlast[2]),
    .m_axis_3_tdata                 (m_axis_tdata[3]),
    .m_axis_3_tkeep                 (m_axis_tkeep[3]),
    .m_axis_3_tuser                 (m_axis_tuser[3]),
    .m_axis_3_tvalid                (m_axis_tvalid[3]),
    .m_axis_3_tready                (m_axis_tready[3]),
    .m_axis_3_tlast                 (m_axis_tlast[3]),
    .m_axis_cpu_tdata               (m_axis_tdata[4]),
    .m_axis_cpu_tkeep               (m_axis_tkeep[4]),
    .m_axis_cpu_tuser               (m_axis_tuser[4]),
    .m_axis_cpu_tvalid              (m_axis_tvalid[4]),
    .m_axis_cpu_tready              (m_axis_tready[4]),
    .m_axis_cpu_tlast               (m_axis_tlast[4]),
    .m_axis_plc_tdata               (m_axis_tdata[5]),
    .m_axis_plc_tkeep               (m_axis_tkeep[5]),
    .m_axis_plc_tuser               (m_axis_tuser[5]),
    .m_axis_plc_tvalid              (m_axis_tvalid[5]),
    .m_axis_plc_tready              (m_axis_tready[5]),
    .m_axis_plc_tlast               (m_axis_tlast[5]),
    .m_axis_6_tdata                 (m_axis_tdata[6]),
    .m_axis_6_tkeep                 (m_axis_tkeep[6]),
    .m_axis_6_tuser                 (m_axis_tuser[6]),
    .m_axis_6_tvalid                (m_axis_tvalid[6]),
    .m_axis_6_tready                (m_axis_tready[6]),
    .m_axis_6_tlast                 (m_axis_tlast[6]),

    // time sync info
    .sync_time_ptp_sec              (),
    .sync_time_ptp_ns               (),
    .sync_time_ptp_ns_mini          (sync_time_ptp_ns_mini),

    // gcl
    .gcl_clk_in                     (gcl_clk),
    .gcl_data_flat                  (),
    .gcl_ld                         (gcl_ld),
    .gcl_id                         (gcl_id),
    .gcl_ld_data                    (gcl_ld_data),
    .gcl_time_ld                    (gcl_time_ld),
    .gcl_time_id                    (gcl_time_id),
    .gcl_ld_time                    (gcl_ld_time),

    // axi-lite interface
    .S_AXI_ACLK                     (gcl_clk),
    .S_AXI_ARESETN                  (~reset),
    .S_AXI_AWADDR                   (M01_AXI_awaddr_0),
    .S_AXI_AWPROT                   (M01_AXI_awprot_0),
    .S_AXI_AWVALID                  (M01_AXI_awvalid_0),
    .S_AXI_AWREADY                  (M01_AXI_awready_0),
    .S_AXI_WDATA                    (M01_AXI_wdata_0),
    .S_AXI_WSTRB                    (M01_AXI_wstrb_0),
    .S_AXI_WVALID                   (M01_AXI_wvalid_0),
    .S_AXI_WREADY                   (M01_AXI_wready_0),
    .S_AXI_BRESP                    (M01_AXI_bresp_0),
    .S_AXI_BVALID                   (M01_AXI_bvalid_0),
    .S_AXI_BREADY                   (M01_AXI_bready_0),
    .S_AXI_ARADDR                   (M01_AXI_araddr_0),
    .S_AXI_ARPROT                   (M01_AXI_arprot_0),
    .S_AXI_ARVALID                  (M01_AXI_arvalid_0),
    .S_AXI_ARREADY                  (M01_AXI_arready_0),
    .S_AXI_RDATA                    (M01_AXI_rdata_0),
    .S_AXI_RRESP                    (M01_AXI_rresp_0),
    .S_AXI_RVALID                   (M01_AXI_rvalid_0),
    .S_AXI_RREADY                   (M01_AXI_rready_0)
);

// Path 0 from 0000_0000_0001 to 0000_0000_0002
// by default, it's forwarded from port #0 to port #2
packet_generator #(
    .AXIS_DATA_WIDTH(AXIS_DATA_WIDTH),
    .AXIS_TUSER_WIDTH(AXIS_TUSER_WIDTH),
    .DST_MAC_ADDR(48'h0000_0000_0003),
    .SRC_MAC_ADDR(48'h0000_0000_0001),
    .VLAN(1'b0), // background flow
    .SRC_PORT(0)
) packet_generator_0 (
    .axis_aclk                      (clk),
    .axis_reset                     (reset),
    .s_axis_tdata                   (s_axis_tdata[0]),
    .s_axis_tkeep                   (s_axis_tkeep[0]),
    .s_axis_tuser                   (s_axis_tuser[0]),
    .s_axis_tvalid                  (s_axis_tvalid[0]),
    .s_axis_tready                  (s_axis_tready[0]),
    .s_axis_tlast                   (s_axis_tlast[0])
);

// Path 1 from 0000_0000_0002 to 0000_0000_0003
// by default, it's forwarded from port #1 to port #2
packet_generator #(
    .AXIS_DATA_WIDTH(AXIS_DATA_WIDTH),
    .AXIS_TUSER_WIDTH(AXIS_TUSER_WIDTH),
    .DST_MAC_ADDR(48'h0000_0000_0003),
    .SRC_MAC_ADDR(48'h0000_0000_0002),
    .VLAN(1'b1), // critical flow
    .PRI(3'b001),
    .SRC_PORT(1)
) packet_generator_1 (
    .axis_aclk                      (clk),
    .axis_reset                     (reset),
    .s_axis_tdata                   (s_axis_tdata[1]),
    .s_axis_tkeep                   (s_axis_tkeep[1]),
    .s_axis_tuser                   (s_axis_tuser[1]),
    .s_axis_tvalid                  (s_axis_tvalid[1]),
    .s_axis_tready                  (s_axis_tready[1]),
    .s_axis_tlast                   (s_axis_tlast[1])
);

// // Path 2 from 0000_0000_0003 to 0000_0000_0101
// packet_generator #(
//     .AXIS_DATA_WIDTH(AXIS_DATA_WIDTH),
//     .AXIS_TUSER_WIDTH(AXIS_TUSER_WIDTH),
//     .DST_MAC_ADDR(48'h0000_0000_0101),
//     .SRC_MAC_ADDR(48'h0000_0000_0003),
//     .VLAN(1'b0),
//     .SRC_PORT(2)
// ) packet_generator_2 (
//     .axis_aclk(clk),
//     .axis_reset(reset),
//     .s_axis_tdata(s_axis_tdata[2]),
//     .s_axis_tkeep(s_axis_tkeep[2]),
//     .s_axis_tuser(s_axis_tuser[2]),
//     .s_axis_tvalid(s_axis_tvalid[2]),
//     .s_axis_tready(s_axis_tready[2]),
//     .s_axis_tlast(s_axis_tlast[2])
// );
assign s_axis_tdata[2]  = {AXIS_DATA_WIDTH{1'b0}};
assign s_axis_tkeep[2]  = {(AXIS_DATA_WIDTH/8-1){1'b0}};
assign s_axis_tuser[2]  = {AXIS_TUSER_WIDTH{1'b0}};
assign s_axis_tvalid[2] = 1'b0;
assign s_axis_tlast[2]  = 1'b0;

// // Path 3 from 0000_0000_0004 to 0000_0000_0201
// packet_generator #(
//     .AXIS_DATA_WIDTH(AXIS_DATA_WIDTH),
//     .AXIS_TUSER_WIDTH(AXIS_TUSER_WIDTH),
//     .DST_MAC_ADDR(48'h0000_0000_0201),
//     .SRC_MAC_ADDR(48'h0000_0000_0004),
//     .VLAN(1'b0),
//     .SRC_PORT(3)
// ) packet_generator_3 (
//     .axis_aclk(clk),
//     .axis_reset(reset),
//     .s_axis_tdata(s_axis_tdata[3]),
//     .s_axis_tkeep(s_axis_tkeep[3]),
//     .s_axis_tuser(s_axis_tuser[3]),
//     .s_axis_tvalid(s_axis_tvalid[3]),
//     .s_axis_tready(s_axis_tready[3]),
//     .s_axis_tlast(s_axis_tlast[3])
// );
assign s_axis_tdata[3]  = {AXIS_DATA_WIDTH{1'b0}};
assign s_axis_tkeep[3]  = {(AXIS_DATA_WIDTH/8-1){1'b0}};
assign s_axis_tuser[3]  = {AXIS_TUSER_WIDTH{1'b0}};
assign s_axis_tvalid[3] = 1'b0;
assign s_axis_tlast[3]  = 1'b0;

assign s_axis_tdata[4]  = {AXIS_DATA_WIDTH{1'b0}};
assign s_axis_tkeep[4]  = {(AXIS_DATA_WIDTH/8-1){1'b0}};
assign s_axis_tuser[4]  = {AXIS_TUSER_WIDTH{1'b0}};
assign s_axis_tvalid[4] = 1'b0;
assign s_axis_tlast[4]  = 1'b0;

// // Path 5 for PLC DMA from 0000_0000_0101 to 0000_0000_0004
// packet_generator #(
//     .AXIS_DATA_WIDTH(AXIS_DATA_WIDTH),
//     .AXIS_TUSER_WIDTH(AXIS_TUSER_WIDTH),
//     .DST_MAC_ADDR(48'h0000_0000_0004),
//     .SRC_MAC_ADDR(48'h0000_0000_0101),
//     .VLAN(1'b0),
//     .SRC_PORT(3) // SRC_PORT is used to learn switch rules or to determine the output ports of Time Sync frames, so in this test, it does not matter what SRC_PORT is.
// ) packet_generator_5 (
//     .axis_aclk(clk),
//     .axis_reset(reset),
//     .s_axis_tdata(s_axis_tdata[5]),
//     .s_axis_tkeep(s_axis_tkeep[5]),
//     .s_axis_tuser(s_axis_tuser[5]),
//     .s_axis_tvalid(s_axis_tvalid[5]),
//     .s_axis_tready(s_axis_tready[5]),
//     .s_axis_tlast(s_axis_tlast[5])
// );
assign s_axis_tdata[5]  = {AXIS_DATA_WIDTH{1'b0}};
assign s_axis_tkeep[5]  = {(AXIS_DATA_WIDTH/8-1){1'b0}};
assign s_axis_tuser[5]  = {AXIS_TUSER_WIDTH{1'b0}};
assign s_axis_tvalid[5] = 1'b0;
assign s_axis_tlast[5]  = 1'b0;

// // Path 6 for PS ETH from 0000_0000_0201 to 0000_0000_0001
// packet_generator #(
//     .AXIS_DATA_WIDTH(AXIS_DATA_WIDTH),
//     .AXIS_TUSER_WIDTH(AXIS_TUSER_WIDTH),
//     .DST_MAC_ADDR(48'h0000_0000_0001),
//     .SRC_MAC_ADDR(48'h0000_0000_0201),
//     .VLAN(1'b0),
//     .SRC_PORT(3) // SRC_PORT is used to learn switch rules or to determine the output ports of Time Sync frames, so in this test, it does not matter what SRC_PORT is.
// ) packet_generator_6 (
//     .axis_aclk(clk),
//     .axis_reset(reset),
//     .s_axis_tdata(s_axis_tdata[6]),
//     .s_axis_tkeep(s_axis_tkeep[6]),
//     .s_axis_tuser(s_axis_tuser[6]),
//     .s_axis_tvalid(s_axis_tvalid[6]),
//     .s_axis_tready(s_axis_tready[6]),
//     .s_axis_tlast(s_axis_tlast[6])
// );
assign s_axis_tdata[6]  = {AXIS_DATA_WIDTH{1'b0}};
assign s_axis_tkeep[6]  = {(AXIS_DATA_WIDTH/8-1){1'b0}};
assign s_axis_tuser[6]  = {AXIS_TUSER_WIDTH{1'b0}};
assign s_axis_tvalid[6] = 1'b0;
assign s_axis_tlast[6]  = 1'b0;

endmodule