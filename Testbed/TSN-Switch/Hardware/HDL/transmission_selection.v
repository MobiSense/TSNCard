`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TNS
// Engineer: Yi Zhao
// 
// Create Date: 2021/04/05 19:09:00
// Design Name: 
// Module Name: transmission_selection
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 802.1Q  8.6.8 and 8.6.9 transmission selection and scheduled traffic state machines.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module transmission_selection 
#(
    parameter AXIS_DATA_WIDTH = 256,
    parameter AXIS_TUSER_WIDTH = 128,
    parameter NUM_QUEUES_PORT = 8
)
(
    input                                      axis_aclk,
    input                                      axis_reset_in,

    input [AXIS_DATA_WIDTH - 1:0]          m_axis_0_tdata,
    input [((AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_0_tkeep,
    input [AXIS_TUSER_WIDTH-1:0]           m_axis_0_tuser,
    input                                      m_axis_0_tvalid,
    output                                     m_axis_0_tready,
    input                                      m_axis_0_tlast,

    input [AXIS_DATA_WIDTH - 1:0]          m_axis_1_tdata,
    input [((AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_1_tkeep,
    input [AXIS_TUSER_WIDTH-1:0]           m_axis_1_tuser,
    input                                      m_axis_1_tvalid,
    output                                     m_axis_1_tready,
    input                                      m_axis_1_tlast,
    
    input [AXIS_DATA_WIDTH - 1:0]          m_axis_2_tdata,
    input [((AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_2_tkeep,
    input [AXIS_TUSER_WIDTH-1:0]           m_axis_2_tuser,
    input                                      m_axis_2_tvalid,
    output                                     m_axis_2_tready,
    input                                      m_axis_2_tlast,

    input [AXIS_DATA_WIDTH - 1:0]          m_axis_3_tdata,
    input [((AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_3_tkeep,
    input [AXIS_TUSER_WIDTH-1:0]           m_axis_3_tuser,
    input                                      m_axis_3_tvalid,
    output                                     m_axis_3_tready,
    input                                      m_axis_3_tlast,

    input [AXIS_DATA_WIDTH - 1:0]          m_axis_4_tdata,
    input [((AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_4_tkeep,
    input [AXIS_TUSER_WIDTH-1:0]           m_axis_4_tuser,
    input                                      m_axis_4_tvalid,
    output                                     m_axis_4_tready,
    input                                      m_axis_4_tlast,

    input [AXIS_DATA_WIDTH - 1:0]          m_axis_5_tdata,
    input [((AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_5_tkeep,
    input [AXIS_TUSER_WIDTH-1:0]           m_axis_5_tuser,
    input                                      m_axis_5_tvalid,
    output                                     m_axis_5_tready,
    input                                      m_axis_5_tlast,
    
    input [AXIS_DATA_WIDTH - 1:0]          m_axis_6_tdata,
    input [((AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_6_tkeep,
    input [AXIS_TUSER_WIDTH-1:0]           m_axis_6_tuser,
    input                                      m_axis_6_tvalid,
    output                                     m_axis_6_tready,
    input                                      m_axis_6_tlast,

    input [AXIS_DATA_WIDTH - 1:0]          m_axis_7_tdata,
    input [((AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_7_tkeep,
    input [AXIS_TUSER_WIDTH-1:0]           m_axis_7_tuser,
    input                                      m_axis_7_tvalid,
    output                                     m_axis_7_tready,
    input                                      m_axis_7_tlast,

    output [AXIS_DATA_WIDTH - 1:0]         s_axis_tdata,
    output [((AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_tkeep,
    output [AXIS_TUSER_WIDTH-1:0]          s_axis_tuser,
    output                                     s_axis_tvalid,
    input                                      s_axis_tready,
    output                                     s_axis_tlast,

    input [47:0]                           sync_time_ptp_sec,
    input [31:0]                           sync_time_ptp_ns,
    input [63:0]                           sync_time_ptp_ns_mini,

    input          gcl_clk_in,
    output [143:0] gcl_rd_data,
    input  wire gcl_ld,
    input [3:0] gcl_id,
    input [8:0] gcl_ld_data,
    input  wire gcl_time_ld,
    input [3:0] gcl_time_id,
    input [19:0] gcl_ld_time            
);

reg axis_reset;

always @(posedge axis_aclk) begin
    axis_reset <= axis_reset_in;
end

wire [AXIS_DATA_WIDTH - 1:0] m_axis_tdata [0:7];
wire [((AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tkeep [0:7];
wire [AXIS_TUSER_WIDTH-1:0] m_axis_tuser [0:7];
wire m_axis_tvalid [0:7];
wire m_axis_tready [0:7];
wire m_axis_tlast [0:7];

assign m_axis_tdata[0] = m_axis_0_tdata;
assign m_axis_tdata[1] = m_axis_1_tdata;
assign m_axis_tdata[2] = m_axis_2_tdata;
assign m_axis_tdata[3] = m_axis_3_tdata;
assign m_axis_tdata[4] = m_axis_4_tdata;
assign m_axis_tdata[5] = m_axis_5_tdata;
assign m_axis_tdata[6] = m_axis_6_tdata;
assign m_axis_tdata[7] = m_axis_7_tdata;

assign m_axis_tkeep[0] = m_axis_0_tkeep;
assign m_axis_tkeep[1] = m_axis_1_tkeep;
assign m_axis_tkeep[2] = m_axis_2_tkeep;
assign m_axis_tkeep[3] = m_axis_3_tkeep;
assign m_axis_tkeep[4] = m_axis_4_tkeep;
assign m_axis_tkeep[5] = m_axis_5_tkeep;
assign m_axis_tkeep[6] = m_axis_6_tkeep;
assign m_axis_tkeep[7] = m_axis_7_tkeep;

assign m_axis_tuser[0] = m_axis_0_tuser;
assign m_axis_tuser[1] = m_axis_1_tuser;
assign m_axis_tuser[2] = m_axis_2_tuser;
assign m_axis_tuser[3] = m_axis_3_tuser;
assign m_axis_tuser[4] = m_axis_4_tuser;
assign m_axis_tuser[5] = m_axis_5_tuser;
assign m_axis_tuser[6] = m_axis_6_tuser;
assign m_axis_tuser[7] = m_axis_7_tuser;

assign m_axis_tvalid[0] = m_axis_0_tvalid;
assign m_axis_tvalid[1] = m_axis_1_tvalid;
assign m_axis_tvalid[2] = m_axis_2_tvalid;
assign m_axis_tvalid[3] = m_axis_3_tvalid;
assign m_axis_tvalid[4] = m_axis_4_tvalid;
assign m_axis_tvalid[5] = m_axis_5_tvalid;
assign m_axis_tvalid[6] = m_axis_6_tvalid;
assign m_axis_tvalid[7] = m_axis_7_tvalid;

assign m_axis_0_tready = m_axis_tready[0];
assign m_axis_1_tready = m_axis_tready[1];
assign m_axis_2_tready = m_axis_tready[2];
assign m_axis_3_tready = m_axis_tready[3];
assign m_axis_4_tready = m_axis_tready[4];
assign m_axis_5_tready = m_axis_tready[5];
assign m_axis_6_tready = m_axis_tready[6];
assign m_axis_7_tready = m_axis_tready[7];

assign m_axis_tlast[0] = m_axis_0_tlast;
assign m_axis_tlast[1] = m_axis_1_tlast;
assign m_axis_tlast[2] = m_axis_2_tlast;
assign m_axis_tlast[3] = m_axis_3_tlast;
assign m_axis_tlast[4] = m_axis_4_tlast;
assign m_axis_tlast[5] = m_axis_5_tlast;
assign m_axis_tlast[6] = m_axis_6_tlast;
assign m_axis_tlast[7] = m_axis_7_tlast;

wire [7:0] strict_queue_valid;
wire [7:0] cbs_queue_valid;
wire [7:0] selection_algorithm;
assign selection_algorithm = 8'b0000_0000;
wire [7:0] queue_valid;

generate
    genvar i;
    for (i = 0; i < 8; i = i + 1) begin
        ts_strict ts_strict_i (
            .axis_aclk(axis_aclk),
            .axis_reset(axis_reset),
            .axis_tvalid(m_axis_tvalid[i]),
            .axis_tready(m_axis_tready[i]),
            .queue_valid(strict_queue_valid[i])
        );

        ts_cbs ts_cbs_i (
            .axis_aclk(axis_aclk),
            .axis_reset(axis_reset),
            .axis_tvalid(m_axis_tvalid[i]),
            .axis_tready(m_axis_tready[i]),
            .queue_valid(cbs_queue_valid[i])
        );

        assign queue_valid[i] = (i >= NUM_QUEUES_PORT)? 0: (selection_algorithm[i]? cbs_queue_valid[i]: strict_queue_valid[i]);
    end
endgenerate

wire CycleStart;
wire [7:0] GateStates;

cycle_timer_sm_aligned cycle_timer_sm_i (
    .clk(axis_aclk),
    .rst(axis_reset),
    .sync_time_ptp_ns_mini(sync_time_ptp_ns_mini),
    .CycleStart(CycleStart)
);

list_execute_sm list_execute_sm_i (
    .clk(axis_aclk),
    .rst(axis_reset),
    .CycleStart(CycleStart),
    .OutGateStates(GateStates),

    .gcl_clk_in(gcl_clk_in),
    .gcl_rd_data(gcl_rd_data),
    .gcl_ld(gcl_ld),
    .gcl_id(gcl_id),
    .gcl_ld_data(gcl_ld_data),
    .gcl_time_ld(gcl_time_ld),
    .gcl_time_id(gcl_time_id),
    .gcl_ld_time(gcl_ld_time)
);

// We have GateStates, queue_valid

// States
localparam IDLE = 1'd0;
localparam TRANSMISSION = 1'd1;

reg trans_state;
reg trans_state_next;
reg [2:0] transmit_queue;
reg [2:0] transmit_queue_next;

wire [7:0] queue_ready = queue_valid & GateStates;

// strict priority here
always @(*) begin
    trans_state_next = trans_state;
    transmit_queue_next = transmit_queue;
    case (trans_state)
        IDLE: begin
            if ((|queue_ready) && s_axis_tready) begin
                trans_state_next = TRANSMISSION;
                casez (queue_ready)
                    8'b1???_????: begin
                        transmit_queue_next = 3'd7;
                    end
                    8'b01??_????: begin
                        transmit_queue_next = 3'd6;
                    end
                    8'b001?_????: begin
                        transmit_queue_next = 3'd5;
                    end
                    8'b0001_????: begin
                        transmit_queue_next = 3'd4;
                    end
                    8'b0000_1???: begin
                        transmit_queue_next = 3'd3;
                    end
                    8'b0000_01??: begin
                        transmit_queue_next = 3'd2;    
                    end
                    8'b0000_001?: begin
                        transmit_queue_next = 3'd1;
                    end
                    8'b0000_0001: begin
                        transmit_queue_next = 3'd0;
                    end
                    default: begin
                        transmit_queue_next = 3'bxxx;
                    end
                endcase 
            end
        end
        TRANSMISSION: begin
            if (s_axis_tvalid && s_axis_tready && s_axis_tlast) begin
                trans_state_next = IDLE;
            end
        end
    endcase
end

always @(posedge axis_aclk or posedge axis_reset) begin
    if (axis_reset == 1'b1) begin
        transmit_queue <= 3'd0;
        trans_state <= IDLE;
    end
    else begin
        transmit_queue <= transmit_queue_next;
        trans_state <= trans_state_next;
    end
end

assign s_axis_tdata = (trans_state == IDLE) ? {AXIS_DATA_WIDTH{1'b0}} : m_axis_tdata[transmit_queue];
assign s_axis_tkeep = (trans_state == IDLE) ? {(AXIS_DATA_WIDTH/8){1'b0}} : m_axis_tkeep[transmit_queue];
assign s_axis_tuser = (trans_state == IDLE) ? {AXIS_TUSER_WIDTH{1'b0}} : m_axis_tuser[transmit_queue];
assign s_axis_tvalid = (trans_state == IDLE) ? 1'b0 : m_axis_tvalid[transmit_queue];

generate
    genvar j;
    for (j = 0; j < 8; j = j + 1) begin
        assign m_axis_tready[j] = (trans_state == IDLE) ? 1'b0 : ((transmit_queue == j) ? s_axis_tready : 0);
    end
endgenerate

assign s_axis_tlast = (trans_state == IDLE) ? 1'b0 : m_axis_tlast[transmit_queue];

endmodule