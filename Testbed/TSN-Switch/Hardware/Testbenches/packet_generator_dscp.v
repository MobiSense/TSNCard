`timescale 1ns / 1ps

module packet_generator_dscp 
#(
    parameter integer AXIS_DATA_WIDTH = 256,
    parameter integer AXIS_TUSER_WIDTH = 128,
    parameter [47:0] DST_MAC_ADDR = 48'h1111_1111_1111,
    parameter [47:0] SRC_MAC_ADDR = 48'h2222_2222_2222,
    parameter VLAN = 1'b1,
    parameter TYPE = 16'h0800,
    parameter PRI = 3'b111,
    parameter DSCP = 6'b0
)
(
    input wire axis_aclk,
    input wire axis_reset,
    output reg [AXIS_DATA_WIDTH-1:0] s_axis_tdata,
    output reg [(AXIS_DATA_WIDTH / 8)-1:0] s_axis_tkeep,
    output reg [AXIS_TUSER_WIDTH-1:0] s_axis_tuser,
    output reg s_axis_tvalid,
    input wire s_axis_tready,
    output reg s_axis_tlast
);

localparam integer MAX_PACKET_LENGTH = 1542;
localparam integer PACKET_LENGTH = 70;
reg [7:0] packet_data [0:MAX_PACKET_LENGTH];

integer i, j, k;
initial begin
    for (i = 0; i < MAX_PACKET_LENGTH; i = i + 1) begin
        packet_data[i] = i[7:0];
    end

    {packet_data[0], packet_data[1], packet_data[2], packet_data[3], packet_data[4], packet_data[5]} = DST_MAC_ADDR;
    {packet_data[6], packet_data[7], packet_data[8], packet_data[9], packet_data[10], packet_data[11]} = SRC_MAC_ADDR;
    if (VLAN) begin
        packet_data[12] = 8'h81;
        packet_data[13] = 8'h00;
        packet_data[14] = {PRI, 5'd0};
        packet_data[15] = 8'h00;
    end
    else begin
        {packet_data[12], packet_data[13]} = TYPE;
        // version 4 bits, IHL 4 bits
        packet_data[14] = 0;
        // DSCP 6 bits, ECN 2 bits
        packet_data[15] = { 2'b00, DSCP };
    end

end

integer packet_byte_index;

always @(posedge axis_aclk or posedge axis_reset) begin
    s_axis_tuser <= {AXIS_TUSER_WIDTH{1'b1}};
    if (axis_reset == 1'b1) begin
        packet_byte_index <= AXIS_DATA_WIDTH/8;        
        for (j = AXIS_DATA_WIDTH/8-1; j >= 0; j = j-1) begin
            s_axis_tdata[j*8 +: 8] <= packet_data[j];
        end    
        s_axis_tkeep <= {(AXIS_DATA_WIDTH/8){1'b1}};
        s_axis_tlast <= 1'b0;
        s_axis_tvalid <= 1'b1;
    end
    else if (s_axis_tvalid && s_axis_tready) begin
        for (j = AXIS_DATA_WIDTH/8-1; j >= 0; j = j-1) begin
            s_axis_tdata[j*8 +: 8] <= packet_data[packet_byte_index + j];
        end    
        if (packet_byte_index + AXIS_DATA_WIDTH/8 >= PACKET_LENGTH) begin
            s_axis_tlast <= 1;
            for (k = 0; k < AXIS_DATA_WIDTH/8; k = k + 1) begin
                if (k < packet_byte_index + AXIS_DATA_WIDTH/8 - PACKET_LENGTH) begin
                    s_axis_tkeep[k] <= 1'b0;
                end
                else begin
                    s_axis_tkeep[k] <= 1'b1;
                end
            end
            packet_byte_index <= 0;
        end
        else begin
            s_axis_tlast <= 1'b0;
            s_axis_tkeep <= {(AXIS_DATA_WIDTH/8){1'b1}};
            packet_byte_index <= packet_byte_index + AXIS_DATA_WIDTH/8;
        end
    end
end

endmodule