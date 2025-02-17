`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/16 13:11:00
// Design Name: Halcao
// Module Name: priority_tagger
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


module priority_tagger #
    (
        // C_DATA_WIDTH must be greater than 144
        parameter C_DATA_WIDTH = 256,
        parameter C_TUSER_WIDTH = 128
    )
    (
        input clk,
        input rst,

        // slave axis interface
        input [C_DATA_WIDTH-1:0] s_axis_tdata,
        input [C_TUSER_WIDTH-1:0] s_axis_tuser,
        input [C_DATA_WIDTH/8-1:0] s_axis_tkeep,
        input s_axis_tvalid,
        input s_axis_tlast,
        output s_axis_tready,

        // master axis interface
        output [C_DATA_WIDTH-1:0] m_axis_tdata,
        output [C_TUSER_WIDTH-1:0] m_axis_tuser,
        output [C_DATA_WIDTH/8-1:0] m_axis_tkeep,
        output m_axis_tvalid,
        output m_axis_tlast,
        input m_axis_tready
    );

    // Internal Params
    localparam ADD_VLAN_HEADER_S = 0;
    localparam RETURN_PAYLOAD_S = 1;
    localparam WAIT_EOP_S = 2;

    // Regs/wires
    reg [1:0]state, nxt_state;
    wire ip_frame;

    // state machine
    always @(posedge rst, posedge clk) begin
        if (rst == 1'b1) begin
            state <= ADD_VLAN_HEADER_S;
        end
        else begin
            state <= nxt_state;
        end
    end

    always @(state, s_axis_tvalid, m_axis_tready, s_axis_tlast) begin
        case(state)
            ADD_VLAN_HEADER_S: begin
                if (m_axis_tvalid && m_axis_tready) begin
                    if (ip_frame) begin
                        nxt_state = RETURN_PAYLOAD_S;
                    end
                    else begin
                        nxt_state = WAIT_EOP_S;
                    end
                end
                else begin
                    nxt_state = ADD_VLAN_HEADER_S;
                end
            end
            RETURN_PAYLOAD_S: begin
                nxt_state = WAIT_EOP_S;
            end
            WAIT_EOP_S: begin
                if (m_axis_tvalid && m_axis_tready && m_axis_tlast) begin
                    nxt_state = ADD_VLAN_HEADER_S;
                end
                else begin
                    nxt_state = WAIT_EOP_S;
                end
            end
        endcase
    end

    assign ip_frame = s_axis_tdata[111:96] == 16'h0008;

    // Determine m_axis signal
    assign s_axis_tready = (state == ADD_VLAN_HEADER_S) ? 0 : m_axis_tready;
    assign m_axis_tdata = (state == ADD_VLAN_HEADER_S && ip_frame) ?
    // if adds header, concatenate the vlan header 
    { s_axis_tdata[C_DATA_WIDTH-1:144], { 16'h0008, 12'h0, s_axis_tdata[125:123], 1'b0,  16'h0081 }, s_axis_tdata[95:0] } : s_axis_tdata;
    assign m_axis_tuser = s_axis_tuser;
    assign m_axis_tvalid = s_axis_tvalid;
    assign m_axis_tkeep = ip_frame ? 
            // only the last 18 bytes are valid
            (state == ADD_VLAN_HEADER_S) ? { {(C_DATA_WIDTH / 8 - 18){1'b0}}, {18{1'b1}} }
            // the last 14 bytes are invalid
            : (state == RETURN_PAYLOAD_S) ? { {(C_DATA_WIDTH / 8 - 14){1'b1}}, {14{1'b0}} } 
            : s_axis_tkeep : s_axis_tkeep;
    assign m_axis_tlast = (state == ADD_VLAN_HEADER_S || state == RETURN_PAYLOAD_S) ? 0 : s_axis_tlast;
endmodule
