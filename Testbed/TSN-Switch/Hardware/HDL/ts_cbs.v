`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TNS
// Engineer: Yi Zhao
// 
// Create Date: 2021/04/04 22:59:35
// Design Name: 
// Module Name: ts_cbs
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: IEEE 802.1Qav Credit Based Shaper. For individual queue.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ts_cbs (
    input wire axis_aclk,
    input wire axis_reset,

    input wire axis_tvalid,
    input wire axis_tready,

    output wire queue_valid
);
// FIXME: modify this parameter in 1000Mbps mac speed.
reg signed [15:0] port_transmit_rate = 16'd100; // The link speed is 100Mbps. 100 bit per 1000ns.
reg signed [15:0] idle_slope = 16'd20; // The token accumulation speed of AV traffic is 75M. bit per 1000ns.
reg [11:0] token_update_count;
wire [15:0] send_slope;
reg signed [15:0] credit;

assign send_slope = idle_slope - port_transmit_rate;

// Update credit.
always @(posedge axis_aclk or posedge axis_reset) begin
    if (axis_reset == 1'b1) begin
        credit <= 0;
        token_update_count <= 0;
    end
    else begin
        if (token_update_count == 12'd124) begin
            token_update_count <= 0;
            if (axis_tvalid && axis_tready) begin
                credit <= credit + send_slope;
            end
            else if (axis_tvalid) begin
                credit <= credit + idle_slope;
            end
            else if (credit + idle_slope > 0) begin
                credit <= 0;
            end
            else begin
                credit <= credit + idle_slope;
            end
        end
        else begin
            token_update_count <= token_update_count + 1;
        end
    end
end

wire transmit_allowed = credit >= 0 ? 1: 0;
assign queue_valid = ((axis_tvalid == 1'b1)? transmit_allowed : 0);

endmodule