`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/02 11:49:04
// Design Name: 
// Module Name: configurable_output_port_lookup
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


module configurable_output_port_lookup
#(
    //Master AXI Stream Data Width
    parameter C_M_AXIS_DATA_WIDTH  = 256,
    parameter C_S_AXIS_DATA_WIDTH  = 256,
    parameter C_M_AXIS_TUSER_WIDTH = 128,
    parameter C_S_AXIS_TUSER_WIDTH = 128,
    parameter SRC_PORT_POS         = 16,
    parameter DST_PORT_POS         = 24
)
(
    // Global Ports
    input                                      axis_aclk,
    input                                      axis_resetn,

    // Master Stream Ports (interface to data path)
    output [C_M_AXIS_DATA_WIDTH - 1:0]         m_axis_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tkeep,
    output reg [C_M_AXIS_TUSER_WIDTH-1:0]      m_axis_tuser,
    output                                     m_axis_tvalid,
    input                                      m_axis_tready,
    output                                     m_axis_tlast,

    // Slave Stream Ports (interface to RX queues)
    input [C_S_AXIS_DATA_WIDTH - 1:0]          s_axis_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0]  s_axis_tkeep,
    input [C_S_AXIS_TUSER_WIDTH-1:0]           s_axis_tuser,
    input                                      s_axis_tvalid,
    output                                     s_axis_tready,
    input                                      s_axis_tlast,
    input [47:0] dst_mac_0,
    input [7:0] dst_port_0,
    input [47:0] dst_mac_1,
    input [7:0] dst_port_1,
    input [47:0] dst_mac_2,
    input [7:0] dst_port_2,
    input [47:0] dst_mac_3,
    input [7:0] dst_port_3,
    input [47:0] dst_mac_4,
    input [7:0] dst_port_4,
    input [47:0] dst_mac_5,
    input [7:0] dst_port_5,
    input [47:0] dst_mac_6,
    input [7:0] dst_port_6,
    input [47:0] dst_mac_7,
    input [7:0] dst_port_7,
    input [47:0] dst_mac_8,
    input [7:0] dst_port_8,
    input [47:0] dst_mac_9,
    input [7:0] dst_port_9,
    input [47:0] dst_mac_10,
    input [7:0] dst_port_10,
    input [47:0] dst_mac_11,
    input [7:0] dst_port_11,
    input [47:0] dst_mac_12,
    input [7:0] dst_port_12,
    input [47:0] dst_mac_13,
    input [7:0] dst_port_13,
    input [47:0] dst_mac_14,
    input [7:0] dst_port_14,
    input [47:0] dst_mac_15,
    input [7:0] dst_port_15,
    input [47:0] dst_mac_16,
    input [7:0] dst_port_16,
    input [47:0] dst_mac_17,
    input [7:0] dst_port_17,
    input [47:0] dst_mac_18,
    input [7:0] dst_port_18,
    input [47:0] dst_mac_19,
    input [7:0] dst_port_19,
    input [47:0] dst_mac_20,
    input [7:0] dst_port_20,
    input [47:0] dst_mac_21,
    input [7:0] dst_port_21,
    input [47:0] dst_mac_22,
    input [7:0] dst_port_22,
    input [47:0] dst_mac_23,
    input [7:0] dst_port_23,
    input [47:0] dst_mac_24,
    input [7:0] dst_port_24,
    input [47:0] dst_mac_25,
    input [7:0] dst_port_25,
    input [47:0] dst_mac_26,
    input [7:0] dst_port_26,
    input [47:0] dst_mac_27,
    input [7:0] dst_port_27,
    input [47:0] dst_mac_28,
    input [7:0] dst_port_28,
    input [47:0] dst_mac_29,
    input [7:0] dst_port_29,
    input [47:0] dst_mac_30,
    input [7:0] dst_port_30,
    input [47:0] dst_mac_31,
    input [7:0] dst_port_31
);

assign m_axis_tdata = s_axis_tdata;
assign m_axis_tkeep = s_axis_tkeep;
assign m_axis_tvalid = s_axis_tvalid;
assign s_axis_tready = m_axis_tready;
assign m_axis_tlast = s_axis_tlast;

wire [47:0] dst_mac_w;
wire [47:0] src_mac_w;
wire [15:0] ether_type_w;
wire [7:0] src_port_w;

assign dst_mac_w    = s_axis_tdata[47:0];
assign src_mac_w    = s_axis_tdata[95:48];
assign ether_type_w = s_axis_tdata[111:96];
assign src_port_w   = s_axis_tuser[SRC_PORT_POS+7:SRC_PORT_POS];

always @(*) begin
    m_axis_tuser = s_axis_tuser;
    if (dst_mac_w == dst_mac_0) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_0;
    end
    else if (dst_mac_w == dst_mac_1) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_1;
    end
    else if (dst_mac_w == dst_mac_2) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_2;
    end
    else if (dst_mac_w == dst_mac_3) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_3;
    end
    else if (dst_mac_w == dst_mac_4) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_4;
    end
    else if (dst_mac_w == dst_mac_5) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_5;
    end
    else if (dst_mac_w == dst_mac_6) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_6;
    end
    else if (dst_mac_w == dst_mac_7) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_7;
    end
    else if (dst_mac_w == dst_mac_8) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_8;
    end
    else if (dst_mac_w == dst_mac_9) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_9;
    end
    else if (dst_mac_w == dst_mac_10) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_10;
    end
    else if (dst_mac_w == dst_mac_11) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_11;
    end
    else if (dst_mac_w == dst_mac_12) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_12;
    end
    else if (dst_mac_w == dst_mac_13) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_13;
    end
    else if (dst_mac_w == dst_mac_14) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_14;
    end
    else if (dst_mac_w == dst_mac_15) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_15;
    end
    else if (dst_mac_w == dst_mac_16) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_16;
    end
    else if (dst_mac_w == dst_mac_17) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_17;
    end
    else if (dst_mac_w == dst_mac_18) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_18;
    end
    else if (dst_mac_w == dst_mac_19) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_19;
    end
    else if (dst_mac_w == dst_mac_20) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_20;
    end
    else if (dst_mac_w == dst_mac_21) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_21;
    end
    else if (dst_mac_w == dst_mac_22) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_22;
    end
    else if (dst_mac_w == dst_mac_23) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_23;
    end
    else if (dst_mac_w == dst_mac_24) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_24;
    end
    else if (dst_mac_w == dst_mac_25) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_25;
    end
    else if (dst_mac_w == dst_mac_26) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_26;
    end
    else if (dst_mac_w == dst_mac_27) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_27;
    end
    else if (dst_mac_w == dst_mac_28) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_28;
    end
    else if (dst_mac_w == dst_mac_29) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_29;
    end
    else if (dst_mac_w == dst_mac_30) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_30;
    end
    else if (dst_mac_w == dst_mac_31) begin
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_port_31;
    end
    else if ((dst_mac_w == 48'h0E_00_00_C2_80_01) && (ether_type_w == 16'hF7_88) && ((src_port_w & 8'haa) == 8'h00)) begin
        // recv ptp message from outside.
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = 8'b0000_0010;
    end
    else if ((dst_mac_w == 48'h0E_00_00_C2_80_01) && (ether_type_w == 16'hF7_88) && ((src_port_w & 8'haa) != 8'h00)) begin
        // send ptp message to outside.
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = {1'b0, src_port_w[7:1]};
    end
    else begin
        // continue use the learned port
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = s_axis_tuser[DST_PORT_POS+7:DST_PORT_POS];
    end

end
endmodule