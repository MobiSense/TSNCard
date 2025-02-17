`timescale 1ns/1ps

module output_queues_v3_tb ();

// Local parameters
localparam ONE_NS = 1;
localparam time PER_125M_clk = 8*ONE_NS; // 8 ns clock

localparam AXIS_DATA_WIDTH = 256;
localparam AXIS_TUSER_WIDTH = 128;

// Reg declarations
reg clk = 1;
reg reset = 1;
reg [31:0] sync_time_ptp_ns;

// Clock signals
always begin
    clk = #(PER_125M_clk/2) ~clk;
end

always @(posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
        sync_time_ptp_ns = 0;
    end
    else begin
        sync_time_ptp_ns = (sync_time_ptp_ns + 8) % 1_000_000_000;
    end
end

initial begin
    reset = 1;
    #(PER_125M_clk*16);
    reset = 0;
    #(PER_125M_clk*16);
end
    
wire [AXIS_DATA_WIDTH-1:0] s_axis_tdata[0:4];
wire [(AXIS_DATA_WIDTH/8)-1:0] s_axis_tkeep[0:4];
wire [AXIS_TUSER_WIDTH-1:0] s_axis_tuser[0:4];
wire [4:0] s_axis_tvalid;
wire [4:0] s_axis_tready;
wire [4:0] s_axis_tlast;

wire [AXIS_DATA_WIDTH-1:0] m_axis_tdata[0:4];
wire [(AXIS_DATA_WIDTH/8)-1:0] m_axis_tkeep[0:4];
wire [AXIS_TUSER_WIDTH-1:0] m_axis_tuser[0:4];
wire [4:0] m_axis_tvalid;
reg [4:0] m_axis_tready;
wire [4:0] m_axis_tlast;

 // Output queues
    output_queues_v3 #(
        .NUM_PORTS(4),
        .NUM_QUEUES_PORT(3)
    ) output_queues_v3_i (
        .axis_aclk(clk), 
        .axis_resetn(~reset), 
        .s_axis_tdata   (s_axis_tdata[0]), 
        .s_axis_tkeep   (s_axis_tkeep[0]), 
        .s_axis_tuser   (s_axis_tuser[0]), 
        .s_axis_tvalid  (s_axis_tvalid[0]), 
        .s_axis_tready  (s_axis_tready[0]), 
        .s_axis_tlast   (s_axis_tlast[0]), 

        .m_axis_0_0_tready(1),
        .m_axis_0_1_tready(1),
        .m_axis_0_2_tready(1),
        .m_axis_0_3_tready(1),
        .m_axis_0_4_tready(1),
        .m_axis_0_5_tready(1),
        .m_axis_0_6_tready(1),
        .m_axis_0_7_tready(1),
        .m_axis_1_0_tready(1),
        .m_axis_1_1_tready(1),
        .m_axis_1_2_tready(1),
        .m_axis_1_3_tready(1),
        .m_axis_1_4_tready(1),
        .m_axis_1_5_tready(1),
        .m_axis_1_6_tready(1),
        .m_axis_1_7_tready(1),
        .m_axis_2_0_tready(1),
        .m_axis_2_1_tready(1),
        .m_axis_2_2_tready(1),
        .m_axis_2_3_tready(1),
        .m_axis_2_4_tready(1),
        .m_axis_2_5_tready(1),
        .m_axis_2_6_tready(1),
        .m_axis_2_7_tready(1),
        .m_axis_3_0_tready(1),
        .m_axis_3_1_tready(1),
        .m_axis_3_2_tready(1),
        .m_axis_3_3_tready(1),
        .m_axis_3_4_tready(1),
        .m_axis_3_5_tready(1),
        .m_axis_3_6_tready(1),
        .m_axis_3_7_tready(1),
        .m_axis_cpu_tready(1),
        .m_axis_plc_tready(1),
        .m_axis_6_tready(1)
    ); 

packet_generator #(
    .AXIS_DATA_WIDTH(AXIS_DATA_WIDTH),
    .AXIS_TUSER_WIDTH(AXIS_TUSER_WIDTH),
    .DST_MAC_ADDR(48'h1111_1111_1111),
    .SRC_MAC_ADDR(48'h0000_0000_0000),
    .VLAN(1'b1),
    .PRI(3'b010),
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

endmodule