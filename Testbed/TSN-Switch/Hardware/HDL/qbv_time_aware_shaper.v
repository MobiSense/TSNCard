`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TNS
// Engineer: Hao Cao
// 
// Create Date: 2021/02/23 15:48:08
// Design Name: 
// Module Name: qbv_time_aware_shaper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: IEEE 802.1Qbv Time-Aware Shaper.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module qbv_time_aware_shaper(
        input tx_mac_aclk,
        input tx_reset,
        
        // TX legacy traffic
        input [7:0]  tx_axis_mac_legacy_tdata,
        input        tx_axis_mac_legacy_tvalid,
        output       tx_axis_mac_legacy_tready,
        input        tx_axis_mac_legacy_tlast,
 
        // TX BV traffic
        input [7:0]  tx_axis_mac_bv_tdata,
        input        tx_axis_mac_bv_tvalid,
        output       tx_axis_mac_bv_tready,
        input        tx_axis_mac_bv_tlast,

        // time ns
        input [31:0] time_ptp_ns,

        // To MAC TX
        output [7:0] tx_axis_mac_tdata,
        output       tx_axis_mac_tvalid,
        input        tx_axis_mac_tready,
        output       tx_axis_mac_tlast,
        output       tx_axis_mac_tuser
    );

    // Transmit state machine states
    localparam IDLE             = 4'h0;
    // localparam DATA_PRELOAD     = 4'h1;
    // localparam FRAME            = 4'h1;
    localparam FRAME_LEGACY     = 4'h1;
    localparam FRAME_BV         = 4'h2;
    // localparam HANDSHAKE        = 4'h3;
    // localparam FINISH           = 4'h4;

    // localparam BV_WIDTH         = 23;
    localparam BV_WIDTH         = 21; // 32KB buffer friendly.
    // localparam PERIOD_WIDTH     = 26;
    localparam PERIOD_WIDTH     = 24; // 32KB buffer friendly.

    // External parameters.
    // reg signed [15:0] port_transmit_rate = 16'd100; // The link speed is 100M. bit per 1000ns.
    
    // bv length (ns)
    reg [31:0] bv_length        = 32'b1 << BV_WIDTH;
    // guard band length (ns)
    reg [31:0] gb_length        = 32'd123_360;
    reg [31:0] period_length    = 32'b1 << PERIOD_WIDTH;

    // timestamp in a period
    reg [31:0] time_period_ns   = 32'd0;

    // Internal parameters.
    reg        transmit_bv;
    reg        nxt_transmit_bv;
    reg        transmit_legacy;
    reg        nxt_transmit_legacy;

    wire transmit_allowed_bv;
    wire transmit_allowed_legacy;

    reg [3:0] tx_state;
    reg [3:0] tx_nxt_state;

    wire [3:0] tx_state_debug;
    wire [3:0] tx_nxt_state_debug;

    // Select axis signal
    wire [7:0] tx_axis_mac_select_tdata;
    wire       tx_axis_mac_select_tvalid;
    wire       tx_axis_mac_select_tready;
    wire       tx_axis_mac_select_tlast;

    assign tx_axis_mac_tuser = 1'b0; // Never drop packets.

    assign transmit_allowed_bv = (time_period_ns < bv_length) ? 1 : 0;
    assign transmit_allowed_legacy = (time_period_ns >= bv_length && (time_period_ns + gb_length) < period_length) ? 1 : 0;

    assign tx_axis_mac_select_tready = tx_axis_mac_tready;
    assign tx_axis_mac_legacy_tready = transmit_legacy? tx_axis_mac_select_tready:0;
    assign tx_axis_mac_bv_tready = transmit_bv? tx_axis_mac_select_tready:0;

    assign tx_axis_mac_tvalid = tx_axis_mac_select_tvalid;
    assign tx_axis_mac_tdata = tx_axis_mac_select_tdata;
    assign tx_axis_mac_tlast = tx_axis_mac_select_tlast;

    assign tx_state_debug = tx_state;
    assign tx_nxt_state_debug = tx_nxt_state;

    always @(time_ptp_ns) begin
        // keep the least PERIOD_WIDTH bits
        time_period_ns[PERIOD_WIDTH-1:0] = time_ptp_ns[PERIOD_WIDTH-1:0];
    end

    // Transmit state machine.
    always @(posedge tx_mac_aclk) begin
        if (tx_reset == 1'b1) begin
            tx_state <= IDLE;
            transmit_legacy <= 1'b0;
            transmit_bv <= 1'b0;
        end
        else begin
            tx_state <= tx_nxt_state;
            transmit_legacy <= nxt_transmit_legacy;
            transmit_bv <= nxt_transmit_bv;
        end
    end

    always @(tx_state, tx_axis_mac_bv_tvalid, transmit_allowed_bv, transmit_allowed_legacy, tx_axis_mac_legacy_tvalid, tx_axis_mac_select_tlast, tx_axis_mac_select_tready, tx_axis_mac_select_tvalid) begin
        case (tx_state)
            IDLE: begin
                if (tx_axis_mac_bv_tvalid == 1'b1 && transmit_allowed_bv == 1'b1) begin
                    nxt_transmit_legacy <= 1'b0;
                    nxt_transmit_bv <= 1'b1;
                    tx_nxt_state <= FRAME_BV;
                end
                else if (tx_axis_mac_legacy_tvalid == 1'b1 && transmit_allowed_legacy == 1'b1) begin
                    nxt_transmit_legacy <= 1'b1;
                    nxt_transmit_bv <= 1'b0;
                    tx_nxt_state <= FRAME_LEGACY;
                end
                else begin
                    tx_nxt_state <= IDLE;
                    nxt_transmit_legacy <= 1'b0;
                    nxt_transmit_bv <= 1'b0;
                end
            end
            FRAME_LEGACY: begin
                if (tx_axis_mac_select_tlast == 1'b1 && tx_axis_mac_select_tready == 1'b1 && tx_axis_mac_select_tvalid == 1'b1) begin
                    tx_nxt_state <= IDLE; // Finish one packet.
                    nxt_transmit_legacy <= 1'b0;
                    nxt_transmit_bv <= 1'b0;
                end
                else begin
                    // whether to stop?
                    tx_nxt_state <= FRAME_LEGACY;
                    nxt_transmit_bv <= 1'b0;
                    nxt_transmit_legacy <= 1'b1;
                end
            end
            FRAME_BV: begin
                if (tx_axis_mac_select_tlast == 1'b1 && tx_axis_mac_select_tready == 1'b1 && tx_axis_mac_select_tvalid == 1'b1) begin
                    tx_nxt_state <= IDLE; // Finish one packet.
                    nxt_transmit_legacy <= 1'b0;
                    nxt_transmit_bv <= 1'b0;
                end
                else begin
                    tx_nxt_state <= FRAME_BV;
                    nxt_transmit_bv <= 1'b1;
                    nxt_transmit_legacy <= 1'b0;
                end
            end
        endcase
    end

    // Determine tx_axis_mac_select signal.
    assign tx_axis_mac_select_tvalid = transmit_legacy? tx_axis_mac_legacy_tvalid:
                                       (transmit_bv? tx_axis_mac_bv_tvalid:0);
    assign tx_axis_mac_select_tdata = transmit_legacy? tx_axis_mac_legacy_tdata:
                                       (transmit_bv? tx_axis_mac_bv_tdata:0);
    assign tx_axis_mac_select_tlast = transmit_legacy? tx_axis_mac_legacy_tlast:
                                       (transmit_bv? tx_axis_mac_bv_tlast:0);

endmodule
