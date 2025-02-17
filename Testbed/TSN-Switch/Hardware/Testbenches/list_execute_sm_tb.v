`timescale 1ns / 1ps

module list_execute_sm_tb();
    
// Local parameters
localparam ONE_NS = 1;
localparam time PER_125M_clk = 8*ONE_NS; // 8 ns clock

// Reg declarations
reg clk = 1;
reg reset = 1;
wire CycleStart;
wire [7:0] OutGateStates;
reg [31:0] sync_time_ptp_ns;
reg [47:0] sync_time_ptp_sec;

// Clock signals
always begin
    clk = #(PER_125M_clk/2) ~clk;
end

always @(posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
        sync_time_ptp_sec <= 0;
        sync_time_ptp_ns <= 32'd999_999_000;
    end
    else begin
        sync_time_ptp_ns <= (sync_time_ptp_ns + 8 > 32'd1_000_000_000)? sync_time_ptp_ns + 8 - 32'd1_000_000_000 : sync_time_ptp_ns + 8;
        sync_time_ptp_sec <= (sync_time_ptp_ns + 8 > 32'd1_000_000_000)? sync_time_ptp_sec + 1: sync_time_ptp_sec;
    end
end

// DUT
list_execute_sm dut1 (
    .clk(clk),
    .rst(reset),
    .CycleStart(CycleStart),
    .OutGateStates(OutGateStates)
);

cycle_timer_sm_self dut2 (
    .clk(clk),
    .rst(reset),
    .CycleStart(CycleStart)
);





initial begin
    reset = 1;
    #(PER_125M_clk*16);
    reset = 0;
    #(PER_125M_clk*16);
    // @(posedge clk);
    // CycleStart = 1;
    // @(posedge clk);
    // CycleStart = 0;
end
endmodule
