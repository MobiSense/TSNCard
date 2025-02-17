`timescale 1ns / 1ps

module list_execute_sm_tb();
    
// Local parameters
localparam ONE_NS = 1;
localparam time PER_125M_clk = 8*ONE_NS; // 8 ns clock
localparam time PER_50M_clk = 20*ONE_NS;

// Reg declarations
reg clk = 1;
reg gcl_clk = 0;
reg reset = 0;
wire CycleStart;
reg [63:0] sync_time_ptp_ns_mini = 0;
wire [7:0] GateStates;
reg gcl_ld;
reg [3:0] gcl_id;
reg [8:0] gcl_ld_data;
reg gcl_time_ld;
reg [3:0] gcl_time_id;
reg [19:0] gcl_ld_time;

// Clock signals
always begin
    clk = #(PER_125M_clk / 2) ~clk;
end

always begin
    gcl_clk = #(PER_50M_clk / 2) ~gcl_clk;
end

always @(posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
        sync_time_ptp_ns_mini <= 0;
    end
    else begin
        sync_time_ptp_ns_mini <= sync_time_ptp_ns_mini + PER_125M_clk;
    end
end

cycle_timer_sm_aligned cycle_timer_sm_aligned_i (
    .clk(clk),
    .rst(reset),
    .sync_time_ptp_ns_mini(sync_time_ptp_ns_mini),
    .CycleStart(CycleStart)
);

list_execute_sm list_execute_sm_i (
    .clk(clk),
    .rst(reset),
    .CycleStart(CycleStart),
    .OutGateStates(GateStates),
    .gcl_clk_in(gcl_clk),
    .gcl_rd_data(),
    .gcl_ld(gcl_ld),
    .gcl_id(gcl_id),
    .gcl_ld_data(gcl_ld_data),
    .gcl_time_ld(gcl_time_ld),
    .gcl_time_id(gcl_time_id),
    .gcl_ld_time(gcl_ld_time)
);

initial begin
    gcl_ld = 0;
    gcl_id = 0;
    gcl_ld_data = 0;
    gcl_time_ld = 0;
    gcl_time_id = 0;
    gcl_ld_time = 0;

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

integer I;

initial begin
    while (sync_time_ptp_ns_mini <= 64'h300_0000) #800;
    // Setup GCL
    for (I = 0; I < 16; I = I + 1)begin
        @(posedge gcl_clk);
        gcl_ld <= 1;
        gcl_id <= I;
        gcl_ld_data <= I;
        @(posedge gcl_clk);
        gcl_ld <= 0;
        gcl_id <= 0;
        gcl_ld_data <= 0;
    end
    // Setup GCL Time interval
    // one slot is one cycle
    for (I = 0; I < 16; I = I + 1)begin
        @(posedge gcl_clk);
        gcl_time_ld <= 1;
        gcl_time_id <= I;
        if (I == 0) begin
            gcl_ld_time <= 20'h35_B0;
        end
        else if (I == 1) begin
            gcl_ld_time <= 20'hD0;
        end
        else if (I == 2) begin
            gcl_ld_time <= 20'h980;
        end
        else begin
            gcl_ld_time <= 20'h0;
        end
        @(posedge gcl_clk);
        gcl_time_ld <= 0;
        gcl_time_id <= 0;
        gcl_ld_time <= 0;
    end


    // Setup GCL Time interval
    // 8 slots is one cycle
    // for (I = 0; I < 16; I = I + 1)begin
    //     @(posedge gcl_clk);
    //     gcl_time_ld <= 1;
    //     gcl_time_id <= I;
    //     gcl_ld_time <= 20'h8_00;
    //     @(posedge gcl_clk);
    //     gcl_ld <= 0;
    //     gcl_id <= 0;
    //     gcl_ld_data <= 0;
    // end
    // while (sync_time_ptp_ns_mini <= 64'h700_0000) #800;
    // for (I = 0; I < 16; I = I + 1)begin
    //     @(posedge gcl_clk);
    //     gcl_ld <= 1;
    //     gcl_id <= I;
    //     gcl_ld_data <= 15 - I;
    //     @(posedge gcl_clk);
    //     gcl_ld <= 0;
    //     gcl_id <= 0;
    //     gcl_ld_data <= 0;
    // end
    // Setup GCL Time interval
    // for (I = 0; I < 16; I = I + 1)begin
    //     @(posedge gcl_clk);
    //     gcl_time_ld <= 1;
    //     gcl_time_id <= I;
    //     if (I % 2 == 0) begin
    //         gcl_ld_time <= 20'h2_00;
    //     end
    //     else begin
    //         gcl_ld_time <= 20'h6_00;
    //     end
    //     @(posedge gcl_clk);
    //     gcl_ld <= 0;
    //     gcl_id <= 0;
    //     gcl_ld_data <= 0;
    // end
end

endmodule
