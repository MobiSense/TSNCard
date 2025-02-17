module simple_output_port_lookup
#(
    //Master AXI Stream Data Width
    parameter C_M_AXIS_DATA_WIDTH  = 256,
    parameter C_S_AXIS_DATA_WIDTH  = 256,
    parameter C_M_AXIS_TUSER_WIDTH = 128,
    parameter C_S_AXIS_TUSER_WIDTH = 128,
    parameter SRC_PORT_POS         = 16,
    parameter DST_PORT_POS         = 24,
    parameter SWITCH_ID            = 1
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
    input                                      s_axis_tlast
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
    if (dst_mac_w == 48'h01_00_00_00_00_00) begin
        if (SWITCH_ID == 1) begin
            m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = 8'b0000_0001;
        end
        else if (SWITCH_ID == 2) begin
            m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = 8'b0000_0001;
        end
    end
    else if (dst_mac_w == 48'h02_00_00_00_00_00) begin
        if (SWITCH_ID == 1) begin
            m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = 8'b0001_0000;
        end
        else if (SWITCH_ID == 2) begin
            m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = 8'b0000_0001;
        end
    end
    else if (dst_mac_w == 48'h03_00_00_00_00_00) begin
        if (SWITCH_ID == 1) begin
            m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = 8'b0000_0100;
        end
        else if (SWITCH_ID == 2) begin
            m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = 8'b0000_0100;
        end
    end
    else if (dst_mac_w == 48'h04_00_00_00_00_00) begin
        if (SWITCH_ID == 1) begin
            m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = 8'b0000_0100;
        end
        else if (SWITCH_ID == 2) begin
            m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = 8'b0001_0000;
        end
    end
    else if ((dst_mac_w == 48'h0E_00_00_C2_80_01) && (ether_type_w == 16'hF7_88) && ((src_port_w & 8'haa) == 8'h00)) begin
        // recv ptp message from outside.
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = 8'haa;
    end
    else if ((dst_mac_w == 48'h0E_00_00_C2_80_01) && (ether_type_w == 16'hF7_88) && ((src_port_w & 8'haa) != 8'h00)) begin
        // send ptp message to outside.
        m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = {1'b0, src_port_w[7:1]};
    end
end
endmodule