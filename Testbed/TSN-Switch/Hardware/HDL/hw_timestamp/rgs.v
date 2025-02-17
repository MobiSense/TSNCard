/*
 * reg.v
 * 
 * Copyright (c) 2012, BABY&HW. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301  USA
 *
 * Description: Provide register accesses for time information (and 
 * others) to upper layers.
 */

`timescale 1ns/1ns

module rgs (
  // generic bus interface
  input         rst,clk,
  input         wr_in,rd_in,
  input  [11:0] addr_in,
  input  [31:0] data_in,
  output [31:0] data_out,
  // rtc interface
  input         rtc_clk_in,
  output        rtc_rst_out,
  output        time_ld_out,
  output [37:0] time_reg_ns_out,
  output [47:0] time_reg_sec_out,
  output        period_ld_out,
  output [39:0] period_out,
  output        adj_ld_out,
  output [31:0] adj_ld_data_out,
  output [39:0] period_adj_out,
  input         adj_ld_done_in,
  output        offset_ld_out,
  output [31:0] offset_ptp_ns_out,
  output [47:0] offset_ptp_sec_out,
  input  [37:0] time_reg_ns_in,
  input  [47:0] time_reg_sec_in,
  input  [31:0] sync_time_ns_in,
  input  [47:0] sync_time_sec_in,
  // rx tsu interface
  output [  3:0] rx_q_rst_out,
  output [  3:0] rx_q_rd_clk_out,
  output [  3:0] rx_q_rd_en_out,
  output [ 31:0] rx_q_ptp_msgid_mask_out_flat,
  input  [ 31:0] rx_q_stat_in_flat,
  input  [511:0] rx_q_data_in_flat,
  // tx tsu interface
  output [  3:0] tx_q_rst_out,
  output [  3:0] tx_q_rd_clk_out,
  output [  3:0] tx_q_rd_en_out,
  output [ 31:0] tx_q_ptp_msgid_mask_out_flat,
  input  [ 31:0] tx_q_stat_in_flat,
  input  [511:0] tx_q_data_in_flat,
  // gcl interface
  input          gcl_clk_in,
  input  [575:0] gcl_data_in_flat,
  output [  3:0] gcl_ld_out,
  output [  3:0] gcl_id_out,
  output [  8:0] gcl_data_out,
  output [  3:0] gcl_time_ld_out,
  output [  3:0] gcl_time_id_out,
  output [ 19:0] gcl_time_out
);

parameter const_000 = 12'h000;
parameter const_004 = 12'h004;
parameter const_008 = 12'h008;
parameter const_00c = 12'h00C;
parameter const_010 = 12'h010;
parameter const_014 = 12'h014;
parameter const_018 = 12'h018;
parameter const_01c = 12'h01C;
parameter const_020 = 12'h020;
parameter const_024 = 12'h024;
parameter const_028 = 12'h028;
parameter const_02c = 12'h02C;
parameter const_030 = 12'h030;
parameter const_034 = 12'h034;
parameter const_038 = 12'h038;
parameter const_03c = 12'h03C;
parameter const_040 = 12'h040;
parameter const_044 = 12'h044;
parameter const_048 = 12'h048;
parameter const_04c = 12'h04C;
parameter const_050 = 12'h050;
parameter const_054 = 12'h054;
parameter const_058 = 12'h058;
parameter const_05c = 12'h05C;
parameter const_060 = 12'h060;
parameter const_064 = 12'h064;
parameter const_068 = 12'h068;
parameter const_06c = 12'h06C;
parameter const_070 = 12'h070;
parameter const_074 = 12'h074;
parameter const_078 = 12'h078;
parameter const_07c = 12'h07C;
parameter const_080 = 12'h080;
parameter const_084 = 12'h084;
parameter const_088 = 12'h088;
parameter const_08c = 12'h08C;
parameter const_090 = 12'h090;
parameter const_094 = 12'h094;
parameter const_098 = 12'h098;
parameter const_09c = 12'h09C;
parameter const_0a0 = 12'h0A0;
parameter const_0a4 = 12'h0A4;
parameter const_0a8 = 12'h0A8;
parameter const_0ac = 12'h0AC;
parameter const_0b0 = 12'h0B0;
parameter const_0b4 = 12'h0B4;
parameter const_0b8 = 12'h0B8;
parameter const_0bc = 12'h0BC;
parameter const_0c0 = 12'h0C0;
parameter const_0c4 = 12'h0C4;
parameter const_0c8 = 12'h0C8;
parameter const_0cc = 12'h0CC;
parameter const_0d0 = 12'h0D0;
parameter const_0d4 = 12'h0D4;
parameter const_0d8 = 12'h0D8;
parameter const_0dc = 12'h0DC;
parameter const_0e0 = 12'h0E0;
parameter const_0e4 = 12'h0E4;
parameter const_0e8 = 12'h0E8;
parameter const_0ec = 12'h0EC;
parameter const_0f0 = 12'h0F0;
parameter const_0f4 = 12'h0F4;
parameter const_0f8 = 12'h0F8;
parameter const_0fc = 12'h0FC;
parameter const_100 = 12'h100;
parameter const_104 = 12'h104;
parameter const_108 = 12'h108;
parameter const_10c = 12'h10C;
parameter const_110 = 12'h110;
parameter const_114 = 12'h114;
parameter const_118 = 12'h118;
parameter const_11c = 12'h11C;
parameter const_120 = 12'h120;
parameter const_124 = 12'h124;
parameter const_128 = 12'h128;
parameter const_12c = 12'h12C;
parameter const_130 = 12'h130;
parameter const_134 = 12'h134;
parameter const_138 = 12'h138;
parameter const_13c = 12'h13C;
parameter const_140 = 12'h140;
parameter const_144 = 12'h144;
parameter const_148 = 12'h148;
parameter const_14c = 12'h14C;
// GCL value - Port 1
parameter const_150 = 12'h150;
parameter const_154 = 12'h154;
parameter const_158 = 12'h158;
parameter const_15c = 12'h15C;
parameter const_160 = 12'h160;
parameter const_164 = 12'h164;
parameter const_168 = 12'h168;
parameter const_16c = 12'h16C;
parameter const_170 = 12'h170;
parameter const_174 = 12'h174;
parameter const_178 = 12'h178;
parameter const_17c = 12'h17C;
parameter const_180 = 12'h180;
parameter const_184 = 12'h184;
parameter const_188 = 12'h188;
parameter const_18c = 12'h18C;
parameter const_190 = 12'h190;
// GCL value - Port 2
parameter const_194 = 12'h194;
parameter const_198 = 12'h198;
parameter const_19c = 12'h19C;
parameter const_1a0 = 12'h1A0;
parameter const_1a4 = 12'h1A4;
parameter const_1a8 = 12'h1A8;
parameter const_1ac = 12'h1AC;
parameter const_1b0 = 12'h1B0;
parameter const_1b4 = 12'h1B4;
parameter const_1b8 = 12'h1B8;
parameter const_1bc = 12'h1BC;
parameter const_1c0 = 12'h1C0;
parameter const_1c4 = 12'h1C4;
parameter const_1c8 = 12'h1C8;
parameter const_1cc = 12'h1CC;
parameter const_1d0 = 12'h1D0;
parameter const_1d4 = 12'h1D4;
// GCL value - Port 3
parameter const_1d8 = 12'h1D8;
parameter const_1dc = 12'h1DC;
parameter const_1e0 = 12'h1E0;
parameter const_1e4 = 12'h1E4;
parameter const_1e8 = 12'h1E8;
parameter const_1ec = 12'h1EC;
parameter const_1f0 = 12'h1F0;
parameter const_1f4 = 12'h1F4;
parameter const_1f8 = 12'h1F8;
parameter const_1fc = 12'h1FC;
parameter const_200 = 12'h200;
parameter const_204 = 12'h204;
parameter const_208 = 12'h208;
parameter const_20c = 12'h20C;
parameter const_210 = 12'h210;
parameter const_214 = 12'h214;
parameter const_218 = 12'h218;
// GCL value - Port 4
parameter const_21c = 12'h21C;
parameter const_220 = 12'h220;
parameter const_224 = 12'h224;
parameter const_228 = 12'h228;
parameter const_22c = 12'h22C;
parameter const_230 = 12'h230;
parameter const_234 = 12'h234;
parameter const_238 = 12'h238;
parameter const_23c = 12'h23C;
parameter const_240 = 12'h240;
parameter const_244 = 12'h244;
parameter const_248 = 12'h248;
parameter const_24c = 12'h24C;
parameter const_250 = 12'h250;
parameter const_254 = 12'h254;
parameter const_258 = 12'h258;
parameter const_25c = 12'h25C;
// tagger/untagger
parameter const_260 = 12'h260; 
parameter const_264 = 12'h264;
parameter const_268 = 12'h268;
parameter const_26c = 12'h26C;
parameter const_270 = 12'h270; 
parameter const_274 = 12'h274;
parameter const_278 = 12'h278;
parameter const_27c = 12'h27C;
parameter const_280 = 12'h280; 
parameter const_284 = 12'h284;
parameter const_288 = 12'h288;
parameter const_28c = 12'h28C;
parameter const_290 = 12'h290; 
parameter const_294 = 12'h294;
parameter const_298 = 12'h298;
parameter const_29c = 12'h29C;
// GCL time interval - Port 1
parameter const_2a0 = 12'h2A0; 
parameter const_2a4 = 12'h2A4;
parameter const_2a8 = 12'h2A8;
parameter const_2ac = 12'h2AC;
parameter const_2b0 = 12'h2B0; 
parameter const_2b4 = 12'h2B4;
parameter const_2b8 = 12'h2B8;
parameter const_2bc = 12'h2BC;
parameter const_2c0 = 12'h2C0; 
parameter const_2c4 = 12'h2C4;
parameter const_2c8 = 12'h2C8;
parameter const_2cc = 12'h2CC;
parameter const_2d0 = 12'h2D0; 
parameter const_2d4 = 12'h2D4;
parameter const_2d8 = 12'h2D8;
parameter const_2dc = 12'h2DC;
// GCL time interval - Port 2
parameter const_2e0 = 12'h2E0; 
parameter const_2e4 = 12'h2E4;
parameter const_2e8 = 12'h2E8;
parameter const_2ec = 12'h2EC;
parameter const_2f0 = 12'h2F0; 
parameter const_2f4 = 12'h2F4;
parameter const_2f8 = 12'h2F8;
parameter const_2fc = 12'h2FC;
parameter const_300 = 12'h300; 
parameter const_304 = 12'h304;
parameter const_308 = 12'h308;
parameter const_30c = 12'h30C;
parameter const_310 = 12'h310; 
parameter const_314 = 12'h314;
parameter const_318 = 12'h318;
parameter const_31c = 12'h31C;
// GCL time interval - Port 3
parameter const_320 = 12'h320; 
parameter const_324 = 12'h324;
parameter const_328 = 12'h328;
parameter const_32c = 12'h32C;
parameter const_330 = 12'h330; 
parameter const_334 = 12'h334;
parameter const_338 = 12'h338;
parameter const_33c = 12'h33C;
parameter const_340 = 12'h340; 
parameter const_344 = 12'h344;
parameter const_348 = 12'h348;
parameter const_34c = 12'h34C;
parameter const_350 = 12'h350; 
parameter const_354 = 12'h354;
parameter const_358 = 12'h358;
parameter const_35c = 12'h35C;
// GCL time interval - Port 4
parameter const_360 = 12'h360; 
parameter const_364 = 12'h364;
parameter const_368 = 12'h368;
parameter const_36c = 12'h36C;
parameter const_370 = 12'h370; 
parameter const_374 = 12'h374;
parameter const_378 = 12'h378;
parameter const_37c = 12'h37C;
parameter const_380 = 12'h380; 
parameter const_384 = 12'h384;
parameter const_388 = 12'h388;
parameter const_38c = 12'h38C;
parameter const_390 = 12'h390; 
parameter const_394 = 12'h394;
parameter const_398 = 12'h398;
parameter const_39c = 12'h39C;

genvar i;

wire cs_000 = (addr_in[11:2]==const_000[11:2])? 1'b1: 1'b0;
wire cs_004 = (addr_in[11:2]==const_004[11:2])? 1'b1: 1'b0;
wire cs_008 = (addr_in[11:2]==const_008[11:2])? 1'b1: 1'b0;
wire cs_00c = (addr_in[11:2]==const_00c[11:2])? 1'b1: 1'b0;
wire cs_010 = (addr_in[11:2]==const_010[11:2])? 1'b1: 1'b0;
wire cs_014 = (addr_in[11:2]==const_014[11:2])? 1'b1: 1'b0;
wire cs_018 = (addr_in[11:2]==const_018[11:2])? 1'b1: 1'b0;
wire cs_01c = (addr_in[11:2]==const_01c[11:2])? 1'b1: 1'b0;
wire cs_020 = (addr_in[11:2]==const_020[11:2])? 1'b1: 1'b0;
wire cs_024 = (addr_in[11:2]==const_024[11:2])? 1'b1: 1'b0;
wire cs_028 = (addr_in[11:2]==const_028[11:2])? 1'b1: 1'b0;
wire cs_02c = (addr_in[11:2]==const_02c[11:2])? 1'b1: 1'b0;
wire cs_030 = (addr_in[11:2]==const_030[11:2])? 1'b1: 1'b0;
wire cs_034 = (addr_in[11:2]==const_034[11:2])? 1'b1: 1'b0;
wire cs_038 = (addr_in[11:2]==const_038[11:2])? 1'b1: 1'b0;
wire cs_03c = (addr_in[11:2]==const_03c[11:2])? 1'b1: 1'b0;
wire cs_040 = (addr_in[11:2]==const_040[11:2])? 1'b1: 1'b0;
wire cs_044 = (addr_in[11:2]==const_044[11:2])? 1'b1: 1'b0;
wire cs_048 = (addr_in[11:2]==const_048[11:2])? 1'b1: 1'b0;
wire cs_04c = (addr_in[11:2]==const_04c[11:2])? 1'b1: 1'b0;
wire cs_050 = (addr_in[11:2]==const_050[11:2])? 1'b1: 1'b0;
wire cs_054 = (addr_in[11:2]==const_054[11:2])? 1'b1: 1'b0;
wire cs_058 = (addr_in[11:2]==const_058[11:2])? 1'b1: 1'b0;
wire cs_05c = (addr_in[11:2]==const_05c[11:2])? 1'b1: 1'b0;
wire cs_060 = (addr_in[11:2]==const_060[11:2])? 1'b1: 1'b0;
wire cs_064 = (addr_in[11:2]==const_064[11:2])? 1'b1: 1'b0;
wire cs_068 = (addr_in[11:2]==const_068[11:2])? 1'b1: 1'b0;
wire cs_06c = (addr_in[11:2]==const_06c[11:2])? 1'b1: 1'b0;
wire cs_070 = (addr_in[11:2]==const_070[11:2])? 1'b1: 1'b0;
wire cs_074 = (addr_in[11:2]==const_074[11:2])? 1'b1: 1'b0;
wire cs_078 = (addr_in[11:2]==const_078[11:2])? 1'b1: 1'b0;
wire cs_07c = (addr_in[11:2]==const_07c[11:2])? 1'b1: 1'b0;
wire cs_080 = (addr_in[11:2]==const_080[11:2])? 1'b1: 1'b0;
wire cs_084 = (addr_in[11:2]==const_084[11:2])? 1'b1: 1'b0;
wire cs_088 = (addr_in[11:2]==const_088[11:2])? 1'b1: 1'b0;
wire cs_08c = (addr_in[11:2]==const_08c[11:2])? 1'b1: 1'b0;
wire cs_090 = (addr_in[11:2]==const_090[11:2])? 1'b1: 1'b0;
wire cs_094 = (addr_in[11:2]==const_094[11:2])? 1'b1: 1'b0;
wire cs_098 = (addr_in[11:2]==const_098[11:2])? 1'b1: 1'b0;
wire cs_09c = (addr_in[11:2]==const_09c[11:2])? 1'b1: 1'b0;
wire cs_0a0 = (addr_in[11:2]==const_0a0[11:2])? 1'b1: 1'b0;
wire cs_0a4 = (addr_in[11:2]==const_0a4[11:2])? 1'b1: 1'b0;
wire cs_0a8 = (addr_in[11:2]==const_0a8[11:2])? 1'b1: 1'b0;
wire cs_0ac = (addr_in[11:2]==const_0ac[11:2])? 1'b1: 1'b0;
wire cs_0b0 = (addr_in[11:2]==const_0b0[11:2])? 1'b1: 1'b0;
wire cs_0b4 = (addr_in[11:2]==const_0b4[11:2])? 1'b1: 1'b0;
wire cs_0b8 = (addr_in[11:2]==const_0b8[11:2])? 1'b1: 1'b0;
wire cs_0bc = (addr_in[11:2]==const_0bc[11:2])? 1'b1: 1'b0;
wire cs_0c0 = (addr_in[11:2]==const_0c0[11:2])? 1'b1: 1'b0;
wire cs_0c4 = (addr_in[11:2]==const_0c4[11:2])? 1'b1: 1'b0;
wire cs_0c8 = (addr_in[11:2]==const_0c8[11:2])? 1'b1: 1'b0;
wire cs_0cc = (addr_in[11:2]==const_0cc[11:2])? 1'b1: 1'b0;
wire cs_0d0 = (addr_in[11:2]==const_0d0[11:2])? 1'b1: 1'b0;
wire cs_0d4 = (addr_in[11:2]==const_0d4[11:2])? 1'b1: 1'b0;
wire cs_0d8 = (addr_in[11:2]==const_0d8[11:2])? 1'b1: 1'b0;
wire cs_0dc = (addr_in[11:2]==const_0dc[11:2])? 1'b1: 1'b0;
wire cs_0e0 = (addr_in[11:2]==const_0e0[11:2])? 1'b1: 1'b0;
wire cs_0e4 = (addr_in[11:2]==const_0e4[11:2])? 1'b1: 1'b0;
wire cs_0e8 = (addr_in[11:2]==const_0e8[11:2])? 1'b1: 1'b0;
wire cs_0ec = (addr_in[11:2]==const_0ec[11:2])? 1'b1: 1'b0;
wire cs_0f0 = (addr_in[11:2]==const_0f0[11:2])? 1'b1: 1'b0;
wire cs_0f4 = (addr_in[11:2]==const_0f4[11:2])? 1'b1: 1'b0;
wire cs_0f8 = (addr_in[11:2]==const_0f8[11:2])? 1'b1: 1'b0;
wire cs_0fc = (addr_in[11:2]==const_0fc[11:2])? 1'b1: 1'b0;
wire cs_100 = (addr_in[11:2]==const_100[11:2])? 1'b1: 1'b0;
wire cs_104 = (addr_in[11:2]==const_104[11:2])? 1'b1: 1'b0;
wire cs_108 = (addr_in[11:2]==const_108[11:2])? 1'b1: 1'b0;
wire cs_10c = (addr_in[11:2]==const_10c[11:2])? 1'b1: 1'b0;
wire cs_110 = (addr_in[11:2]==const_110[11:2])? 1'b1: 1'b0;
wire cs_114 = (addr_in[11:2]==const_114[11:2])? 1'b1: 1'b0;
wire cs_118 = (addr_in[11:2]==const_118[11:2])? 1'b1: 1'b0;
wire cs_11c = (addr_in[11:2]==const_11c[11:2])? 1'b1: 1'b0;
wire cs_120 = (addr_in[11:2]==const_120[11:2])? 1'b1: 1'b0;
wire cs_124 = (addr_in[11:2]==const_124[11:2])? 1'b1: 1'b0;
wire cs_128 = (addr_in[11:2]==const_128[11:2])? 1'b1: 1'b0;
wire cs_12c = (addr_in[11:2]==const_12c[11:2])? 1'b1: 1'b0;
wire cs_130 = (addr_in[11:2]==const_130[11:2])? 1'b1: 1'b0;
wire cs_134 = (addr_in[11:2]==const_134[11:2])? 1'b1: 1'b0;
wire cs_138 = (addr_in[11:2]==const_138[11:2])? 1'b1: 1'b0;
wire cs_13c = (addr_in[11:2]==const_13c[11:2])? 1'b1: 1'b0;
wire cs_140 = (addr_in[11:2]==const_140[11:2])? 1'b1: 1'b0;
wire cs_144 = (addr_in[11:2]==const_144[11:2])? 1'b1: 1'b0;
wire cs_148 = (addr_in[11:2]==const_148[11:2])? 1'b1: 1'b0;
wire cs_14c = (addr_in[11:2]==const_14c[11:2])? 1'b1: 1'b0;
// GCL cs
wire cs_150 = (addr_in[11:2]==const_150[11:2])? 1'b1: 1'b0;
wire cs_154 = (addr_in[11:2]==const_154[11:2])? 1'b1: 1'b0;
wire cs_158 = (addr_in[11:2]==const_158[11:2])? 1'b1: 1'b0;
wire cs_15c = (addr_in[11:2]==const_15c[11:2])? 1'b1: 1'b0;
wire cs_160 = (addr_in[11:2]==const_160[11:2])? 1'b1: 1'b0;
wire cs_164 = (addr_in[11:2]==const_164[11:2])? 1'b1: 1'b0;
wire cs_168 = (addr_in[11:2]==const_168[11:2])? 1'b1: 1'b0;
wire cs_16c = (addr_in[11:2]==const_16c[11:2])? 1'b1: 1'b0;
wire cs_170 = (addr_in[11:2]==const_170[11:2])? 1'b1: 1'b0;
wire cs_174 = (addr_in[11:2]==const_174[11:2])? 1'b1: 1'b0;
wire cs_178 = (addr_in[11:2]==const_178[11:2])? 1'b1: 1'b0;
wire cs_17c = (addr_in[11:2]==const_17c[11:2])? 1'b1: 1'b0;
wire cs_180 = (addr_in[11:2]==const_180[11:2])? 1'b1: 1'b0;
wire cs_184 = (addr_in[11:2]==const_184[11:2])? 1'b1: 1'b0;
wire cs_188 = (addr_in[11:2]==const_188[11:2])? 1'b1: 1'b0;
wire cs_18c = (addr_in[11:2]==const_18c[11:2])? 1'b1: 1'b0;
wire cs_190 = (addr_in[11:2]==const_190[11:2])? 1'b1: 1'b0;
wire cs_194 = (addr_in[11:2]==const_194[11:2])? 1'b1: 1'b0;
wire cs_198 = (addr_in[11:2]==const_198[11:2])? 1'b1: 1'b0;
wire cs_19c = (addr_in[11:2]==const_19c[11:2])? 1'b1: 1'b0;
wire cs_1a0 = (addr_in[11:2]==const_1a0[11:2])? 1'b1: 1'b0;
wire cs_1a4 = (addr_in[11:2]==const_1a4[11:2])? 1'b1: 1'b0;
wire cs_1a8 = (addr_in[11:2]==const_1a8[11:2])? 1'b1: 1'b0;
wire cs_1ac = (addr_in[11:2]==const_1ac[11:2])? 1'b1: 1'b0;
wire cs_1b0 = (addr_in[11:2]==const_1b0[11:2])? 1'b1: 1'b0;
wire cs_1b4 = (addr_in[11:2]==const_1b4[11:2])? 1'b1: 1'b0;
wire cs_1b8 = (addr_in[11:2]==const_1b8[11:2])? 1'b1: 1'b0;
wire cs_1bc = (addr_in[11:2]==const_1bc[11:2])? 1'b1: 1'b0;
wire cs_1c0 = (addr_in[11:2]==const_1c0[11:2])? 1'b1: 1'b0;
wire cs_1c4 = (addr_in[11:2]==const_1c4[11:2])? 1'b1: 1'b0;
wire cs_1c8 = (addr_in[11:2]==const_1c8[11:2])? 1'b1: 1'b0;
wire cs_1cc = (addr_in[11:2]==const_1cc[11:2])? 1'b1: 1'b0;
wire cs_1d0 = (addr_in[11:2]==const_1d0[11:2])? 1'b1: 1'b0;
wire cs_1d4 = (addr_in[11:2]==const_1d4[11:2])? 1'b1: 1'b0;
wire cs_1d8 = (addr_in[11:2]==const_1d8[11:2])? 1'b1: 1'b0;
wire cs_1dc = (addr_in[11:2]==const_1dc[11:2])? 1'b1: 1'b0;
wire cs_1e0 = (addr_in[11:2]==const_1e0[11:2])? 1'b1: 1'b0;
wire cs_1e4 = (addr_in[11:2]==const_1e4[11:2])? 1'b1: 1'b0;
wire cs_1e8 = (addr_in[11:2]==const_1e8[11:2])? 1'b1: 1'b0;
wire cs_1ec = (addr_in[11:2]==const_1ec[11:2])? 1'b1: 1'b0;
wire cs_1f0 = (addr_in[11:2]==const_1f0[11:2])? 1'b1: 1'b0;
wire cs_1f4 = (addr_in[11:2]==const_1f4[11:2])? 1'b1: 1'b0;
wire cs_1f8 = (addr_in[11:2]==const_1f8[11:2])? 1'b1: 1'b0;
wire cs_1fc = (addr_in[11:2]==const_1fc[11:2])? 1'b1: 1'b0;
wire cs_200 = (addr_in[11:2]==const_200[11:2])? 1'b1: 1'b0;
wire cs_204 = (addr_in[11:2]==const_204[11:2])? 1'b1: 1'b0;
wire cs_208 = (addr_in[11:2]==const_208[11:2])? 1'b1: 1'b0;
wire cs_20c = (addr_in[11:2]==const_20c[11:2])? 1'b1: 1'b0;
wire cs_210 = (addr_in[11:2]==const_210[11:2])? 1'b1: 1'b0;
wire cs_214 = (addr_in[11:2]==const_214[11:2])? 1'b1: 1'b0;
wire cs_218 = (addr_in[11:2]==const_218[11:2])? 1'b1: 1'b0;
wire cs_21c = (addr_in[11:2]==const_21c[11:2])? 1'b1: 1'b0;
wire cs_220 = (addr_in[11:2]==const_220[11:2])? 1'b1: 1'b0;
wire cs_224 = (addr_in[11:2]==const_224[11:2])? 1'b1: 1'b0;
wire cs_228 = (addr_in[11:2]==const_228[11:2])? 1'b1: 1'b0;
wire cs_22c = (addr_in[11:2]==const_22c[11:2])? 1'b1: 1'b0;
wire cs_230 = (addr_in[11:2]==const_230[11:2])? 1'b1: 1'b0;
wire cs_234 = (addr_in[11:2]==const_234[11:2])? 1'b1: 1'b0;
wire cs_238 = (addr_in[11:2]==const_238[11:2])? 1'b1: 1'b0;
wire cs_23c = (addr_in[11:2]==const_23c[11:2])? 1'b1: 1'b0;
wire cs_240 = (addr_in[11:2]==const_240[11:2])? 1'b1: 1'b0;
wire cs_244 = (addr_in[11:2]==const_244[11:2])? 1'b1: 1'b0;
wire cs_248 = (addr_in[11:2]==const_248[11:2])? 1'b1: 1'b0;
wire cs_24c = (addr_in[11:2]==const_24c[11:2])? 1'b1: 1'b0;
wire cs_250 = (addr_in[11:2]==const_250[11:2])? 1'b1: 1'b0;
wire cs_254 = (addr_in[11:2]==const_254[11:2])? 1'b1: 1'b0;
wire cs_258 = (addr_in[11:2]==const_258[11:2])? 1'b1: 1'b0;
wire cs_25c = (addr_in[11:2]==const_25c[11:2])? 1'b1: 1'b0;
// tagger/untagger
wire cs_260 = (addr_in[11:2]==const_260[11:2])? 1'b1: 1'b0;
wire cs_264 = (addr_in[11:2]==const_264[11:2])? 1'b1: 1'b0;
wire cs_268 = (addr_in[11:2]==const_268[11:2])? 1'b1: 1'b0;
wire cs_26c = (addr_in[11:2]==const_26c[11:2])? 1'b1: 1'b0;
wire cs_270 = (addr_in[11:2]==const_270[11:2])? 1'b1: 1'b0;
wire cs_274 = (addr_in[11:2]==const_274[11:2])? 1'b1: 1'b0;
wire cs_278 = (addr_in[11:2]==const_278[11:2])? 1'b1: 1'b0;
wire cs_27c = (addr_in[11:2]==const_27c[11:2])? 1'b1: 1'b0;
wire cs_280 = (addr_in[11:2]==const_280[11:2])? 1'b1: 1'b0;
wire cs_284 = (addr_in[11:2]==const_284[11:2])? 1'b1: 1'b0;
wire cs_288 = (addr_in[11:2]==const_288[11:2])? 1'b1: 1'b0;
wire cs_28c = (addr_in[11:2]==const_28c[11:2])? 1'b1: 1'b0;
wire cs_290 = (addr_in[11:2]==const_290[11:2])? 1'b1: 1'b0;
wire cs_294 = (addr_in[11:2]==const_294[11:2])? 1'b1: 1'b0;
wire cs_298 = (addr_in[11:2]==const_298[11:2])? 1'b1: 1'b0;
wire cs_29c = (addr_in[11:2]==const_29c[11:2])? 1'b1: 1'b0;
// GCL time interval - Port 1
wire cs_2a0 = (addr_in[11:2]==const_2a0[11:2])? 1'b1: 1'b0;
wire cs_2a4 = (addr_in[11:2]==const_2a4[11:2])? 1'b1: 1'b0;
wire cs_2a8 = (addr_in[11:2]==const_2a8[11:2])? 1'b1: 1'b0;
wire cs_2ac = (addr_in[11:2]==const_2ac[11:2])? 1'b1: 1'b0;
wire cs_2b0 = (addr_in[11:2]==const_2b0[11:2])? 1'b1: 1'b0;
wire cs_2b4 = (addr_in[11:2]==const_2b4[11:2])? 1'b1: 1'b0;
wire cs_2b8 = (addr_in[11:2]==const_2b8[11:2])? 1'b1: 1'b0;
wire cs_2bc = (addr_in[11:2]==const_2bc[11:2])? 1'b1: 1'b0;
wire cs_2c0 = (addr_in[11:2]==const_2c0[11:2])? 1'b1: 1'b0;
wire cs_2c4 = (addr_in[11:2]==const_2c4[11:2])? 1'b1: 1'b0;
wire cs_2c8 = (addr_in[11:2]==const_2c8[11:2])? 1'b1: 1'b0;
wire cs_2cc = (addr_in[11:2]==const_2cc[11:2])? 1'b1: 1'b0;
wire cs_2d0 = (addr_in[11:2]==const_2d0[11:2])? 1'b1: 1'b0;
wire cs_2d4 = (addr_in[11:2]==const_2d4[11:2])? 1'b1: 1'b0;
wire cs_2d8 = (addr_in[11:2]==const_2d8[11:2])? 1'b1: 1'b0;
wire cs_2dc = (addr_in[11:2]==const_2dc[11:2])? 1'b1: 1'b0;
// GCL time interval - Port 2
wire cs_2e0 = (addr_in[11:2]==const_2e0[11:2])? 1'b1: 1'b0;
wire cs_2e4 = (addr_in[11:2]==const_2e4[11:2])? 1'b1: 1'b0;
wire cs_2e8 = (addr_in[11:2]==const_2e8[11:2])? 1'b1: 1'b0;
wire cs_2ec = (addr_in[11:2]==const_2ec[11:2])? 1'b1: 1'b0;
wire cs_2f0 = (addr_in[11:2]==const_2f0[11:2])? 1'b1: 1'b0;
wire cs_2f4 = (addr_in[11:2]==const_2f4[11:2])? 1'b1: 1'b0;
wire cs_2f8 = (addr_in[11:2]==const_2f8[11:2])? 1'b1: 1'b0;
wire cs_2fc = (addr_in[11:2]==const_2fc[11:2])? 1'b1: 1'b0;
wire cs_300 = (addr_in[11:2]==const_300[11:2])? 1'b1: 1'b0;
wire cs_304 = (addr_in[11:2]==const_304[11:2])? 1'b1: 1'b0;
wire cs_308 = (addr_in[11:2]==const_308[11:2])? 1'b1: 1'b0;
wire cs_30c = (addr_in[11:2]==const_30c[11:2])? 1'b1: 1'b0;
wire cs_310 = (addr_in[11:2]==const_310[11:2])? 1'b1: 1'b0;
wire cs_314 = (addr_in[11:2]==const_314[11:2])? 1'b1: 1'b0;
wire cs_318 = (addr_in[11:2]==const_318[11:2])? 1'b1: 1'b0;
wire cs_31c = (addr_in[11:2]==const_31c[11:2])? 1'b1: 1'b0;
// GCL time interval - Port 3
wire cs_320 = (addr_in[11:2]==const_320[11:2])? 1'b1: 1'b0;
wire cs_324 = (addr_in[11:2]==const_324[11:2])? 1'b1: 1'b0;
wire cs_328 = (addr_in[11:2]==const_328[11:2])? 1'b1: 1'b0;
wire cs_32c = (addr_in[11:2]==const_32c[11:2])? 1'b1: 1'b0;
wire cs_330 = (addr_in[11:2]==const_330[11:2])? 1'b1: 1'b0;
wire cs_334 = (addr_in[11:2]==const_334[11:2])? 1'b1: 1'b0;
wire cs_338 = (addr_in[11:2]==const_338[11:2])? 1'b1: 1'b0;
wire cs_33c = (addr_in[11:2]==const_33c[11:2])? 1'b1: 1'b0;
wire cs_340 = (addr_in[11:2]==const_340[11:2])? 1'b1: 1'b0;
wire cs_344 = (addr_in[11:2]==const_344[11:2])? 1'b1: 1'b0;
wire cs_348 = (addr_in[11:2]==const_348[11:2])? 1'b1: 1'b0;
wire cs_34c = (addr_in[11:2]==const_34c[11:2])? 1'b1: 1'b0;
wire cs_350 = (addr_in[11:2]==const_350[11:2])? 1'b1: 1'b0;
wire cs_354 = (addr_in[11:2]==const_354[11:2])? 1'b1: 1'b0;
wire cs_358 = (addr_in[11:2]==const_358[11:2])? 1'b1: 1'b0;
wire cs_35c = (addr_in[11:2]==const_35c[11:2])? 1'b1: 1'b0;
// GCL time interval - Port 4
wire cs_360 = (addr_in[11:2]==const_360[11:2])? 1'b1: 1'b0;
wire cs_364 = (addr_in[11:2]==const_364[11:2])? 1'b1: 1'b0;
wire cs_368 = (addr_in[11:2]==const_368[11:2])? 1'b1: 1'b0;
wire cs_36c = (addr_in[11:2]==const_36c[11:2])? 1'b1: 1'b0;
wire cs_370 = (addr_in[11:2]==const_370[11:2])? 1'b1: 1'b0;
wire cs_374 = (addr_in[11:2]==const_374[11:2])? 1'b1: 1'b0;
wire cs_378 = (addr_in[11:2]==const_378[11:2])? 1'b1: 1'b0;
wire cs_37c = (addr_in[11:2]==const_37c[11:2])? 1'b1: 1'b0;
wire cs_380 = (addr_in[11:2]==const_380[11:2])? 1'b1: 1'b0;
wire cs_384 = (addr_in[11:2]==const_384[11:2])? 1'b1: 1'b0;
wire cs_388 = (addr_in[11:2]==const_388[11:2])? 1'b1: 1'b0;
wire cs_38c = (addr_in[11:2]==const_38c[11:2])? 1'b1: 1'b0;
wire cs_390 = (addr_in[11:2]==const_390[11:2])? 1'b1: 1'b0;
wire cs_394 = (addr_in[11:2]==const_394[11:2])? 1'b1: 1'b0;
wire cs_398 = (addr_in[11:2]==const_398[11:2])? 1'b1: 1'b0;
wire cs_39c = (addr_in[11:2]==const_39c[11:2])? 1'b1: 1'b0;


reg [31:0] reg_000;  // ctrl 5 bit
reg [31:0] reg_004;  // scratch reg
reg [31:0] reg_008;  // null
reg [31:0] reg_00c;  // null
reg [31:0] reg_010;  // time 16 bit s
reg [31:0] reg_014;  // time 32 bit s
reg [31:0] reg_018;  // time 30 bit ns
reg [31:0] reg_01c;  // time  8 bit nsf
reg [31:0] reg_020;  // peri  8 bit ns
reg [31:0] reg_024;  // peri 32 bit nsf
reg [31:0] reg_028;  // ajpr  8 bit ns
reg [31:0] reg_02c;  // ajpr 32 bit nsf
reg [31:0] reg_030;  // ajld 32 bit
reg [31:0] reg_034;  // sync time offset 16 bit sec
reg [31:0] reg_038;  // sync time offset 32 bit sec
reg [31:0] reg_03c;  // sync time offset 32 bit ns

// TSU register - Port 0
reg [31:0] reg_040;  // ctrl  2 bit
reg [31:0] reg_044;  // qsta  8 bit
reg [31:0] reg_048;  // null
reg [31:0] reg_04c;  // null
reg [31:0] reg_050;  // rxqu 32 bit
reg [31:0] reg_054;  // rxqu 32 bit
reg [31:0] reg_058;  // rxqu 32 bit
reg [31:0] reg_05c;  // rxqu 32 bit

reg [31:0] reg_060;  // ctrl  2 bit
reg [31:0] reg_064;  // qsta  8 bit
reg [31:0] reg_068;  // null
reg [31:0] reg_06c;  // null
reg [31:0] reg_070;  // txqu 32 bit
reg [31:0] reg_074;  // txqu 32 bit
reg [31:0] reg_078;  // txqu 32 bit
reg [31:0] reg_07c;  // txqu 32 bit

// TSU register - Port 1
reg [31:0] reg_080;  // ctrl  2 bit
reg [31:0] reg_084;  // qsta  8 bit
reg [31:0] reg_088;  // null
reg [31:0] reg_08c;  // null
reg [31:0] reg_090;  // rxqu 32 bit
reg [31:0] reg_094;  // rxqu 32 bit
reg [31:0] reg_098;  // rxqu 32 bit
reg [31:0] reg_09c;  // rxqu 32 bit

reg [31:0] reg_0a0;  // ctrl  2 bit
reg [31:0] reg_0a4;  // qsta  8 bit
reg [31:0] reg_0a8;  // null
reg [31:0] reg_0ac;  // null
reg [31:0] reg_0b0;  // txqu 32 bit
reg [31:0] reg_0b4;  // txqu 32 bit
reg [31:0] reg_0b8;  // txqu 32 bit
reg [31:0] reg_0bc;  // txqu 32 bit

// TSU register - Port 2
reg [31:0] reg_0c0;  // ctrl  2 bit
reg [31:0] reg_0c4;  // qsta  8 bit
reg [31:0] reg_0c8;  // null
reg [31:0] reg_0cc;  // null
reg [31:0] reg_0d0;  // rxqu 32 bit
reg [31:0] reg_0d4;  // rxqu 32 bit
reg [31:0] reg_0d8;  // rxqu 32 bit
reg [31:0] reg_0dc;  // rxqu 32 bit

reg [31:0] reg_0e0;  // ctrl  2 bit
reg [31:0] reg_0e4;  // qsta  8 bit
reg [31:0] reg_0e8;  // null
reg [31:0] reg_0ec;  // null
reg [31:0] reg_0f0;  // txqu 32 bit
reg [31:0] reg_0f4;  // txqu 32 bit
reg [31:0] reg_0f8;  // txqu 32 bit
reg [31:0] reg_0fc;  // txqu 32 bit

// TSU register - Port 3
reg [31:0] reg_100;  // ctrl  2 bit
reg [31:0] reg_104;  // qsta  8 bit
reg [31:0] reg_108;  // null
reg [31:0] reg_10c;  // null
reg [31:0] reg_110;  // rxqu 32 bit
reg [31:0] reg_114;  // rxqu 32 bit
reg [31:0] reg_118;  // rxqu 32 bit
reg [31:0] reg_11c;  // rxqu 32 bit

reg [31:0] reg_120;  // ctrl  2 bit
reg [31:0] reg_124;  // qsta  8 bit
reg [31:0] reg_128;  // null
reg [31:0] reg_12c;  // null
reg [31:0] reg_130;  // txqu 32 bit
reg [31:0] reg_134;  // txqu 32 bit
reg [31:0] reg_138;  // txqu 32 bit
reg [31:0] reg_13c;  // txqu 32 bit

reg [31:0] reg_140;  // sync time 16 bit sec
reg [31:0] reg_144;  // sync time 32 bit sec
reg [31:0] reg_148;  // sync time 32 bit ns
reg [31:0] reg_14c;  // null
// GCL write data 
// GCL id (4 bits) + GCL write data (9 bits)

// GCL register - Port 1 
reg [31:0] reg_150; // ctrl 2 bit
reg [31:0] reg_154; // GCL[0]  - Port 1 
reg [31:0] reg_158; // GCL[1]  - Port 1 
reg [31:0] reg_15c; // GCL[2]  - Port 1 
reg [31:0] reg_160; // GCL[3]  - Port 1 
reg [31:0] reg_164; // GCL[4]  - Port 1 
reg [31:0] reg_168; // GCL[5]  - Port 1 
reg [31:0] reg_16c; // GCL[6]  - Port 1 
reg [31:0] reg_170; // GCL[7]  - Port 1 
reg [31:0] reg_174; // GCL[8]  - Port 1 
reg [31:0] reg_178; // GCL[9]  - Port 1 
reg [31:0] reg_17c; // GCL[10] - Port 1 
reg [31:0] reg_180; // GCL[11] - Port 1 
reg [31:0] reg_184; // GCL[12] - Port 1 
reg [31:0] reg_188; // GCL[13] - Port 1 
reg [31:0] reg_18c; // GCL[14] - Port 1 
reg [31:0] reg_190; // GCL[15] - Port 1 
// GCL register - Port 2
reg [31:0] reg_194; // ctrl 2 bit
reg [31:0] reg_198; // GCL[0]  - Port 2  
reg [31:0] reg_19c; // GCL[1]  - Port 2 
reg [31:0] reg_1a0; // GCL[2]  - Port 2 
reg [31:0] reg_1a4; // GCL[3]  - Port 2 
reg [31:0] reg_1a8; // GCL[4]  - Port 2 
reg [31:0] reg_1ac; // GCL[5]  - Port 2 
reg [31:0] reg_1b0; // GCL[6]  - Port 2 
reg [31:0] reg_1b4; // GCL[7]  - Port 2 
reg [31:0] reg_1b8; // GCL[8]  - Port 2 
reg [31:0] reg_1bc; // GCL[9]  - Port 2 
reg [31:0] reg_1c0; // GCL[10] - Port 2 
reg [31:0] reg_1c4; // GCL[11] - Port 2 
reg [31:0] reg_1c8; // GCL[12] - Port 2 
reg [31:0] reg_1cc; // GCL[13] - Port 2 
reg [31:0] reg_1d0; // GCL[14] - Port 2 
reg [31:0] reg_1d4; // GCL[15] - Port 2 
// GCL register - Port 3
reg [31:0] reg_1d8; // ctrl 2 bit
reg [31:0] reg_1dc; // GCL[0]  - Port 3  
reg [31:0] reg_1e0; // GCL[1]  - Port 3 
reg [31:0] reg_1e4; // GCL[2]  - Port 3 
reg [31:0] reg_1e8; // GCL[3]  - Port 3 
reg [31:0] reg_1ec; // GCL[4]  - Port 3 
reg [31:0] reg_1f0; // GCL[5]  - Port 3 
reg [31:0] reg_1f4; // GCL[6]  - Port 3 
reg [31:0] reg_1f8; // GCL[7]  - Port 3 
reg [31:0] reg_1fc; // GCL[8]  - Port 3 
reg [31:0] reg_200; // GCL[9]  - Port 3 
reg [31:0] reg_204; // GCL[10] - Port 3 
reg [31:0] reg_208; // GCL[11] - Port 3 
reg [31:0] reg_20c; // GCL[12] - Port 3 
reg [31:0] reg_210; // GCL[13] - Port 3 
reg [31:0] reg_214; // GCL[14] - Port 3 
reg [31:0] reg_218; // GCL[15] - Port 3 
// GCL register - Port 4
reg [31:0] reg_21c; // ctrl 2 bit
reg [31:0] reg_220; // GCL[0]  - Port 4 
reg [31:0] reg_224; // GCL[1]  - Port 4 
reg [31:0] reg_228; // GCL[2]  - Port 4 
reg [31:0] reg_22c; // GCL[3]  - Port 4 
reg [31:0] reg_230; // GCL[4]  - Port 4 
reg [31:0] reg_234; // GCL[5]  - Port 4 
reg [31:0] reg_238; // GCL[6]  - Port 4 
reg [31:0] reg_23c; // GCL[7]  - Port 4 
reg [31:0] reg_240; // GCL[8]  - Port 4 
reg [31:0] reg_244; // GCL[9]  - Port 4 
reg [31:0] reg_248; // GCL[10] - Port 4 
reg [31:0] reg_24c; // GCL[11] - Port 4 
reg [31:0] reg_250; // GCL[12] - Port 4 
reg [31:0] reg_254; // GCL[13] - Port 4 
reg [31:0] reg_258; // GCL[14] - Port 4 
reg [31:0] reg_25c; // GCL[15] - Port 4 

// tagger/untagger register
// Port 1
// ctrl 2 bits, lower bit: tagger_ctrl_ld bit, higher bit: priority_ld bit
reg [31:0] reg_260; 
// tagger 1 bit, tagger(1) or not
reg [31:0] reg_264; 
// untagger 1 bits, untagger(1) or not
reg [31:0] reg_268;
// priority 3 bits, 0-7
reg [31:0] reg_26c;
// Port 2 
reg [31:0] reg_270;
reg [31:0] reg_274;
reg [31:0] reg_278;
reg [31:0] reg_27c;
// Port 3
reg [31:0] reg_280;
reg [31:0] reg_284;
reg [31:0] reg_288;
reg [31:0] reg_28c;
// Port 4 
reg [31:0] reg_290;
reg [31:0] reg_294;
reg [31:0] reg_298;
reg [31:0] reg_29c;

// GCL time interval - Port 1
reg [31:0] reg_2a0;
reg [31:0] reg_2a4;
reg [31:0] reg_2a8;
reg [31:0] reg_2ac;
reg [31:0] reg_2b0;
reg [31:0] reg_2b4;
reg [31:0] reg_2b8;
reg [31:0] reg_2bc;
reg [31:0] reg_2c0;
reg [31:0] reg_2c4;
reg [31:0] reg_2c8;
reg [31:0] reg_2cc;
reg [31:0] reg_2d0;
reg [31:0] reg_2d4;
reg [31:0] reg_2d8;
reg [31:0] reg_2dc;
// GCL time interval - Port 2
reg [31:0] reg_2e0;
reg [31:0] reg_2e4;
reg [31:0] reg_2e8;
reg [31:0] reg_2ec;
reg [31:0] reg_2f0;
reg [31:0] reg_2f4;
reg [31:0] reg_2f8;
reg [31:0] reg_2fc;
reg [31:0] reg_300;
reg [31:0] reg_304;
reg [31:0] reg_308;
reg [31:0] reg_30c;
reg [31:0] reg_310;
reg [31:0] reg_314;
reg [31:0] reg_318;
reg [31:0] reg_31c;
// GCL time interval - Port 3
reg [31:0] reg_320;
reg [31:0] reg_324;
reg [31:0] reg_328;
reg [31:0] reg_32c;
reg [31:0] reg_330;
reg [31:0] reg_334;
reg [31:0] reg_338;
reg [31:0] reg_33c;
reg [31:0] reg_340;
reg [31:0] reg_344;
reg [31:0] reg_348;
reg [31:0] reg_34c;
reg [31:0] reg_350;
reg [31:0] reg_354;
reg [31:0] reg_358;
reg [31:0] reg_35c;
// GCL time interval - Port 4
reg [31:0] reg_360;
reg [31:0] reg_364;
reg [31:0] reg_368;
reg [31:0] reg_36c;
reg [31:0] reg_370;
reg [31:0] reg_374;
reg [31:0] reg_378;
reg [31:0] reg_37c;
reg [31:0] reg_380;
reg [31:0] reg_384;
reg [31:0] reg_388;
reg [31:0] reg_38c;
reg [31:0] reg_390;
reg [31:0] reg_394;
reg [31:0] reg_398;
reg [31:0] reg_39c;

wire [  7:0] rx_q_stat_in [0:3];
wire [127:0] rx_q_data_in [0:3];
wire [  7:0] tx_q_stat_in [0:3];
wire [127:0] tx_q_data_in [0:3];

assign {rx_q_stat_in[3], rx_q_stat_in[2], rx_q_stat_in[1], rx_q_stat_in[0]} = rx_q_stat_in_flat;
assign {rx_q_data_in[3], rx_q_data_in[2], rx_q_data_in[1], rx_q_data_in[0]} = rx_q_data_in_flat;
assign {tx_q_stat_in[3], tx_q_stat_in[2], tx_q_stat_in[1], tx_q_stat_in[0]} = tx_q_stat_in_flat;
assign {tx_q_data_in[3], tx_q_data_in[2], tx_q_data_in[1], tx_q_data_in[0]} = tx_q_data_in_flat;

wire [  7:0] rx_q_ptp_msgid_mask_out [0:3];
wire [  7:0] tx_q_ptp_msgid_mask_out [0:3];

assign rx_q_ptp_msgid_mask_out_flat = {rx_q_ptp_msgid_mask_out[3], rx_q_ptp_msgid_mask_out[2], rx_q_ptp_msgid_mask_out[1], rx_q_ptp_msgid_mask_out[0]};
assign tx_q_ptp_msgid_mask_out_flat = {tx_q_ptp_msgid_mask_out[3], tx_q_ptp_msgid_mask_out[2], tx_q_ptp_msgid_mask_out[1], tx_q_ptp_msgid_mask_out[0]};

wire [575:0] gcl_data_in [0:3];
assign {gcl_data_in[3], gcl_data_in[2], gcl_data_in[1], gcl_data_in[0]} = gcl_data_in_flat;


reg [31:0] wt_gcl_data_int;

// write registers
always @(posedge clk) begin
    if (wr_in && cs_000) reg_000 <= data_in;
    if (wr_in && cs_004) reg_004 <= data_in;
    if (wr_in && cs_008) reg_008 <= data_in;
    if (wr_in && cs_00c) reg_00c <= data_in;
    if (wr_in && cs_010) reg_010 <= data_in;
    if (wr_in && cs_014) reg_014 <= data_in;
    if (wr_in && cs_018) reg_018 <= data_in;
    if (wr_in && cs_01c) reg_01c <= data_in;
    if (wr_in && cs_020) reg_020 <= data_in;
    if (wr_in && cs_024) reg_024 <= data_in;
    if (wr_in && cs_028) reg_028 <= data_in;
    if (wr_in && cs_02c) reg_02c <= data_in;
    if (wr_in && cs_030) reg_030 <= data_in;
    if (wr_in && cs_034) reg_034 <= data_in;
    if (wr_in && cs_038) reg_038 <= data_in;
    if (wr_in && cs_03c) reg_03c <= data_in;
    if (wr_in && cs_040) reg_040 <= data_in;
    if (wr_in && cs_044) reg_044 <= data_in;
    if (wr_in && cs_048) reg_048 <= data_in;
    if (wr_in && cs_04c) reg_04c <= data_in;
    if (wr_in && cs_050) reg_050 <= data_in;
    if (wr_in && cs_054) reg_054 <= data_in;
    if (wr_in && cs_058) reg_058 <= data_in;
    if (wr_in && cs_05c) reg_05c <= data_in;
    if (wr_in && cs_060) reg_060 <= data_in;
    if (wr_in && cs_064) reg_064 <= data_in;
    if (wr_in && cs_068) reg_068 <= data_in;
    if (wr_in && cs_06c) reg_06c <= data_in;
    if (wr_in && cs_070) reg_070 <= data_in;
    if (wr_in && cs_074) reg_074 <= data_in;
    if (wr_in && cs_078) reg_078 <= data_in;
    if (wr_in && cs_07c) reg_07c <= data_in;
    if (wr_in && cs_080) reg_080 <= data_in;
    if (wr_in && cs_084) reg_084 <= data_in;
    if (wr_in && cs_088) reg_088 <= data_in;
    if (wr_in && cs_08c) reg_08c <= data_in;
    if (wr_in && cs_090) reg_090 <= data_in;
    if (wr_in && cs_094) reg_094 <= data_in;
    if (wr_in && cs_098) reg_098 <= data_in;
    if (wr_in && cs_09c) reg_09c <= data_in;
    if (wr_in && cs_0a0) reg_0a0 <= data_in;
    if (wr_in && cs_0a4) reg_0a4 <= data_in;
    if (wr_in && cs_0a8) reg_0a8 <= data_in;
    if (wr_in && cs_0ac) reg_0ac <= data_in;
    if (wr_in && cs_0b0) reg_0b0 <= data_in;
    if (wr_in && cs_0b4) reg_0b4 <= data_in;
    if (wr_in && cs_0b8) reg_0b8 <= data_in;
    if (wr_in && cs_0bc) reg_0bc <= data_in;
    if (wr_in && cs_0c0) reg_0c0 <= data_in;
    if (wr_in && cs_0c4) reg_0c4 <= data_in;
    if (wr_in && cs_0c8) reg_0c8 <= data_in;
    if (wr_in && cs_0cc) reg_0cc <= data_in;
    if (wr_in && cs_0d0) reg_0d0 <= data_in;
    if (wr_in && cs_0d4) reg_0d4 <= data_in;
    if (wr_in && cs_0d8) reg_0d8 <= data_in;
    if (wr_in && cs_0dc) reg_0dc <= data_in;
    if (wr_in && cs_0e0) reg_0e0 <= data_in;
    if (wr_in && cs_0e4) reg_0e4 <= data_in;
    if (wr_in && cs_0e8) reg_0e8 <= data_in;
    if (wr_in && cs_0ec) reg_0ec <= data_in;
    if (wr_in && cs_0f0) reg_0f0 <= data_in;
    if (wr_in && cs_0f4) reg_0f4 <= data_in;
    if (wr_in && cs_0f8) reg_0f8 <= data_in;
    if (wr_in && cs_0fc) reg_0fc <= data_in;
    if (wr_in && cs_100) reg_100 <= data_in;
    if (wr_in && cs_104) reg_104 <= data_in;
    if (wr_in && cs_108) reg_108 <= data_in;
    if (wr_in && cs_10c) reg_10c <= data_in;
    if (wr_in && cs_110) reg_110 <= data_in;
    if (wr_in && cs_114) reg_114 <= data_in;
    if (wr_in && cs_118) reg_118 <= data_in;
    if (wr_in && cs_11c) reg_11c <= data_in;
    if (wr_in && cs_120) reg_120 <= data_in;
    if (wr_in && cs_124) reg_124 <= data_in;
    if (wr_in && cs_128) reg_128 <= data_in;
    if (wr_in && cs_12c) reg_12c <= data_in;
    if (wr_in && cs_130) reg_130 <= data_in;
    if (wr_in && cs_134) reg_134 <= data_in;
    if (wr_in && cs_138) reg_138 <= data_in;
    if (wr_in && cs_13c) reg_13c <= data_in;
    if (wr_in && cs_140) reg_140 <= data_in;
    if (wr_in && cs_144) reg_144 <= data_in;
    if (wr_in && cs_148) reg_148 <= data_in;
    if (wr_in && cs_14c) reg_14c <= data_in;
    // GCL
    if (wr_in && cs_150) reg_150 <= data_in; // ctrl - port0
    if (wr_in && cs_154) reg_154 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_158) reg_158 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_15c) reg_15c <= {23'b0, data_in[8:0]};
    if (wr_in && cs_160) reg_160 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_164) reg_164 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_168) reg_168 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_16c) reg_16c <= {23'b0, data_in[8:0]};
    if (wr_in && cs_170) reg_170 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_174) reg_174 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_178) reg_178 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_17c) reg_17c <= {23'b0, data_in[8:0]};
    if (wr_in && cs_180) reg_180 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_184) reg_184 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_188) reg_188 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_18c) reg_18c <= {23'b0, data_in[8:0]};
    if (wr_in && cs_190) reg_190 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_194) reg_194 <= data_in; // ctrl - port1
    if (wr_in && cs_198) reg_198 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_19c) reg_19c <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1a0) reg_1a0 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1a4) reg_1a4 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1a8) reg_1a8 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1ac) reg_1ac <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1b0) reg_1b0 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1b4) reg_1b4 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1b8) reg_1b8 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1bc) reg_1bc <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1c0) reg_1c0 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1c4) reg_1c4 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1c8) reg_1c8 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1cc) reg_1cc <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1d0) reg_1d0 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1d4) reg_1d4 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1d8) reg_1d8 <= data_in; // ctrl - port2
    if (wr_in && cs_1dc) reg_1dc <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1e0) reg_1e0 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1e4) reg_1e4 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1e8) reg_1e8 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1ec) reg_1ec <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1f0) reg_1f0 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1f4) reg_1f4 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1f8) reg_1f8 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_1fc) reg_1fc <= {23'b0, data_in[8:0]};
    if (wr_in && cs_200) reg_200 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_204) reg_204 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_208) reg_208 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_20c) reg_20c <= {23'b0, data_in[8:0]};
    if (wr_in && cs_210) reg_210 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_214) reg_214 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_218) reg_218 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_21c) reg_21c <= data_in; // ctrl - port3
    if (wr_in && cs_220) reg_220 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_224) reg_224 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_228) reg_228 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_22c) reg_22c <= {23'b0, data_in[8:0]};
    if (wr_in && cs_230) reg_230 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_234) reg_234 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_238) reg_238 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_23c) reg_23c <= {23'b0, data_in[8:0]};
    if (wr_in && cs_240) reg_240 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_244) reg_244 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_248) reg_248 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_24c) reg_24c <= {23'b0, data_in[8:0]};
    if (wr_in && cs_250) reg_250 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_254) reg_254 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_258) reg_258 <= {23'b0, data_in[8:0]};
    if (wr_in && cs_25c) reg_25c <= {23'b0, data_in[8:0]};

    if (wr_in && (cs_154 || cs_158 || cs_15c || cs_160 ||
    cs_164 || cs_168 || cs_16c || cs_170 ||
    cs_174 || cs_178 || cs_17c || cs_180 ||
    cs_184 || cs_188 || cs_18c || cs_190 ||
    cs_198 || cs_19c || cs_1a0 || cs_1a4 ||
    cs_1a8 || cs_1ac || cs_1b0 || cs_1b4 ||
    cs_1b8 || cs_1bc || cs_1c0 || cs_1c4 ||
    cs_1c8 || cs_1cc || cs_1d0 || cs_1d4 ||
    cs_1dc || cs_1e0 || cs_1e4 || cs_1e8 ||
    cs_1ec || cs_1f0 || cs_1f4 || cs_1f8 ||
    cs_1fc || cs_200 || cs_204 || cs_208 ||
    cs_20c || cs_210 || cs_214 || cs_218 ||
    cs_220 || cs_224 || cs_228 || cs_22c ||
    cs_230 || cs_234 || cs_238 || cs_23c ||
    cs_240 || cs_244 || cs_248 || cs_24c ||
    cs_250 || cs_254 || cs_258 || cs_25c
    )) wt_gcl_data_int <= data_in;

    if (wr_in && cs_2a0) reg_2a0 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_2a4) reg_2a4 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_2a8) reg_2a8 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_2ac) reg_2ac <= {12'b0, data_in[19:0]};
    if (wr_in && cs_2b0) reg_2b0 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_2b4) reg_2b4 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_2b8) reg_2b8 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_2bc) reg_2bc <= {12'b0, data_in[19:0]};
    if (wr_in && cs_2c0) reg_2c0 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_2c4) reg_2c4 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_2c8) reg_2c8 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_2cc) reg_2cc <= {12'b0, data_in[19:0]};
    if (wr_in && cs_2d0) reg_2d0 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_2d4) reg_2d4 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_2d8) reg_2d8 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_2dc) reg_2dc <= {12'b0, data_in[19:0]};
    
    if (wr_in && cs_2e0) reg_2e0 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_2e4) reg_2e4 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_2e8) reg_2e8 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_2ec) reg_2ec <= {12'b0, data_in[19:0]};
    if (wr_in && cs_2f0) reg_2f0 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_2f4) reg_2f4 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_2f8) reg_2f8 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_2fc) reg_2fc <= {12'b0, data_in[19:0]};
    if (wr_in && cs_300) reg_300 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_304) reg_304 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_308) reg_308 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_30c) reg_30c <= {12'b0, data_in[19:0]};
    if (wr_in && cs_310) reg_310 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_314) reg_314 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_318) reg_318 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_31c) reg_31c <= {12'b0, data_in[19:0]};
    
    if (wr_in && cs_320) reg_320 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_324) reg_324 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_328) reg_328 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_32c) reg_32c <= {12'b0, data_in[19:0]};
    if (wr_in && cs_330) reg_330 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_334) reg_334 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_338) reg_338 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_33c) reg_33c <= {12'b0, data_in[19:0]};
    if (wr_in && cs_340) reg_340 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_344) reg_344 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_348) reg_348 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_34c) reg_34c <= {12'b0, data_in[19:0]};
    if (wr_in && cs_350) reg_350 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_354) reg_354 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_358) reg_358 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_35c) reg_35c <= {12'b0, data_in[19:0]};

    if (wr_in && cs_360) reg_360 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_364) reg_364 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_368) reg_368 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_36c) reg_36c <= {12'b0, data_in[19:0]};
    if (wr_in && cs_370) reg_370 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_374) reg_374 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_378) reg_378 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_37c) reg_37c <= {12'b0, data_in[19:0]};
    if (wr_in && cs_380) reg_380 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_384) reg_384 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_388) reg_388 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_38c) reg_38c <= {12'b0, data_in[19:0]};
    if (wr_in && cs_390) reg_390 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_394) reg_394 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_398) reg_398 <= {12'b0, data_in[19:0]};
    if (wr_in && cs_39c) reg_39c <= {12'b0, data_in[19:0]};

    if (wr_in && (cs_2a0 || cs_2a4 || cs_2a8 || cs_2ac ||
    cs_2b0 || cs_2b4 || cs_2b8 || cs_2bc ||
    cs_2c0 || cs_2c4 || cs_2c8 || cs_2cc ||
    cs_2d0 || cs_2d4 || cs_2d8 || cs_2dc ||
    cs_2e0 || cs_2e4 || cs_2e8 || cs_2ec ||
    cs_2f0 || cs_2f4 || cs_2f8 || cs_2fc ||
    cs_300 || cs_304 || cs_308 || cs_30c ||
    cs_310 || cs_314 || cs_318 || cs_31c ||
    cs_320 || cs_324 || cs_328 || cs_32c ||
    cs_330 || cs_334 || cs_338 || cs_33c ||
    cs_340 || cs_344 || cs_348 || cs_34c ||
    cs_350 || cs_354 || cs_358 || cs_35c ||
    cs_360 || cs_364 || cs_368 || cs_36c ||
    cs_370 || cs_374 || cs_378 || cs_37c ||
    cs_380 || cs_384 || cs_388 || cs_38c ||
    cs_390 || cs_394 || cs_398 || cs_39c
    )) wt_gcl_data_int <= data_in;

    
end

// read registers
reg  [ 37:0] time_reg_ns_int;
reg  [ 47:0] time_reg_sec_int;
reg  [ 31:0] sync_time_ns_int;
reg  [ 47:0] sync_time_sec_int;
reg  [127:0] rx_q_data_int [0:3];
reg  [  7:0] rx_q_stat_int [0:3];
reg  [127:0] tx_q_data_int [0:3];
reg  [  7:0] tx_q_stat_int [0:3];
reg          time_ok;
reg  [  3:0] rxqu_ok;
reg  [  3:0] txqu_ok;

reg  [127:0] gcl_data_int [0:3];

// Debug signals
wire rd_in_debug = rd_in;
wire wr_in_debug = wr_in;
wire [11:0] addr_in_debug = addr_in;
wire [7:0] data_in_debug = data_in[7:0];
wire [7:0] data_out_debug = data_out[7:0];
wire adj_ld_done_in_debug = adj_ld_done_in;
wire time_ok_debug = time_ok;
wire time_rd_req;
wire time_rd_req_debug = time_rd_req;
wire time_rd_ack;
wire time_rd_ack_debug = time_rd_ack;

reg  [31:0] data_out_reg;
always @(posedge clk) begin
    // register mapping: RTC
    if (rd_in && cs_000) data_out_reg <= {26'd0, reg_000[ 5: 2], adj_ld_done_in, time_ok};
    if (rd_in && cs_004) data_out_reg <= reg_004;
    if (rd_in && cs_008) data_out_reg <= 32'd0;
    if (rd_in && cs_00c) data_out_reg <= 32'd0;
    if (rd_in && cs_010) data_out_reg <= {16'd0, time_reg_sec_int[47:32]};
    if (rd_in && cs_014) data_out_reg <=         time_reg_sec_int[31: 0] ;
    if (rd_in && cs_018) data_out_reg <= { 2'd0, time_reg_ns_int [37: 8]};
    if (rd_in && cs_01c) data_out_reg <= {24'd0, time_reg_ns_int [ 7: 0]};
    if (rd_in && cs_020) data_out_reg <= {24'd0, reg_020[ 7: 0]};
    if (rd_in && cs_024) data_out_reg <= reg_024;
    if (rd_in && cs_028) data_out_reg <= {24'd0, reg_028[ 7: 0]};
    if (rd_in && cs_02c) data_out_reg <= reg_02c;
    if (rd_in && cs_030) data_out_reg <= reg_030;
    if (rd_in && cs_034) data_out_reg <= 32'd0;
    if (rd_in && cs_038) data_out_reg <= 32'd0;
    if (rd_in && cs_03c) data_out_reg <= 32'd0;
    // register mapping: TSU RX Port 0
    if (rd_in && cs_040) data_out_reg <= {30'd0, reg_040[ 1], rxqu_ok[0]};
    if (rd_in && cs_044) data_out_reg <= {reg_044[31:24], 16'd0, rx_q_stat_int[0][ 7: 0]};
    if (rd_in && cs_048) data_out_reg <= 32'd0;
    if (rd_in && cs_04c) data_out_reg <= 32'd0;
    if (rd_in && cs_050) data_out_reg <= rx_q_data_int[0][127: 96];
    if (rd_in && cs_054) data_out_reg <= rx_q_data_int[0][ 95: 64];
    if (rd_in && cs_058) data_out_reg <= rx_q_data_int[0][ 63: 32];
    if (rd_in && cs_05c) data_out_reg <= rx_q_data_int[0][ 31:  0];
    // register mapping: TSU TX Port 0
    if (rd_in && cs_060) data_out_reg <= {30'd0, reg_060[ 1], txqu_ok[0]}; 
    if (rd_in && cs_064) data_out_reg <= {reg_064[31:24], 16'd0, tx_q_stat_int[0][ 7: 0]};
    if (rd_in && cs_068) data_out_reg <= 32'd0;
    if (rd_in && cs_06c) data_out_reg <= 32'd0;
    if (rd_in && cs_070) data_out_reg <= tx_q_data_int[0][127: 96];
    if (rd_in && cs_074) data_out_reg <= tx_q_data_int[0][ 95: 64];
    if (rd_in && cs_078) data_out_reg <= tx_q_data_int[0][ 63: 32];
    if (rd_in && cs_07c) data_out_reg <= tx_q_data_int[0][ 31:  0];
    // register mapping: TSU RX Port 1
    if (rd_in && cs_080) data_out_reg <= {30'd0, reg_080[ 1], rxqu_ok[1]};
    if (rd_in && cs_084) data_out_reg <= {reg_084[31:24], 16'd0, rx_q_stat_int[1][ 7: 0]};
    if (rd_in && cs_088) data_out_reg <= 32'd0;
    if (rd_in && cs_08c) data_out_reg <= 32'd0;
    if (rd_in && cs_090) data_out_reg <= rx_q_data_int[1][127: 96];
    if (rd_in && cs_094) data_out_reg <= rx_q_data_int[1][ 95: 64];
    if (rd_in && cs_098) data_out_reg <= rx_q_data_int[1][ 63: 32];
    if (rd_in && cs_09c) data_out_reg <= rx_q_data_int[1][ 31:  0];
    // register mapping: TSU TX Port 1
    if (rd_in && cs_0a0) data_out_reg <= {30'd0, reg_0a0[ 1], txqu_ok[1]}; 
    if (rd_in && cs_0a4) data_out_reg <= {reg_0a4[31:24], 16'd0, tx_q_stat_int[1][ 7: 0]};
    if (rd_in && cs_0a8) data_out_reg <= 32'd0;
    if (rd_in && cs_0ac) data_out_reg <= 32'd0;
    if (rd_in && cs_0b0) data_out_reg <= tx_q_data_int[1][127: 96];
    if (rd_in && cs_0b4) data_out_reg <= tx_q_data_int[1][ 95: 64];
    if (rd_in && cs_0b8) data_out_reg <= tx_q_data_int[1][ 63: 32];
    if (rd_in && cs_0bc) data_out_reg <= tx_q_data_int[1][ 31:  0];
    // register mapping: TSU RX Port 2
    if (rd_in && cs_0c0) data_out_reg <= {30'd0, reg_0c0[ 1], rxqu_ok[2]};
    if (rd_in && cs_0c4) data_out_reg <= {reg_0c4[31:24], 16'd0, rx_q_stat_int[2][ 7: 0]};
    if (rd_in && cs_0c8) data_out_reg <= 32'd0;
    if (rd_in && cs_0cc) data_out_reg <= 32'd0;
    if (rd_in && cs_0d0) data_out_reg <= rx_q_data_int[2][127: 96];
    if (rd_in && cs_0d4) data_out_reg <= rx_q_data_int[2][ 95: 64];
    if (rd_in && cs_0d8) data_out_reg <= rx_q_data_int[2][ 63: 32];
    if (rd_in && cs_0dc) data_out_reg <= rx_q_data_int[2][ 31:  0];
    // register mapping: TSU TX Port 2
    if (rd_in && cs_0e0) data_out_reg <= {30'd0, reg_0e0[ 1], txqu_ok[2]}; 
    if (rd_in && cs_0e4) data_out_reg <= {reg_0e4[31:24], 16'd0, tx_q_stat_int[2][ 7: 0]};
    if (rd_in && cs_0e8) data_out_reg <= 32'd0;
    if (rd_in && cs_0ec) data_out_reg <= 32'd0;
    if (rd_in && cs_0f0) data_out_reg <= tx_q_data_int[2][127: 96];
    if (rd_in && cs_0f4) data_out_reg <= tx_q_data_int[2][ 95: 64];
    if (rd_in && cs_0f8) data_out_reg <= tx_q_data_int[2][ 63: 32];
    if (rd_in && cs_0fc) data_out_reg <= tx_q_data_int[2][ 31:  0];
    // register mapping: TSU RX Port 3
    if (rd_in && cs_100) data_out_reg <= {30'd0, reg_100[ 1], rxqu_ok[3]};
    if (rd_in && cs_104) data_out_reg <= {reg_104[31:24], 16'd0, rx_q_stat_int[3][ 7: 0]};
    if (rd_in && cs_108) data_out_reg <= 32'd0;
    if (rd_in && cs_10c) data_out_reg <= 32'd0;
    if (rd_in && cs_110) data_out_reg <= rx_q_data_int[3][127: 96];
    if (rd_in && cs_114) data_out_reg <= rx_q_data_int[3][ 95: 64];
    if (rd_in && cs_118) data_out_reg <= rx_q_data_int[3][ 63: 32];
    if (rd_in && cs_11c) data_out_reg <= rx_q_data_int[3][ 31:  0];
    // register mapping: TSU TX Port 3
    if (rd_in && cs_120) data_out_reg <= {30'd0, reg_120[ 1], txqu_ok[3]}; 
    if (rd_in && cs_124) data_out_reg <= {reg_124[31:24], 16'd0, tx_q_stat_int[3][ 7: 0]};
    if (rd_in && cs_128) data_out_reg <= 32'd0;
    if (rd_in && cs_12c) data_out_reg <= 32'd0;
    if (rd_in && cs_130) data_out_reg <= tx_q_data_int[3][127: 96];
    if (rd_in && cs_134) data_out_reg <= tx_q_data_int[3][ 95: 64];
    if (rd_in && cs_138) data_out_reg <= tx_q_data_int[3][ 63: 32];
    if (rd_in && cs_13c) data_out_reg <= tx_q_data_int[3][ 31:  0];
    // register mapping: Sync time
    if (rd_in && cs_140) data_out_reg <= {16'd0, sync_time_sec_int[47:32]};
    if (rd_in && cs_144) data_out_reg <= sync_time_sec_int[31:0];
    if (rd_in && cs_148) data_out_reg <= sync_time_ns_int;
    if (rd_in && cs_14c) data_out_reg <= 32'd0;

    // register mapping: GCL Port 0
    if (rd_in && cs_150) data_out_reg <= {30'd0, reg_150[1], 1'd0};
    if (rd_in && cs_154) data_out_reg <= reg_154;
    if (rd_in && cs_158) data_out_reg <= reg_158;
    if (rd_in && cs_15c) data_out_reg <= reg_15c;
    if (rd_in && cs_160) data_out_reg <= reg_160;
    if (rd_in && cs_164) data_out_reg <= reg_164;
    if (rd_in && cs_168) data_out_reg <= reg_168;
    if (rd_in && cs_16c) data_out_reg <= reg_16c;
    if (rd_in && cs_170) data_out_reg <= reg_170;
    if (rd_in && cs_174) data_out_reg <= reg_174;
    if (rd_in && cs_178) data_out_reg <= reg_178;
    if (rd_in && cs_17c) data_out_reg <= reg_17c;
    if (rd_in && cs_180) data_out_reg <= reg_180;
    if (rd_in && cs_184) data_out_reg <= reg_184;
    if (rd_in && cs_188) data_out_reg <= reg_188;
    if (rd_in && cs_18c) data_out_reg <= reg_18c;
    if (rd_in && cs_190) data_out_reg <= reg_190;

    // register mapping: GCL Port 1
    if (rd_in && cs_194) data_out_reg <= {30'd0, reg_194[1], 1'd0};
    if (rd_in && cs_198) data_out_reg <= reg_198;
    if (rd_in && cs_19c) data_out_reg <= reg_19c;
    if (rd_in && cs_1a0) data_out_reg <= reg_1a0;
    if (rd_in && cs_1a4) data_out_reg <= reg_1a4;
    if (rd_in && cs_1a8) data_out_reg <= reg_1a8;
    if (rd_in && cs_1ac) data_out_reg <= reg_1ac;
    if (rd_in && cs_1b0) data_out_reg <= reg_1b0;
    if (rd_in && cs_1b4) data_out_reg <= reg_1b4;
    if (rd_in && cs_1b8) data_out_reg <= reg_1b8;
    if (rd_in && cs_1bc) data_out_reg <= reg_1bc;
    if (rd_in && cs_1c0) data_out_reg <= reg_1c0;
    if (rd_in && cs_1c4) data_out_reg <= reg_1c4;
    if (rd_in && cs_1c8) data_out_reg <= reg_1c8;
    if (rd_in && cs_1cc) data_out_reg <= reg_1cc;
    if (rd_in && cs_1d0) data_out_reg <= reg_1d0;
    if (rd_in && cs_1d4) data_out_reg <= reg_1d4;

    
    // register mapping: GCL Port 2
    if (rd_in && cs_1d8) data_out_reg <= {30'd0, reg_1d8[1], 1'd0};
    if (rd_in && cs_1dc) data_out_reg <= reg_1dc;
    if (rd_in && cs_1e0) data_out_reg <= reg_1e0;
    if (rd_in && cs_1e4) data_out_reg <= reg_1e4;
    if (rd_in && cs_1e8) data_out_reg <= reg_1e8;
    if (rd_in && cs_1ec) data_out_reg <= reg_1ec;
    if (rd_in && cs_1f0) data_out_reg <= reg_1f0;
    if (rd_in && cs_1f4) data_out_reg <= reg_1f4;
    if (rd_in && cs_1f8) data_out_reg <= reg_1f8;
    if (rd_in && cs_1fc) data_out_reg <= reg_1fc;
    if (rd_in && cs_200) data_out_reg <= reg_200;
    if (rd_in && cs_204) data_out_reg <= reg_204;
    if (rd_in && cs_208) data_out_reg <= reg_208;
    if (rd_in && cs_20c) data_out_reg <= reg_20c;
    if (rd_in && cs_210) data_out_reg <= reg_210;
    if (rd_in && cs_214) data_out_reg <= reg_214;
    if (rd_in && cs_218) data_out_reg <= reg_218;

    // register mapping: GCL Port 3
    if (rd_in && cs_21c) data_out_reg <= {30'd0, reg_21c[1], 1'd0};
    if (rd_in && cs_220) data_out_reg <= reg_220;
    if (rd_in && cs_224) data_out_reg <= reg_224;
    if (rd_in && cs_228) data_out_reg <= reg_228;
    if (rd_in && cs_22c) data_out_reg <= reg_22c;
    if (rd_in && cs_230) data_out_reg <= reg_230;
    if (rd_in && cs_234) data_out_reg <= reg_234;
    if (rd_in && cs_238) data_out_reg <= reg_238;
    if (rd_in && cs_23c) data_out_reg <= reg_23c;
    if (rd_in && cs_240) data_out_reg <= reg_240;
    if (rd_in && cs_244) data_out_reg <= reg_244;
    if (rd_in && cs_248) data_out_reg <= reg_248;
    if (rd_in && cs_24c) data_out_reg <= reg_24c;
    if (rd_in && cs_250) data_out_reg <= reg_250;
    if (rd_in && cs_254) data_out_reg <= reg_254;
    if (rd_in && cs_258) data_out_reg <= reg_258;
    if (rd_in && cs_25c) data_out_reg <= reg_25c;
    // GCL time interval - Port 1
    if (rd_in && cs_2a0) data_out_reg <= reg_2a0;
    if (rd_in && cs_2a4) data_out_reg <= reg_2a4;
    if (rd_in && cs_2a8) data_out_reg <= reg_2a8;
    if (rd_in && cs_2ac) data_out_reg <= reg_2ac;
    if (rd_in && cs_2b0) data_out_reg <= reg_2b0;
    if (rd_in && cs_2b4) data_out_reg <= reg_2b4;
    if (rd_in && cs_2b8) data_out_reg <= reg_2b8;
    if (rd_in && cs_2bc) data_out_reg <= reg_2bc;
    if (rd_in && cs_2c0) data_out_reg <= reg_2c0;
    if (rd_in && cs_2c4) data_out_reg <= reg_2c4;
    if (rd_in && cs_2c8) data_out_reg <= reg_2c8;
    if (rd_in && cs_2cc) data_out_reg <= reg_2cc;
    if (rd_in && cs_2d0) data_out_reg <= reg_2d0;
    if (rd_in && cs_2d4) data_out_reg <= reg_2d4;
    if (rd_in && cs_2d8) data_out_reg <= reg_2d8;
    if (rd_in && cs_2dc) data_out_reg <= reg_2dc;
    // GCL time interval - Port 2
    if (rd_in && cs_2e0) data_out_reg <= reg_2e0;
    if (rd_in && cs_2e4) data_out_reg <= reg_2e4;
    if (rd_in && cs_2e8) data_out_reg <= reg_2e8;
    if (rd_in && cs_2ec) data_out_reg <= reg_2ec;
    if (rd_in && cs_2f0) data_out_reg <= reg_2f0;
    if (rd_in && cs_2f4) data_out_reg <= reg_2f4;
    if (rd_in && cs_2f8) data_out_reg <= reg_2f8;
    if (rd_in && cs_2fc) data_out_reg <= reg_2fc;
    if (rd_in && cs_300) data_out_reg <= reg_300;
    if (rd_in && cs_304) data_out_reg <= reg_304;
    if (rd_in && cs_308) data_out_reg <= reg_308;
    if (rd_in && cs_30c) data_out_reg <= reg_30c;
    if (rd_in && cs_310) data_out_reg <= reg_310;
    if (rd_in && cs_314) data_out_reg <= reg_314;
    if (rd_in && cs_318) data_out_reg <= reg_318;
    if (rd_in && cs_31c) data_out_reg <= reg_31c;
    // GCL time interval - Port 3
    if (rd_in && cs_320) data_out_reg <= reg_320;
    if (rd_in && cs_324) data_out_reg <= reg_324;
    if (rd_in && cs_328) data_out_reg <= reg_328;
    if (rd_in && cs_32c) data_out_reg <= reg_32c;
    if (rd_in && cs_330) data_out_reg <= reg_330;
    if (rd_in && cs_334) data_out_reg <= reg_334;
    if (rd_in && cs_338) data_out_reg <= reg_338;
    if (rd_in && cs_33c) data_out_reg <= reg_33c;
    if (rd_in && cs_340) data_out_reg <= reg_340;
    if (rd_in && cs_344) data_out_reg <= reg_344;
    if (rd_in && cs_348) data_out_reg <= reg_348;
    if (rd_in && cs_34c) data_out_reg <= reg_34c;
    if (rd_in && cs_350) data_out_reg <= reg_350;
    if (rd_in && cs_354) data_out_reg <= reg_354;
    if (rd_in && cs_358) data_out_reg <= reg_358;
    if (rd_in && cs_35c) data_out_reg <= reg_35c;
    // GCL time interval - Port 4
    if (rd_in && cs_360) data_out_reg <= reg_360;
    if (rd_in && cs_364) data_out_reg <= reg_364;
    if (rd_in && cs_368) data_out_reg <= reg_368;
    if (rd_in && cs_36c) data_out_reg <= reg_36c;
    if (rd_in && cs_370) data_out_reg <= reg_370;
    if (rd_in && cs_374) data_out_reg <= reg_374;
    if (rd_in && cs_378) data_out_reg <= reg_378;
    if (rd_in && cs_37c) data_out_reg <= reg_37c;
    if (rd_in && cs_380) data_out_reg <= reg_380;
    if (rd_in && cs_384) data_out_reg <= reg_384;
    if (rd_in && cs_388) data_out_reg <= reg_388;
    if (rd_in && cs_38c) data_out_reg <= reg_38c;
    if (rd_in && cs_390) data_out_reg <= reg_390;
    if (rd_in && cs_394) data_out_reg <= reg_394;
    if (rd_in && cs_398) data_out_reg <= reg_398;
    if (rd_in && cs_39c) data_out_reg <= reg_39c;
    
end
assign data_out = data_out_reg;

// register mapping: RTC
//wire       = reg_000[ 7];
//wire       = reg_000[ 6];
wire offset_ld = reg_000[ 5];
wire rtc_rst   = reg_000[ 4];
wire time_ld   = reg_000[ 3];
wire perd_ld   = reg_000[ 2];
wire adjt_ld   = reg_000[ 1];
wire time_rd   = reg_000[ 0];
assign time_reg_sec_out  [47:0] = {reg_010[15: 0], reg_014[31: 0]};
assign time_reg_ns_out   [37:0] = {reg_018[29: 0], reg_01c[ 7: 0]};
assign period_out        [39:0] = {reg_020[ 7: 0], reg_024[31: 0]};
assign period_adj_out    [39:0] = {reg_028[ 7: 0], reg_02c[31: 0]};
assign adj_ld_data_out   [31:0] =  reg_030[31: 0];
assign offset_ptp_sec_out[47:0] = {reg_034[15: 0], reg_038[31: 0]}; 
assign offset_ptp_ns_out [31:0] =  reg_03c[31: 0];

assign gcl_id_out = wt_gcl_data_int[12:9];
assign gcl_data_out = wt_gcl_data_int[8:0];

assign gcl_time_id_out = wt_gcl_data_int[23:20];
assign gcl_time_out = wt_gcl_data_int[19:0];

wire [3:0] rxq_rst;
wire [3:0] rxqu_rd;
wire [3:0] txq_rst;
wire [3:0] txqu_rd;

wire [3:0] gcl_ld;
wire [3:0] gcl_time_ld;
wire [3:0] gcl_rd;

// register mapping: TSU RX Port 0
//wire       = reg_040[ 7];
//wire       = reg_040[ 6];
//wire       = reg_040[ 5];
//wire       = reg_040[ 4];
//wire       = reg_040[ 3];
//wire       = reg_040[ 2];
assign rxq_rst[0] = reg_040[ 1];
assign rxqu_rd[0] = reg_040[ 0];
assign rx_q_ptp_msgid_mask_out[0][7:0] = reg_044[31:24];

// register mapping: TSU TX Port 0
//wire       = reg_060[ 7];
//wire       = reg_060[ 6];
//wire       = reg_060[ 5];
//wire       = reg_060[ 4];
//wire       = reg_060[ 3];
//wire       = reg_060[ 2];
assign txq_rst[0] = reg_060[ 1];
assign txqu_rd[0] = reg_060[ 0];
assign tx_q_ptp_msgid_mask_out[0][7:0] = reg_064[31:24];

// register mapping: TSU RX Port 1
//wire       = reg_080[ 7];
//wire       = reg_080[ 6];
//wire       = reg_080[ 5];
//wire       = reg_080[ 4];
//wire       = reg_080[ 3];
//wire       = reg_080[ 2];
assign rxq_rst[1] = reg_080[ 1];
assign rxqu_rd[1] = reg_080[ 0];
assign rx_q_ptp_msgid_mask_out[1][7:0] = reg_084[31:24];

// register mapping: TSU TX Port 1
//wire       = reg_0a0[ 7];
//wire       = reg_0a0[ 6];
//wire       = reg_0a0[ 5];
//wire       = reg_0a0[ 4];
//wire       = reg_0a0[ 3];
//wire       = reg_0a0[ 2];
assign txq_rst[1] = reg_0a0[ 1];
assign txqu_rd[1] = reg_0a0[ 0];
assign tx_q_ptp_msgid_mask_out[1][7:0] = reg_0a4[31:24];

// register mapping: TSU RX Port 2
//wire       = reg_0c0[ 7];
//wire       = reg_0c0[ 6];
//wire       = reg_0c0[ 5];
//wire       = reg_0c0[ 4];
//wire       = reg_0c0[ 3];
//wire       = reg_0c0[ 2];
assign rxq_rst[2] = reg_0c0[ 1];
assign rxqu_rd[2] = reg_0c0[ 0];
assign rx_q_ptp_msgid_mask_out[2][7:0] = reg_0c4[31:24];

// register mapping: TSU TX Port 2
//wire       = reg_0e0[ 7];
//wire       = reg_0e0[ 6];
//wire       = reg_0e0[ 5];
//wire       = reg_0e0[ 4];
//wire       = reg_0e0[ 3];
//wire       = reg_0e0[ 2];
assign txq_rst[2] = reg_0e0[ 1];
assign txqu_rd[2] = reg_0e0[ 0];
assign tx_q_ptp_msgid_mask_out[2][7:0] = reg_0e4[31:24];

// register mapping: TSU RX Port 3
//wire       = reg_100[ 7];
//wire       = reg_100[ 6];
//wire       = reg_100[ 5];
//wire       = reg_100[ 4];
//wire       = reg_100[ 3];
//wire       = reg_100[ 2];
assign rxq_rst[3] = reg_100[ 1];
assign rxqu_rd[3] = reg_100[ 0];
assign rx_q_ptp_msgid_mask_out[3][7:0] = reg_104[31:24];

// register mapping: TSU TX Port 3
//wire       = reg_120[ 7];
//wire       = reg_120[ 6];
//wire       = reg_120[ 5];
//wire       = reg_120[ 4];
//wire       = reg_120[ 3];
//wire       = reg_120[ 2];
assign txq_rst[3] = reg_120[ 1];
assign txqu_rd[3] = reg_120[ 0];
assign tx_q_ptp_msgid_mask_out[3][7:0] = reg_124[31:24];
// TODO: add configurable VLANTPID values


// register mapping: GCL Port 0
assign gcl_ld[0] = reg_150[1];
assign gcl_rd[0] = reg_150[0];
// register mapping: GCL Port 1
assign gcl_ld[1] = reg_194[1];
assign gcl_rd[1] = reg_194[0];
// register mapping: GCL Port 2
assign gcl_ld[2] = reg_1d8[1];
assign gcl_rd[2] = reg_1d8[0];
// register mapping: GCL Port 3
assign gcl_ld[3] = reg_21c[1];
assign gcl_rd[3] = reg_21c[0];

// gcl time ld signal
assign gcl_time_ld[0] = reg_150[2];
assign gcl_time_ld[1] = reg_194[2];
assign gcl_time_ld[2] = reg_1d8[2];
assign gcl_time_ld[3] = reg_21c[2];

// real time clock
reg rtc_rst_s1, rtc_rst_s2, rtc_rst_s3;
assign rtc_rst_out = rtc_rst_s2 && !rtc_rst_s3;
always @(posedge rtc_clk_in) begin
  rtc_rst_s1 <= rtc_rst;
  rtc_rst_s2 <= rtc_rst_s1;
  rtc_rst_s3 <= rtc_rst_s2;
end

reg time_ld_s1, time_ld_s2, time_ld_s3;
assign time_ld_out = time_ld_s2 && !time_ld_s3;
always @(posedge rtc_clk_in) begin
  time_ld_s1 <= time_ld;
  time_ld_s2 <= time_ld_s1;
  time_ld_s3 <= time_ld_s2;
end

reg offset_ld_s1, offset_ld_s2, offset_ld_s3;
assign offset_ld_out = offset_ld_s2 && !offset_ld_s3;
always @(posedge rtc_clk_in) begin
  offset_ld_s1 <= offset_ld;
  offset_ld_s2 <= offset_ld_s1;
  offset_ld_s3 <= offset_ld_s2;
end

reg perd_ld_s1, perd_ld_s2, perd_ld_s3;
assign period_ld_out  = perd_ld_s2 && !perd_ld_s3;
always @(posedge rtc_clk_in) begin
  perd_ld_s1 <= perd_ld;
  perd_ld_s2 <= perd_ld_s1;
  perd_ld_s3 <= perd_ld_s2;
end

reg adjt_ld_s1, adjt_ld_s2, adjt_ld_s3;
assign adj_ld_out = adjt_ld_s2 && !adjt_ld_s3;
always @(posedge rtc_clk_in) begin
  adjt_ld_s1 <= adjt_ld;
  adjt_ld_s2 <= adjt_ld_s1;
  adjt_ld_s3 <= adjt_ld_s2;
end

// RTC time read CDC hand-shaking
reg time_rd_s1, time_rd_s2, time_rd_s3;
assign time_rd_ack = time_rd_s2 && !time_rd_s3;
always @(posedge rtc_clk_in) begin
  time_rd_s1 <= time_rd;
  time_rd_s2 <= time_rd_s1;
  time_rd_s3 <= time_rd_s2;
end

always @(posedge rtc_clk_in) begin
  if (time_rd_ack) begin
    time_reg_ns_int  <= time_reg_ns_in;
    time_reg_sec_int <= time_reg_sec_in;	  
    sync_time_ns_int <= sync_time_ns_in;
    sync_time_sec_int <= sync_time_sec_in;
  end
end

reg time_rd_ack_rtc_clk_holder, time_rd_ack_rtc_clk_holder_d1, time_rd_ack_rtc_clk_holder_d2, time_rd_ack_rtc_clk_holder_d3;
reg time_rd_ack_rtc_clk_clr;
always @(posedge time_rd_ack_rtc_clk_clr or posedge rtc_clk_in) begin
    if (time_rd_ack_rtc_clk_clr) begin
        time_rd_ack_rtc_clk_holder <= 1'b0;
    end
    else if (time_rd_ack) begin
        time_rd_ack_rtc_clk_holder <= 1'b1;
    end
        
end

always @(posedge rst or posedge clk) begin
    if (rst) begin
        time_rd_ack_rtc_clk_holder_d1 <= 1'b0;
        time_rd_ack_rtc_clk_holder_d2 <= 1'b0;
        time_rd_ack_rtc_clk_holder_d3 <= 1'b0;
    end
    else begin
        time_rd_ack_rtc_clk_holder_d1 <= time_rd_ack_rtc_clk_holder;
        time_rd_ack_rtc_clk_holder_d2 <= time_rd_ack_rtc_clk_holder_d1;
        time_rd_ack_rtc_clk_holder_d3 <= time_rd_ack_rtc_clk_holder_d2;
    end
end

wire time_rd_ack_ack = time_rd_ack_rtc_clk_holder_d2 && !time_rd_ack_rtc_clk_holder_d3;

reg time_rd_d1;
assign time_rd_req = time_rd && !time_rd_d1;
always @(posedge clk) begin
  time_rd_d1 <= time_rd;
end

always @(posedge clk) begin
  if (time_rd_ack_ack) begin
    time_ok <= 1'b1;
    time_rd_ack_rtc_clk_clr <= 1'b1;
  end
  else if (time_rd_req) begin
    time_ok <= 1'b0;
    time_rd_ack_rtc_clk_clr <= 1'b0;
  end
  else begin
    time_rd_ack_rtc_clk_clr <= 1'b0;
  end
end


generate  
    for (i = 0; i < 4; i = i + 1) begin
        // rx time stamp queue
        assign rx_q_rd_clk_out[i] = clk;
        reg rxq_rst_d1, rxq_rst_d2, rxq_rst_d3;
        assign rx_q_rst_out[i] = rxq_rst_d2 && !rxq_rst_d3;
        always @(posedge clk) begin
            rxq_rst_d1 <= rxq_rst[i];
            rxq_rst_d2 <= rxq_rst_d1;
            rxq_rst_d3 <= rxq_rst_d2;
        end

        // Maybe it's because these are registers (or asynchronous clocks?), so detecting posedge needs the following method.
        reg rxqu_rd_d1, rxqu_rd_d2, rxqu_rd_d3, rxqu_rd_d4, rxqu_rd_d5;
        assign rx_q_rd_en_out[i] = rxqu_rd_d2 && !rxqu_rd_d3;
        wire   rx_q_rd_req    = rxqu_rd_d2 && !rxqu_rd_d3;
        wire   rx_q_rd_ack    = rxqu_rd_d4 && !rxqu_rd_d5;

        always @(posedge clk) begin
            rxqu_rd_d1 <= rxqu_rd[i];
            rxqu_rd_d2 <= rxqu_rd_d1;
            rxqu_rd_d3 <= rxqu_rd_d2;
            rxqu_rd_d4 <= rxqu_rd_d3;
            rxqu_rd_d5 <= rxqu_rd_d4;
        end

        always @(posedge clk) begin
            if (rx_q_rd_ack)
                rxqu_ok[i] <= 1'b1;
            else if (rx_q_rd_req)
                rxqu_ok[i] <= 1'b0;
        end

        always @(posedge clk) begin
            rx_q_data_int[i] <= rx_q_data_in[i];
            rx_q_stat_int[i] <= rx_q_stat_in[i];
        end

        // tx time stamp queue
        assign tx_q_rd_clk_out[i] = clk;

        reg txq_rst_d1, txq_rst_d2, txq_rst_d3;
        assign tx_q_rst_out[i] = txq_rst_d2 && !txq_rst_d3;
        always @(posedge clk) begin
            txq_rst_d1 <= txq_rst[i];
            txq_rst_d2 <= txq_rst_d1;
            txq_rst_d3 <= txq_rst_d2;
        end

        reg txqu_rd_d1, txqu_rd_d2, txqu_rd_d3, txqu_rd_d4, txqu_rd_d5;
        assign tx_q_rd_en_out[i] = txqu_rd_d2 && !txqu_rd_d3;
        wire   tx_q_rd_req    = txqu_rd_d2 && !txqu_rd_d3;
        wire   tx_q_rd_ack    = txqu_rd_d4 && !txqu_rd_d5;
        always @(posedge clk) begin
            txqu_rd_d1 <= txqu_rd[i];
            txqu_rd_d2 <= txqu_rd_d1;
            txqu_rd_d3 <= txqu_rd_d2;
            txqu_rd_d4 <= txqu_rd_d3;
            txqu_rd_d5 <= txqu_rd_d4;
        end

        always @(posedge clk) begin
            if (tx_q_rd_ack)
                txqu_ok[i] <= 1'b1;
            else if (tx_q_rd_req)
                txqu_ok[i] <= 1'b0;
        end

        always @(posedge clk) begin
            tx_q_data_int[i] <= tx_q_data_in[i];
            tx_q_stat_int[i] <= tx_q_stat_in[i];
        end

        // gate control list
        reg gcl_ld_s1, gcl_ld_s2, gcl_ld_s3;
        assign gcl_ld_out[i] = gcl_ld_s2 && !gcl_ld_s3;
        always @(posedge gcl_clk_in) begin
          gcl_ld_s1 <= gcl_ld[i];
          gcl_ld_s2 <= gcl_ld_s1;
          gcl_ld_s3 <= gcl_ld_s2;
        end
        // gate control list time interval
        reg gcl_time_ld_s1, gcl_time_ld_s2, gcl_time_ld_s3;
        assign gcl_time_ld_out[i] = gcl_time_ld_s2 && !gcl_time_ld_s3;
        always @(posedge gcl_clk_in) begin
          gcl_time_ld_s1 <= gcl_time_ld[i];
          gcl_time_ld_s2 <= gcl_time_ld_s1;
          gcl_time_ld_s3 <= gcl_time_ld_s2;
        end

    end
endgenerate


endmodule
