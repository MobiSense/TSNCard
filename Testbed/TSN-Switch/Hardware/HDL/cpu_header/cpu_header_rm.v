module cpu_header_rm # 
    (
        parameter C_DATA_WIDTH = 256,
        parameter C_TUSER_WIDTH = 256
    )
    (
        input clk,
        input rst,

        // slave axis interface
        input [C_DATA_WIDTH-1:0] s_axis_tdata,
        input [C_DATA_WIDTH/8-1:0] s_axis_tkeep,
        input s_axis_tvalid,
        input s_axis_tlast,
        output s_axis_tready,

        //master axis interface
        output [C_DATA_WIDTH-1:0] m_axis_tdata,
        output reg [C_TUSER_WIDTH-1:0] m_axis_tuser,
        output [C_DATA_WIDTH/8-1:0] m_axis_tkeep,
        output m_axis_tvalid,
        output m_axis_tlast,
        input m_axis_tready
    );

    // Internal Params
    localparam HEADER2USER_S = 0;
    localparam WAIT_EOP_S = 1;

    // Regs/wires
    reg state, nxt_state;


    
    // state machine
    always @(posedge rst, posedge clk) begin
        if (rst == 1'b1) begin
            state <= HEADER2USER_S;
        end
        else begin
            state <= nxt_state;
        end
    end

    always @(state, s_axis_tvalid, m_axis_tready, s_axis_tlast) begin
        case(state)
            HEADER2USER_S: begin
                if (s_axis_tvalid) begin
                    nxt_state = WAIT_EOP_S;
                end
                else begin
                    nxt_state = HEADER2USER_S;
                end
            end
            WAIT_EOP_S: begin
                if (m_axis_tvalid && m_axis_tready && m_axis_tlast) begin
                    nxt_state = HEADER2USER_S;
                end
                else begin
                    nxt_state = WAIT_EOP_S;
                end
            end
        endcase
    end

    // Determine m_axis signal
    always @(posedge rst, posedge clk) begin
        if (rst == 1'b1) begin
            m_axis_tuser <= 0;
        end
        else if (state == HEADER2USER_S) begin
            m_axis_tuser <= s_axis_tdata[C_TUSER_WIDTH-1:0];
        end
        else begin
            m_axis_tuser <= m_axis_tuser;
        end
    end

    assign s_axis_tready = (state == HEADER2USER_S) ? 1: m_axis_tready;
    assign m_axis_tdata = s_axis_tdata;
    assign m_axis_tvalid = (state == HEADER2USER_S) ? 0: s_axis_tvalid;
    assign m_axis_tkeep = s_axis_tkeep;
    assign m_axis_tlast = s_axis_tlast;
endmodule