`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TNS
// Engineer: Yi Zhao
// 
// Create Date: 2021/04/10 21:39:00
// Design Name: 
// Module Name: 802.1Q-2018 8.6.9.1 Cycle Timer state machine.
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

// 2^24ns is about 16ms
// 2^25ns is about 32ms

module cycle_timer_sm_aligned (
    input wire clk,
    input wire rst,
    input wire [63:0] sync_time_ptp_ns_mini,
    output reg CycleStart
);

localparam CYCLE_IDLE = 2'd0;
localparam SET_CYCLE_START_TIME = 2'd1;
localparam START_CYCLE = 2'd2;

reg [1:0] state;
reg [1:0] next_state;
reg [63:0] CycleStartTimeNs;
reg [63:0] CycleStartTimeNsNext;
reg [7:0] period_width = 25; // The period is 2^period_width ns

// assign CycleStartTimeNsNext = {sync_time_ptp_ns_mini[63:24] + 8'd1, sync_time_ptp_ns_mini[23:0]};

always @(*) begin
    next_state = state;
    CycleStartTimeNsNext = CycleStartTimeNs;

    CycleStart = 1'b0;

    case (state)
        CYCLE_IDLE: begin
            next_state = SET_CYCLE_START_TIME;
            CycleStartTimeNsNext = ((sync_time_ptp_ns_mini >> period_width) + 1) << period_width;
        end
        SET_CYCLE_START_TIME: begin
            if (CycleStartTimeNs <= sync_time_ptp_ns_mini) begin
                next_state = START_CYCLE;
            end
        end
        START_CYCLE: begin
            next_state = SET_CYCLE_START_TIME;
            CycleStartTimeNsNext = ((sync_time_ptp_ns_mini >> period_width) + 1) << period_width;
            CycleStart = 1'b1;
        end
    endcase
end

always @(posedge rst, posedge clk) begin
    if (rst == 1'b1) begin
        state <= CYCLE_IDLE;
        CycleStartTimeNs <= 64'd0;
    end
    else begin
        state <= next_state;
        CycleStartTimeNs <= CycleStartTimeNsNext;
    end
end
    
endmodule