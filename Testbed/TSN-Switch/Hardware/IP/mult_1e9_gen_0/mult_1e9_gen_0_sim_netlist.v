// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Sun Nov 28 19:51:27 2021
// Host        : Horace-TNS-win10 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Data/TSN_development/tsn_device_new-2/IP/mult_1e9_gen_0/mult_1e9_gen_0_sim_netlist.v
// Design      : mult_1e9_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mult_1e9_gen_0,mult_gen_v12_0_16,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_16,Vivado 2020.1" *) 
(* NotValidForBitStream *)
module mult_1e9_gen_0
   (A,
    P);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [31:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [63:0]P;

  wire \<const0> ;
  wire [31:0]A;
  wire [63:9]\^P ;
  wire [8:0]NLW_U0_P_UNCONNECTED;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  assign P[63:9] = \^P [63:9];
  assign P[8] = \<const0> ;
  assign P[7] = \<const0> ;
  assign P[6] = \<const0> ;
  assign P[5] = \<const0> ;
  assign P[4] = \<const0> ;
  assign P[3] = \<const0> ;
  assign P[2] = \<const0> ;
  assign P[1] = \<const0> ;
  assign P[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "111011100110101100101000000000" *) 
  (* C_B_WIDTH = "30" *) 
  (* C_CCM_IMP = "2" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "0" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "2" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "63" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  mult_1e9_gen_0_mult_gen_v12_0_16 U0
       (.A(A),
        .B({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CE(1'b1),
        .CLK(1'b1),
        .P({\^P ,NLW_U0_P_UNCONNECTED[8:0]}),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule

(* C_A_TYPE = "0" *) (* C_A_WIDTH = "32" *) (* C_B_TYPE = "1" *) 
(* C_B_VALUE = "111011100110101100101000000000" *) (* C_B_WIDTH = "30" *) (* C_CCM_IMP = "2" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "0" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "2" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "63" *) 
(* C_OUT_LOW = "0" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "zynq" *) (* ORIG_REF_NAME = "mult_gen_v12_0_16" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module mult_1e9_gen_0_mult_gen_v12_0_16
   (CLK,
    A,
    B,
    CE,
    SCLR,
    ZERO_DETECT,
    P,
    PCASC);
  input CLK;
  input [31:0]A;
  input [29:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [63:0]P;
  output [47:0]PCASC;

  wire \<const0> ;
  wire [31:0]A;
  wire [63:9]\^P ;
  wire [8:0]NLW_i_mult_P_UNCONNECTED;
  wire [47:0]NLW_i_mult_PCASC_UNCONNECTED;
  wire [1:0]NLW_i_mult_ZERO_DETECT_UNCONNECTED;

  assign P[63:9] = \^P [63:9];
  assign P[8] = \<const0> ;
  assign P[7] = \<const0> ;
  assign P[6] = \<const0> ;
  assign P[5] = \<const0> ;
  assign P[4] = \<const0> ;
  assign P[3] = \<const0> ;
  assign P[2] = \<const0> ;
  assign P[1] = \<const0> ;
  assign P[0] = \<const0> ;
  assign PCASC[47] = \<const0> ;
  assign PCASC[46] = \<const0> ;
  assign PCASC[45] = \<const0> ;
  assign PCASC[44] = \<const0> ;
  assign PCASC[43] = \<const0> ;
  assign PCASC[42] = \<const0> ;
  assign PCASC[41] = \<const0> ;
  assign PCASC[40] = \<const0> ;
  assign PCASC[39] = \<const0> ;
  assign PCASC[38] = \<const0> ;
  assign PCASC[37] = \<const0> ;
  assign PCASC[36] = \<const0> ;
  assign PCASC[35] = \<const0> ;
  assign PCASC[34] = \<const0> ;
  assign PCASC[33] = \<const0> ;
  assign PCASC[32] = \<const0> ;
  assign PCASC[31] = \<const0> ;
  assign PCASC[30] = \<const0> ;
  assign PCASC[29] = \<const0> ;
  assign PCASC[28] = \<const0> ;
  assign PCASC[27] = \<const0> ;
  assign PCASC[26] = \<const0> ;
  assign PCASC[25] = \<const0> ;
  assign PCASC[24] = \<const0> ;
  assign PCASC[23] = \<const0> ;
  assign PCASC[22] = \<const0> ;
  assign PCASC[21] = \<const0> ;
  assign PCASC[20] = \<const0> ;
  assign PCASC[19] = \<const0> ;
  assign PCASC[18] = \<const0> ;
  assign PCASC[17] = \<const0> ;
  assign PCASC[16] = \<const0> ;
  assign PCASC[15] = \<const0> ;
  assign PCASC[14] = \<const0> ;
  assign PCASC[13] = \<const0> ;
  assign PCASC[12] = \<const0> ;
  assign PCASC[11] = \<const0> ;
  assign PCASC[10] = \<const0> ;
  assign PCASC[9] = \<const0> ;
  assign PCASC[8] = \<const0> ;
  assign PCASC[7] = \<const0> ;
  assign PCASC[6] = \<const0> ;
  assign PCASC[5] = \<const0> ;
  assign PCASC[4] = \<const0> ;
  assign PCASC[3] = \<const0> ;
  assign PCASC[2] = \<const0> ;
  assign PCASC[1] = \<const0> ;
  assign PCASC[0] = \<const0> ;
  assign ZERO_DETECT[1] = \<const0> ;
  assign ZERO_DETECT[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "111011100110101100101000000000" *) 
  (* C_B_WIDTH = "30" *) 
  (* C_CCM_IMP = "2" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "0" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "2" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "63" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  mult_1e9_gen_0_mult_gen_v12_0_16_viv i_mult
       (.A(A),
        .B({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CE(1'b0),
        .CLK(1'b1),
        .P({\^P ,NLW_i_mult_P_UNCONNECTED[8:0]}),
        .PCASC(NLW_i_mult_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_i_mult_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2020.1"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
ZqI7Lq/aGyAcoaejBEIk07VX9jYIkvdeTPQu9dSbDEADopcPNa+0k8THWemULZmXocovtHBV2sQ+
UG9Mr3L0hg==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
R4vPs+jPUBq40hDi8U6b9avbUk2Eb50U4A+mDDli/Y0olyqpMjS2bHK8VDjTVAFuQ+H3qih0cQYm
+ik1m47VLNMfNDfRLbftE2okRK8Kx81MRcEafr+7z29VxyL2KSwmOKbcDCEkIT1VX5y+96x7q9/g
O5zX1cVuj6hrFncQjBI=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
RHGRLed4zRtfx3HaMZFysMR3Ua1JohlSUQn/uIq0QNaCK2P96ztDgqQoqe6ZQ11betfsHTRFzq/1
66ClFz6QxXME/fh2KrrXSgUZxYxwfstEZlyOThrSfu+qzCsdk0R654q7wyvVT8+Lni3RuXc5nFXx
raCVZl6qLm50r3EadUq562wDBW7iVkrMp3OgccKyJyw39sT1Jc+0IkzHuHqjKA44tfGTOOSTHNUj
YgsyeZCJS72pabS90ZfprHyjsELB7Bxw/M9/XLEV7l1LP+SCDJFvOP5dNLZDBmwYIJ5OoU7247Tk
wYu3m6ZFZNnTwWGI9SAZJyiXILRa8hVZPL9TSA==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
OU7rNiePgxinwm/ruLBNeniAmTTLdwPhOZ1i35IGtDWXtaPoMnsPLRF6vnJo1xeYUES1MIlBqaG4
FUeyfrnBl3ofk5rfTbxL16dBcEtA8Z/duJARcLCIBD/J+xf2VlSqIo8dG9Ww8/L9pBTHpNAObSOU
o17xArTTrLfHWXZRGfRwuRpGlTLTYOMvS1AGhQcPbXjHrlijOoz3XigDVsnyGbHfkSgOlGBCnyDS
TPebi8IC8YIl88ieW+lqTL6jl+3DZ55iTfCJKbFt/HrE1Uou1l+60xI/9h9XhrNzE5ANic5eFmyC
tdncsHEBtx+UfZhyFrHV8z72yZoLCX2rOJ+IJA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
GUoHfgebfwQKNkw122kR1rRfB4ZFf7/0xjFIvV3auOQ9RcZO2jgecvvtUAn3nocoMNPW1jFFZW0u
xgkVDSrwVJrMR/obpu7gqo1n1FD2E5BpOJV2Gwso9aZGhgTdfd0mINfCxPi4lxUYuTw1vd+iNkBH
peC7j2xzDHSu6o2S58c=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lW3oa+bS7VSdBch0q4Lk4kIel2MxeXNlqo+JkBKYCThE5vtBv3Mob32tRj6s2h8BAos9XGsKRu0r
zWpu3cgAnv8lYIL4/UPBP9T+caGqWHHoGULrLn4zuybUvPzfGPj+ANXGfPXBomTO48UgPFWBnBA2
3vlOjCiOyKLMQAUrg8RqpfdYfcnwHxk8ebrE+lZJf6NCQtrqGu/EnH7PYFH/8MSQa6yey02fLQ2J
HenzdGNam7fu3z20gETHgePuewowRrJu5bEZOzlor2RrSnb0hcSbcO4/KSA9EcbmjzBMjE5uRYAM
1y+0t4rNGr+0XAjpp8m6B8lGF+m1jIGYMJ55eQ==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
AYjoOGO5c2rCxRUY5RbgjfKwpMKJQrCDGPu9wzqv2ZhoT9Trod7xJlCnzNNU4kNJPTgmDf05Bkoo
EvR1hgWeTmTgCGdy7Qci0Z0L3pdxnOg9i69qsJO1qAW46sOYPeZHpvATo3irsreTIyOEcblYRdLh
Raj2T02eEhljrx1UdWXHwIq6kJGwbPaiMRXRJewJ75w53lF3nNUwTYgttUbm/hKuK4MTBvyDWlHF
UReBw5kEbERTaRF91+HNJUeoBgfLIgVhtPzX3Yzqy4fl1PxZ0BzAGNRQWfLI4TBSyl64znmxdzaS
+wcpSJ3OHZL4sBSIwGqpZ8UuNr53DWWwkd5lqw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2019_11", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
F93W5rP9wRsskpVAtvm9VhlFJY5TOuivcFKT2bVYmeqxn925TMU0N0nDRJZmC+O7NbtC0kbL9Hfv
iPaQAjkvtWKCEafU216A83pjNwYVINq3GbStXAtCrvf3KbYJMQPnr6FzKWLa0RlmEqf2z1LRIJMY
cR3LKzziLGgP+oQLz6W3siXeoyqxsbDm+dasSbu2YxzGAvkTos4kX2slGrQzxYSQogS6j/MzVgIk
Vhsm3BYDbtVT5TsiHGfRfi137tS2Q9o11KN44GT+JYigwORe+GyKi5xjI6kGPl1N1DK12TlRGsgC
Wq2YWMn2ABYXE2F8mkwPOJqSaaAR0S5MMCjkaQ==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
EO2KlFB8vWgjeXvua8SEZL2APl0WfdPtqoF/0VTjBDZhkKh8T7GBS9tSSrCin7kHRBUGF6hOUPK2
V0JQtp4yW7c3oVbMN2ePIV7UdtkAszA2lMqOqeKJbWn0TfxRWL5adG+jGlhhYEbaT6tkCGPbbtbk
y5Kew5kT3RyGP8Rb0tim3cGvqi2BdBxqdc5Sb+Vyj0havZUyZo1AsjuLnNukDIYIrPCtqOY22MTp
VlNOr/u23OIMx+xx7Z4aOvZacPCxfg662ljyHetf5a0wu31WI6zf/69lkXq1iWJtHgEJn2iDpIWs
bSWDEtGgKAFHGKVAoc0vIGP3aPG6DIsqRyQ90Q==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
J0/VCruKPa0ocNTKTVjPA2iEvv3WitN0cK4NZtw77sD84JDYfveW405PaF2ZzNpa1Ea6b/QqFUiA
4qKMV6fslnVaxDwwbC1k6WHu6si6Q1X63xcETIgzGRTtPIoZG5kmiFnmuFususbmv1TztlHQaQcS
tcFgjMpgSbdvhdP5L8yTuVlcEZbMxHqO1Z41grc6P19sOH9beSTVbqNmDTLCPm5fDZLZ9FujPqxI
jC1pGQsQIrUowpj/+sDfP/9b5xj2xzlpJH3kryGk0luHr1WnoF/41HdpZkkfeZVclCzpEbpix2hY
dd8xX2NnfdZOB1cfsFfK7zwY4QHAlY3JTAp8AA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
5Qi5RsfRUIZVKO/vJiZSEjI0ZVLFd6cMdbJvJLXOAZNGc5iymKoZqlb17CVbY08otcDIjGRxYF11
WF3tkP+OqcEcZZqGcmLh2zt7+B6xUEiH9hn45vjrt1rAdBZ02REGfMB9Q/VwZyAqCaa7WF/4xbh+
o98cr1NiwpsKGBQSymrcj+FduAAHuDntYOv4zXtZNPBxCqn7/FTtf19/CLNgcICkjHcsftAHYscS
GUz9aBaX8ZSW30bQZ7H19gzq8QeWtDV8Z9SpRUc7VsdVp7Wr5F8rzyu4LzEyQNNcD/vyZcYMnJQu
ifL1Pdf5AzI0OVz8OdHKUBByucapk1xiTh3cCA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 20176)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
