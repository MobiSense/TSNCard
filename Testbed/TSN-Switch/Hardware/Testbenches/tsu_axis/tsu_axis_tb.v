`timescale 1ps/1ps

module tsu_axis_tb (
);

// Local parameters
// time scale is 1ps/1ps
localparam ONE_NS = 1000;
localparam time PER_clk = 40*ONE_NS; // 40 ns clock
localparam time PER_rtc_clk = 8*ONE_NS; // 8 ns clock
localparam time PER_PS = 20*ONE_NS;
localparam DATA_WIDTH = 8;
localparam PACKET_LENGTH = 61;

// Reg declarations
reg clk = 1;
reg rtc_clk = 1;
reg ps_clk = 1;
reg [79:0] rtc_timer = 0;
reg reset = 1;
reg [DATA_WIDTH-1:0] m_axis_tdata = 0;
reg m_axis_tvalid = 0;
reg m_axis_tlast = 0;
reg m_axis_tready = 1'b1;

integer i = 0;

reg [DATA_WIDTH-1:0] packet [0:PACKET_LENGTH-1];

// Wire declarations
wire [7:0] q_rd_stat;
wire [127:0] q_rd_data;

// Clock signals
always begin
    clk = #(PER_clk/2) ~clk;
end

always begin
    rtc_clk = #(PER_rtc_clk/2) ~rtc_clk;
end

always begin
    ps_clk = #(PER_PS/2) ~ps_clk;
end

always @(posedge rtc_clk) begin
    if (reset == 1'b1) begin
        rtc_timer = 0;
    end
    else begin
        rtc_timer = rtc_timer + 1;
    end
end

// DUT
tsu_axis dut (
    .rst(reset),

    .mac_axis_aclk(clk),
    .mac_axis_tvalid(m_axis_tvalid),
    .mac_axis_tready(m_axis_tready),
    .mac_axis_tdata(m_axis_tdata),
    .mac_axis_tlast(m_axis_tlast),

    .ptp_msgid_mask(8'b0000_1101),

    .rtc_timer_clk(rtc_clk),
    .rtc_timer_in(rtc_timer),

    .q_rst(reset),
    .q_rd_clk(ps_clk),
    .q_rd_en(1),
    .q_rd_stat(q_rd_stat),
    .q_rd_data(q_rd_data)
);

// Packet content
initial begin
    packet[0] = 8'h01;packet[1] = 8'h80;packet[2] = 8'hC2;packet[3] = 8'h00;
    packet[4] = 8'h00;packet[5] = 8'h0E;packet[6] = 8'hD3;packet[7] = 8'h02;
    packet[8] = 8'h03;packet[9] = 8'h04;packet[10] = 8'h05;packet[11] = 8'h06;
    packet[12] = 8'h88;packet[13] = 8'hF7;packet[14] = 8'h02;packet[15] = 8'h00;
    packet[16] = 8'h00;packet[17] = 8'h00;packet[18] = 8'h00;packet[19] = 8'h00;
    packet[20] = 8'h00;packet[21] = 8'h00;packet[22] = 8'h00;packet[23] = 8'h00;
    packet[24] = 8'h00;packet[25] = 8'h00;packet[26] = 8'h00;packet[27] = 8'h00;
    packet[28] = 8'h00;packet[29] = 8'h00;packet[30] = 8'h00;packet[31] = 8'h00;
    packet[32] = 8'h00;packet[33] = 8'h00;packet[34] = 8'h00;packet[35] = 8'h00;
    packet[36] = 8'h01;packet[37] = 8'h02;packet[38] = 8'h04;packet[39] = 8'h08;
    packet[40] = 8'h10;packet[41] = 8'h20;packet[42] = 8'h40;packet[43] = 8'h80;
    packet[44] = 8'h00;packet[45] = 8'hFF;packet[46] = 8'h00;packet[47] = 8'h00;
    packet[48] = 8'h00;packet[49] = 8'h00;packet[50] = 8'h00;packet[51] = 8'h00;
    packet[52] = 8'h00;packet[53] = 8'h00;packet[54] = 8'h00;packet[55] = 8'h00;
    packet[56] = 8'h00;packet[57] = 8'h00;packet[58] = 8'h00;packet[59] = 8'h00;
    packet[60] = 8'hFF;
end

initial begin
    reset = 1;
    #(PER_clk*16);
    reset = 0;
    for (i = 0; i < PACKET_LENGTH; i=i+1) begin // TODO when DATA_WIDTH is larger than 8.
        @(posedge clk);
        m_axis_tdata = packet[i];
        m_axis_tvalid = 1'b1;
        if (i == PACKET_LENGTH-1) begin
            m_axis_tlast = 1'b1;
        end
    end
    @(posedge clk);
    m_axis_tvalid = 1'b0;
    m_axis_tlast = 1'b0;

    repeat(16) @(posedge clk);

    for (i = 0; i < PACKET_LENGTH; i=i+1) begin // TODO when DATA_WIDTH is larger than 8.
        @(posedge clk);
        m_axis_tdata = packet[i];
        m_axis_tvalid = 1'b1;
        if (i == PACKET_LENGTH-1) begin
            m_axis_tlast = 1'b1;
        end
    end
    @(posedge clk);
    m_axis_tvalid = 1'b0;
    m_axis_tlast = 1'b0;

end

endmodule