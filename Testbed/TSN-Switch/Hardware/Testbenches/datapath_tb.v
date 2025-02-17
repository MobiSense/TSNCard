`timescale 1ns/1ps

module datapath_tb ();

// Local parameters
localparam ONE_NS = 1;
localparam time PER_125M_clk = 8*ONE_NS; // 8 ns clock

localparam AXIS_DATA_WIDTH = 256;
localparam AXIS_TUSER_WIDTH = 128;

// Reg declarations
reg clk = 1;
reg reset = 1;
reg [31:0] sync_time_ptp_ns;

// Clock signals
always begin
    clk = #(PER_125M_clk/2) ~clk;
end

always @(posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
        sync_time_ptp_ns = 0;
    end
    else begin
        sync_time_ptp_ns = (sync_time_ptp_ns + 8) % 1_000_000_000;
    end
end

initial begin
    m_axis_tready = 5'b00000;
    reset = 1;
    #(PER_125M_clk*16);
    reset = 0;
    #(PER_125M_clk*16);
    m_axis_tready = 5'b11111;
end
    
wire [AXIS_DATA_WIDTH-1:0] s_axis_tdata[0:4];
wire [(AXIS_DATA_WIDTH/8)-1:0] s_axis_tkeep[0:4];
wire [AXIS_TUSER_WIDTH-1:0] s_axis_tuser[0:4];
wire [4:0] s_axis_tvalid;
wire [4:0] s_axis_tready;
wire [4:0] s_axis_tlast;

wire [AXIS_DATA_WIDTH-1:0] m_axis_tdata[0:4];
wire [(AXIS_DATA_WIDTH/8)-1:0] m_axis_tkeep[0:4];
wire [AXIS_TUSER_WIDTH-1:0] m_axis_tuser[0:4];
wire [4:0] m_axis_tvalid;
reg [4:0] m_axis_tready;
wire [4:0] m_axis_tlast;

wire [11:0]   M01_AXI_araddr_0 = 12'b0;
wire [2:0]    M01_AXI_arprot_0;
wire [0:0]    M01_AXI_arready_0;
wire [0:0]    M01_AXI_arvalid_0 = 1'b0;
wire [11:0]   M01_AXI_awaddr_0 = 12'b0;
wire [2:0]    M01_AXI_awprot_0;
wire [0:0]    M01_AXI_awready_0;
wire [0:0]    M01_AXI_awvalid_0 = 1'b0;
wire [0:0]    M01_AXI_bready_0 = 1'b0;
wire [1:0]    M01_AXI_bresp_0;
wire [0:0]    M01_AXI_bvalid_0;
wire [31:0]   M01_AXI_rdata_0;
wire [0:0]    M01_AXI_rready_0 = 1'b0;
wire [1:0]    M01_AXI_rresp_0;
wire [0:0]    M01_AXI_rvalid_0;
wire [31:0]   M01_AXI_wdata_0 = 32'b0;
wire [0:0]    M01_AXI_wready_0;
wire [3:0]    M01_AXI_wstrb_0 = 4'b0;
wire [0:0]    M01_AXI_wvalid_0 = 1'b0;

wire [11:0]   M02_AXI_araddr_0 = 12'b0;
wire [2:0]    M02_AXI_arprot_0;
wire [0:0]    M02_AXI_arready_0;
wire [0:0]    M02_AXI_arvalid_0 = 1'b0;
wire [11:0]   M02_AXI_awaddr_0 = 12'b0;
wire [2:0]    M02_AXI_awprot_0;
wire [0:0]    M02_AXI_awready_0;
wire [0:0]    M02_AXI_awvalid_0 = 1'b0;
wire [0:0]    M02_AXI_bready_0 = 1'b0;
wire [1:0]    M02_AXI_bresp_0;
wire [0:0]    M02_AXI_bvalid_0;
wire [31:0]   M02_AXI_rdata_0;
wire [0:0]    M02_AXI_rready_0 = 1'b0;
wire [1:0]    M02_AXI_rresp_0;
wire [0:0]    M02_AXI_rvalid_0;
wire [31:0]   M02_AXI_wdata_0 = 32'b0;
wire [0:0]    M02_AXI_wready_0;
wire [3:0]    M02_AXI_wstrb_0 = 4'b0;
wire [0:0]    M02_AXI_wvalid_0 = 1'b0;

wire [11:0]   M03_AXI_araddr_0 = 12'b0;
wire [2:0]    M03_AXI_arprot_0;
wire [0:0]    M03_AXI_arready_0;
wire [0:0]    M03_AXI_arvalid_0 = 1'b0;
wire [11:0]   M03_AXI_awaddr_0 = 12'b0;
wire [2:0]    M03_AXI_awprot_0;
wire [0:0]    M03_AXI_awready_0;
wire [0:0]    M03_AXI_awvalid_0 = 1'b0;
wire [0:0]    M03_AXI_bready_0 = 1'b0;
wire [1:0]    M03_AXI_bresp_0;
wire [0:0]    M03_AXI_bvalid_0;
wire [31:0]   M03_AXI_rdata_0;
wire [0:0]    M03_AXI_rready_0 = 1'b0;
wire [1:0]    M03_AXI_rresp_0;
wire [0:0]    M03_AXI_rvalid_0;
wire [31:0]   M03_AXI_wdata_0 = 32'b0;
wire [0:0]    M03_AXI_wready_0;
wire [3:0]    M03_AXI_wstrb_0 = 4'b0;
wire [0:0]    M03_AXI_wvalid_0 = 1'b0;

datapath_v3 
#(
    .C_M_AXIS_DATA_WIDTH (AXIS_DATA_WIDTH),
    .C_S_AXIS_DATA_WIDTH (AXIS_DATA_WIDTH),
    .C_S_AXI_ADDR_WIDTH (12),
    .C_M_AXIS_TUSER_WIDTH (AXIS_TUSER_WIDTH),
    .C_S_AXIS_TUSER_WIDTH (AXIS_TUSER_WIDTH)
)
dut 
(
    .axis_aclk                      (clk),
    .axis_resetn                    (~reset),
    .axi_aclk                       (clk),
    .axi_resetn                     (~reset),
    
    // Slave Stream Ports (interface from Rx queues)
    .s_axis_0_tdata                 (s_axis_tdata[0]),  
    .s_axis_0_tkeep                 (s_axis_tkeep[0]),  
    .s_axis_0_tuser                 (s_axis_tuser[0]),  
    .s_axis_0_tvalid                (s_axis_tvalid[0]), 
    .s_axis_0_tready                (s_axis_tready[0]), 
    .s_axis_0_tlast                 (s_axis_tlast[0]),  
    .s_axis_1_tdata                 (s_axis_tdata[1]),  
    .s_axis_1_tkeep                 (s_axis_tkeep[1]),  
    .s_axis_1_tuser                 (s_axis_tuser[1]),  
    .s_axis_1_tvalid                (s_axis_tvalid[1]), 
    .s_axis_1_tready                (s_axis_tready[1]), 
    .s_axis_1_tlast                 (s_axis_tlast[1]),  
    .s_axis_2_tdata                 (s_axis_tdata[2]),  
    .s_axis_2_tkeep                 (s_axis_tkeep[2]),  
    .s_axis_2_tuser                 (s_axis_tuser[2]),  
    .s_axis_2_tvalid                (s_axis_tvalid[2]), 
    .s_axis_2_tready                (s_axis_tready[2]), 
    .s_axis_2_tlast                 (s_axis_tlast[2]),  
    .s_axis_3_tdata                 (s_axis_tdata[3]),  
    .s_axis_3_tkeep                 (s_axis_tkeep[3]),  
    .s_axis_3_tuser                 (s_axis_tuser[3]),  
    .s_axis_3_tvalid                (s_axis_tvalid[3]), 
    .s_axis_3_tready                (s_axis_tready[3]), 
    .s_axis_3_tlast                 (s_axis_tlast[3]),  
    .s_axis_4_tdata                 (s_axis_tdata[4]), 
    .s_axis_4_tkeep                 (s_axis_tkeep[4]), 
    .s_axis_4_tuser                 (s_axis_tuser[4]), 
    .s_axis_4_tvalid                (s_axis_tvalid[4]),
    .s_axis_4_tready                (s_axis_tready[4]), 
    .s_axis_4_tlast                 (s_axis_tlast[4]),  


    // Master Stream Ports (interface to TX queues)
    .m_axis_0_tdata                (m_axis_tdata[0]),
    .m_axis_0_tkeep                (m_axis_tkeep[0]),
    .m_axis_0_tuser                (m_axis_tuser[0]),
    .m_axis_0_tvalid               (m_axis_tvalid[0]),
    .m_axis_0_tready               (m_axis_tready[0]),
    .m_axis_0_tlast                (m_axis_tlast[0]),
    .m_axis_1_tdata                (m_axis_tdata[1]), 
    .m_axis_1_tkeep                (m_axis_tkeep[1]), 
    .m_axis_1_tuser                (m_axis_tuser[1]), 
    .m_axis_1_tvalid               (m_axis_tvalid[1]),
    .m_axis_1_tready               (m_axis_tready[1]),
    .m_axis_1_tlast                (m_axis_tlast[1]), 
    .m_axis_2_tdata                (m_axis_tdata[2]), 
    .m_axis_2_tkeep                (m_axis_tkeep[2]), 
    .m_axis_2_tuser                (m_axis_tuser[2]), 
    .m_axis_2_tvalid               (m_axis_tvalid[2]),
    .m_axis_2_tready               (m_axis_tready[2]),
    .m_axis_2_tlast                (m_axis_tlast[2]), 
    .m_axis_3_tdata                (m_axis_tdata[3]), 
    .m_axis_3_tkeep                (m_axis_tkeep[3]), 
    .m_axis_3_tuser                (m_axis_tuser[3]), 
    .m_axis_3_tvalid               (m_axis_tvalid[3]),
    .m_axis_3_tready               (m_axis_tready[3]),
    .m_axis_3_tlast                (m_axis_tlast[3]), 
    .m_axis_cpu_tdata              (m_axis_tdata[4]),
    .m_axis_cpu_tkeep              (m_axis_tkeep[4]),
    .m_axis_cpu_tuser              (m_axis_tuser[4]),
    .m_axis_cpu_tvalid             (m_axis_tvalid[4]),
    .m_axis_cpu_tready             (m_axis_tready[4]),
    .m_axis_cpu_tlast              (m_axis_tlast[4]),

    //AXI-Lite interface  

    .S0_AXI_AWADDR                    (M01_AXI_awaddr_0), 
    .S0_AXI_AWVALID                   (M01_AXI_awvalid_0),
    .S0_AXI_WDATA                     (M01_AXI_wdata_0),  
    .S0_AXI_WSTRB                     (M01_AXI_wstrb_0),  
    .S0_AXI_WVALID                    (M01_AXI_wvalid_0), 
    .S0_AXI_BREADY                    (M01_AXI_bready_0), 
    .S0_AXI_ARADDR                    (M01_AXI_araddr_0), 
    .S0_AXI_ARVALID                   (M01_AXI_arvalid_0),
    .S0_AXI_RREADY                    (M01_AXI_rready_0), 
    .S0_AXI_ARREADY                   (M01_AXI_arready_0),
    .S0_AXI_RDATA                     (M01_AXI_rdata_0),  
    .S0_AXI_RRESP                     (M01_AXI_rresp_0),  
    .S0_AXI_RVALID                    (M01_AXI_rvalid_0), 
    .S0_AXI_WREADY                    (M01_AXI_wready_0), 
    .S0_AXI_BRESP                     (M01_AXI_bresp_0),  
    .S0_AXI_BVALID                    (M01_AXI_bvalid_0), 
    .S0_AXI_AWREADY                   (M01_AXI_awready_0),
    
    .S1_AXI_AWADDR                    (M02_AXI_awaddr_0), 
    .S1_AXI_AWVALID                   (M02_AXI_awvalid_0),
    .S1_AXI_WDATA                     (M02_AXI_wdata_0),  
    .S1_AXI_WSTRB                     (M02_AXI_wstrb_0),  
    .S1_AXI_WVALID                    (M02_AXI_wvalid_0), 
    .S1_AXI_BREADY                    (M02_AXI_bready_0), 
    .S1_AXI_ARADDR                    (M02_AXI_araddr_0), 
    .S1_AXI_ARVALID                   (M02_AXI_arvalid_0),
    .S1_AXI_RREADY                    (M02_AXI_rready_0), 
    .S1_AXI_ARREADY                   (M02_AXI_arready_0),
    .S1_AXI_RDATA                     (M02_AXI_rdata_0),  
    .S1_AXI_RRESP                     (M02_AXI_rresp_0),  
    .S1_AXI_RVALID                    (M02_AXI_rvalid_0), 
    .S1_AXI_WREADY                    (M02_AXI_wready_0), 
    .S1_AXI_BRESP                     (M02_AXI_bresp_0),  
    .S1_AXI_BVALID                    (M02_AXI_bvalid_0), 
    .S1_AXI_AWREADY                   (M02_AXI_awready_0),

    .S2_AXI_AWADDR                    (M03_AXI_awaddr_0), 
    .S2_AXI_AWVALID                   (M03_AXI_awvalid_0),
    .S2_AXI_WDATA                     (M03_AXI_wdata_0),  
    .S2_AXI_WSTRB                     (M03_AXI_wstrb_0),  
    .S2_AXI_WVALID                    (M03_AXI_wvalid_0), 
    .S2_AXI_BREADY                    (M03_AXI_bready_0), 
    .S2_AXI_ARADDR                    (M03_AXI_araddr_0), 
    .S2_AXI_ARVALID                   (M03_AXI_arvalid_0),
    .S2_AXI_RREADY                    (M03_AXI_rready_0), 
    .S2_AXI_ARREADY                   (M03_AXI_arready_0),
    .S2_AXI_RDATA                     (M03_AXI_rdata_0),  
    .S2_AXI_RRESP                     (M03_AXI_rresp_0),  
    .S2_AXI_RVALID                    (M03_AXI_rvalid_0), 
    .S2_AXI_WREADY                    (M03_AXI_wready_0), 
    .S2_AXI_BRESP                     (M03_AXI_bresp_0),  
    .S2_AXI_BVALID                    (M03_AXI_bvalid_0), 
    .S2_AXI_AWREADY                   (M03_AXI_awready_0),

    .sync_time_ptp_ns(sync_time_ptp_ns)
);

packet_generator #(
    .AXIS_DATA_WIDTH(AXIS_DATA_WIDTH),
    .AXIS_TUSER_WIDTH(AXIS_TUSER_WIDTH),
    .DST_MAC_ADDR(48'h1111_1111_1111),
    .SRC_MAC_ADDR(48'h0000_0000_0000),
    .VLAN(1'b0),
    .SRC_PORT(0)
) packet_generator_0 (
    .axis_aclk(clk),
    .axis_reset(reset),
    .s_axis_tdata(s_axis_tdata[0]),
    .s_axis_tkeep(s_axis_tkeep[0]),
    .s_axis_tuser(s_axis_tuser[0]),
    .s_axis_tvalid(s_axis_tvalid[0]),
    .s_axis_tready(s_axis_tready[0]),
    .s_axis_tlast(s_axis_tlast[0])
);

packet_generator #(
    .AXIS_DATA_WIDTH(AXIS_DATA_WIDTH),
    .AXIS_TUSER_WIDTH(AXIS_TUSER_WIDTH),
    .DST_MAC_ADDR(48'h0000_0000_0000),
    .SRC_MAC_ADDR(48'h1111_1111_1111),
    .VLAN(1'b1),
    .PRI(3'b111),
    .SRC_PORT(1)
) packet_generator_1 (
    .axis_aclk(clk),
    .axis_reset(reset),
    .s_axis_tdata(s_axis_tdata[1]),
    .s_axis_tkeep(s_axis_tkeep[1]),
    .s_axis_tuser(s_axis_tuser[1]),
    .s_axis_tvalid(s_axis_tvalid[1]),
    .s_axis_tready(s_axis_tready[1]),
    .s_axis_tlast(s_axis_tlast[1])
);

packet_generator #(
    .AXIS_DATA_WIDTH(AXIS_DATA_WIDTH),
    .AXIS_TUSER_WIDTH(AXIS_TUSER_WIDTH),
    .DST_MAC_ADDR(48'h1111_1111_1111),
    .SRC_MAC_ADDR(48'h2222_2222_2222),
    .VLAN(1'b1),
    .PRI(3'b000),
    .SRC_PORT(2)
) packet_generator_2 (
    .axis_aclk(clk),
    .axis_reset(reset),
    .s_axis_tdata(s_axis_tdata[2]),
    .s_axis_tkeep(s_axis_tkeep[2]),
    .s_axis_tuser(s_axis_tuser[2]),
    .s_axis_tvalid(s_axis_tvalid[2]),
    .s_axis_tready(s_axis_tready[2]),
    .s_axis_tlast(s_axis_tlast[2])
);

packet_generator #(
    .AXIS_DATA_WIDTH(AXIS_DATA_WIDTH),
    .AXIS_TUSER_WIDTH(AXIS_TUSER_WIDTH),
    .DST_MAC_ADDR(48'h1111_1111_1111),
    .SRC_MAC_ADDR(48'h3333_3333_3333),
    .VLAN(1'b1),
    .PRI(3'b001),
    .SRC_PORT(3)
) packet_generator_3 (
    .axis_aclk(clk),
    .axis_reset(reset),
    .s_axis_tdata(s_axis_tdata[3]),
    .s_axis_tkeep(s_axis_tkeep[3]),
    .s_axis_tuser(s_axis_tuser[3]),
    .s_axis_tvalid(s_axis_tvalid[3]),
    .s_axis_tready(s_axis_tready[3]),
    .s_axis_tlast(s_axis_tlast[3])
);

packet_generator #(
    .AXIS_DATA_WIDTH(AXIS_DATA_WIDTH),
    .AXIS_TUSER_WIDTH(AXIS_TUSER_WIDTH),
    .DST_MAC_ADDR(48'h1111_1111_1111),
    .SRC_MAC_ADDR(48'h4444_4444_4444),
    .VLAN(1'b1),
    .PRI(3'b011),
    .SRC_PORT(4)
) packet_generator_4 (
    .axis_aclk(clk),
    .axis_reset(reset),
    .s_axis_tdata(s_axis_tdata[4]),
    .s_axis_tkeep(s_axis_tkeep[4]),
    .s_axis_tuser(s_axis_tuser[4]),
    .s_axis_tvalid(s_axis_tvalid[4]),
    .s_axis_tready(s_axis_tready[4]),
    .s_axis_tlast(s_axis_tlast[4])
);
endmodule