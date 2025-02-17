-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Mon Dec  7 10:59:46 2020
-- Host        : DESKTOP-1VIEL1M running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub e:/Code/vivado_projects/tns_tsn_03/IP/clk_wiz_0/clk_wiz_0_stub.vhdl
-- Design      : clk_wiz_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_wiz_0 is
  Port ( 
    clk125 : out STD_LOGIC;
    clk200 : out STD_LOGIC;
    clk100 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    sys_clk : in STD_LOGIC
  );

end clk_wiz_0;

architecture stub of clk_wiz_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk125,clk200,clk100,reset,locked,sys_clk";
begin
end;
