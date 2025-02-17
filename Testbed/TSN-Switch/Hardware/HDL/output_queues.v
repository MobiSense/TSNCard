module output_queues
#(
    // Master AXI Stream Data Width
    parameter C_M_AXIS_DATA_WIDTH=256,
    parameter C_S_AXIS_DATA_WIDTH=256,
    parameter C_M_AXIS_TUSER_WIDTH=128,
    parameter C_S_AXIS_TUSER_WIDTH=128,
    parameter NUM_PORTS = 4,
    parameter NUM_QUEUES_PORT = 3,
    parameter C_S_AXI_DATA_WIDTH    = 32,          
    parameter C_S_AXI_ADDR_WIDTH    = 32
)
(
    // Part 1: System side signals
    // Global Ports
    input axis_aclk,
    input axis_resetn,

    // Slave Stream Ports (interface to data path)
    input [C_S_AXIS_DATA_WIDTH - 1:0]           s_axis_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0]   s_axis_tkeep,
    input [C_S_AXIS_TUSER_WIDTH-1:0]            s_axis_tuser,
    input                                       s_axis_tvalid,
    output                                      s_axis_tready,
    input                                       s_axis_tlast,

    // Master Stream Ports (interface to TX queues)
    // 8 Queues for Port 0
    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_0_0_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_0_0_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_0_0_tuser,
    output                                      m_axis_0_0_tvalid,
    input                                       m_axis_0_0_tready,
    output                                      m_axis_0_0_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_0_1_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_0_1_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_0_1_tuser,
    output                                      m_axis_0_1_tvalid,
    input                                       m_axis_0_1_tready,
    output                                      m_axis_0_1_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_0_2_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_0_2_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_0_2_tuser,
    output                                      m_axis_0_2_tvalid,
    input                                       m_axis_0_2_tready,
    output                                      m_axis_0_2_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_0_3_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_0_3_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_0_3_tuser,
    output                                      m_axis_0_3_tvalid,
    input                                       m_axis_0_3_tready,
    output                                      m_axis_0_3_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_0_4_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_0_4_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_0_4_tuser,
    output                                      m_axis_0_4_tvalid,
    input                                       m_axis_0_4_tready,
    output                                      m_axis_0_4_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_0_5_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_0_5_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_0_5_tuser,
    output                                      m_axis_0_5_tvalid,
    input                                       m_axis_0_5_tready,
    output                                      m_axis_0_5_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_0_6_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_0_6_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_0_6_tuser,
    output                                      m_axis_0_6_tvalid,
    input                                       m_axis_0_6_tready,
    output                                      m_axis_0_6_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_0_7_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_0_7_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_0_7_tuser,
    output                                      m_axis_0_7_tvalid,
    input                                       m_axis_0_7_tready,
    output                                      m_axis_0_7_tlast,

    // 8 Queues for Port 1
    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_1_0_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_1_0_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_1_0_tuser,
    output                                      m_axis_1_0_tvalid,
    input                                       m_axis_1_0_tready,
    output                                      m_axis_1_0_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_1_1_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_1_1_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_1_1_tuser,
    output                                      m_axis_1_1_tvalid,
    input                                       m_axis_1_1_tready,
    output                                      m_axis_1_1_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_1_2_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_1_2_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_1_2_tuser,
    output                                      m_axis_1_2_tvalid,
    input                                       m_axis_1_2_tready,
    output                                      m_axis_1_2_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_1_3_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_1_3_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_1_3_tuser,
    output                                      m_axis_1_3_tvalid,
    input                                       m_axis_1_3_tready,
    output                                      m_axis_1_3_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_1_4_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_1_4_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_1_4_tuser,
    output                                      m_axis_1_4_tvalid,
    input                                       m_axis_1_4_tready,
    output                                      m_axis_1_4_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_1_5_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_1_5_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_1_5_tuser,
    output                                      m_axis_1_5_tvalid,
    input                                       m_axis_1_5_tready,
    output                                      m_axis_1_5_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_1_6_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_1_6_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_1_6_tuser,
    output                                      m_axis_1_6_tvalid,
    input                                       m_axis_1_6_tready,
    output                                      m_axis_1_6_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_1_7_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_1_7_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_1_7_tuser,
    output                                      m_axis_1_7_tvalid,
    input                                       m_axis_1_7_tready,
    output                                      m_axis_1_7_tlast,

    // 8 Queues for Port 2
    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_2_0_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_2_0_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_2_0_tuser,
    output                                      m_axis_2_0_tvalid,
    input                                       m_axis_2_0_tready,
    output                                      m_axis_2_0_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_2_1_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_2_1_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_2_1_tuser,
    output                                      m_axis_2_1_tvalid,
    input                                       m_axis_2_1_tready,
    output                                      m_axis_2_1_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_2_2_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_2_2_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_2_2_tuser,
    output                                      m_axis_2_2_tvalid,
    input                                       m_axis_2_2_tready,
    output                                      m_axis_2_2_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_2_3_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_2_3_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_2_3_tuser,
    output                                      m_axis_2_3_tvalid,
    input                                       m_axis_2_3_tready,
    output                                      m_axis_2_3_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_2_4_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_2_4_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_2_4_tuser,
    output                                      m_axis_2_4_tvalid,
    input                                       m_axis_2_4_tready,
    output                                      m_axis_2_4_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_2_5_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_2_5_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_2_5_tuser,
    output                                      m_axis_2_5_tvalid,
    input                                       m_axis_2_5_tready,
    output                                      m_axis_2_5_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_2_6_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_2_6_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_2_6_tuser,
    output                                      m_axis_2_6_tvalid,
    input                                       m_axis_2_6_tready,
    output                                      m_axis_2_6_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_2_7_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_2_7_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_2_7_tuser,
    output                                      m_axis_2_7_tvalid,
    input                                       m_axis_2_7_tready,
    output                                      m_axis_2_7_tlast,

    // 8 Queues for Port 3
    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_3_0_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_3_0_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_3_0_tuser,
    output                                      m_axis_3_0_tvalid,
    input                                       m_axis_3_0_tready,
    output                                      m_axis_3_0_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_3_1_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_3_1_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_3_1_tuser,
    output                                      m_axis_3_1_tvalid,
    input                                       m_axis_3_1_tready,
    output                                      m_axis_3_1_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_3_2_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_3_2_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_3_2_tuser,
    output                                      m_axis_3_2_tvalid,
    input                                       m_axis_3_2_tready,
    output                                      m_axis_3_2_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_3_3_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_3_3_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_3_3_tuser,
    output                                      m_axis_3_3_tvalid,
    input                                       m_axis_3_3_tready,
    output                                      m_axis_3_3_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_3_4_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_3_4_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_3_4_tuser,
    output                                      m_axis_3_4_tvalid,
    input                                       m_axis_3_4_tready,
    output                                      m_axis_3_4_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_3_5_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_3_5_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_3_5_tuser,
    output                                      m_axis_3_5_tvalid,
    input                                       m_axis_3_5_tready,
    output                                      m_axis_3_5_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_3_6_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_3_6_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_3_6_tuser,
    output                                      m_axis_3_6_tvalid,
    input                                       m_axis_3_6_tready,
    output                                      m_axis_3_6_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_3_7_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_3_7_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_3_7_tuser,
    output                                      m_axis_3_7_tvalid,
    input                                       m_axis_3_7_tready,
    output                                      m_axis_3_7_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_cpu_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_cpu_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_cpu_tuser,
    output                                      m_axis_cpu_tvalid,
    input                                       m_axis_cpu_tready,
    output                                      m_axis_cpu_tlast,

    // stats
    output reg  [C_S_AXI_DATA_WIDTH-1:0] bytes_stored,
    output reg  [4 * NUM_QUEUES_PORT:0]         pkt_stored,

    output [C_S_AXI_DATA_WIDTH-1:0]  bytes_removed_0,
    output [C_S_AXI_DATA_WIDTH-1:0]  bytes_removed_1,
    output [C_S_AXI_DATA_WIDTH-1:0]  bytes_removed_2,
    output [C_S_AXI_DATA_WIDTH-1:0]  bytes_removed_3,
    output [C_S_AXI_DATA_WIDTH-1:0]  bytes_removed_4,
    output [C_S_AXI_DATA_WIDTH-1:0]  bytes_removed_5,
    output [C_S_AXI_DATA_WIDTH-1:0]  bytes_removed_6,
    output [C_S_AXI_DATA_WIDTH-1:0]  bytes_removed_7,
    output [C_S_AXI_DATA_WIDTH-1:0]  bytes_removed_8,
    output                           pkt_removed_0,
    output                           pkt_removed_1,
    output                           pkt_removed_2,
    output                           pkt_removed_3,
    output                           pkt_removed_4,
    output                           pkt_removed_5,
    output                           pkt_removed_6,
    output                           pkt_removed_7,
    output                           pkt_removed_8,

    output reg [C_S_AXI_DATA_WIDTH-1:0]  bytes_dropped,
    output reg [4 * NUM_QUEUES_PORT:0]          pkt_dropped
);

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

    // localparam NUM_QUEUES_WIDTH = log2(NUM_QUEUES);
    localparam NUM_QUEUES = NUM_PORTS * NUM_QUEUES_PORT + 1;

    localparam BUFFER_SIZE         = 16384; // Buffer size 4096B
    localparam BUFFER_SIZE_WIDTH   = log2(BUFFER_SIZE/(C_M_AXIS_DATA_WIDTH/8));
    localparam NUM_QUEUES_PORT_WIDTH = log2(NUM_QUEUES_PORT);

    localparam MAX_PACKET_SIZE = 1600;
    localparam BUFFER_THRESHOLD = (BUFFER_SIZE-MAX_PACKET_SIZE)/(C_M_AXIS_DATA_WIDTH/8);

    localparam NUM_STATES = 3;
    localparam IDLE = 0;
    localparam WR_PKT = 1;
    localparam DROP = 2;

    localparam NUM_METADATA_STATES = 2;
    localparam WAIT_HEADER = 0;
    localparam WAIT_EOP = 1;


    // ------------- Regs/ wires -----------

    reg [NUM_QUEUES-1:0]                nearly_full;
    wire [NUM_QUEUES-1:0]               nearly_full_fifo;
    wire [NUM_QUEUES-1:0]               full_fifo;
    wire [NUM_QUEUES-1:0]               empty;

    reg [NUM_QUEUES-1:0]                metadata_nearly_full;
    wire [NUM_QUEUES-1:0]               metadata_nearly_full_fifo;
    wire [NUM_QUEUES-1:0]               metadata_full_fifo;
    wire [NUM_QUEUES-1:0]               metadata_empty;

    wire [C_M_AXIS_TUSER_WIDTH-1:0]             fifo_out_tuser[NUM_QUEUES-1:0];
    wire [C_M_AXIS_DATA_WIDTH-1:0]        fifo_out_tdata[NUM_QUEUES-1:0];
    wire [((C_M_AXIS_DATA_WIDTH/8))-1:0]  fifo_out_tkeep[NUM_QUEUES-1:0];
    wire [NUM_QUEUES-1:0] 	           fifo_out_tlast;

    wire [NUM_QUEUES-1:0]               rd_en;
    wire [NUM_QUEUES-1:0]                wr_en;

    reg [NUM_QUEUES-1:0]                metadata_rd_en;
    wire [NUM_QUEUES-1:0]                metadata_wr_en;

    reg [NUM_QUEUES-1:0]          cur_queue;
    reg [NUM_QUEUES-1:0]          cur_queue_next;
    
    wire [4:0]     oq_orig;
    wire [NUM_QUEUES-1:0]         oq;

    reg [NUM_STATES-1:0]                state;
    reg [NUM_STATES-1:0]                state_next;

    reg [NUM_METADATA_STATES-1:0]       metadata_state[NUM_QUEUES-1:0];
    reg [NUM_METADATA_STATES-1:0]       metadata_state_next[NUM_QUEUES-1:0];

    reg [NUM_QUEUES-1:0] pkt_stored_next;
    reg [C_S_AXI_DATA_WIDTH-1:0] bytes_stored_next;
    reg [NUM_QUEUES-1:0] pkt_dropped_next;
    reg [C_S_AXI_DATA_WIDTH-1:0] bytes_dropped_next;
    reg [NUM_QUEUES-1:0] pkt_removed;
    reg [C_S_AXI_DATA_WIDTH-1:0] bytes_removed[NUM_QUEUES-1:0];

    wire clear_counters;
    wire reset_registers;

    reg tready;


    // ------------ Modules -------------

    generate
    genvar i;
    for(i = 0; i < NUM_QUEUES; i = i + 1) begin: output_queues
        fallthrough_small_fifo
            #( .WIDTH(C_M_AXIS_DATA_WIDTH+C_M_AXIS_DATA_WIDTH/8+1),
            .MAX_DEPTH_BITS(BUFFER_SIZE_WIDTH),
            .PROG_FULL_THRESHOLD(BUFFER_THRESHOLD))
        output_fifo
            (// Outputs
            .dout                           ({fifo_out_tlast[i], fifo_out_tkeep[i], fifo_out_tdata[i]}),
            .full                           (full_fifo[i]),
            .nearly_full                    (),
            .prog_full                      (nearly_full_fifo[i]),
            .empty                          (empty[i]),
            // Inputs
            .din                            ({s_axis_tlast, s_axis_tkeep, s_axis_tdata}),
            .wr_en                          (wr_en[i]),
            .rd_en                          (rd_en[i]),
            .reset                          (~axis_resetn),
            .clk                            (axis_aclk));

        fallthrough_small_fifo
            #( .WIDTH(C_M_AXIS_TUSER_WIDTH),
            .MAX_DEPTH_BITS(BUFFER_SIZE_WIDTH)) // Todo This may be too large. maybe divide by 2.
            //    .MAX_DEPTH_BITS(BUFFER_SIZE_WIDTH),
            //    .PROG_FULL_THRESHOLD(BUFFER_THRESHOLD))
        metadata_fifo
            (// Outputs
            .dout                           (fifo_out_tuser[i]),
            .full                           (metadata_full_fifo[i]),
            .nearly_full                    (metadata_nearly_full_fifo[i]),
            .prog_full                      (),
            .empty                          (metadata_empty[i]),
            // Inputs
            .din                            (s_axis_tuser),
            .wr_en                          (metadata_wr_en[i]),
            .rd_en                          (metadata_rd_en[i]),
            .reset                          (~axis_resetn),
            .clk                            (axis_aclk));


    always @(metadata_state[i], rd_en[i], fifo_out_tlast[i], fifo_out_tuser[i]) begin // This is the read process, what about the metadata write process?
            metadata_rd_en[i] = 1'b0;
            pkt_removed[i]= 1'b0;
        bytes_removed[i]=32'b0;
        metadata_state_next[i] = metadata_state[i];
            case(metadata_state[i])
                WAIT_HEADER: begin
                    if(rd_en[i]) begin
                        metadata_state_next[i] = WAIT_EOP;
                        metadata_rd_en[i] = 1'b1;
                    pkt_removed[i]= 1'b1;
                    bytes_removed[i]=fifo_out_tuser[i][15:0];
                    end
                end
                WAIT_EOP: begin
                    if(rd_en[i] & fifo_out_tlast[i]) begin
                        metadata_state_next[i] = WAIT_HEADER;
                    end
                end
            endcase
        end

        always @(posedge axis_aclk) begin
            if(~axis_resetn) begin
                metadata_state[i] <= WAIT_HEADER;
            end
            else begin
                metadata_state[i] <= metadata_state_next[i];
            end
        end

    end 
    endgenerate

    // Per NetFPGA-10G AXI Spec
    localparam DST_POS = 24;
    assign oq_orig = s_axis_tuser[DST_POS] |
                (s_axis_tuser[DST_POS + 2] << 1) |
                (s_axis_tuser[DST_POS + 4] << 2) |
                (s_axis_tuser[DST_POS + 6] << 3) |
                ((s_axis_tuser[DST_POS + 1] | s_axis_tuser[DST_POS + 3] | s_axis_tuser[DST_POS + 5] | s_axis_tuser[DST_POS + 7]) << 4);

    //    assign oq = {oq_orig[4], oq_orig[3] & (~s_axis_tuser[0]), oq_orig[3] & s_axis_tuser[0], oq_orig[2] & (~s_axis_tuser[0]), oq_orig[2] & s_axis_tuser[0], oq_orig[1] & (~s_axis_tuser[0]), oq_orig[1] & s_axis_tuser[0], oq_orig[0] & (~s_axis_tuser[0]), oq_orig[0] & s_axis_tuser[0]};
    // oq when there are only two queues.
    // assign oq = {oq_orig[4], oq_orig[3] & s_axis_tuser[0], oq_orig[2] & s_axis_tuser[0], oq_orig[1] & s_axis_tuser[0], oq_orig[0] & s_axis_tuser[0], oq_orig[3] & (~s_axis_tuser[0]), oq_orig[2] & (~s_axis_tuser[0]), oq_orig[1] & (~s_axis_tuser[0]), oq_orig[0] & (~s_axis_tuser[0])};
    // oq for eight queues.
    reg [NUM_QUEUES_PORT-1:0] oq_ports[0:3];
    wire [15:0] ether_type = s_axis_tdata[111:96];
    wire [2:0] pri = (ether_type == 16'h0081) ? s_axis_tdata[119:117]: 0;
    wire [2:0] pri_queue_table [0:7];
    assign pri_queue_table[0] = 3'd0;
    assign pri_queue_table[1] = 3'd0;
    assign pri_queue_table[2] = 3'd1;
    assign pri_queue_table[3] = 3'd1;
    assign pri_queue_table[4] = 3'd2;
    assign pri_queue_table[5] = 3'd2;
    assign pri_queue_table[6] = 3'd3;
    assign pri_queue_table[7] = 3'd3;
    
    generate
        genvar j;
        for (j = 0; j < 4; j = j + 1) begin
            always @(*) begin
                oq_ports[j] = {NUM_QUEUES_PORT{1'b0}};
                if (oq_orig[j]) begin
                    oq_ports[j][pri_queue_table[pri][NUM_QUEUES_PORT_WIDTH-1:0]] = 1;
                end
            end
        end
    endgenerate 
    
    assign oq = {oq_orig[4], oq_ports[3][NUM_QUEUES_PORT-1:0], oq_ports[2][NUM_QUEUES_PORT-1:0], oq_ports[1][NUM_QUEUES_PORT-1:0], oq_ports[0][NUM_QUEUES_PORT-1:0]};

    always @(*) begin
        state_next     = state;
        cur_queue_next = cur_queue;    
        bytes_stored_next = 0;
        pkt_stored_next = 0;
        pkt_dropped_next = 0;
        bytes_dropped_next = 0;
        

        case(state)

            /* cycle between input queues until one is not empty */
            IDLE: begin
            cur_queue_next = oq; // If s_axis_tvalid is not 1, then oq may be alll 0, which is meaning less.
            if(s_axis_tvalid ) begin
                if ((~|((nearly_full | metadata_nearly_full) & oq)) && (oq != 0)) begin // All interesting oqs are NOT _nearly_ full (able to fit in the maximum pacekt).
                    state_next = WR_PKT;
            pkt_stored_next = oq;
            bytes_stored_next = s_axis_tuser[15:0];
                end
                else begin
                    state_next = DROP;
                pkt_dropped_next = oq;
            bytes_dropped_next = s_axis_tuser[15:0];
                end
            end
            end

            /* wait until eop */
            WR_PKT: begin
                if(s_axis_tvalid ) begin
                    if(s_axis_tlast) begin
                        state_next = IDLE;
                    end
            end 
            end // case: WR_PKT

            DROP: begin
            if (s_axis_tvalid & s_axis_tlast ) begin
                state_next = IDLE;
            end
            end

        endcase // case(state)
    end // always @ (*)


    assign s_axis_tready =  1;//((~|(full_fifo | metadata_full_fifo) )); | (state == DROP)); 
    // Fix 2 If the state is WR_PKT, we should always write, otherwise a packet will be partly transmitted downward.
    // Additionally, precedence? parathesis?
    // assign wr_en = !(s_axis_tvalid & s_axis_tready)  ? 0 : 
    //                (state == IDLE) ? (~|((full_fifo | metadata_full_fifo) & oq) ? oq : 0 ) :
    //                (state == WR_PKT) ? (~|((full_fifo | metadata_full_fifo) & cur_queue)? cur_queue : 0 ) :
    //                0 ;
    assign wr_en = !(s_axis_tvalid & s_axis_tready)  ? 0 : 
                ((state == IDLE) ? (~|((nearly_full | metadata_nearly_full) & oq) ? oq : 0 ) :
                ((state == WR_PKT) ? cur_queue : 0)); 
    // This will cause the metadata of dropped packets to be written to fifo.
    // assign metadata_wr_en = s_axis_tvalid & s_axis_tready & ((state == IDLE)) ? oq : 0; 
    assign metadata_wr_en = s_axis_tvalid & s_axis_tready & ((state == IDLE)) & (~|((nearly_full | metadata_nearly_full) & oq)) ? oq : 0; 


    always @(posedge axis_aclk) begin
        if(~axis_resetn) begin
            state <= IDLE;
            cur_queue <= 0;
        bytes_stored <= 0;
            pkt_stored <= 0;
            pkt_dropped <=0;
            bytes_dropped <=0;
        end
        else begin
            state <= state_next;
            cur_queue <= cur_queue_next;
        bytes_stored <= bytes_stored_next;
            pkt_stored <= pkt_stored_next;
            pkt_dropped<= pkt_dropped_next;
            bytes_dropped<= bytes_dropped_next;
        end

        nearly_full <= nearly_full_fifo;
        metadata_nearly_full <= metadata_nearly_full_fifo;
    end

    wire [C_M_AXIS_DATA_WIDTH-1:0]          int_m_axis_tdata  [0:3] [7:0];
    wire [((C_M_AXIS_DATA_WIDTH/8)) - 1:0]  int_m_axis_tkeep  [0:3] [7:0];
    wire [C_M_AXIS_TUSER_WIDTH-1:0]         int_m_axis_tuser  [0:3] [7:0];
    wire                                    int_m_axis_tvalid [0:3] [7:0];
    wire                                    int_m_axis_tlast  [0:3] [7:0];
    wire                                    int_m_axis_tready [0:3] [7:0];

    assign m_axis_0_0_tdata         = int_m_axis_tdata[0][0];
    assign m_axis_0_0_tkeep         = int_m_axis_tkeep[0][0];
    assign m_axis_0_0_tuser         = int_m_axis_tuser[0][0];
    assign m_axis_0_0_tvalid        = int_m_axis_tvalid[0][0];
    assign m_axis_0_0_tlast         = int_m_axis_tlast[0][0];
    assign int_m_axis_tready[0][0]  = m_axis_0_0_tready;

    assign m_axis_0_1_tdata         = int_m_axis_tdata[0][1];
    assign m_axis_0_1_tkeep         = int_m_axis_tkeep[0][1];
    assign m_axis_0_1_tuser         = int_m_axis_tuser[0][1];
    assign m_axis_0_1_tvalid        = int_m_axis_tvalid[0][1];
    assign m_axis_0_1_tlast         = int_m_axis_tlast[0][1];
    assign int_m_axis_tready[0][1]  = m_axis_0_1_tready;

    assign m_axis_0_2_tdata         = int_m_axis_tdata[0][2];
    assign m_axis_0_2_tkeep         = int_m_axis_tkeep[0][2];
    assign m_axis_0_2_tuser         = int_m_axis_tuser[0][2];
    assign m_axis_0_2_tvalid        = int_m_axis_tvalid[0][2];
    assign m_axis_0_2_tlast         = int_m_axis_tlast[0][2];
    assign int_m_axis_tready[0][2]  = m_axis_0_2_tready;

    assign m_axis_0_3_tdata         = int_m_axis_tdata[0][3];
    assign m_axis_0_3_tkeep         = int_m_axis_tkeep[0][3];
    assign m_axis_0_3_tuser         = int_m_axis_tuser[0][3];
    assign m_axis_0_3_tvalid        = int_m_axis_tvalid[0][3];
    assign m_axis_0_3_tlast         = int_m_axis_tlast[0][3];
    assign int_m_axis_tready[0][3]  = m_axis_0_3_tready;

    assign m_axis_0_4_tdata         = int_m_axis_tdata[0][4];
    assign m_axis_0_4_tkeep         = int_m_axis_tkeep[0][4];
    assign m_axis_0_4_tuser         = int_m_axis_tuser[0][4];
    assign m_axis_0_4_tvalid        = int_m_axis_tvalid[0][4];
    assign m_axis_0_4_tlast         = int_m_axis_tlast[0][4];
    assign int_m_axis_tready[0][4]  = m_axis_0_4_tready;

    assign m_axis_0_5_tdata         = int_m_axis_tdata[0][5];
    assign m_axis_0_5_tkeep         = int_m_axis_tkeep[0][5];
    assign m_axis_0_5_tuser         = int_m_axis_tuser[0][5];
    assign m_axis_0_5_tvalid        = int_m_axis_tvalid[0][5];
    assign m_axis_0_5_tlast         = int_m_axis_tlast[0][5];
    assign int_m_axis_tready[0][5]  = m_axis_0_5_tready;

    assign m_axis_0_6_tdata         = int_m_axis_tdata[0][6];
    assign m_axis_0_6_tkeep         = int_m_axis_tkeep[0][6];
    assign m_axis_0_6_tuser         = int_m_axis_tuser[0][6];
    assign m_axis_0_6_tvalid        = int_m_axis_tvalid[0][6];
    assign m_axis_0_6_tlast         = int_m_axis_tlast[0][6];
    assign int_m_axis_tready[0][6]  = m_axis_0_6_tready;

    assign m_axis_0_7_tdata         = int_m_axis_tdata[0][7];
    assign m_axis_0_7_tkeep         = int_m_axis_tkeep[0][7];
    assign m_axis_0_7_tuser         = int_m_axis_tuser[0][7];
    assign m_axis_0_7_tvalid        = int_m_axis_tvalid[0][7];
    assign m_axis_0_7_tlast         = int_m_axis_tlast[0][7];
    assign int_m_axis_tready[0][7]  = m_axis_0_7_tready;

    assign m_axis_1_0_tdata         = int_m_axis_tdata[1][0];
    assign m_axis_1_0_tkeep         = int_m_axis_tkeep[1][0];
    assign m_axis_1_0_tuser         = int_m_axis_tuser[1][0];
    assign m_axis_1_0_tvalid        = int_m_axis_tvalid[1][0];
    assign m_axis_1_0_tlast         = int_m_axis_tlast[1][0];
    assign int_m_axis_tready[1][0]  = m_axis_1_0_tready;

    assign m_axis_1_1_tdata         = int_m_axis_tdata[1][1];
    assign m_axis_1_1_tkeep         = int_m_axis_tkeep[1][1];
    assign m_axis_1_1_tuser         = int_m_axis_tuser[1][1];
    assign m_axis_1_1_tvalid        = int_m_axis_tvalid[1][1];
    assign m_axis_1_1_tlast         = int_m_axis_tlast[1][1];
    assign int_m_axis_tready[1][1]  = m_axis_1_1_tready;

    assign m_axis_1_2_tdata         = int_m_axis_tdata[1][2];
    assign m_axis_1_2_tkeep         = int_m_axis_tkeep[1][2];
    assign m_axis_1_2_tuser         = int_m_axis_tuser[1][2];
    assign m_axis_1_2_tvalid        = int_m_axis_tvalid[1][2];
    assign m_axis_1_2_tlast         = int_m_axis_tlast[1][2];
    assign int_m_axis_tready[1][2]  = m_axis_1_2_tready;

    assign m_axis_1_3_tdata         = int_m_axis_tdata[1][3];
    assign m_axis_1_3_tkeep         = int_m_axis_tkeep[1][3];
    assign m_axis_1_3_tuser         = int_m_axis_tuser[1][3];
    assign m_axis_1_3_tvalid        = int_m_axis_tvalid[1][3];
    assign m_axis_1_3_tlast         = int_m_axis_tlast[1][3];
    assign int_m_axis_tready[1][3]  = m_axis_1_3_tready;

    assign m_axis_1_4_tdata         = int_m_axis_tdata[1][4];
    assign m_axis_1_4_tkeep         = int_m_axis_tkeep[1][4];
    assign m_axis_1_4_tuser         = int_m_axis_tuser[1][4];
    assign m_axis_1_4_tvalid        = int_m_axis_tvalid[1][4];
    assign m_axis_1_4_tlast         = int_m_axis_tlast[1][4];
    assign int_m_axis_tready[1][4]  = m_axis_1_4_tready;

    assign m_axis_1_5_tdata         = int_m_axis_tdata[1][5];
    assign m_axis_1_5_tkeep         = int_m_axis_tkeep[1][5];
    assign m_axis_1_5_tuser         = int_m_axis_tuser[1][5];
    assign m_axis_1_5_tvalid        = int_m_axis_tvalid[1][5];
    assign m_axis_1_5_tlast         = int_m_axis_tlast[1][5];
    assign int_m_axis_tready[1][5]  = m_axis_1_5_tready;

    assign m_axis_1_6_tdata         = int_m_axis_tdata[1][6];
    assign m_axis_1_6_tkeep         = int_m_axis_tkeep[1][6];
    assign m_axis_1_6_tuser         = int_m_axis_tuser[1][6];
    assign m_axis_1_6_tvalid        = int_m_axis_tvalid[1][6];
    assign m_axis_1_6_tlast         = int_m_axis_tlast[1][6];
    assign int_m_axis_tready[1][6]  = m_axis_1_6_tready;

    assign m_axis_1_7_tdata         = int_m_axis_tdata[1][7];
    assign m_axis_1_7_tkeep         = int_m_axis_tkeep[1][7];
    assign m_axis_1_7_tuser         = int_m_axis_tuser[1][7];
    assign m_axis_1_7_tvalid        = int_m_axis_tvalid[1][7];
    assign m_axis_1_7_tlast         = int_m_axis_tlast[1][7];
    assign int_m_axis_tready[1][7]  = m_axis_1_7_tready;

    assign m_axis_2_0_tdata         = int_m_axis_tdata[2][0];
    assign m_axis_2_0_tkeep         = int_m_axis_tkeep[2][0];
    assign m_axis_2_0_tuser         = int_m_axis_tuser[2][0];
    assign m_axis_2_0_tvalid        = int_m_axis_tvalid[2][0];
    assign m_axis_2_0_tlast         = int_m_axis_tlast[2][0];
    assign int_m_axis_tready[2][0]  = m_axis_2_0_tready;

    assign m_axis_2_1_tdata         = int_m_axis_tdata[2][1];
    assign m_axis_2_1_tkeep         = int_m_axis_tkeep[2][1];
    assign m_axis_2_1_tuser         = int_m_axis_tuser[2][1];
    assign m_axis_2_1_tvalid        = int_m_axis_tvalid[2][1];
    assign m_axis_2_1_tlast         = int_m_axis_tlast[2][1];
    assign int_m_axis_tready[2][1]  = m_axis_2_1_tready;

    assign m_axis_2_2_tdata         = int_m_axis_tdata[2][2];
    assign m_axis_2_2_tkeep         = int_m_axis_tkeep[2][2];
    assign m_axis_2_2_tuser         = int_m_axis_tuser[2][2];
    assign m_axis_2_2_tvalid        = int_m_axis_tvalid[2][2];
    assign m_axis_2_2_tlast         = int_m_axis_tlast[2][2];
    assign int_m_axis_tready[2][2]  = m_axis_2_2_tready;

    assign m_axis_2_3_tdata         = int_m_axis_tdata[2][3];
    assign m_axis_2_3_tkeep         = int_m_axis_tkeep[2][3];
    assign m_axis_2_3_tuser         = int_m_axis_tuser[2][3];
    assign m_axis_2_3_tvalid        = int_m_axis_tvalid[2][3];
    assign m_axis_2_3_tlast         = int_m_axis_tlast[2][3];
    assign int_m_axis_tready[2][3]  = m_axis_2_3_tready;

    assign m_axis_2_4_tdata         = int_m_axis_tdata[2][4];
    assign m_axis_2_4_tkeep         = int_m_axis_tkeep[2][4];
    assign m_axis_2_4_tuser         = int_m_axis_tuser[2][4];
    assign m_axis_2_4_tvalid        = int_m_axis_tvalid[2][4];
    assign m_axis_2_4_tlast         = int_m_axis_tlast[2][4];
    assign int_m_axis_tready[2][4]  = m_axis_2_4_tready;

    assign m_axis_2_5_tdata         = int_m_axis_tdata[2][5];
    assign m_axis_2_5_tkeep         = int_m_axis_tkeep[2][5];
    assign m_axis_2_5_tuser         = int_m_axis_tuser[2][5];
    assign m_axis_2_5_tvalid        = int_m_axis_tvalid[2][5];
    assign m_axis_2_5_tlast         = int_m_axis_tlast[2][5];
    assign int_m_axis_tready[2][5]  = m_axis_2_5_tready;

    assign m_axis_2_6_tdata         = int_m_axis_tdata[2][6];
    assign m_axis_2_6_tkeep         = int_m_axis_tkeep[2][6];
    assign m_axis_2_6_tuser         = int_m_axis_tuser[2][6];
    assign m_axis_2_6_tvalid        = int_m_axis_tvalid[2][6];
    assign m_axis_2_6_tlast         = int_m_axis_tlast[2][6];
    assign int_m_axis_tready[2][6]  = m_axis_2_6_tready;

    assign m_axis_2_7_tdata         = int_m_axis_tdata[2][7];
    assign m_axis_2_7_tkeep         = int_m_axis_tkeep[2][7];
    assign m_axis_2_7_tuser         = int_m_axis_tuser[2][7];
    assign m_axis_2_7_tvalid        = int_m_axis_tvalid[2][7];
    assign m_axis_2_7_tlast         = int_m_axis_tlast[2][7];
    assign int_m_axis_tready[2][7]  = m_axis_2_7_tready;

    assign m_axis_3_0_tdata         = int_m_axis_tdata[3][0];
    assign m_axis_3_0_tkeep         = int_m_axis_tkeep[3][0];
    assign m_axis_3_0_tuser         = int_m_axis_tuser[3][0];
    assign m_axis_3_0_tvalid        = int_m_axis_tvalid[3][0];
    assign m_axis_3_0_tlast         = int_m_axis_tlast[3][0];
    assign int_m_axis_tready[3][0]  = m_axis_3_0_tready;

    assign m_axis_3_1_tdata         = int_m_axis_tdata[3][1];
    assign m_axis_3_1_tkeep         = int_m_axis_tkeep[3][1];
    assign m_axis_3_1_tuser         = int_m_axis_tuser[3][1];
    assign m_axis_3_1_tvalid        = int_m_axis_tvalid[3][1];
    assign m_axis_3_1_tlast         = int_m_axis_tlast[3][1];
    assign int_m_axis_tready[3][1]  = m_axis_3_1_tready;

    assign m_axis_3_2_tdata         = int_m_axis_tdata[3][2];
    assign m_axis_3_2_tkeep         = int_m_axis_tkeep[3][2];
    assign m_axis_3_2_tuser         = int_m_axis_tuser[3][2];
    assign m_axis_3_2_tvalid        = int_m_axis_tvalid[3][2];
    assign m_axis_3_2_tlast         = int_m_axis_tlast[3][2];
    assign int_m_axis_tready[3][2]  = m_axis_3_2_tready;

    assign m_axis_3_3_tdata         = int_m_axis_tdata[3][3];
    assign m_axis_3_3_tkeep         = int_m_axis_tkeep[3][3];
    assign m_axis_3_3_tuser         = int_m_axis_tuser[3][3];
    assign m_axis_3_3_tvalid        = int_m_axis_tvalid[3][3];
    assign m_axis_3_3_tlast         = int_m_axis_tlast[3][3];
    assign int_m_axis_tready[3][3]  = m_axis_3_3_tready;

    assign m_axis_3_4_tdata         = int_m_axis_tdata[3][4];
    assign m_axis_3_4_tkeep         = int_m_axis_tkeep[3][4];
    assign m_axis_3_4_tuser         = int_m_axis_tuser[3][4];
    assign m_axis_3_4_tvalid        = int_m_axis_tvalid[3][4];
    assign m_axis_3_4_tlast         = int_m_axis_tlast[3][4];
    assign int_m_axis_tready[3][4]  = m_axis_3_4_tready;

    assign m_axis_3_5_tdata         = int_m_axis_tdata[3][5];
    assign m_axis_3_5_tkeep         = int_m_axis_tkeep[3][5];
    assign m_axis_3_5_tuser         = int_m_axis_tuser[3][5];
    assign m_axis_3_5_tvalid        = int_m_axis_tvalid[3][5];
    assign m_axis_3_5_tlast         = int_m_axis_tlast[3][5];
    assign int_m_axis_tready[3][5]  = m_axis_3_5_tready;

    assign m_axis_3_6_tdata         = int_m_axis_tdata[3][6];
    assign m_axis_3_6_tkeep         = int_m_axis_tkeep[3][6];
    assign m_axis_3_6_tuser         = int_m_axis_tuser[3][6];
    assign m_axis_3_6_tvalid        = int_m_axis_tvalid[3][6];
    assign m_axis_3_6_tlast         = int_m_axis_tlast[3][6];
    assign int_m_axis_tready[3][6]  = m_axis_3_6_tready;

    assign m_axis_3_7_tdata         = int_m_axis_tdata[3][7];
    assign m_axis_3_7_tkeep         = int_m_axis_tkeep[3][7];
    assign m_axis_3_7_tuser         = int_m_axis_tuser[3][7];
    assign m_axis_3_7_tvalid        = int_m_axis_tvalid[3][7];
    assign m_axis_3_7_tlast         = int_m_axis_tlast[3][7];
    assign int_m_axis_tready[3][7]  = m_axis_3_7_tready;

    generate
        genvar k, w;
        for (k = 0; k < NUM_PORTS; k = k + 1) begin
            for (w = 0; w < NUM_QUEUES_PORT; w = w + 1) begin
                assign int_m_axis_tdata[k][w]     = fifo_out_tdata[k*NUM_QUEUES_PORT+w];
                assign int_m_axis_tkeep[k][w]     = fifo_out_tkeep[k*NUM_QUEUES_PORT+w];
                assign int_m_axis_tuser[k][w]     = fifo_out_tuser[k*NUM_QUEUES_PORT+w];
                assign int_m_axis_tlast[k][w]     = fifo_out_tlast[k*NUM_QUEUES_PORT+w];
                assign int_m_axis_tvalid[k][w]    = ~empty[k*NUM_QUEUES_PORT+w];
                assign rd_en[k*NUM_QUEUES_PORT+w] = int_m_axis_tready[k][w] & ~empty[k*NUM_QUEUES_PORT+w];
            end
        end
    endgenerate

    assign m_axis_cpu_tdata            = fifo_out_tdata[NUM_PORTS * NUM_QUEUES_PORT];
    assign m_axis_cpu_tkeep            = fifo_out_tkeep[NUM_PORTS * NUM_QUEUES_PORT];
    assign m_axis_cpu_tuser            = fifo_out_tuser[NUM_PORTS * NUM_QUEUES_PORT];
    assign m_axis_cpu_tlast            = fifo_out_tlast[NUM_PORTS * NUM_QUEUES_PORT];
    assign m_axis_cpu_tvalid           = ~empty[NUM_PORTS * NUM_QUEUES_PORT];
    assign rd_en[NUM_PORTS * NUM_QUEUES_PORT]  = m_axis_cpu_tready & ~empty[NUM_PORTS * NUM_QUEUES_PORT];

    endmodule
