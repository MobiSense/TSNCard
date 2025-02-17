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

module cycle_timer_sm (
    input wire clk,
    input wire rst,
    input wire [47:0] sync_time_ptp_sec,
    input wire [31:0] sync_time_ptp_ns,
    output reg CycleStart
);

localparam CYCLE_IDLE = 2'd0;
localparam SET_CYCLE_START_TIME = 2'd1;
localparam START_CYCLE = 2'd2;

reg [1:0] state;
reg [1:0] next_state;
reg [31:0] CycleStartTimeNs;
reg [47:0] CycleStartTimeSec;
reg [31:0] CycleStartTimeNsNext;
reg [47:0] CycleStartTimeSecNext;
// wire [31:0] CycleStartTimeNextRaw = {sync_time_ptp_ns[31:21] + 11'd1, 21'd0};
wire [31:0] CycleStartTimeNsNextRaw = {sync_time_ptp_ns[31:24] + 8'd1, sync_time_ptp_ns[23:0]};
// wire [31:0] CycleStartTimeNextTrue = CycleStartTimeNextRaw > 32'd999_999_900 ? 32'd0 : CycleStartTimeNextRaw;

always @(*) begin
    next_state = state;
    CycleStartTimeNsNext = CycleStartTimeNs;
    CycleStartTimeSecNext = CycleStartTimeSec;

    CycleStart = 1'b0;

    case (state)
        CYCLE_IDLE: begin
            next_state = SET_CYCLE_START_TIME;
            // Set CycleStartTime (simplified)
            CycleStartTimeNsNext = (CycleStartTimeNsNextRaw > 32'd999_999_999)? (CycleStartTimeNsNextRaw - 32'd1_000_000_000): CycleStartTimeNsNextRaw;
            CycleStartTimeSecNext = (CycleStartTimeNsNextRaw > 32'd999_999_999)? (sync_time_ptp_sec + 1): sync_time_ptp_sec;
        end
        SET_CYCLE_START_TIME: begin
            if (CycleStartTimeSec < sync_time_ptp_sec) begin
                next_state = START_CYCLE;
            end
            else if (CycleStartTimeSec == sync_time_ptp_sec && CycleStartTimeNs <= sync_time_ptp_ns) begin
                next_state = START_CYCLE;
            end
        end
        START_CYCLE: begin
            next_state = SET_CYCLE_START_TIME;
            CycleStartTimeNsNext = (CycleStartTimeNsNextRaw > 32'd999_999_999)? (CycleStartTimeNsNextRaw - 32'd1_000_000_000): CycleStartTimeNsNextRaw;
            CycleStartTimeSecNext = (CycleStartTimeNsNextRaw > 32'd999_999_999)? (sync_time_ptp_sec + 1): sync_time_ptp_sec;
            CycleStart = 1'b1;
        end
    endcase
end

always @(posedge rst, posedge clk) begin
    if (rst == 1'b1) begin
        state <= CYCLE_IDLE;
        CycleStartTimeNs <= 32'd0;
        CycleStartTimeSec <= 48'd0;
    end
    else begin
        state <= next_state;
        CycleStartTimeNs <= CycleStartTimeNsNext;
        CycleStartTimeSec <= CycleStartTimeSecNext;
    end
end
    
endmodule