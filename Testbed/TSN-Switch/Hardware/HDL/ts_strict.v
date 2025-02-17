`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TNS
// Engineer: Yi Zhao
// 
// Create Date: 2021/04/05 11:15:00
// Design Name: 
// Module Name: ts_strict
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Strict Priority Transmission Selection Algorithm.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ts_strict (
    input wire axis_aclk,
    input wire axis_reset,

    input wire axis_tvalid,
    input wire axis_tready,

    output wire queue_valid
);

assign queue_valid = (axis_tvalid == 1'b1) ? 1'b1: 1'b0;

endmodule