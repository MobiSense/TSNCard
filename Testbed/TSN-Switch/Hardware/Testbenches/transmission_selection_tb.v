`timescale 1ns / 1ps

module transmission_selection_tb();
    
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
        sync_time_ptp_ns = 32'd999_999_000;
    end
    else begin
        sync_time_ptp_ns = (sync_time_ptp_ns + 8) % 1_000_000_000;
    end
end

wire [AXIS_DATA_WIDTH-1:0] m_axis_tdata[0:7];
wire [(AXIS_DATA_WIDTH/8)-1:0] m_axis_tkeep[0:7];
wire [AXIS_TUSER_WIDTH-1:0] m_axis_tuser[0:7];
wire [7:0] m_axis_tvalid;
wire [7:0] m_axis_tready;
wire [7:0] m_axis_tlast;

wire [AXIS_DATA_WIDTH-1:0] s_axis_tdata;
wire [(AXIS_DATA_WIDTH/8)-1:0] s_axis_tkeep;
wire [AXIS_TUSER_WIDTH-1:0] s_axis_tuser;
wire s_axis_tvalid;
reg s_axis_tready = 1'b1;
wire s_axis_tlast;


generate
    genvar i;
    for (i = 0; i < 8; i = i + 1) begin
        packet_generator
        #(
            .AXIS_DATA_WIDTH(AXIS_DATA_WIDTH),
            .AXIS_TUSER_WIDTH(AXIS_TUSER_WIDTH)
        )
        packet_generator_i (
            .axis_aclk(clk),
            .axis_reset(reset),
            .s_axis_tdata(m_axis_tdata[i]),
            .s_axis_tkeep(m_axis_tkeep[i]),
            .s_axis_tuser(m_axis_tuser[i]),
            .s_axis_tvalid(m_axis_tvalid[i]),
            .s_axis_tready(m_axis_tready[i]),
            .s_axis_tlast(m_axis_tlast[i])
        );
    end
endgenerate

// DUT
transmission_selection dut (
    .axis_aclk(clk),
    .axis_reset(reset),

    .m_axis_0_tdata(m_axis_tdata[0]),
    .m_axis_0_tkeep(m_axis_tkeep[0]),
    .m_axis_0_tuser(m_axis_tuser[0]),
    .m_axis_0_tvalid(m_axis_tvalid[0]),
    .m_axis_0_tready(m_axis_tready[0]),
    .m_axis_0_tlast(m_axis_tlast[0]),
    
    .m_axis_1_tdata(m_axis_tdata[1]),
    .m_axis_1_tkeep(m_axis_tkeep[1]),
    .m_axis_1_tuser(m_axis_tuser[1]),
    .m_axis_1_tvalid(m_axis_tvalid[1]),
    .m_axis_1_tready(m_axis_tready[1]),
    .m_axis_1_tlast(m_axis_tlast[1]),

    .m_axis_2_tdata(m_axis_tdata[2]),
    .m_axis_2_tkeep(m_axis_tkeep[2]),
    .m_axis_2_tuser(m_axis_tuser[2]),
    .m_axis_2_tvalid(m_axis_tvalid[2]),
    .m_axis_2_tready(m_axis_tready[2]),
    .m_axis_2_tlast(m_axis_tlast[2]),

    .m_axis_3_tdata(m_axis_tdata[3]),
    .m_axis_3_tkeep(m_axis_tkeep[3]),
    .m_axis_3_tuser(m_axis_tuser[3]),
    .m_axis_3_tvalid(m_axis_tvalid[3]),
    .m_axis_3_tready(m_axis_tready[3]),
    .m_axis_3_tlast(m_axis_tlast[3]),

    .m_axis_4_tdata(m_axis_tdata[4]),
    .m_axis_4_tkeep(m_axis_tkeep[4]),
    .m_axis_4_tuser(m_axis_tuser[4]),
    .m_axis_4_tvalid(m_axis_tvalid[4]),
    .m_axis_4_tready(m_axis_tready[4]),
    .m_axis_4_tlast(m_axis_tlast[4]),

    .m_axis_5_tdata(m_axis_tdata[5]),
    .m_axis_5_tkeep(m_axis_tkeep[5]),
    .m_axis_5_tuser(m_axis_tuser[5]),
    .m_axis_5_tvalid(m_axis_tvalid[5]),
    .m_axis_5_tready(m_axis_tready[5]),
    .m_axis_5_tlast(m_axis_tlast[5]),

    .m_axis_6_tdata(m_axis_tdata[6]),
    .m_axis_6_tkeep(m_axis_tkeep[6]),
    .m_axis_6_tuser(m_axis_tuser[6]),
    .m_axis_6_tvalid(m_axis_tvalid[6]),
    .m_axis_6_tready(m_axis_tready[6]),
    .m_axis_6_tlast(m_axis_tlast[6]),

    .m_axis_7_tdata(m_axis_tdata[7]),
    .m_axis_7_tkeep(m_axis_tkeep[7]),
    .m_axis_7_tuser(m_axis_tuser[7]),
    .m_axis_7_tvalid(m_axis_tvalid[7]),
    .m_axis_7_tready(m_axis_tready[7]),
    .m_axis_7_tlast(m_axis_tlast[7]),
    
    .s_axis_tdata(s_axis_tdata),
    .s_axis_tkeep(s_axis_tkeep),
    .s_axis_tuser(s_axis_tuser),
    .s_axis_tvalid(s_axis_tvalid),
    .s_axis_tready(s_axis_tready),
    .s_axis_tlast(s_axis_tlast),
    
    .sync_time_ptp_ns(sync_time_ptp_ns)
);




initial begin
    reset = 1;
    #(PER_125M_clk*16);
    reset = 0;
    #(PER_125M_clk*16);
end
endmodule
