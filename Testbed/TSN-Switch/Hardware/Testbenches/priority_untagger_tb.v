`timescale 1ns/1ps

module priority_untagger_tb ();

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
    m_axis_tready = 5'b00000;
    reset = 1;
    #(PER_125M_clk*16);
    reset = 0;
    #(PER_125M_clk*16);
    m_axis_tready = 5'b11111;
end
    
wire [AXIS_DATA_WIDTH-1:0]     s_axis_tdata;
wire [(AXIS_DATA_WIDTH/8)-1:0] s_axis_tkeep;
wire [AXIS_TUSER_WIDTH-1:0]    s_axis_tuser;
wire                           s_axis_tvalid;
wire                           s_axis_tready;
wire                           s_axis_tlast;

wire [AXIS_DATA_WIDTH-1:0]     m_axis_tdata;
wire [(AXIS_DATA_WIDTH/8)-1:0] m_axis_tkeep;
wire [AXIS_TUSER_WIDTH-1:0]    m_axis_tuser;
wire                           m_axis_tvalid;
reg                            m_axis_tready;
wire                           m_axis_tlast;

priority_untagger 
#(
    .C_DATA_WIDTH (AXIS_DATA_WIDTH),
    .C_TUSER_WIDTH (AXIS_TUSER_WIDTH)
)
dut(
        .clk         (clk),
        .rst         (reset),

        // slave axis interface
        .s_axis_tdata  (s_axis_tdata),
        .s_axis_tuser  (s_axis_tuser),
        .s_axis_tkeep  (s_axis_tkeep),
        .s_axis_tvalid (s_axis_tvalid),
        .s_axis_tlast  (s_axis_tlast),
        .s_axis_tready (s_axis_tready),

        // master axis interface
        .m_axis_tdata  (m_axis_tdata),
        .m_axis_tuser  (m_axis_tuser),
        .m_axis_tkeep  (m_axis_tkeep),
        .m_axis_tvalid (m_axis_tvalid),
        .m_axis_tlast  (m_axis_tlast),
        .m_axis_tready (m_axis_tready)
);

packet_generator_dscp #(
    .AXIS_DATA_WIDTH(AXIS_DATA_WIDTH),
    .AXIS_TUSER_WIDTH(AXIS_TUSER_WIDTH),
    .DST_MAC_ADDR(48'h1111_1111_1111),
    .SRC_MAC_ADDR(48'h0000_0000_0000),
    .VLAN(1'b1),
    .TYPE(16'h0800),
    .DSCP(6'd56)
) packet_generator_0 (
    .axis_aclk(clk),
    .axis_reset(reset),
    .s_axis_tdata(s_axis_tdata),
    .s_axis_tkeep(s_axis_tkeep),
    .s_axis_tuser(s_axis_tuser),
    .s_axis_tvalid(s_axis_tvalid),
    .s_axis_tready(s_axis_tready),
    .s_axis_tlast(s_axis_tlast)
);

endmodule