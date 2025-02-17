`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TNS
// Engineer: Yi Zhao
// 
// Create Date: 2020/12/06 11:10:35
// Design Name: 
// Module Name: qav_credit_based_shaper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: IEEE 802.1Qav Credit Based Shaper.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module qav_credit_based_shaper(
        input tx_mac_aclk,
        input tx_reset,

        // TX legacy traffic
        input  [7:0]  tx_axis_mac_legacy_tdata,
        input         tx_axis_mac_legacy_tvalid,
        output        tx_axis_mac_legacy_tready,
        input         tx_axis_mac_legacy_tlast,

        // TX AV traffic
        input  [7:0]  tx_axis_mac_av_tdata,
        input         tx_axis_mac_av_tvalid,
        output        tx_axis_mac_av_tready,
        input         tx_axis_mac_av_tlast,

        // To MAC TX
        output [7:0]  tx_axis_mac_tdata,
        output        tx_axis_mac_tvalid,
        input         tx_axis_mac_tready,
        output        tx_axis_mac_tlast,
        output        tx_axis_mac_tuser
    );

    // Transmit state machine states
    localparam IDLE             = 4'h0;
    // localparam DATA_PRELOAD     = 4'h1;
    // localparam FRAME            = 4'h1;
    localparam FRAME_LEGACY     = 4'h1;
    localparam FRAME_AV         = 4'h2;
    // localparam HANDSHAKE        = 4'h3;
    // localparam FINISH           = 4'h4;

    // External parameters.
    reg signed [15:0] port_transmit_rate = 16'd100; // The link speed is 100M. bit per 1000ns.
    reg signed [15:0] idle_slope = 16'd75; // The token accumulation speed of AV traffic is 75M. bit per 1000ns.
    reg [11:0] token_update_count;

    // Internal parameters.
    reg        transmit_av;
    reg        nxt_transmit_av;
    reg        transmit_legacy;
    reg        nxt_transmit_legacy;
    reg signed [15:0] credit;
    reg signed [15:0] send_slope;
    wire       transmit_allowed_av;

    wire       have_data_waiting_av;

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
    assign transmit_allowed_av = credit >= 0? 1:0;
    assign have_data_waiting_av = tx_axis_mac_av_tvalid;
    assign tx_axis_mac_select_tready = tx_axis_mac_tready;
    assign tx_axis_mac_legacy_tready = transmit_legacy? tx_axis_mac_select_tready:0;
    assign tx_axis_mac_av_tready = transmit_av? tx_axis_mac_select_tready:0;

    assign tx_axis_mac_tvalid = tx_axis_mac_select_tvalid;
    assign tx_axis_mac_tdata = tx_axis_mac_select_tdata;
    assign tx_axis_mac_tlast = tx_axis_mac_select_tlast;

    assign tx_state_debug = tx_state;
    assign tx_nxt_state_debug = tx_nxt_state;

    // Determine send_slope
    always @(port_transmit_rate, idle_slope) begin
        send_slope = idle_slope - port_transmit_rate;
    end

    // Update credit.
    always @(posedge tx_mac_aclk) begin
        if (tx_reset == 1'b1) begin
            credit <= 0;
            token_update_count <= 0;
        end
        else begin
            if (token_update_count == 12'd124) begin
                token_update_count <= 0;
                if (transmit_av) begin
                    credit <= credit + send_slope;
                end
                else if (have_data_waiting_av) begin
                    credit <= credit + idle_slope;
                end
                else if (credit + idle_slope > 0) begin
                    credit <= 0;
                end
                else begin
                    credit <= credit + idle_slope;
                end
            end
            else begin
                token_update_count <= token_update_count + 1;
            end
        end
    end

    // Transmit state machine.
    always @(posedge tx_mac_aclk) begin
        if (tx_reset == 1'b1) begin
            tx_state <= IDLE;
            transmit_legacy <= 1'b0;
            transmit_av <= 1'b0;
        end
        else begin
            tx_state <= tx_nxt_state;
            transmit_legacy <= nxt_transmit_legacy;
            transmit_av <= nxt_transmit_av;
        end
    end

    always @(tx_state, tx_axis_mac_av_tvalid, transmit_allowed_av, tx_axis_mac_legacy_tvalid, tx_axis_mac_select_tlast, tx_axis_mac_select_tready, tx_axis_mac_select_tvalid) begin
        case (tx_state)
            IDLE: begin
                if (tx_axis_mac_av_tvalid == 1'b1 && transmit_allowed_av == 1'b1) begin
                    nxt_transmit_legacy <= 1'b0;
                    nxt_transmit_av <= 1'b1;
                    tx_nxt_state <= FRAME_AV;
                end
                else if (tx_axis_mac_legacy_tvalid == 1'b1) begin
                    nxt_transmit_legacy <= 1'b1;
                    nxt_transmit_av <= 1'b0;
                    tx_nxt_state <= FRAME_LEGACY;
                end
                else begin
                    tx_nxt_state <= IDLE;
                    nxt_transmit_legacy <= 1'b0;
                    nxt_transmit_av <= 1'b0;
                end
            end
            FRAME_LEGACY: begin
                if (tx_axis_mac_select_tlast == 1'b1 && tx_axis_mac_select_tready == 1'b1 && tx_axis_mac_select_tvalid == 1'b1) begin
                    tx_nxt_state <= IDLE; // Finish one packet.
                    nxt_transmit_legacy <= 1'b0;
                    nxt_transmit_av <= 1'b0;
                end
                else begin
                    tx_nxt_state <= FRAME_LEGACY;
                    nxt_transmit_av <= 1'b0;
                    nxt_transmit_legacy <= 1'b1;
                end
            end
            FRAME_AV: begin
                if (tx_axis_mac_select_tlast == 1'b1 && tx_axis_mac_select_tready == 1'b1 && tx_axis_mac_select_tvalid == 1'b1) begin
                    tx_nxt_state <= IDLE; // Finish one packet.
                    nxt_transmit_legacy <= 1'b0;
                    nxt_transmit_av <= 1'b0;
                end
                else begin
                    tx_nxt_state <= FRAME_AV;
                    nxt_transmit_av <= 1'b1;
                    nxt_transmit_legacy <= 1'b0;
                end
            end
        endcase
    end

    // Determine tx_axis_mac_select signal.
    assign tx_axis_mac_select_tvalid = transmit_legacy? tx_axis_mac_legacy_tvalid:
                                       (transmit_av? tx_axis_mac_av_tvalid:0);
    assign tx_axis_mac_select_tdata = transmit_legacy? tx_axis_mac_legacy_tdata:
                                       (transmit_av? tx_axis_mac_av_tdata:0);
    assign tx_axis_mac_select_tlast = transmit_legacy? tx_axis_mac_legacy_tlast:
                                       (transmit_av? tx_axis_mac_av_tlast:0);

endmodule
