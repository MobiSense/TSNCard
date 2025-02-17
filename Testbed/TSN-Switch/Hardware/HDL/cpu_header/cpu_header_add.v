`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/05 14:43:56
// Design Name: 
// Module Name: cpu_header_add
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


module cpu_header_add #
    (
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

        //master axis interface
        output [C_DATA_WIDTH-1:0] m_axis_tdata,
        output [C_DATA_WIDTH/8-1:0] m_axis_tkeep,
        output m_axis_tvalid,
        output m_axis_tlast,
        input m_axis_tready
    );

    // Internal Params
    localparam ADD_HEADER_S = 0;
    localparam WAIT_EOP_S = 1;

    // Regs/wires
    reg state, nxt_state;
    
    // state machine
    always @(posedge rst, posedge clk) begin
        if (rst == 1'b1) begin
            state <= ADD_HEADER_S;
        end
        else begin
            state <= nxt_state;
        end
    end

    always @(state, s_axis_tvalid, m_axis_tready, s_axis_tlast) begin
        case(state)
            ADD_HEADER_S: begin
                if (m_axis_tvalid && m_axis_tready) begin
                    nxt_state = WAIT_EOP_S;
                end
                else begin
                    nxt_state = ADD_HEADER_S;
                end
            end
            WAIT_EOP_S: begin
                if (m_axis_tvalid && m_axis_tready && m_axis_tlast) begin
                    nxt_state = ADD_HEADER_S;
                end
                else begin
                    nxt_state = WAIT_EOP_S;
                end
            end
        endcase
    end

    // Determine m_axis signal
    assign s_axis_tready = (state == ADD_HEADER_S) ? 0: m_axis_tready;
    assign m_axis_tdata = (state == ADD_HEADER_S) ? {{(C_DATA_WIDTH-C_TUSER_WIDTH){1'b0}}, s_axis_tuser}: s_axis_tdata;
    assign m_axis_tvalid = s_axis_tvalid;
    assign m_axis_tkeep = (state == ADD_HEADER_S) ? {(C_DATA_WIDTH/8){1'b1}}: s_axis_tkeep;
    assign m_axis_tlast = (state == ADD_HEADER_S) ? 0: s_axis_tlast;
endmodule
