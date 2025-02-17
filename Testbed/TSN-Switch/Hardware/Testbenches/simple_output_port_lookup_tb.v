`timescale 1ns / 1ps

module simple_output_port_lookup_tb();
    
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

wire [AXIS_DATA_WIDTH-1:0] m_axis_tdata;
wire [(AXIS_DATA_WIDTH/8)-1:0] m_axis_tkeep;
wire [AXIS_TUSER_WIDTH-1:0] m_axis_tuser;
wire m_axis_tvalid;
wire m_axis_tready;
wire m_axis_tlast;

wire [AXIS_DATA_WIDTH-1:0] s_axis_tdata;
wire [(AXIS_DATA_WIDTH/8)-1:0] s_axis_tkeep;
wire [AXIS_TUSER_WIDTH-1:0] s_axis_tuser;
wire s_axis_tvalid;
reg s_axis_tready = 1'b1;
wire s_axis_tlast;


packet_generator #(
    .AXIS_DATA_WIDTH(AXIS_DATA_WIDTH),
    .AXIS_TUSER_WIDTH(AXIS_TUSER_WIDTH),
    .DST_MAC_ADDR(48'h0180_C200_000E),
    .SRC_MAC_ADDR(48'h0000_0000_0003),
    .TYPE(16'h88F7),
    .VLAN(0),
    .TUSER_SRC_IN(8'h20)
) packet_generator_i (
    .axis_aclk(clk),
    .axis_reset(reset),
    .s_axis_tdata(m_axis_tdata),
    .s_axis_tkeep(m_axis_tkeep),
    .s_axis_tuser(m_axis_tuser),
    .s_axis_tvalid(m_axis_tvalid),
    .s_axis_tready(m_axis_tready),
    .s_axis_tlast(m_axis_tlast)
);


// DUT
simple_output_port_lookup #(
    .SWITCH_ID(2)
) simple_output_port_lookup (
    .axis_aclk(clk),
    .axis_resetn(~reset),
    .m_axis_tdata(s_axis_tdata),
    .m_axis_tkeep(s_axis_tkeep),
    .m_axis_tuser(s_axis_tuser),
    .m_axis_tvalid(s_axis_tvalid),
    .m_axis_tready(s_axis_tready),
    .m_axis_tlast(s_axis_tlast),

    .s_axis_tdata(m_axis_tdata),
    .s_axis_tkeep(m_axis_tkeep),
    .s_axis_tuser(m_axis_tuser),
    .s_axis_tvalid(m_axis_tvalid),
    .s_axis_tready(m_axis_tready),
    .s_axis_tlast(m_axis_tlast)
);


initial begin
    reset = 1;
    #(PER_125M_clk*16);
    reset = 0;
    #(PER_125M_clk*16);
end
endmodule
