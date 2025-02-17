`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Xiaowu He, Yi Zhao, GPT-4.
// 
// Create Date: 2022/03/13 19:39:58
// Design Name: 
// Module Name: input_arbiter_seven_ports
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//     This is based on the input_arbiter module of NetFPGA, we expand it to seven ports.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// Revision 0.02 - Use Xilinx AXI-S DATA FIFO in packet mode.
// 
// Description from ChatGPT:
// In this updated design, we have a two-stage state machine to implement the round-robin logic. In the "IDLE" state, the arbiter checks if the current queue (`cur_queue`) has valid data. If it does, the arbiter transitions to the "WR_PKT" state to transmit the packet. If not, the arbiter updates `cur_queue` to the next queue index in the round-robin order.
//
// In the "WR_PKT" state, the arbiter transmits the packet. If the `tlast_out` signal is high, indicating the end of the packet, and the `tready_out` signal is high, the arbiter transitions back to the "IDLE" state and updates `cur_queue` to the next queue index.
//
// This design implements the round-robin logic using a two-stage state machine, which simplifies the design and allows each queue to be checked in a sequential manner.
//
// 
//////////////////////////////////////////////////////////////////////////////////


module input_arbiter_seven_ports_packet_mode
#(
    // Master AXI Stream Data Width
    parameter C_M_AXIS_DATA_WIDTH=256,
    parameter C_S_AXIS_DATA_WIDTH=256,
    parameter C_M_AXIS_TUSER_WIDTH=128,
    parameter C_S_AXIS_TUSER_WIDTH=128,
    parameter NUM_QUEUES=7
)
(
    // Part 1: System side signals
    // Global Ports
    input axis_aclk,
    input axis_resetn_in,

    // Master Stream Ports (interface to data path)
    output [C_M_AXIS_DATA_WIDTH - 1:0] m_axis_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0] m_axis_tuser,
    output m_axis_tvalid,
    input  m_axis_tready,
    output m_axis_tlast,

    // Slave Stream Ports (interface to RX queues)
    input [C_S_AXIS_DATA_WIDTH - 1:0] s_axis_0_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_0_tkeep,
    input [C_S_AXIS_TUSER_WIDTH-1:0] s_axis_0_tuser,
    input  s_axis_0_tvalid,
    output s_axis_0_tready,
    input  s_axis_0_tlast,

    input [C_S_AXIS_DATA_WIDTH - 1:0] s_axis_1_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_1_tkeep,
    input [C_S_AXIS_TUSER_WIDTH-1:0] s_axis_1_tuser,
    input  s_axis_1_tvalid,
    output s_axis_1_tready,
    input  s_axis_1_tlast,

    input [C_S_AXIS_DATA_WIDTH - 1:0] s_axis_2_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_2_tkeep,
    input [C_S_AXIS_TUSER_WIDTH-1:0] s_axis_2_tuser,
    input  s_axis_2_tvalid,
    output s_axis_2_tready,
    input  s_axis_2_tlast,

    input [C_S_AXIS_DATA_WIDTH - 1:0] s_axis_3_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_3_tkeep,
    input [C_S_AXIS_TUSER_WIDTH-1:0] s_axis_3_tuser,
    input  s_axis_3_tvalid,
    output s_axis_3_tready,
    input  s_axis_3_tlast,

    input [C_S_AXIS_DATA_WIDTH - 1:0] s_axis_4_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_4_tkeep,
    input [C_S_AXIS_TUSER_WIDTH-1:0] s_axis_4_tuser,
    input  s_axis_4_tvalid,
    output s_axis_4_tready,
    input  s_axis_4_tlast,
    
    input [C_S_AXIS_DATA_WIDTH - 1:0] s_axis_5_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_5_tkeep,
    input [C_S_AXIS_TUSER_WIDTH-1:0] s_axis_5_tuser,
    input  s_axis_5_tvalid,
    output s_axis_5_tready,
    input  s_axis_5_tlast,

    input [C_S_AXIS_DATA_WIDTH - 1:0] s_axis_6_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_6_tkeep,
    input [C_S_AXIS_TUSER_WIDTH-1:0] s_axis_6_tuser,
    input  s_axis_6_tvalid,
    output s_axis_6_tready,
    input  s_axis_6_tlast,

    // stats
    output reg pkt_fwd

);

    // Local reset signal
    reg axis_resetn;
    always @(posedge axis_aclk) begin
        axis_resetn <= axis_resetn_in;
    end

    function integer log2;
        input integer number;
        begin
            log2=0;
            while(2**log2<number) begin
                log2=log2+1;
            end
        end
    endfunction // log2

    // ------------ Internal Params --------

    localparam  NUM_QUEUES_WIDTH = log2(NUM_QUEUES);
    

    localparam NUM_STATES = 1;
    localparam IDLE = 0;
    localparam WR_PKT = 1;

    localparam MAX_PKT_SIZE = 2000; // In bytes
    localparam IN_FIFO_DEPTH_BIT = log2(MAX_PKT_SIZE/(C_M_AXIS_DATA_WIDTH / 8));

    // ------------- Regs/ wires -----------

    wire [NUM_QUEUES-1:0]                   nearly_full;
    wire [NUM_QUEUES-1:0]                   empty;
    wire [C_M_AXIS_DATA_WIDTH-1:0]          in_tdata      [NUM_QUEUES-1:0];
    wire [((C_M_AXIS_DATA_WIDTH/8))-1:0]    in_tkeep      [NUM_QUEUES-1:0];
    wire [C_M_AXIS_TUSER_WIDTH-1:0]         in_tuser      [NUM_QUEUES-1:0];
    wire [NUM_QUEUES-1:0] 	                in_tvalid;
    wire [NUM_QUEUES-1:0]                   in_tlast;
    wire [NUM_QUEUES-1:0]                   in_tready;
    wire [C_M_AXIS_TUSER_WIDTH-1:0]         fifo_out_tuser[NUM_QUEUES-1:0];
    wire [C_M_AXIS_DATA_WIDTH-1:0]          fifo_out_tdata[NUM_QUEUES-1:0];
    wire [((C_M_AXIS_DATA_WIDTH/8))-1:0]    fifo_out_tkeep[NUM_QUEUES-1:0];
    wire [NUM_QUEUES-1:0] 	                fifo_out_tlast;
    wire [NUM_QUEUES-1:0]                   fifo_out_tvalid;
    wire [NUM_QUEUES-1:0]                   fifo_out_tready;
    wire                                    fifo_tlast;
    reg [NUM_QUEUES-1:0]                    rd_en;

    wire [NUM_QUEUES_WIDTH-1:0]             cur_queue_plus1;
    reg [NUM_QUEUES_WIDTH-1:0]              cur_queue;
    reg [NUM_QUEUES_WIDTH-1:0]              cur_queue_next;

    reg [NUM_STATES-1:0]                    state;
    reg [NUM_STATES-1:0]                    state_next;

    reg				       pkt_fwd_next;
    
    wire clear_counters;
    wire reset_registers;

    // ------------ Packet mode input FIFO Modules -------------

    generate
    genvar i;
    for(i=0; i<NUM_QUEUES; i=i+1) begin: in_arb_queues
        input_arbiter_fifo input_arbiter_fifo_i (
            .s_axis_aclk    (axis_aclk),
            .s_axis_aresetn (axis_resetn),

            // input
            .s_axis_tdata   (in_tdata[i]),
            .s_axis_tkeep   (in_tkeep[i]),
            .s_axis_tlast   (in_tlast[i]),
            .s_axis_tready  (in_tready[i]),
            .s_axis_tuser   (in_tuser[i]),
            .s_axis_tvalid  (in_tvalid[i]),

            // output
            .m_axis_tdata   (fifo_out_tdata[i]),
            .m_axis_tkeep   (fifo_out_tkeep[i]),
            .m_axis_tlast   (fifo_out_tlast[i]),
            .m_axis_tready  (fifo_out_tready[i]),
            .m_axis_tuser   (fifo_out_tuser[i]),
            .m_axis_tvalid  (fifo_out_tvalid[i])
        );
    end
    endgenerate

    // ------------- Logic ------------

    assign in_tdata[0]        = s_axis_0_tdata;
    assign in_tkeep[0]        = s_axis_0_tkeep;
    assign in_tuser[0]        = s_axis_0_tuser;
    assign in_tvalid[0]       = s_axis_0_tvalid;
    assign in_tlast[0]        = s_axis_0_tlast;
    // assign s_axis_0_tready    = !nearly_full[0];
    assign s_axis_0_tready    = in_tready[0];

    assign in_tdata[1]        = s_axis_1_tdata;
    assign in_tkeep[1]        = s_axis_1_tkeep;
    assign in_tuser[1]        = s_axis_1_tuser;
    assign in_tvalid[1]       = s_axis_1_tvalid;
    assign in_tlast[1]        = s_axis_1_tlast;
    // assign s_axis_1_tready    = !nearly_full[1];
    assign s_axis_1_tready    = in_tready[1];

    assign in_tdata[2]        = s_axis_2_tdata;
    assign in_tkeep[2]        = s_axis_2_tkeep;
    assign in_tuser[2]        = s_axis_2_tuser;
    assign in_tvalid[2]       = s_axis_2_tvalid;
    assign in_tlast[2]        = s_axis_2_tlast;
    // assign s_axis_2_tready    = !nearly_full[2];
    assign s_axis_2_tready    = in_tready[2];

    assign in_tdata[3]        = s_axis_3_tdata;
    assign in_tkeep[3]        = s_axis_3_tkeep;
    assign in_tuser[3]        = s_axis_3_tuser;
    assign in_tvalid[3]       = s_axis_3_tvalid;
    assign in_tlast[3]        = s_axis_3_tlast;
    // assign s_axis_3_tready    = !nearly_full[3];
    assign s_axis_3_tready    = in_tready[3];

    assign in_tdata[4]        = s_axis_4_tdata;
    assign in_tkeep[4]        = s_axis_4_tkeep;
    assign in_tuser[4]        = s_axis_4_tuser;
    assign in_tvalid[4]       = s_axis_4_tvalid;
    assign in_tlast[4]        = s_axis_4_tlast;
    // assign s_axis_4_tready    = !nearly_full[4];
    assign s_axis_4_tready    = in_tready[4];

    assign in_tdata[5]        = s_axis_5_tdata;
    assign in_tkeep[5]        = s_axis_5_tkeep;
    assign in_tuser[5]        = s_axis_5_tuser;
    assign in_tvalid[5]       = s_axis_5_tvalid;
    assign in_tlast[5]        = s_axis_5_tlast;
    // assign s_axis_5_tready    = !nearly_full[5];
    assign s_axis_5_tready    = in_tready[5];

    // Expand with NUM_QUEUES
    assign in_tdata[6]        = s_axis_6_tdata;
    assign in_tkeep[6]        = s_axis_6_tkeep;
    assign in_tuser[6]        = s_axis_6_tuser;
    assign in_tvalid[6]       = s_axis_6_tvalid;
    assign in_tlast[6]        = s_axis_6_tlast;
    // assign s_axis_6_tready    = !nearly_full[6];
    assign s_axis_6_tready    = in_tready[6];

    assign cur_queue_plus1    = (cur_queue == NUM_QUEUES-1) ? 0 : cur_queue + 1;


    // Assign output to cur_queue
    assign m_axis_tuser = fifo_out_tuser[cur_queue];
    assign m_axis_tdata = fifo_out_tdata[cur_queue];
    assign m_axis_tlast = fifo_out_tlast[cur_queue];
    assign m_axis_tkeep = fifo_out_tkeep[cur_queue];
    // assign m_axis_tvalid = ~empty[cur_queue];
    assign m_axis_tvalid = fifo_out_tvalid[cur_queue];

    generate
        // genvar i;
        for (i = 0; i < NUM_QUEUES; i = i + 1) 
        begin
            assign fifo_out_tready[i] = (i==cur_queue) ? m_axis_tready : 1'b0;
        end
    endgenerate

    // Round-robin control state machine
    always @(*) begin
        state_next = state;
        cur_queue_next = cur_queue;
        case (state)
            IDLE: begin
                if (fifo_out_tvalid[cur_queue]) begin
                    state_next = WR_PKT;
                end else begin
                    cur_queue_next = cur_queue_plus1;
                end
            end

            WR_PKT: begin
                if (fifo_out_tlast[cur_queue] && m_axis_tready) begin // tvalid is expected to be high when tlast=1
                    state_next = IDLE;
                    cur_queue_next = cur_queue_plus1;
                end
            end
        endcase
    end

    // State machine register update
    always @(posedge axis_aclk or negedge axis_resetn) begin
        if (!axis_resetn) begin
            state <= IDLE;
            cur_queue <= 3'b0;
        end else begin
            state <= state_next;
            cur_queue <= cur_queue_next;
        end
    end
endmodule
