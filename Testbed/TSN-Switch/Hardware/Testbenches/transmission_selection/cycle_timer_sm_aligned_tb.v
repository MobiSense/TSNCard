`timescale 1ns / 1ps

module cycle_timer_sm_aligned_tb();
    
// Local parameters
localparam ONE_NS = 1;
localparam time PER_125M_clk = 8*ONE_NS; // 8 ns clock

// Reg declarations
reg clk = 1;
reg reset = 0;
wire CycleStart;
reg [63:0] sync_time_ptp_ns_mini;

// Clock signals
always begin
    clk = #(PER_125M_clk/2) ~clk;
end

always @(posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
        sync_time_ptp_ns_mini <= 0;
    end
    else begin
        if (sync_time_ptp_ns_mini == 64'h210_0000) begin
            sync_time_ptp_ns_mini <= 64'h390_0000;
        end
        else if (sync_time_ptp_ns_mini == 64'h590_0000) begin
            sync_time_ptp_ns_mini <= 64'h410_0000;
        end
        else begin
            sync_time_ptp_ns_mini <= sync_time_ptp_ns_mini + PER_125M_clk;
        end
    end
end

// DUT
cycle_timer_sm_aligned dut (
    .clk(clk),
    .rst(reset),
    .sync_time_ptp_ns_mini(sync_time_ptp_ns_mini),
    .CycleStart(CycleStart)
);

initial begin
    #(PER_125M_clk*16);
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
