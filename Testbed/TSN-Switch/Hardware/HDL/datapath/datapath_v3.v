`timescale 1ns / 1ps
// This file is based on the datapath of NetFPGA.
// We add three additional data paths
// 1. Time sync DMA
// 2. PLC IO DMA
// 3. For PS Ethernet interface (newly added in this version)

module datapath_v3 #(
    //Slave AXI parameters
    parameter C_S_AXI_DATA_WIDTH    = 32,          
    parameter C_S_AXI_ADDR_WIDTH    = 16,          

    // Master AXI Stream Data Width
    parameter C_M_AXIS_DATA_WIDTH=256,
    parameter C_S_AXIS_DATA_WIDTH=256,
    parameter C_M_AXIS_TUSER_WIDTH=128,
    parameter C_S_AXIS_TUSER_WIDTH=128,
    parameter NUM_PORTS=4, // number of physical ports
    parameter NUM_QUEUES_PORT=3
)
(
    //Datapath clock
    input                                     axis_aclk,
    input                                     axis_resetn,
    
    // Slave Stream Ports (interface from Rx queues)
    input [C_S_AXIS_DATA_WIDTH - 1:0]         s_axis_0_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_0_tkeep,
    input [C_S_AXIS_TUSER_WIDTH-1:0]          s_axis_0_tuser,
    input                                     s_axis_0_tvalid,
    output                                    s_axis_0_tready,
    input                                     s_axis_0_tlast,
    input [C_S_AXIS_DATA_WIDTH - 1:0]         s_axis_1_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_1_tkeep,
    input [C_S_AXIS_TUSER_WIDTH-1:0]          s_axis_1_tuser,
    input                                     s_axis_1_tvalid,
    output                                    s_axis_1_tready,
    input                                     s_axis_1_tlast,
    input [C_S_AXIS_DATA_WIDTH - 1:0]         s_axis_2_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_2_tkeep,
    input [C_S_AXIS_TUSER_WIDTH-1:0]          s_axis_2_tuser,
    input                                     s_axis_2_tvalid,
    output                                    s_axis_2_tready,
    input                                     s_axis_2_tlast,
    input [C_S_AXIS_DATA_WIDTH - 1:0]         s_axis_3_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_3_tkeep,
    input [C_S_AXIS_TUSER_WIDTH-1:0]          s_axis_3_tuser,
    input                                     s_axis_3_tvalid,
    output                                    s_axis_3_tready,
    input                                     s_axis_3_tlast,

    // From PS, 802.1AS
    input [C_S_AXIS_DATA_WIDTH - 1:0]         s_axis_4_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_4_tkeep,
    input [C_S_AXIS_TUSER_WIDTH-1:0]          s_axis_4_tuser,
    input                                     s_axis_4_tvalid,
    output                                    s_axis_4_tready,
    input                                     s_axis_4_tlast,

    // From PS, PLC
    input [C_S_AXIS_DATA_WIDTH - 1:0]         s_axis_5_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_5_tkeep,
    input [C_S_AXIS_TUSER_WIDTH-1:0]          s_axis_5_tuser,
    input                                     s_axis_5_tvalid,
    output                                    s_axis_5_tready,
    input                                     s_axis_5_tlast,

    // From PS, Ethernet
    input [C_S_AXIS_DATA_WIDTH - 1:0]         s_axis_6_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_6_tkeep,
    input [C_S_AXIS_TUSER_WIDTH-1:0]          s_axis_6_tuser,
    input                                     s_axis_6_tvalid,
    output                                    s_axis_6_tready,
    input                                     s_axis_6_tlast,

    // Master Stream Ports (interface to TX queues)
    output [C_M_AXIS_DATA_WIDTH - 1:0]         m_axis_0_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_0_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]          m_axis_0_tuser,
    output                                     m_axis_0_tvalid,
    input                                      m_axis_0_tready,
    output                                     m_axis_0_tlast,
    output [C_M_AXIS_DATA_WIDTH - 1:0]         m_axis_1_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_1_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]          m_axis_1_tuser,
    output                                     m_axis_1_tvalid,
    input                                      m_axis_1_tready,
    output                                     m_axis_1_tlast,
    output [C_M_AXIS_DATA_WIDTH - 1:0]         m_axis_2_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_2_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]          m_axis_2_tuser,
    output                                     m_axis_2_tvalid,
    input                                      m_axis_2_tready,
    output                                     m_axis_2_tlast,
    output [C_M_AXIS_DATA_WIDTH - 1:0]         m_axis_3_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_3_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]          m_axis_3_tuser,
    output                                     m_axis_3_tvalid,
    input                                      m_axis_3_tready,
    output                                     m_axis_3_tlast,
    // The cpu group axis signal is the first DMA path, for 802.1AS data frames.
    output [C_M_AXIS_DATA_WIDTH - 1:0]         m_axis_cpu_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_cpu_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]          m_axis_cpu_tuser,
    output                                     m_axis_cpu_tvalid,
    input                                      m_axis_cpu_tready,
    output                                     m_axis_cpu_tlast,
    // The plc group axis signal is the second DMA path, for PLC control input and output.
    output [C_M_AXIS_DATA_WIDTH - 1:0]         m_axis_plc_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_plc_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]          m_axis_plc_tuser,
    output                                     m_axis_plc_tvalid,
    input                                      m_axis_plc_tready,
    output                                     m_axis_plc_tlast,
    // To PS Ethernet
    output [C_M_AXIS_DATA_WIDTH - 1:0]         m_axis_6_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_6_tkeep,
    output [C_M_AXIS_TUSER_WIDTH-1:0]          m_axis_6_tuser,
    output                                     m_axis_6_tvalid,
    input                                      m_axis_6_tready,
    output                                     m_axis_6_tlast,

    input [47:0]                               sync_time_ptp_sec,
    input [31:0]                               sync_time_ptp_ns,
    input [63:0]                               sync_time_ptp_ns_mini,

    input                                      gcl_clk_in,
    output[575:0]                              gcl_data_flat,
    input [3:0]                                gcl_ld,
    input [3:0]                                gcl_id,
    input [8:0]                                gcl_ld_data,
    input [3:0]                                gcl_time_ld,
    input [3:0]                                gcl_time_id,
    input [19:0]                               gcl_ld_time,

    // Global Clock Signal
    input wire  S_AXI_ACLK,
    // Global Reset Signal. This Signal is Active LOW
    input wire  S_AXI_ARESETN,
    // Write address (issued by master, acceped by Slave)
    input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
    // Write channel Protection type. This signal indicates the
        // privilege and security level of the transaction, and whether
        // the transaction is a data access or an instruction access.
    input wire [2 : 0] S_AXI_AWPROT,
    // Write address valid. This signal indicates that the master signaling
        // valid write address and control information.
    input wire  S_AXI_AWVALID,
    // Write address ready. This signal indicates that the slave is ready
        // to accept an address and associated control signals.
    output wire  S_AXI_AWREADY,
    // Write data (issued by master, acceped by Slave) 
    input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
    // Write strobes. This signal indicates which byte lanes hold
        // valid data. There is one write strobe bit for each eight
        // bits of the write data bus.    
    input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
    // Write valid. This signal indicates that valid write
        // data and strobes are available.
    input wire  S_AXI_WVALID,
    // Write ready. This signal indicates that the slave
        // can accept the write data.
    output wire  S_AXI_WREADY,
    // Write response. This signal indicates the status
        // of the write transaction.
    output wire [1 : 0] S_AXI_BRESP,
    // Write response valid. This signal indicates that the channel
        // is signaling a valid write response.
    output wire  S_AXI_BVALID,
    // Response ready. This signal indicates that the master
        // can accept a write response.
    input wire  S_AXI_BREADY,
    // Read address (issued by master, acceped by Slave)
    input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
    // Protection type. This signal indicates the privilege
        // and security level of the transaction, and whether the
        // transaction is a data access or an instruction access.
    input wire [2 : 0] S_AXI_ARPROT,
    // Read address valid. This signal indicates that the channel
        // is signaling valid read address and control information.
    input wire  S_AXI_ARVALID,
    // Read address ready. This signal indicates that the slave is
        // ready to accept an address and associated control signals.
    output wire  S_AXI_ARREADY,
    // Read data (issued by slave)
    output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
    // Read response. This signal indicates the status of the
        // read transfer.
    output wire [1 : 0] S_AXI_RRESP,
    // Read valid. This signal indicates that the channel is
        // signaling the required read data.
    output wire  S_AXI_RVALID,
    // Read ready. This signal indicates that the master can
        // accept the read data and response information.
    input wire  S_AXI_RREADY
    );
    
    //internal connectivity
  
    wire [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_opl_tdata;
    wire [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_opl_tkeep;
    wire [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_opl_tuser;
    wire                                      m_axis_opl_tvalid;

    wire                                      m_axis_opl_tready;
    wire                                      m_axis_opl_tlast;
    
    
    reg [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_opl_tdata_reg;
    reg [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_opl_tkeep_reg;
    reg [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_opl_tuser_reg;
    reg                                      m_axis_opl_tvalid_reg;

    // wire                                      m_axis_opl_tready_;
    reg                                      m_axis_opl_tlast_reg;
     
    wire [C_M_AXIS_DATA_WIDTH - 1:0]          s_axis_opl_tdata;
    wire [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  s_axis_opl_tkeep;
    wire [C_M_AXIS_TUSER_WIDTH-1:0]           s_axis_opl_tuser;
    wire                                      s_axis_opl_tvalid;
    wire                                      s_axis_opl_tready;
    wire                                      s_axis_opl_tlast;

    reg [C_M_AXIS_DATA_WIDTH - 1:0]          s_axis_opl_tdata_reg;
    reg [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  s_axis_opl_tkeep_reg;
    reg [C_M_AXIS_TUSER_WIDTH-1:0]           s_axis_opl_tuser_reg;
    reg                                      s_axis_opl_tvalid_reg;
    reg                                      s_axis_opl_tlast_reg;

    wire [C_M_AXIS_DATA_WIDTH - 1:0]          s_axis_learned_opl_tdata;
    wire [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  s_axis_learned_opl_tkeep;
    wire [C_M_AXIS_TUSER_WIDTH-1:0]           s_axis_learned_opl_tuser;
    wire                                      s_axis_learned_opl_tvalid;
    wire                                      s_axis_learned_opl_tready;
    wire                                      s_axis_learned_opl_tlast;

    
    // Currently, only physical ports have multiple frame queues.
    wire [C_M_AXIS_DATA_WIDTH - 1:0]          m_axis_tdata [0:3][0:7];
    wire [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  m_axis_tkeep [0:3][0:7];
    wire [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_tuser [0:3][0:7];
    wire                                      m_axis_tvalid [0:3][0:7];
    wire                                      m_axis_tready [0:3][0:7];
    wire                                      m_axis_tlast [0:3][0:7];

    wire [C_M_AXIS_DATA_WIDTH - 1:0]          port_s_axis_tdata [0:3];
    wire [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0]  port_s_axis_tkeep [0:3];
    wire [C_M_AXIS_TUSER_WIDTH-1:0]           port_s_axis_tuser [0:3];
    wire                                      port_s_axis_tvalid [0:3];
    wire                                      port_s_axis_tready [0:3];
    wire                                      port_s_axis_tlast [0:3];
    wire [143:0]                              port_gcl_data[0:3];


    wire [47:0] dst_mac_0;
    wire [7:0] dst_port_0;
    wire [47:0] dst_mac_1;
    wire [7:0] dst_port_1;
    wire [47:0] dst_mac_2;
    wire [7:0] dst_port_2;
    wire [47:0] dst_mac_3;
    wire [7:0] dst_port_3;
    wire [47:0] dst_mac_4;
    wire [7:0] dst_port_4;
    wire [47:0] dst_mac_5;
    wire [7:0] dst_port_5;
    wire [47:0] dst_mac_6;
    wire [7:0] dst_port_6;
    wire [47:0] dst_mac_7;
    wire [7:0] dst_port_7;
    wire [47:0] dst_mac_8;
    wire [7:0] dst_port_8;
    wire [47:0] dst_mac_9;
    wire [7:0] dst_port_9;
    wire [47:0] dst_mac_10;
    wire [7:0] dst_port_10;
    wire [47:0] dst_mac_11;
    wire [7:0] dst_port_11;
    wire [47:0] dst_mac_12;
    wire [7:0] dst_port_12;
    wire [47:0] dst_mac_13;
    wire [7:0] dst_port_13;
    wire [47:0] dst_mac_14;
    wire [7:0] dst_port_14;
    wire [47:0] dst_mac_15;
    wire [7:0] dst_port_15;
    wire [47:0] dst_mac_16;
    wire [7:0] dst_port_16;
    wire [47:0] dst_mac_17;
    wire [7:0] dst_port_17;
    wire [47:0] dst_mac_18;
    wire [7:0] dst_port_18;
    wire [47:0] dst_mac_19;
    wire [7:0] dst_port_19;
    wire [47:0] dst_mac_20;
    wire [7:0] dst_port_20;
    wire [47:0] dst_mac_21;
    wire [7:0] dst_port_21;
    wire [47:0] dst_mac_22;
    wire [7:0] dst_port_22;
    wire [47:0] dst_mac_23;
    wire [7:0] dst_port_23;
    wire [47:0] dst_mac_24;
    wire [7:0] dst_port_24;
    wire [47:0] dst_mac_25;
    wire [7:0] dst_port_25;
    wire [47:0] dst_mac_26;
    wire [7:0] dst_port_26;
    wire [47:0] dst_mac_27;
    wire [7:0] dst_port_27;
    wire [47:0] dst_mac_28;
    wire [7:0] dst_port_28;
    wire [47:0] dst_mac_29;
    wire [7:0] dst_port_29;
    wire [47:0] dst_mac_30;
    wire [7:0] dst_port_30;
    wire [47:0] dst_mac_31;
    wire [7:0] dst_port_31;
    
    assign gcl_data_flat = {port_gcl_data[3], port_gcl_data[2], port_gcl_data[1], port_gcl_data[0]};

    //Input Arbiter
    input_arbiter_seven_ports #(
        .C_M_AXIS_DATA_WIDTH(C_M_AXIS_DATA_WIDTH),
        .C_M_AXIS_TUSER_WIDTH(C_M_AXIS_TUSER_WIDTH),
        .C_S_AXIS_DATA_WIDTH(C_S_AXIS_DATA_WIDTH),
        .C_S_AXIS_TUSER_WIDTH(C_S_AXIS_TUSER_WIDTH),
        .NUM_QUEUES(NUM_PORTS+3)
    ) 
    input_arbiter_seven_ports_i (
        .axis_aclk(axis_aclk), 
        .axis_resetn_in(axis_resetn), 
        .m_axis_tdata (s_axis_opl_tdata), 
        .m_axis_tkeep (s_axis_opl_tkeep), 
        .m_axis_tuser (s_axis_opl_tuser), 
        .m_axis_tvalid(s_axis_opl_tvalid), 
        .m_axis_tready(s_axis_opl_tready || (~s_axis_opl_tvalid_reg)), 
        .m_axis_tlast (s_axis_opl_tlast), 
        .s_axis_0_tdata (s_axis_0_tdata), 
        .s_axis_0_tkeep (s_axis_0_tkeep), 
        .s_axis_0_tuser (s_axis_0_tuser), 
        .s_axis_0_tvalid(s_axis_0_tvalid), 
        .s_axis_0_tready(s_axis_0_tready), 
        .s_axis_0_tlast (s_axis_0_tlast), 
        .s_axis_1_tdata (s_axis_1_tdata), 
        .s_axis_1_tkeep (s_axis_1_tkeep), 
        .s_axis_1_tuser (s_axis_1_tuser), 
        .s_axis_1_tvalid(s_axis_1_tvalid), 
        .s_axis_1_tready(s_axis_1_tready), 
        .s_axis_1_tlast (s_axis_1_tlast), 
        .s_axis_2_tdata (s_axis_2_tdata), 
        .s_axis_2_tkeep (s_axis_2_tkeep), 
        .s_axis_2_tuser (s_axis_2_tuser), 
        .s_axis_2_tvalid(s_axis_2_tvalid), 
        .s_axis_2_tready(s_axis_2_tready), 
        .s_axis_2_tlast (s_axis_2_tlast), 
        .s_axis_3_tdata (s_axis_3_tdata), 
        .s_axis_3_tkeep (s_axis_3_tkeep), 
        .s_axis_3_tuser (s_axis_3_tuser), 
        .s_axis_3_tvalid(s_axis_3_tvalid), 
        .s_axis_3_tready(s_axis_3_tready), 
        .s_axis_3_tlast (s_axis_3_tlast), 
        .s_axis_4_tdata (s_axis_4_tdata), 
        .s_axis_4_tkeep (s_axis_4_tkeep), 
        .s_axis_4_tuser (s_axis_4_tuser), 
        .s_axis_4_tvalid(s_axis_4_tvalid), 
        .s_axis_4_tready(s_axis_4_tready), 
        .s_axis_4_tlast (s_axis_4_tlast), 
        .s_axis_5_tdata (s_axis_5_tdata), 
        .s_axis_5_tkeep (s_axis_5_tkeep), 
        .s_axis_5_tuser (s_axis_5_tuser), 
        .s_axis_5_tvalid(s_axis_5_tvalid), 
        .s_axis_5_tready(s_axis_5_tready), 
        .s_axis_5_tlast (s_axis_5_tlast), 
        .s_axis_6_tdata (s_axis_6_tdata), 
        .s_axis_6_tkeep (s_axis_6_tkeep), 
        .s_axis_6_tuser (s_axis_6_tuser), 
        .s_axis_6_tvalid(s_axis_6_tvalid), 
        .s_axis_6_tready(s_axis_6_tready), 
        .s_axis_6_tlast (s_axis_6_tlast), 
        .pkt_fwd() 
    );

    wire reg_enable1 = s_axis_opl_tready || (~s_axis_opl_tvalid_reg);
    
    // Pipeline axis to break long path that cause failed timing.
    always @(posedge axis_aclk) begin
        if (reg_enable1) begin
            s_axis_opl_tdata_reg  <= s_axis_opl_tdata;
            s_axis_opl_tkeep_reg  <= s_axis_opl_tkeep;
            s_axis_opl_tuser_reg  <= s_axis_opl_tuser;
            s_axis_opl_tvalid_reg <= s_axis_opl_tvalid;
            s_axis_opl_tlast_reg  <= s_axis_opl_tlast;
        end
    end

    
    switch_lite_output_port_lookup output_port_lookup_1  (
        .axis_aclk(axis_aclk), 
        .axis_resetn(axis_resetn), 
        .m_axis_tdata (s_axis_learned_opl_tdata), 
        .m_axis_tkeep (s_axis_learned_opl_tkeep), 
        .m_axis_tuser (s_axis_learned_opl_tuser), 
        .m_axis_tvalid(s_axis_learned_opl_tvalid), 
        .m_axis_tready(s_axis_learned_opl_tready), 
        .m_axis_tlast (s_axis_learned_opl_tlast), 
        .s_axis_tdata (s_axis_opl_tdata_reg),
        .s_axis_tkeep (s_axis_opl_tkeep_reg),
        .s_axis_tuser (s_axis_opl_tuser_reg),
        .s_axis_tvalid(s_axis_opl_tvalid_reg),
        .s_axis_tready(s_axis_opl_tready),
        .s_axis_tlast (s_axis_opl_tlast_reg)
    );

    configurable_output_port_lookup output_port_lookup_i (
        .axis_aclk(axis_aclk), 
        .axis_resetn(axis_resetn), 
        .m_axis_tdata (m_axis_opl_tdata), 
        .m_axis_tkeep (m_axis_opl_tkeep), 
        .m_axis_tuser (m_axis_opl_tuser), 
        .m_axis_tvalid(m_axis_opl_tvalid), 
        .m_axis_tready(m_axis_opl_tready || (~m_axis_opl_tvalid_reg)), 
        // .m_axis_tready(m_axis_opl_tready), 
        .m_axis_tlast (m_axis_opl_tlast), 
        .s_axis_tdata (s_axis_learned_opl_tdata), 
        .s_axis_tkeep (s_axis_learned_opl_tkeep), 
        .s_axis_tuser (s_axis_learned_opl_tuser), 
        .s_axis_tvalid(s_axis_learned_opl_tvalid), 
        .s_axis_tready(s_axis_learned_opl_tready), 
        .s_axis_tlast (s_axis_learned_opl_tlast),

        .dst_mac_0(dst_mac_0),
        .dst_port_0(dst_port_0),
        .dst_mac_1(dst_mac_1),
        .dst_port_1(dst_port_1),
        .dst_mac_2(dst_mac_2),
        .dst_port_2(dst_port_2),
        .dst_mac_3(dst_mac_3),
        .dst_port_3(dst_port_3),
        .dst_mac_4(dst_mac_4),
        .dst_port_4(dst_port_4),
        .dst_mac_5(dst_mac_5),
        .dst_port_5(dst_port_5),
        .dst_mac_6(dst_mac_6),
        .dst_port_6(dst_port_6),
        .dst_mac_7(dst_mac_7),
        .dst_port_7(dst_port_7),
        .dst_mac_8(dst_mac_8),
        .dst_port_8(dst_port_8),
        .dst_mac_9(dst_mac_9),
        .dst_port_9(dst_port_9),
        .dst_mac_10(dst_mac_10),
        .dst_port_10(dst_port_10),
        .dst_mac_11(dst_mac_11),
        .dst_port_11(dst_port_11),
        .dst_mac_12(dst_mac_12),
        .dst_port_12(dst_port_12),
        .dst_mac_13(dst_mac_13),
        .dst_port_13(dst_port_13),
        .dst_mac_14(dst_mac_14),
        .dst_port_14(dst_port_14),
        .dst_mac_15(dst_mac_15),
        .dst_port_15(dst_port_15),
        .dst_mac_16(dst_mac_16),
        .dst_port_16(dst_port_16),
        .dst_mac_17(dst_mac_17),
        .dst_port_17(dst_port_17),
        .dst_mac_18(dst_mac_18),
        .dst_port_18(dst_port_18),
        .dst_mac_19(dst_mac_19),
        .dst_port_19(dst_port_19),
        .dst_mac_20(dst_mac_20),
        .dst_port_20(dst_port_20),
        .dst_mac_21(dst_mac_21),
        .dst_port_21(dst_port_21),
        .dst_mac_22(dst_mac_22),
        .dst_port_22(dst_port_22),
        .dst_mac_23(dst_mac_23),
        .dst_port_23(dst_port_23),
        .dst_mac_24(dst_mac_24),
        .dst_port_24(dst_port_24),
        .dst_mac_25(dst_mac_25),
        .dst_port_25(dst_port_25),
        .dst_mac_26(dst_mac_26),
        .dst_port_26(dst_port_26),
        .dst_mac_27(dst_mac_27),
        .dst_port_27(dst_port_27),
        .dst_mac_28(dst_mac_28),
        .dst_port_28(dst_port_28),
        .dst_mac_29(dst_mac_29),
        .dst_port_29(dst_port_29),
        .dst_mac_30(dst_mac_30),
        .dst_port_30(dst_port_30),
        .dst_mac_31(dst_mac_31),
        .dst_port_31(dst_port_31)
    );

    wire reg_enable = m_axis_opl_tready || (~m_axis_opl_tvalid_reg);
    
    // Pipeline axis to break long path that cause failed timing.
    always @(posedge axis_aclk) begin
        if (reg_enable) begin
            m_axis_opl_tdata_reg <= m_axis_opl_tdata;
            m_axis_opl_tkeep_reg <= m_axis_opl_tkeep;
            m_axis_opl_tuser_reg <= m_axis_opl_tuser;
            m_axis_opl_tvalid_reg <= m_axis_opl_tvalid;
            m_axis_opl_tlast_reg <= m_axis_opl_tlast;
        end
    end

    wire [NUM_PORTS * NUM_QUEUES_PORT + 2:0] output_queue_pkt_drop;

    // Output queues
    output_queues_v3 #(
        .NUM_PORTS(NUM_PORTS),
        .NUM_QUEUES_PORT(NUM_QUEUES_PORT)
    ) output_queues_v3_i (
        .axis_aclk(axis_aclk), 
        .axis_resetn(axis_resetn), 
        .s_axis_tdata   (m_axis_opl_tdata_reg), 
        .s_axis_tkeep   (m_axis_opl_tkeep_reg), 
        .s_axis_tuser   (m_axis_opl_tuser_reg), 
        .s_axis_tvalid  (m_axis_opl_tvalid_reg), 
        .s_axis_tready  (m_axis_opl_tready), 
        .s_axis_tlast   (m_axis_opl_tlast_reg), 
      
        .m_axis_0_0_tdata(m_axis_tdata[0][0]),
        .m_axis_0_0_tkeep(m_axis_tkeep[0][0]),
        .m_axis_0_0_tuser(m_axis_tuser[0][0]),
        .m_axis_0_0_tvalid(m_axis_tvalid[0][0]),
        .m_axis_0_0_tready(m_axis_tready[0][0]),
        .m_axis_0_0_tlast(m_axis_tlast[0][0]),
        .m_axis_0_1_tdata(m_axis_tdata[0][1]),
        .m_axis_0_1_tkeep(m_axis_tkeep[0][1]),
        .m_axis_0_1_tuser(m_axis_tuser[0][1]),
        .m_axis_0_1_tvalid(m_axis_tvalid[0][1]),
        .m_axis_0_1_tready(m_axis_tready[0][1]),
        .m_axis_0_1_tlast(m_axis_tlast[0][1]),
        .m_axis_0_2_tdata(m_axis_tdata[0][2]),
        .m_axis_0_2_tkeep(m_axis_tkeep[0][2]),
        .m_axis_0_2_tuser(m_axis_tuser[0][2]),
        .m_axis_0_2_tvalid(m_axis_tvalid[0][2]),
        .m_axis_0_2_tready(m_axis_tready[0][2]),
        .m_axis_0_2_tlast(m_axis_tlast[0][2]),
        .m_axis_0_3_tdata(m_axis_tdata[0][3]),
        .m_axis_0_3_tkeep(m_axis_tkeep[0][3]),
        .m_axis_0_3_tuser(m_axis_tuser[0][3]),
        .m_axis_0_3_tvalid(m_axis_tvalid[0][3]),
        .m_axis_0_3_tready(m_axis_tready[0][3]),
        .m_axis_0_3_tlast(m_axis_tlast[0][3]),
        .m_axis_0_4_tdata(m_axis_tdata[0][4]),
        .m_axis_0_4_tkeep(m_axis_tkeep[0][4]),
        .m_axis_0_4_tuser(m_axis_tuser[0][4]),
        .m_axis_0_4_tvalid(m_axis_tvalid[0][4]),
        .m_axis_0_4_tready(m_axis_tready[0][4]),
        .m_axis_0_4_tlast(m_axis_tlast[0][4]),
        .m_axis_0_5_tdata(m_axis_tdata[0][5]),
        .m_axis_0_5_tkeep(m_axis_tkeep[0][5]),
        .m_axis_0_5_tuser(m_axis_tuser[0][5]),
        .m_axis_0_5_tvalid(m_axis_tvalid[0][5]),
        .m_axis_0_5_tready(m_axis_tready[0][5]),
        .m_axis_0_5_tlast(m_axis_tlast[0][5]),
        .m_axis_0_6_tdata(m_axis_tdata[0][6]),
        .m_axis_0_6_tkeep(m_axis_tkeep[0][6]),
        .m_axis_0_6_tuser(m_axis_tuser[0][6]),
        .m_axis_0_6_tvalid(m_axis_tvalid[0][6]),
        .m_axis_0_6_tready(m_axis_tready[0][6]),
        .m_axis_0_6_tlast(m_axis_tlast[0][6]),
        .m_axis_0_7_tdata(m_axis_tdata[0][7]),
        .m_axis_0_7_tkeep(m_axis_tkeep[0][7]),
        .m_axis_0_7_tuser(m_axis_tuser[0][7]),
        .m_axis_0_7_tvalid(m_axis_tvalid[0][7]),
        .m_axis_0_7_tready(m_axis_tready[0][7]),
        .m_axis_0_7_tlast(m_axis_tlast[0][7]),
        .m_axis_1_0_tdata(m_axis_tdata[1][0]),
        .m_axis_1_0_tkeep(m_axis_tkeep[1][0]),
        .m_axis_1_0_tuser(m_axis_tuser[1][0]),
        .m_axis_1_0_tvalid(m_axis_tvalid[1][0]),
        .m_axis_1_0_tready(m_axis_tready[1][0]),
        .m_axis_1_0_tlast(m_axis_tlast[1][0]),
        .m_axis_1_1_tdata(m_axis_tdata[1][1]),
        .m_axis_1_1_tkeep(m_axis_tkeep[1][1]),
        .m_axis_1_1_tuser(m_axis_tuser[1][1]),
        .m_axis_1_1_tvalid(m_axis_tvalid[1][1]),
        .m_axis_1_1_tready(m_axis_tready[1][1]),
        .m_axis_1_1_tlast(m_axis_tlast[1][1]),
        .m_axis_1_2_tdata(m_axis_tdata[1][2]),
        .m_axis_1_2_tkeep(m_axis_tkeep[1][2]),
        .m_axis_1_2_tuser(m_axis_tuser[1][2]),
        .m_axis_1_2_tvalid(m_axis_tvalid[1][2]),
        .m_axis_1_2_tready(m_axis_tready[1][2]),
        .m_axis_1_2_tlast(m_axis_tlast[1][2]),
        .m_axis_1_3_tdata(m_axis_tdata[1][3]),
        .m_axis_1_3_tkeep(m_axis_tkeep[1][3]),
        .m_axis_1_3_tuser(m_axis_tuser[1][3]),
        .m_axis_1_3_tvalid(m_axis_tvalid[1][3]),
        .m_axis_1_3_tready(m_axis_tready[1][3]),
        .m_axis_1_3_tlast(m_axis_tlast[1][3]),
        .m_axis_1_4_tdata(m_axis_tdata[1][4]),
        .m_axis_1_4_tkeep(m_axis_tkeep[1][4]),
        .m_axis_1_4_tuser(m_axis_tuser[1][4]),
        .m_axis_1_4_tvalid(m_axis_tvalid[1][4]),
        .m_axis_1_4_tready(m_axis_tready[1][4]),
        .m_axis_1_4_tlast(m_axis_tlast[1][4]),
        .m_axis_1_5_tdata(m_axis_tdata[1][5]),
        .m_axis_1_5_tkeep(m_axis_tkeep[1][5]),
        .m_axis_1_5_tuser(m_axis_tuser[1][5]),
        .m_axis_1_5_tvalid(m_axis_tvalid[1][5]),
        .m_axis_1_5_tready(m_axis_tready[1][5]),
        .m_axis_1_5_tlast(m_axis_tlast[1][5]),
        .m_axis_1_6_tdata(m_axis_tdata[1][6]),
        .m_axis_1_6_tkeep(m_axis_tkeep[1][6]),
        .m_axis_1_6_tuser(m_axis_tuser[1][6]),
        .m_axis_1_6_tvalid(m_axis_tvalid[1][6]),
        .m_axis_1_6_tready(m_axis_tready[1][6]),
        .m_axis_1_6_tlast(m_axis_tlast[1][6]),
        .m_axis_1_7_tdata(m_axis_tdata[1][7]),
        .m_axis_1_7_tkeep(m_axis_tkeep[1][7]),
        .m_axis_1_7_tuser(m_axis_tuser[1][7]),
        .m_axis_1_7_tvalid(m_axis_tvalid[1][7]),
        .m_axis_1_7_tready(m_axis_tready[1][7]),
        .m_axis_1_7_tlast(m_axis_tlast[1][7]),
        .m_axis_2_0_tdata(m_axis_tdata[2][0]),
        .m_axis_2_0_tkeep(m_axis_tkeep[2][0]),
        .m_axis_2_0_tuser(m_axis_tuser[2][0]),
        .m_axis_2_0_tvalid(m_axis_tvalid[2][0]),
        .m_axis_2_0_tready(m_axis_tready[2][0]),
        .m_axis_2_0_tlast(m_axis_tlast[2][0]),
        .m_axis_2_1_tdata(m_axis_tdata[2][1]),
        .m_axis_2_1_tkeep(m_axis_tkeep[2][1]),
        .m_axis_2_1_tuser(m_axis_tuser[2][1]),
        .m_axis_2_1_tvalid(m_axis_tvalid[2][1]),
        .m_axis_2_1_tready(m_axis_tready[2][1]),
        .m_axis_2_1_tlast(m_axis_tlast[2][1]),
        .m_axis_2_2_tdata(m_axis_tdata[2][2]),
        .m_axis_2_2_tkeep(m_axis_tkeep[2][2]),
        .m_axis_2_2_tuser(m_axis_tuser[2][2]),
        .m_axis_2_2_tvalid(m_axis_tvalid[2][2]),
        .m_axis_2_2_tready(m_axis_tready[2][2]),
        .m_axis_2_2_tlast(m_axis_tlast[2][2]),
        .m_axis_2_3_tdata(m_axis_tdata[2][3]),
        .m_axis_2_3_tkeep(m_axis_tkeep[2][3]),
        .m_axis_2_3_tuser(m_axis_tuser[2][3]),
        .m_axis_2_3_tvalid(m_axis_tvalid[2][3]),
        .m_axis_2_3_tready(m_axis_tready[2][3]),
        .m_axis_2_3_tlast(m_axis_tlast[2][3]),
        .m_axis_2_4_tdata(m_axis_tdata[2][4]),
        .m_axis_2_4_tkeep(m_axis_tkeep[2][4]),
        .m_axis_2_4_tuser(m_axis_tuser[2][4]),
        .m_axis_2_4_tvalid(m_axis_tvalid[2][4]),
        .m_axis_2_4_tready(m_axis_tready[2][4]),
        .m_axis_2_4_tlast(m_axis_tlast[2][4]),
        .m_axis_2_5_tdata(m_axis_tdata[2][5]),
        .m_axis_2_5_tkeep(m_axis_tkeep[2][5]),
        .m_axis_2_5_tuser(m_axis_tuser[2][5]),
        .m_axis_2_5_tvalid(m_axis_tvalid[2][5]),
        .m_axis_2_5_tready(m_axis_tready[2][5]),
        .m_axis_2_5_tlast(m_axis_tlast[2][5]),
        .m_axis_2_6_tdata(m_axis_tdata[2][6]),
        .m_axis_2_6_tkeep(m_axis_tkeep[2][6]),
        .m_axis_2_6_tuser(m_axis_tuser[2][6]),
        .m_axis_2_6_tvalid(m_axis_tvalid[2][6]),
        .m_axis_2_6_tready(m_axis_tready[2][6]),
        .m_axis_2_6_tlast(m_axis_tlast[2][6]),
        .m_axis_2_7_tdata(m_axis_tdata[2][7]),
        .m_axis_2_7_tkeep(m_axis_tkeep[2][7]),
        .m_axis_2_7_tuser(m_axis_tuser[2][7]),
        .m_axis_2_7_tvalid(m_axis_tvalid[2][7]),
        .m_axis_2_7_tready(m_axis_tready[2][7]),
        .m_axis_2_7_tlast(m_axis_tlast[2][7]),
        .m_axis_3_0_tdata(m_axis_tdata[3][0]),
        .m_axis_3_0_tkeep(m_axis_tkeep[3][0]),
        .m_axis_3_0_tuser(m_axis_tuser[3][0]),
        .m_axis_3_0_tvalid(m_axis_tvalid[3][0]),
        .m_axis_3_0_tready(m_axis_tready[3][0]),
        .m_axis_3_0_tlast(m_axis_tlast[3][0]),
        .m_axis_3_1_tdata(m_axis_tdata[3][1]),
        .m_axis_3_1_tkeep(m_axis_tkeep[3][1]),
        .m_axis_3_1_tuser(m_axis_tuser[3][1]),
        .m_axis_3_1_tvalid(m_axis_tvalid[3][1]),
        .m_axis_3_1_tready(m_axis_tready[3][1]),
        .m_axis_3_1_tlast(m_axis_tlast[3][1]),
        .m_axis_3_2_tdata(m_axis_tdata[3][2]),
        .m_axis_3_2_tkeep(m_axis_tkeep[3][2]),
        .m_axis_3_2_tuser(m_axis_tuser[3][2]),
        .m_axis_3_2_tvalid(m_axis_tvalid[3][2]),
        .m_axis_3_2_tready(m_axis_tready[3][2]),
        .m_axis_3_2_tlast(m_axis_tlast[3][2]),
        .m_axis_3_3_tdata(m_axis_tdata[3][3]),
        .m_axis_3_3_tkeep(m_axis_tkeep[3][3]),
        .m_axis_3_3_tuser(m_axis_tuser[3][3]),
        .m_axis_3_3_tvalid(m_axis_tvalid[3][3]),
        .m_axis_3_3_tready(m_axis_tready[3][3]),
        .m_axis_3_3_tlast(m_axis_tlast[3][3]),
        .m_axis_3_4_tdata(m_axis_tdata[3][4]),
        .m_axis_3_4_tkeep(m_axis_tkeep[3][4]),
        .m_axis_3_4_tuser(m_axis_tuser[3][4]),
        .m_axis_3_4_tvalid(m_axis_tvalid[3][4]),
        .m_axis_3_4_tready(m_axis_tready[3][4]),
        .m_axis_3_4_tlast(m_axis_tlast[3][4]),
        .m_axis_3_5_tdata(m_axis_tdata[3][5]),
        .m_axis_3_5_tkeep(m_axis_tkeep[3][5]),
        .m_axis_3_5_tuser(m_axis_tuser[3][5]),
        .m_axis_3_5_tvalid(m_axis_tvalid[3][5]),
        .m_axis_3_5_tready(m_axis_tready[3][5]),
        .m_axis_3_5_tlast(m_axis_tlast[3][5]),
        .m_axis_3_6_tdata(m_axis_tdata[3][6]),
        .m_axis_3_6_tkeep(m_axis_tkeep[3][6]),
        .m_axis_3_6_tuser(m_axis_tuser[3][6]),
        .m_axis_3_6_tvalid(m_axis_tvalid[3][6]),
        .m_axis_3_6_tready(m_axis_tready[3][6]),
        .m_axis_3_6_tlast(m_axis_tlast[3][6]),
        .m_axis_3_7_tdata(m_axis_tdata[3][7]),
        .m_axis_3_7_tkeep(m_axis_tkeep[3][7]),
        .m_axis_3_7_tuser(m_axis_tuser[3][7]),
        .m_axis_3_7_tvalid(m_axis_tvalid[3][7]),
        .m_axis_3_7_tready(m_axis_tready[3][7]),
        .m_axis_3_7_tlast(m_axis_tlast[3][7]),
        .m_axis_cpu_tdata(m_axis_cpu_tdata),
        .m_axis_cpu_tkeep(m_axis_cpu_tkeep),
        .m_axis_cpu_tuser(m_axis_cpu_tuser),
        .m_axis_cpu_tvalid(m_axis_cpu_tvalid),
        .m_axis_cpu_tready(m_axis_cpu_tready),
        .m_axis_cpu_tlast(m_axis_cpu_tlast),
        .m_axis_plc_tdata(m_axis_plc_tdata),
        .m_axis_plc_tkeep(m_axis_plc_tkeep),
        .m_axis_plc_tuser(m_axis_plc_tuser),
        .m_axis_plc_tvalid(m_axis_plc_tvalid),
        .m_axis_plc_tready(m_axis_plc_tready),
        .m_axis_plc_tlast(m_axis_plc_tlast),
        .m_axis_6_tdata(m_axis_6_tdata),
        .m_axis_6_tkeep(m_axis_6_tkeep),
        .m_axis_6_tuser(m_axis_6_tuser),
        .m_axis_6_tvalid(m_axis_6_tvalid),
        .m_axis_6_tready(m_axis_6_tready),
        .m_axis_6_tlast(m_axis_6_tlast),

        .bytes_stored(), 
        .pkt_stored(), 
        .bytes_removed_0(), 
        .bytes_removed_1(), 
        .bytes_removed_2(), 
        .bytes_removed_3(), 
        .bytes_removed_4(), 
        .bytes_removed_5(), 
        .bytes_removed_6(), 
        .bytes_removed_7(), 
        .bytes_removed_8(), 
        .pkt_removed_0(), 
        .pkt_removed_1(), 
        .pkt_removed_2(), 
        .pkt_removed_3(), 
        .pkt_removed_4(), 
        .pkt_removed_5(), 
        .pkt_removed_6(), 
        .pkt_removed_7(), 
        .pkt_removed_8(), 
        .bytes_dropped(), 
        .pkt_dropped(output_queue_pkt_drop)
    ); 
    
    generate
        genvar i;
        for (i = 0; i < NUM_PORTS; i = i + 1) begin
            transmission_selection #(
                .AXIS_DATA_WIDTH(C_M_AXIS_DATA_WIDTH),
                .AXIS_TUSER_WIDTH(C_M_AXIS_TUSER_WIDTH),
                .NUM_QUEUES_PORT(NUM_QUEUES_PORT)
            )
            transmission_selection_i (
                .axis_aclk(axis_aclk),
                .axis_reset_in(~axis_resetn),

                .m_axis_0_tdata(m_axis_tdata[i][0]),
                .m_axis_0_tkeep(m_axis_tkeep[i][0]),
                .m_axis_0_tuser(m_axis_tuser[i][0]),
                .m_axis_0_tvalid(m_axis_tvalid[i][0]),
                .m_axis_0_tready(m_axis_tready[i][0]),
                .m_axis_0_tlast(m_axis_tlast[i][0]),
                
                .m_axis_1_tdata(m_axis_tdata[i][1]),
                .m_axis_1_tkeep(m_axis_tkeep[i][1]),
                .m_axis_1_tuser(m_axis_tuser[i][1]),
                .m_axis_1_tvalid(m_axis_tvalid[i][1]),
                .m_axis_1_tready(m_axis_tready[i][1]),
                .m_axis_1_tlast(m_axis_tlast[i][1]),

                .m_axis_2_tdata(m_axis_tdata[i][2]),
                .m_axis_2_tkeep(m_axis_tkeep[i][2]),
                .m_axis_2_tuser(m_axis_tuser[i][2]),
                .m_axis_2_tvalid(m_axis_tvalid[i][2]),
                .m_axis_2_tready(m_axis_tready[i][2]),
                .m_axis_2_tlast(m_axis_tlast[i][2]),

                .m_axis_3_tdata(m_axis_tdata[i][3]),
                .m_axis_3_tkeep(m_axis_tkeep[i][3]),
                .m_axis_3_tuser(m_axis_tuser[i][3]),
                .m_axis_3_tvalid(m_axis_tvalid[i][3]),
                .m_axis_3_tready(m_axis_tready[i][3]),
                .m_axis_3_tlast(m_axis_tlast[i][3]),

                .m_axis_4_tdata(m_axis_tdata[i][4]),
                .m_axis_4_tkeep(m_axis_tkeep[i][4]),
                .m_axis_4_tuser(m_axis_tuser[i][4]),
                .m_axis_4_tvalid(m_axis_tvalid[i][4]),
                .m_axis_4_tready(m_axis_tready[i][4]),
                .m_axis_4_tlast(m_axis_tlast[i][4]),

                .m_axis_5_tdata(m_axis_tdata[i][5]),
                .m_axis_5_tkeep(m_axis_tkeep[i][5]),
                .m_axis_5_tuser(m_axis_tuser[i][5]),
                .m_axis_5_tvalid(m_axis_tvalid[i][5]),
                .m_axis_5_tready(m_axis_tready[i][5]),
                .m_axis_5_tlast(m_axis_tlast[i][5]),

                .m_axis_6_tdata(m_axis_tdata[i][6]),
                .m_axis_6_tkeep(m_axis_tkeep[i][6]),
                .m_axis_6_tuser(m_axis_tuser[i][6]),
                .m_axis_6_tvalid(m_axis_tvalid[i][6]),
                .m_axis_6_tready(m_axis_tready[i][6]),
                .m_axis_6_tlast(m_axis_tlast[i][6]),

                .m_axis_7_tdata(m_axis_tdata[i][7]),
                .m_axis_7_tkeep(m_axis_tkeep[i][7]),
                .m_axis_7_tuser(m_axis_tuser[i][7]),
                .m_axis_7_tvalid(m_axis_tvalid[i][7]),
                .m_axis_7_tready(m_axis_tready[i][7]),
                .m_axis_7_tlast(m_axis_tlast[i][7]),
                
                .s_axis_tdata(port_s_axis_tdata[i]),
                .s_axis_tkeep(port_s_axis_tkeep[i]),
                .s_axis_tuser(port_s_axis_tuser[i]),
                .s_axis_tvalid(port_s_axis_tvalid[i]),
                .s_axis_tready(port_s_axis_tready[i]),
                .s_axis_tlast(port_s_axis_tlast[i]),
                
                .sync_time_ptp_sec(sync_time_ptp_sec),
                .sync_time_ptp_ns(sync_time_ptp_ns),
                .sync_time_ptp_ns_mini(sync_time_ptp_ns_mini),
                
                .gcl_clk_in(gcl_clk_in),
                .gcl_rd_data(port_gcl_data[i]),
                .gcl_ld(gcl_ld[i]),
                .gcl_id(gcl_id),
                .gcl_ld_data(gcl_ld_data),
                .gcl_time_ld(gcl_time_ld[i]),
                .gcl_time_id(gcl_time_id),
                .gcl_ld_time(gcl_ld_time)

            );
        end
    endgenerate    
    
    assign m_axis_0_tdata = port_s_axis_tdata[0];
    assign m_axis_0_tkeep = port_s_axis_tkeep[0];
    assign m_axis_0_tuser = port_s_axis_tuser[0];
    assign m_axis_0_tvalid = port_s_axis_tvalid[0];
    assign port_s_axis_tready[0] = m_axis_0_tready;
    assign m_axis_0_tlast = port_s_axis_tlast[0];

    assign m_axis_1_tdata = port_s_axis_tdata[1];
    assign m_axis_1_tkeep = port_s_axis_tkeep[1];
    assign m_axis_1_tuser = port_s_axis_tuser[1];
    assign m_axis_1_tvalid = port_s_axis_tvalid[1];
    assign port_s_axis_tready[1] = m_axis_1_tready;
    assign m_axis_1_tlast = port_s_axis_tlast[1];

    assign m_axis_2_tdata = port_s_axis_tdata[2];
    assign m_axis_2_tkeep = port_s_axis_tkeep[2];
    assign m_axis_2_tuser = port_s_axis_tuser[2];
    assign m_axis_2_tvalid = port_s_axis_tvalid[2];
    assign port_s_axis_tready[2] = m_axis_2_tready;
    assign m_axis_2_tlast = port_s_axis_tlast[2];

    assign m_axis_3_tdata = port_s_axis_tdata[3];
    assign m_axis_3_tkeep = port_s_axis_tkeep[3];
    assign m_axis_3_tuser = port_s_axis_tuser[3];
    assign m_axis_3_tvalid = port_s_axis_tvalid[3];
    assign port_s_axis_tready[3] = m_axis_3_tready;
    assign m_axis_3_tlast = port_s_axis_tlast[3];

    datapath_registers #(
        .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
        .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
    ) datapath_registers_i (
        .dst_mac_0(dst_mac_0),
        .dst_port_0(dst_port_0),
        .dst_mac_1(dst_mac_1),
        .dst_port_1(dst_port_1),
        .dst_mac_2(dst_mac_2),
        .dst_port_2(dst_port_2),
        .dst_mac_3(dst_mac_3),
        .dst_port_3(dst_port_3),
        .dst_mac_4(dst_mac_4),
        .dst_port_4(dst_port_4),
        .dst_mac_5(dst_mac_5),
        .dst_port_5(dst_port_5),
        .dst_mac_6(dst_mac_6),
        .dst_port_6(dst_port_6),
        .dst_mac_7(dst_mac_7),
        .dst_port_7(dst_port_7),
        .dst_mac_8(dst_mac_8),
        .dst_port_8(dst_port_8),
        .dst_mac_9(dst_mac_9),
        .dst_port_9(dst_port_9),
        .dst_mac_10(dst_mac_10),
        .dst_port_10(dst_port_10),
        .dst_mac_11(dst_mac_11),
        .dst_port_11(dst_port_11),
        .dst_mac_12(dst_mac_12),
        .dst_port_12(dst_port_12),
        .dst_mac_13(dst_mac_13),
        .dst_port_13(dst_port_13),
        .dst_mac_14(dst_mac_14),
        .dst_port_14(dst_port_14),
        .dst_mac_15(dst_mac_15),
        .dst_port_15(dst_port_15),
        .dst_mac_16(dst_mac_16),
        .dst_port_16(dst_port_16),
        .dst_mac_17(dst_mac_17),
        .dst_port_17(dst_port_17),
        .dst_mac_18(dst_mac_18),
        .dst_port_18(dst_port_18),
        .dst_mac_19(dst_mac_19),
        .dst_port_19(dst_port_19),
        .dst_mac_20(dst_mac_20),
        .dst_port_20(dst_port_20),
        .dst_mac_21(dst_mac_21),
        .dst_port_21(dst_port_21),
        .dst_mac_22(dst_mac_22),
        .dst_port_22(dst_port_22),
        .dst_mac_23(dst_mac_23),
        .dst_port_23(dst_port_23),
        .dst_mac_24(dst_mac_24),
        .dst_port_24(dst_port_24),
        .dst_mac_25(dst_mac_25),
        .dst_port_25(dst_port_25),
        .dst_mac_26(dst_mac_26),
        .dst_port_26(dst_port_26),
        .dst_mac_27(dst_mac_27),
        .dst_port_27(dst_port_27),
        .dst_mac_28(dst_mac_28),
        .dst_port_28(dst_port_28),
        .dst_mac_29(dst_mac_29),
        .dst_port_29(dst_port_29),
        .dst_mac_30(dst_mac_30),
        .dst_port_30(dst_port_30),
        .dst_mac_31(dst_mac_31),
        .dst_port_31(dst_port_31),

        .S_AXI_ACLK(S_AXI_ACLK),
        .S_AXI_ARESETN(S_AXI_ARESETN),
        .S_AXI_AWADDR(S_AXI_AWADDR),
        .S_AXI_AWPROT(S_AXI_AWPROT),
        .S_AXI_AWVALID(S_AXI_AWVALID),
        .S_AXI_AWREADY(S_AXI_AWREADY),
        .S_AXI_WDATA(S_AXI_WDATA),
        .S_AXI_WSTRB(S_AXI_WSTRB),
        .S_AXI_WVALID(S_AXI_WVALID),
        .S_AXI_WREADY(S_AXI_WREADY),
        .S_AXI_BRESP(S_AXI_BRESP),
        .S_AXI_BVALID(S_AXI_BVALID),
        .S_AXI_BREADY(S_AXI_BREADY),
        .S_AXI_ARADDR(S_AXI_ARADDR),
        .S_AXI_ARPROT(S_AXI_ARPROT),
        .S_AXI_ARVALID(S_AXI_ARVALID),
        .S_AXI_ARREADY(S_AXI_ARREADY),
        .S_AXI_RDATA(S_AXI_RDATA),
        .S_AXI_RRESP(S_AXI_RRESP),
        .S_AXI_RVALID(S_AXI_RVALID),
        .S_AXI_RREADY(S_AXI_RREADY)
    );
endmodule

