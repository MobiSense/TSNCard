`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/05 15:37:36
// Design Name: 
// Module Name: cpu_header_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cpu_header_tb;
    parameter DATA_WIDTH = 256;
    parameter USER_WIDTH = 128;

    reg clk;
    reg rst;

    reg [DATA_WIDTH-1:0] s_axis_tdata;
    reg [USER_WIDTH-1:0] s_axis_tuser;
    reg [DATA_WIDTH/8-1:0] s_axis_tkeep;
    reg s_axis_tvalid;
    reg s_axis_tlast;
    wire s_axis_tready;

    wire [DATA_WIDTH-1:0] m_axis_tdata;
    wire [DATA_WIDTH/8-1:0] m_axis_tkeep;
    wire m_axis_tvalid;
    wire m_axis_tlast;
    reg m_axis_tready;

    initial 
    begin
        clk <= 1'b0;
        forever #4 clk <= !clk;
    end

    initial 
    begin
        rst <= 1'b1;
        #40;
        rst <= 1'b0;
    end

    cpu_header_add 
    #(
        .C_DATA_WIDTH(DATA_WIDTH),
        .C_TUSER_WIDTH(USER_WIDTH)
    )
    dut (
        .clk(clk),
        .rst(rst),

        .s_axis_tdata(s_axis_tdata),
        .s_axis_tuser(s_axis_tuser),
        .s_axis_tkeep(s_axis_tkeep),
        .s_axis_tvalid(s_axis_tvalid),
        .s_axis_tlast(s_axis_tlast),
        .s_axis_tready(s_axis_tready),

        .m_axis_tdata(m_axis_tdata),
        .m_axis_tkeep(m_axis_tkeep),
        .m_axis_tvalid(m_axis_tvalid),
        .m_axis_tlast(m_axis_tlast),
        .m_axis_tready(m_axis_tready)
    );

    // initial begin
    //     #150; 
    //     m_axis_tready = 1'b0;
    //     #50;
    //     m_axis_tready = 1'b1;
    //     #50;
    //     m_axis_tready = 1'b0;
    //     #50;
    //     m_axis_tready = 1'b1;
    // end

    initial 
    begin
        #100;
        m_axis_tready = 1'b1;
        #1;
        s_axis_tdata = 256'h0123456789abcdef_0123456789abcdef_0123456789abcdef_0123456789abcdef;
        s_axis_tuser = 128'haaaaaaaaaaaaaaaa_aaaaaaaaaaaaaaaa;
        s_axis_tkeep = 32'hffffffff;
        s_axis_tlast = 1'b0;

        #1;
        s_axis_tvalid = 1'b1;

        @(posedge clk)
        while (s_axis_tready != 1'b1)
            @(posedge clk);
        s_axis_tdata = 256'h123456789abedef0_123456789abedef0_123456789abedef0_123456789abedef0;
        @(posedge clk);
        while (s_axis_tready != 1'b1)
            @(posedge clk);
        s_axis_tdata = 256'h23456789abedef01_23456789abedef01_23456789abedef01_23456789abedef01;
        s_axis_tkeep = 32'hffff0000;
        s_axis_tlast = 1'b1;
        @(posedge clk);
        while (s_axis_tready != 1'b1)
            @(posedge clk);

        s_axis_tdata = 256'h0123456789abcdef_0123456789abcdef_0123456789abcdef_0123456789abcdef;
        s_axis_tuser = 128'hbbbbbbbbbbbbbbbb_bbbbbbbbbbbbbbbb;
        s_axis_tkeep = 32'hffffffff;
        s_axis_tlast = 1'b0;
        @(posedge clk);
        while (s_axis_tready != 1'b1)
            @(posedge clk);
        s_axis_tdata = 256'h123456789abedef0_123456789abedef0_123456789abedef0_123456789abedef0;
        @(posedge clk);
        while (s_axis_tready != 1'b1)
            @(posedge clk);
        s_axis_tdata = 256'h23456789abedef01_23456789abedef01_23456789abedef01_23456789abedef01;
        s_axis_tkeep = 32'hffff0000;
        s_axis_tlast = 1'b1;
        @(posedge clk);
        while (s_axis_tready != 1'b1)
            @(posedge clk);
        
        s_axis_tvalid = 1'b0;
        @(posedge clk);

        s_axis_tvalid = 1'b1;
        s_axis_tdata = 256'h0123456789abcdef_0123456789abcdef_0123456789abcdef_0123456789abcdef;
        s_axis_tuser = 128'hcccccccccccccccc_cccccccccccccccc;
        s_axis_tkeep = 32'hffffffff;
        s_axis_tlast = 1'b0;
        @(posedge clk);
        while (s_axis_tready != 1'b1)
            @(posedge clk);
        s_axis_tdata = 256'h123456789abedef0_123456789abedef0_123456789abedef0_123456789abedef0;
        @(posedge clk);
        while (s_axis_tready != 1'b1)
            @(posedge clk);
        s_axis_tdata = 256'h23456789abedef01_23456789abedef01_23456789abedef01_23456789abedef01;
        s_axis_tlast = 1'b1;
        @(posedge clk);
        while (s_axis_tready != 1'b1)
            @(posedge clk);
        s_axis_tvalid = 1'b0;
        s_axis_tlast = 1'b0;
        

    end
endmodule
