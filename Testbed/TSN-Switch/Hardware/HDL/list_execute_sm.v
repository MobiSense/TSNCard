`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TNS
// Engineer: Yi Zhao
// 
// Create Date: 2021/04/05 19:09:00
// Design Name: 
// Module Name: 802.1Q-2018 8.6.9.2 List Execute state machine.
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//     Output: The Gate states of each queue (taking guard band into consideration)
//             Then the upper module decide the connection of axis signal based on 
//             This gate states and transmission selection result. 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Revision 0.1 - Make Interval of each slot configurable
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module list_execute_sm (
    input wire clk,
    input wire rst,

    input wire CycleStart,

    output wire [7:0] OutGateStates,

    input  gcl_clk_in,
    output[143:0] gcl_rd_data,
    input wire gcl_ld,
    input [3:0] gcl_id,
    input [8:0] gcl_ld_data,
    input wire gcl_time_ld,
    input [3:0] gcl_time_id,
    input [19:0] gcl_ld_time
);

localparam INIT = 3'd0;
localparam NEW_CYCLE = 3'd1;
localparam EXECUTE_CYCLE = 3'd2;
localparam DELAY = 3'd3;
localparam END_OF_CYCLE = 3'd4;

reg GateEnabled = 1'b1;
reg [2:0] state;
reg [2:0] next_state;
reg [7:0] AdminGateStates = 8'hff;
reg [7:0] OperGateStates;
reg       GuardBand;
reg [19:0] AdminTimeInterval = 20'h20000;
wire [27:0] OperTimeInterval;
reg [27:0] ExitTimer;
// reg [19:0] GuardBandInterval = 20'd49;
// reg [19:0] GuardBandInterval = 20'd1600; // covers a MTU in 1000Mbps
reg [19:0] GuardBandInterval = 20'd3200; // covers a MTU in 1000Mbps

reg [27:0] ExitTimerNext;
reg [4:0] ListPointer;
reg [4:0] ListPointerNext;
reg [8:0] GCL[0:15];
// Assume the value in TimeIntervalList is x, then the length of the corresponding slot is x * 2^8 * 8ns
reg [19:0] TimeIntervalList[0:15]; // Interval of each slot.
reg [4:0] OperControlListLength = 5'd16;

assign OperTimeInterval = TimeIntervalList[ListPointerNext] << 8;

always @(*) begin
    next_state = state;
    ListPointerNext = ListPointer;
    ExitTimerNext = ExitTimer;
    OperGateStates = GCL[ListPointer][7:0];
    GuardBand = GCL[ListPointer][8];

    if (!GateEnabled) begin
        next_state = INIT;
        OperGateStates = AdminGateStates;
        ListPointerNext = 5'd0;
    end
    else if (CycleStart) begin
        next_state = NEW_CYCLE;
        ListPointerNext = 5'd0;
    end
    else begin
        case (state)
            INIT: next_state = END_OF_CYCLE;
            NEW_CYCLE: begin
                next_state = EXECUTE_CYCLE;
                ExitTimerNext = OperTimeInterval;
                // ListPointerNext = ListPointer + 1;
            end
            EXECUTE_CYCLE: begin
                if (ListPointer + 1 >= OperControlListLength) begin
                    // If reach the end, then enter END_OF_CYCLE state and stay there, Gatestates will remain the last slot of GCL.
                    next_state = END_OF_CYCLE;
                end 
                else if (ListPointer + 1 < OperControlListLength && ExitTimer > 0) begin
                    next_state = DELAY;
                    ExitTimerNext = ExitTimer - 1;
                end
                else if (ListPointer + 1 < OperControlListLength && ExitTimer == 0) begin 
                    ExitTimerNext = OperTimeInterval;
                    ListPointerNext = ListPointer + 1;
                end
            end
            DELAY: begin
                if (ExitTimer > 0) begin
                    ExitTimerNext = ExitTimer - 1;
                end
                if (ExitTimer == 0) begin
                    next_state = EXECUTE_CYCLE;
                    ExitTimerNext = OperTimeInterval;
                    ListPointerNext = ListPointer + 1;
                end
            end
        endcase
    end
end
reg[143:0] gcl_rd_data_reg;
assign gcl_rd_data = {GCL[0], GCL[1], GCL[2], GCL[3], GCL[4], GCL[5], GCL[6], GCL[7], GCL[8], GCL[9], GCL[10], GCL[11], GCL[12], GCL[13], GCL[14], GCL[15]};
// state update
always @(posedge rst, posedge clk) begin
    if (rst == 1'b1) begin
        state <= INIT;
        ListPointer <= 0;
        ExitTimer <= AdminTimeInterval;
    end
    else begin
        state <= next_state;
        ListPointer <= ListPointerNext;
        ExitTimer <= ExitTimerNext;
    end
end

// GCL update
always @(posedge rst, posedge gcl_clk_in) begin
    if (rst == 1'b1) begin
        // GCL is 2 by default.
        GCL[0]  <= 9'b0_0000_0010;
        GCL[1]  <= 9'b0_0000_0010;
        GCL[2]  <= 9'b0_0000_0010;
        GCL[3]  <= 9'b0_0000_0010;
        GCL[4]  <= 9'b0_0000_0010;
        GCL[5]  <= 9'b0_0000_0010;
        GCL[6]  <= 9'b0_0000_0010;
        GCL[7]  <= 9'b0_0000_0010;
        GCL[8]  <= 9'b0_0000_0010;
        GCL[9]  <= 9'b0_0000_0010;
        GCL[10] <= 9'b0_0000_0010;
        GCL[11] <= 9'b0_0000_0010;
        GCL[12] <= 9'b0_0000_0010;
        GCL[13] <= 9'b0_0000_0010;
        GCL[14] <= 9'b0_0000_0010;
        GCL[15] <= 9'b0_0000_0010;
        TimeIntervalList[0]  <= 20'h400;
        TimeIntervalList[1]  <= 20'h400;
        TimeIntervalList[2]  <= 20'h400;
        TimeIntervalList[3]  <= 20'h400;
        TimeIntervalList[4]  <= 20'h400;
        TimeIntervalList[5]  <= 20'h400;
        TimeIntervalList[6]  <= 20'h400;
        TimeIntervalList[7]  <= 20'h400;
        TimeIntervalList[8]  <= 20'h400;
        TimeIntervalList[9]  <= 20'h400;
        TimeIntervalList[10] <= 20'h400;
        TimeIntervalList[11] <= 20'h400;
        TimeIntervalList[12] <= 20'h400;
        TimeIntervalList[13] <= 20'h400;
        TimeIntervalList[14] <= 20'h400;
        TimeIntervalList[15] <= 20'h400;
    end
    else begin
        if (gcl_ld) begin  // direct write 
            GCL[gcl_id] <= gcl_ld_data;
        end
        if (gcl_time_ld) begin  // direct write 
            TimeIntervalList[gcl_time_id] <= gcl_ld_time;
        end
    end 
end

// Determine outputs
assign OutGateStates = GuardBand? (ExitTimer <= GuardBandInterval? 8'd0: OperGateStates): OperGateStates;

endmodule