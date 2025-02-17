-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Tue Mar 28 14:56:09 2023
-- Host        : Horace-TNS-win10 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               d:/Data/TSN_development/tns-tsn-switch/IP/input_arbiter_fifo/input_arbiter_fifo_sim_netlist.vhdl
-- Design      : input_arbiter_fifo
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity input_arbiter_fifo_xpm_cdc_sync_rst is
  port (
    src_rst : in STD_LOGIC;
    dest_clk : in STD_LOGIC;
    dest_rst : out STD_LOGIC
  );
  attribute DEF_VAL : string;
  attribute DEF_VAL of input_arbiter_fifo_xpm_cdc_sync_rst : entity is "1'b0";
  attribute DEST_SYNC_FF : integer;
  attribute DEST_SYNC_FF of input_arbiter_fifo_xpm_cdc_sync_rst : entity is 4;
  attribute INIT : string;
  attribute INIT of input_arbiter_fifo_xpm_cdc_sync_rst : entity is "0";
  attribute INIT_SYNC_FF : integer;
  attribute INIT_SYNC_FF of input_arbiter_fifo_xpm_cdc_sync_rst : entity is 1;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of input_arbiter_fifo_xpm_cdc_sync_rst : entity is "xpm_cdc_sync_rst";
  attribute SIM_ASSERT_CHK : integer;
  attribute SIM_ASSERT_CHK of input_arbiter_fifo_xpm_cdc_sync_rst : entity is 0;
  attribute VERSION : integer;
  attribute VERSION of input_arbiter_fifo_xpm_cdc_sync_rst : entity is 0;
  attribute XPM_MODULE : string;
  attribute XPM_MODULE of input_arbiter_fifo_xpm_cdc_sync_rst : entity is "TRUE";
  attribute keep_hierarchy : string;
  attribute keep_hierarchy of input_arbiter_fifo_xpm_cdc_sync_rst : entity is "true";
  attribute xpm_cdc : string;
  attribute xpm_cdc of input_arbiter_fifo_xpm_cdc_sync_rst : entity is "SYNC_RST";
end input_arbiter_fifo_xpm_cdc_sync_rst;

architecture STRUCTURE of input_arbiter_fifo_xpm_cdc_sync_rst is
  signal syncstages_ff : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of syncstages_ff : signal is "true";
  attribute async_reg : string;
  attribute async_reg of syncstages_ff : signal is "true";
  attribute xpm_cdc of syncstages_ff : signal is "SYNC_RST";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of \syncstages_ff_reg[0]\ : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of \syncstages_ff_reg[0]\ : label is "true";
  attribute XPM_CDC of \syncstages_ff_reg[0]\ : label is "SYNC_RST";
  attribute ASYNC_REG_boolean of \syncstages_ff_reg[1]\ : label is std.standard.true;
  attribute KEEP of \syncstages_ff_reg[1]\ : label is "true";
  attribute XPM_CDC of \syncstages_ff_reg[1]\ : label is "SYNC_RST";
  attribute ASYNC_REG_boolean of \syncstages_ff_reg[2]\ : label is std.standard.true;
  attribute KEEP of \syncstages_ff_reg[2]\ : label is "true";
  attribute XPM_CDC of \syncstages_ff_reg[2]\ : label is "SYNC_RST";
  attribute ASYNC_REG_boolean of \syncstages_ff_reg[3]\ : label is std.standard.true;
  attribute KEEP of \syncstages_ff_reg[3]\ : label is "true";
  attribute XPM_CDC of \syncstages_ff_reg[3]\ : label is "SYNC_RST";
begin
  dest_rst <= syncstages_ff(3);
\syncstages_ff_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => dest_clk,
      CE => '1',
      D => src_rst,
      Q => syncstages_ff(0),
      R => '0'
    );
\syncstages_ff_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => dest_clk,
      CE => '1',
      D => syncstages_ff(0),
      Q => syncstages_ff(1),
      R => '0'
    );
\syncstages_ff_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => dest_clk,
      CE => '1',
      D => syncstages_ff(1),
      Q => syncstages_ff(2),
      R => '0'
    );
\syncstages_ff_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => dest_clk,
      CE => '1',
      D => syncstages_ff(2),
      Q => syncstages_ff(3),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \input_arbiter_fifo_xpm_counter_updn__parameterized0\ is
  port (
    Q : out STD_LOGIC_VECTOR ( 5 downto 0 );
    wr_en : in STD_LOGIC;
    \count_value_i_reg[5]_0\ : in STD_LOGIC;
    \count_value_i_reg[1]_0\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    rst_d1 : in STD_LOGIC;
    ram_wr_en_i : in STD_LOGIC;
    wr_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \input_arbiter_fifo_xpm_counter_updn__parameterized0\ : entity is "xpm_counter_updn";
end \input_arbiter_fifo_xpm_counter_updn__parameterized0\;

architecture STRUCTURE of \input_arbiter_fifo_xpm_counter_updn__parameterized0\ is
  signal \^q\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \count_value_i[0]_i_1__1_n_0\ : STD_LOGIC;
  signal \count_value_i[1]_i_1__1_n_0\ : STD_LOGIC;
  signal \count_value_i[2]_i_1__1_n_0\ : STD_LOGIC;
  signal \count_value_i[3]_i_1__1_n_0\ : STD_LOGIC;
  signal \count_value_i[4]_i_1__1_n_0\ : STD_LOGIC;
  signal \count_value_i[5]_i_1_n_0\ : STD_LOGIC;
  signal \count_value_i[5]_i_2_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \count_value_i[0]_i_1__1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \count_value_i[2]_i_1__1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \count_value_i[3]_i_1__1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \count_value_i[4]_i_1__1\ : label is "soft_lutpair7";
begin
  Q(5 downto 0) <= \^q\(5 downto 0);
\count_value_i[0]_i_1__1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q\(0),
      O => \count_value_i[0]_i_1__1_n_0\
    );
\count_value_i[1]_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      O => \count_value_i[1]_i_1__1_n_0\
    );
\count_value_i[2]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      I2 => \^q\(2),
      O => \count_value_i[2]_i_1__1_n_0\
    );
\count_value_i[3]_i_1__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \^q\(1),
      I1 => \^q\(0),
      I2 => \^q\(2),
      I3 => \^q\(3),
      O => \count_value_i[3]_i_1__1_n_0\
    );
\count_value_i[4]_i_1__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \^q\(2),
      I1 => \^q\(0),
      I2 => \^q\(1),
      I3 => \^q\(3),
      I4 => \^q\(4),
      O => \count_value_i[4]_i_1__1_n_0\
    );
\count_value_i[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \^q\(3),
      I1 => \count_value_i[5]_i_2_n_0\,
      I2 => \^q\(2),
      I3 => \^q\(4),
      I4 => \^q\(5),
      O => \count_value_i[5]_i_1_n_0\
    );
\count_value_i[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000800000000"
    )
        port map (
      I0 => \^q\(1),
      I1 => wr_en,
      I2 => \count_value_i_reg[5]_0\,
      I3 => \count_value_i_reg[1]_0\(0),
      I4 => rst_d1,
      I5 => \^q\(0),
      O => \count_value_i[5]_i_2_n_0\
    );
\count_value_i_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => ram_wr_en_i,
      D => \count_value_i[0]_i_1__1_n_0\,
      Q => \^q\(0),
      R => \count_value_i_reg[1]_0\(0)
    );
\count_value_i_reg[1]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => wr_clk,
      CE => ram_wr_en_i,
      D => \count_value_i[1]_i_1__1_n_0\,
      Q => \^q\(1),
      S => \count_value_i_reg[1]_0\(0)
    );
\count_value_i_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => ram_wr_en_i,
      D => \count_value_i[2]_i_1__1_n_0\,
      Q => \^q\(2),
      R => \count_value_i_reg[1]_0\(0)
    );
\count_value_i_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => ram_wr_en_i,
      D => \count_value_i[3]_i_1__1_n_0\,
      Q => \^q\(3),
      R => \count_value_i_reg[1]_0\(0)
    );
\count_value_i_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => ram_wr_en_i,
      D => \count_value_i[4]_i_1__1_n_0\,
      Q => \^q\(4),
      R => \count_value_i_reg[1]_0\(0)
    );
\count_value_i_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => ram_wr_en_i,
      D => \count_value_i[5]_i_1_n_0\,
      Q => \^q\(5),
      R => \count_value_i_reg[1]_0\(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \input_arbiter_fifo_xpm_counter_updn__parameterized2\ is
  port (
    going_afull : out STD_LOGIC;
    \FSM_sequential_gen_fwft.curr_fwft_state_reg[1]\ : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 5 downto 0 );
    leaving_empty0 : out STD_LOGIC;
    going_full1 : out STD_LOGIC;
    \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg\ : out STD_LOGIC;
    \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_0\ : out STD_LOGIC;
    ram_wr_en_i : in STD_LOGIC;
    \count_value_i_reg[0]_0\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    rd_en : in STD_LOGIC;
    ram_empty_i : in STD_LOGIC;
    \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_3_0\ : in STD_LOGIC_VECTOR ( 5 downto 0 );
    \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_4_0\ : in STD_LOGIC_VECTOR ( 5 downto 0 );
    \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0\ : in STD_LOGIC_VECTOR ( 5 downto 0 );
    \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_1\ : in STD_LOGIC;
    clr_full : in STD_LOGIC;
    \count_value_i_reg[5]_0\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    wr_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \input_arbiter_fifo_xpm_counter_updn__parameterized2\ : entity is "xpm_counter_updn";
end \input_arbiter_fifo_xpm_counter_updn__parameterized2\;

architecture STRUCTURE of \input_arbiter_fifo_xpm_counter_updn__parameterized2\ is
  signal \^fsm_sequential_gen_fwft.curr_fwft_state_reg[1]\ : STD_LOGIC;
  signal \^q\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \count_value_i[0]_i_1__2_n_0\ : STD_LOGIC;
  signal \count_value_i[1]_i_1__2_n_0\ : STD_LOGIC;
  signal \count_value_i[2]_i_1__2_n_0\ : STD_LOGIC;
  signal \count_value_i[3]_i_1__2_n_0\ : STD_LOGIC;
  signal \count_value_i[4]_i_1__2_n_0\ : STD_LOGIC;
  signal \count_value_i[5]_i_1__2_n_0\ : STD_LOGIC;
  signal \count_value_i[5]_i_2__2_n_0\ : STD_LOGIC;
  signal \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_5_n_0\ : STD_LOGIC;
  signal \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_6_n_0\ : STD_LOGIC;
  signal \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_5_n_0\ : STD_LOGIC;
  signal \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_6_n_0\ : STD_LOGIC;
  signal \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_7_n_0\ : STD_LOGIC;
  signal \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_8_n_0\ : STD_LOGIC;
  signal \^going_full1\ : STD_LOGIC;
  signal \^leaving_empty0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \count_value_i[0]_i_1__2\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \count_value_i[1]_i_1__2\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \count_value_i[3]_i_1__2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \count_value_i[4]_i_1__2\ : label is "soft_lutpair1";
begin
  \FSM_sequential_gen_fwft.curr_fwft_state_reg[1]\ <= \^fsm_sequential_gen_fwft.curr_fwft_state_reg[1]\;
  Q(5 downto 0) <= \^q\(5 downto 0);
  going_full1 <= \^going_full1\;
  leaving_empty0 <= \^leaving_empty0\;
\count_value_i[0]_i_1__2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"10EF"
    )
        port map (
      I0 => rd_en,
      I1 => \count_value_i_reg[0]_0\(0),
      I2 => \count_value_i_reg[0]_0\(1),
      I3 => \^q\(0),
      O => \count_value_i[0]_i_1__2_n_0\
    );
\count_value_i[1]_i_1__2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"02FFFD00"
    )
        port map (
      I0 => \count_value_i_reg[0]_0\(1),
      I1 => \count_value_i_reg[0]_0\(0),
      I2 => rd_en,
      I3 => \^q\(0),
      I4 => \^q\(1),
      O => \count_value_i[1]_i_1__2_n_0\
    );
\count_value_i[2]_i_1__2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      I2 => \^q\(2),
      O => \count_value_i[2]_i_1__2_n_0\
    );
\count_value_i[3]_i_1__2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \^q\(1),
      I1 => \^q\(0),
      I2 => \^q\(2),
      I3 => \^q\(3),
      O => \count_value_i[3]_i_1__2_n_0\
    );
\count_value_i[4]_i_1__2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \^q\(2),
      I1 => \^q\(0),
      I2 => \^q\(1),
      I3 => \^q\(3),
      I4 => \^q\(4),
      O => \count_value_i[4]_i_1__2_n_0\
    );
\count_value_i[5]_i_1__2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \^q\(3),
      I1 => \count_value_i[5]_i_2__2_n_0\,
      I2 => \^q\(2),
      I3 => \^q\(4),
      I4 => \^q\(5),
      O => \count_value_i[5]_i_1__2_n_0\
    );
\count_value_i[5]_i_2__2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AAA200000000"
    )
        port map (
      I0 => \^q\(1),
      I1 => \count_value_i_reg[0]_0\(1),
      I2 => \count_value_i_reg[0]_0\(0),
      I3 => rd_en,
      I4 => ram_empty_i,
      I5 => \^q\(0),
      O => \count_value_i[5]_i_2__2_n_0\
    );
\count_value_i_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => \^fsm_sequential_gen_fwft.curr_fwft_state_reg[1]\,
      D => \count_value_i[0]_i_1__2_n_0\,
      Q => \^q\(0),
      R => \count_value_i_reg[5]_0\(0)
    );
\count_value_i_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => \^fsm_sequential_gen_fwft.curr_fwft_state_reg[1]\,
      D => \count_value_i[1]_i_1__2_n_0\,
      Q => \^q\(1),
      R => \count_value_i_reg[5]_0\(0)
    );
\count_value_i_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => \^fsm_sequential_gen_fwft.curr_fwft_state_reg[1]\,
      D => \count_value_i[2]_i_1__2_n_0\,
      Q => \^q\(2),
      R => \count_value_i_reg[5]_0\(0)
    );
\count_value_i_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => \^fsm_sequential_gen_fwft.curr_fwft_state_reg[1]\,
      D => \count_value_i[3]_i_1__2_n_0\,
      Q => \^q\(3),
      R => \count_value_i_reg[5]_0\(0)
    );
\count_value_i_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => \^fsm_sequential_gen_fwft.curr_fwft_state_reg[1]\,
      D => \count_value_i[4]_i_1__2_n_0\,
      Q => \^q\(4),
      R => \count_value_i_reg[5]_0\(0)
    );
\count_value_i_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => \^fsm_sequential_gen_fwft.curr_fwft_state_reg[1]\,
      D => \count_value_i[5]_i_1__2_n_0\,
      Q => \^q\(5),
      R => \count_value_i_reg[5]_0\(0)
    );
\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_5_n_0\,
      I1 => \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_6_n_0\,
      I2 => \^fsm_sequential_gen_fwft.curr_fwft_state_reg[1]\,
      I3 => ram_wr_en_i,
      O => going_afull
    );
\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \^q\(3),
      I1 => \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0\(3),
      I2 => \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0\(5),
      I3 => \^q\(5),
      I4 => \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0\(4),
      I5 => \^q\(4),
      O => \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_5_n_0\
    );
\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \^q\(0),
      I1 => \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0\(0),
      I2 => \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0\(2),
      I3 => \^q\(2),
      I4 => \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0\(1),
      I5 => \^q\(1),
      O => \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_6_n_0\
    );
\gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000000FFF0088"
    )
        port map (
      I0 => ram_wr_en_i,
      I1 => \^going_full1\,
      I2 => \^leaving_empty0\,
      I3 => \^fsm_sequential_gen_fwft.curr_fwft_state_reg[1]\,
      I4 => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_1\,
      I5 => clr_full,
      O => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg\
    );
\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FABAFBBBFBBBFBBB"
    )
        port map (
      I0 => clr_full,
      I1 => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_1\,
      I2 => \^fsm_sequential_gen_fwft.curr_fwft_state_reg[1]\,
      I3 => \^leaving_empty0\,
      I4 => \^going_full1\,
      I5 => ram_wr_en_i,
      O => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_0\
    );
\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_5_n_0\,
      I1 => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_6_n_0\,
      O => \^leaving_empty0\
    );
\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_7_n_0\,
      I1 => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_8_n_0\,
      O => \^going_full1\
    );
\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \^q\(0),
      I1 => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_3_0\(0),
      I2 => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_3_0\(2),
      I3 => \^q\(2),
      I4 => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_3_0\(1),
      I5 => \^q\(1),
      O => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_5_n_0\
    );
\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \^q\(3),
      I1 => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_3_0\(3),
      I2 => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_3_0\(5),
      I3 => \^q\(5),
      I4 => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_3_0\(4),
      I5 => \^q\(4),
      O => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_6_n_0\
    );
\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \^q\(0),
      I1 => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_4_0\(0),
      I2 => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_4_0\(2),
      I3 => \^q\(2),
      I4 => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_4_0\(1),
      I5 => \^q\(1),
      O => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_7_n_0\
    );
\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \^q\(3),
      I1 => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_4_0\(3),
      I2 => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_4_0\(5),
      I3 => \^q\(5),
      I4 => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_4_0\(4),
      I5 => \^q\(4),
      O => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_8_n_0\
    );
\gen_sdpram.xpm_memory_base_inst_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00FD"
    )
        port map (
      I0 => \count_value_i_reg[0]_0\(1),
      I1 => \count_value_i_reg[0]_0\(0),
      I2 => rd_en,
      I3 => ram_empty_i,
      O => \^fsm_sequential_gen_fwft.curr_fwft_state_reg[1]\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \input_arbiter_fifo_xpm_counter_updn__parameterized2_0\ is
  port (
    Q : out STD_LOGIC_VECTOR ( 5 downto 0 );
    ram_empty_i0 : out STD_LOGIC;
    wr_en : in STD_LOGIC;
    \count_value_i_reg[5]_0\ : in STD_LOGIC;
    \count_value_i_reg[0]_0\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    rst_d1 : in STD_LOGIC;
    \gen_pntr_flags_cc.ram_empty_i_reg\ : in STD_LOGIC;
    leaving_empty0 : in STD_LOGIC;
    ram_wr_en_i : in STD_LOGIC;
    ram_empty_i : in STD_LOGIC;
    \gen_pntr_flags_cc.ram_empty_i_reg_0\ : in STD_LOGIC_VECTOR ( 5 downto 0 );
    wr_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \input_arbiter_fifo_xpm_counter_updn__parameterized2_0\ : entity is "xpm_counter_updn";
end \input_arbiter_fifo_xpm_counter_updn__parameterized2_0\;

architecture STRUCTURE of \input_arbiter_fifo_xpm_counter_updn__parameterized2_0\ is
  signal \^q\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \count_value_i[0]_i_1_n_0\ : STD_LOGIC;
  signal \count_value_i[1]_i_1_n_0\ : STD_LOGIC;
  signal \count_value_i[2]_i_1_n_0\ : STD_LOGIC;
  signal \count_value_i[3]_i_1_n_0\ : STD_LOGIC;
  signal \count_value_i[4]_i_1_n_0\ : STD_LOGIC;
  signal \count_value_i[5]_i_1__0_n_0\ : STD_LOGIC;
  signal \count_value_i[5]_i_2__0_n_0\ : STD_LOGIC;
  signal \gen_pntr_flags_cc.ram_empty_i_i_2_n_0\ : STD_LOGIC;
  signal \gen_pntr_flags_cc.ram_empty_i_i_3_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \count_value_i[1]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \count_value_i[2]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \count_value_i[3]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \count_value_i[4]_i_1\ : label is "soft_lutpair3";
begin
  Q(5 downto 0) <= \^q\(5 downto 0);
\count_value_i[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q\(0),
      O => \count_value_i[0]_i_1_n_0\
    );
\count_value_i[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      O => \count_value_i[1]_i_1_n_0\
    );
\count_value_i[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      I2 => \^q\(2),
      O => \count_value_i[2]_i_1_n_0\
    );
\count_value_i[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \^q\(1),
      I1 => \^q\(0),
      I2 => \^q\(2),
      I3 => \^q\(3),
      O => \count_value_i[3]_i_1_n_0\
    );
\count_value_i[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \^q\(2),
      I1 => \^q\(0),
      I2 => \^q\(1),
      I3 => \^q\(3),
      I4 => \^q\(4),
      O => \count_value_i[4]_i_1_n_0\
    );
\count_value_i[5]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \^q\(3),
      I1 => \count_value_i[5]_i_2__0_n_0\,
      I2 => \^q\(2),
      I3 => \^q\(4),
      I4 => \^q\(5),
      O => \count_value_i[5]_i_1__0_n_0\
    );
\count_value_i[5]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000800000000"
    )
        port map (
      I0 => \^q\(1),
      I1 => wr_en,
      I2 => \count_value_i_reg[5]_0\,
      I3 => \count_value_i_reg[0]_0\(0),
      I4 => rst_d1,
      I5 => \^q\(0),
      O => \count_value_i[5]_i_2__0_n_0\
    );
\count_value_i_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => ram_wr_en_i,
      D => \count_value_i[0]_i_1_n_0\,
      Q => \^q\(0),
      R => \count_value_i_reg[0]_0\(0)
    );
\count_value_i_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => ram_wr_en_i,
      D => \count_value_i[1]_i_1_n_0\,
      Q => \^q\(1),
      R => \count_value_i_reg[0]_0\(0)
    );
\count_value_i_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => ram_wr_en_i,
      D => \count_value_i[2]_i_1_n_0\,
      Q => \^q\(2),
      R => \count_value_i_reg[0]_0\(0)
    );
\count_value_i_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => ram_wr_en_i,
      D => \count_value_i[3]_i_1_n_0\,
      Q => \^q\(3),
      R => \count_value_i_reg[0]_0\(0)
    );
\count_value_i_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => ram_wr_en_i,
      D => \count_value_i[4]_i_1_n_0\,
      Q => \^q\(4),
      R => \count_value_i_reg[0]_0\(0)
    );
\count_value_i_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => ram_wr_en_i,
      D => \count_value_i[5]_i_1__0_n_0\,
      Q => \^q\(5),
      R => \count_value_i_reg[0]_0\(0)
    );
\gen_pntr_flags_cc.ram_empty_i_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00FFFFFF00008080"
    )
        port map (
      I0 => \gen_pntr_flags_cc.ram_empty_i_reg\,
      I1 => \gen_pntr_flags_cc.ram_empty_i_i_2_n_0\,
      I2 => \gen_pntr_flags_cc.ram_empty_i_i_3_n_0\,
      I3 => leaving_empty0,
      I4 => ram_wr_en_i,
      I5 => ram_empty_i,
      O => ram_empty_i0
    );
\gen_pntr_flags_cc.ram_empty_i_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \^q\(0),
      I1 => \gen_pntr_flags_cc.ram_empty_i_reg_0\(0),
      I2 => \gen_pntr_flags_cc.ram_empty_i_reg_0\(2),
      I3 => \^q\(2),
      I4 => \gen_pntr_flags_cc.ram_empty_i_reg_0\(1),
      I5 => \^q\(1),
      O => \gen_pntr_flags_cc.ram_empty_i_i_2_n_0\
    );
\gen_pntr_flags_cc.ram_empty_i_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \^q\(3),
      I1 => \gen_pntr_flags_cc.ram_empty_i_reg_0\(3),
      I2 => \gen_pntr_flags_cc.ram_empty_i_reg_0\(5),
      I3 => \^q\(5),
      I4 => \gen_pntr_flags_cc.ram_empty_i_reg_0\(4),
      I5 => \^q\(4),
      O => \gen_pntr_flags_cc.ram_empty_i_i_3_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \input_arbiter_fifo_xpm_counter_updn__parameterized3\ is
  port (
    Q : out STD_LOGIC_VECTOR ( 5 downto 0 );
    \count_value_i_reg[1]_0\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    rd_en : in STD_LOGIC;
    ram_empty_i : in STD_LOGIC;
    \count_value_i_reg[1]_1\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    wr_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \input_arbiter_fifo_xpm_counter_updn__parameterized3\ : entity is "xpm_counter_updn";
end \input_arbiter_fifo_xpm_counter_updn__parameterized3\;

architecture STRUCTURE of \input_arbiter_fifo_xpm_counter_updn__parameterized3\ is
  signal \^q\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \count_value_i[0]_i_1__3_n_0\ : STD_LOGIC;
  signal \count_value_i[1]_i_1__3_n_0\ : STD_LOGIC;
  signal \count_value_i[2]_i_1__3_n_0\ : STD_LOGIC;
  signal \count_value_i[3]_i_1__3_n_0\ : STD_LOGIC;
  signal \count_value_i[4]_i_1__3_n_0\ : STD_LOGIC;
  signal \count_value_i[5]_i_1__3_n_0\ : STD_LOGIC;
  signal \count_value_i[5]_i_2__3_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \count_value_i[3]_i_1__3\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \count_value_i[4]_i_1__3\ : label is "soft_lutpair2";
begin
  Q(5 downto 0) <= \^q\(5 downto 0);
\count_value_i[0]_i_1__3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"10EF"
    )
        port map (
      I0 => rd_en,
      I1 => \count_value_i_reg[1]_0\(0),
      I2 => \count_value_i_reg[1]_0\(1),
      I3 => \^q\(0),
      O => \count_value_i[0]_i_1__3_n_0\
    );
\count_value_i[1]_i_1__3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"02FFFD00"
    )
        port map (
      I0 => \count_value_i_reg[1]_0\(1),
      I1 => \count_value_i_reg[1]_0\(0),
      I2 => rd_en,
      I3 => \^q\(0),
      I4 => \^q\(1),
      O => \count_value_i[1]_i_1__3_n_0\
    );
\count_value_i[2]_i_1__3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      I2 => \^q\(2),
      O => \count_value_i[2]_i_1__3_n_0\
    );
\count_value_i[3]_i_1__3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \^q\(1),
      I1 => \^q\(0),
      I2 => \^q\(2),
      I3 => \^q\(3),
      O => \count_value_i[3]_i_1__3_n_0\
    );
\count_value_i[4]_i_1__3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \^q\(2),
      I1 => \^q\(0),
      I2 => \^q\(1),
      I3 => \^q\(3),
      I4 => \^q\(4),
      O => \count_value_i[4]_i_1__3_n_0\
    );
\count_value_i[5]_i_1__3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \^q\(3),
      I1 => \count_value_i[5]_i_2__3_n_0\,
      I2 => \^q\(2),
      I3 => \^q\(4),
      I4 => \^q\(5),
      O => \count_value_i[5]_i_1__3_n_0\
    );
\count_value_i[5]_i_2__3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AAA200000000"
    )
        port map (
      I0 => \^q\(1),
      I1 => \count_value_i_reg[1]_0\(1),
      I2 => \count_value_i_reg[1]_0\(0),
      I3 => rd_en,
      I4 => ram_empty_i,
      I5 => \^q\(0),
      O => \count_value_i[5]_i_2__3_n_0\
    );
\count_value_i_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => wr_clk,
      CE => E(0),
      D => \count_value_i[0]_i_1__3_n_0\,
      Q => \^q\(0),
      S => \count_value_i_reg[1]_1\(0)
    );
\count_value_i_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => E(0),
      D => \count_value_i[1]_i_1__3_n_0\,
      Q => \^q\(1),
      R => \count_value_i_reg[1]_1\(0)
    );
\count_value_i_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => E(0),
      D => \count_value_i[2]_i_1__3_n_0\,
      Q => \^q\(2),
      R => \count_value_i_reg[1]_1\(0)
    );
\count_value_i_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => E(0),
      D => \count_value_i[3]_i_1__3_n_0\,
      Q => \^q\(3),
      R => \count_value_i_reg[1]_1\(0)
    );
\count_value_i_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => E(0),
      D => \count_value_i[4]_i_1__3_n_0\,
      Q => \^q\(4),
      R => \count_value_i_reg[1]_1\(0)
    );
\count_value_i_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => E(0),
      D => \count_value_i[5]_i_1__3_n_0\,
      Q => \^q\(5),
      R => \count_value_i_reg[1]_1\(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \input_arbiter_fifo_xpm_counter_updn__parameterized3_1\ is
  port (
    Q : out STD_LOGIC_VECTOR ( 5 downto 0 );
    wr_en : in STD_LOGIC;
    \count_value_i_reg[5]_0\ : in STD_LOGIC;
    \count_value_i_reg[1]_0\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    rst_d1 : in STD_LOGIC;
    ram_wr_en_i : in STD_LOGIC;
    wr_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \input_arbiter_fifo_xpm_counter_updn__parameterized3_1\ : entity is "xpm_counter_updn";
end \input_arbiter_fifo_xpm_counter_updn__parameterized3_1\;

architecture STRUCTURE of \input_arbiter_fifo_xpm_counter_updn__parameterized3_1\ is
  signal \^q\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \count_value_i[0]_i_1__0_n_0\ : STD_LOGIC;
  signal \count_value_i[1]_i_1__0_n_0\ : STD_LOGIC;
  signal \count_value_i[2]_i_1__0_n_0\ : STD_LOGIC;
  signal \count_value_i[3]_i_1__0_n_0\ : STD_LOGIC;
  signal \count_value_i[4]_i_1__0_n_0\ : STD_LOGIC;
  signal \count_value_i[5]_i_1__1_n_0\ : STD_LOGIC;
  signal \count_value_i[5]_i_2__1_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \count_value_i[1]_i_1__0\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \count_value_i[2]_i_1__0\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \count_value_i[3]_i_1__0\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \count_value_i[4]_i_1__0\ : label is "soft_lutpair5";
begin
  Q(5 downto 0) <= \^q\(5 downto 0);
\count_value_i[0]_i_1__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q\(0),
      O => \count_value_i[0]_i_1__0_n_0\
    );
\count_value_i[1]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      O => \count_value_i[1]_i_1__0_n_0\
    );
\count_value_i[2]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      I2 => \^q\(2),
      O => \count_value_i[2]_i_1__0_n_0\
    );
\count_value_i[3]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \^q\(1),
      I1 => \^q\(0),
      I2 => \^q\(2),
      I3 => \^q\(3),
      O => \count_value_i[3]_i_1__0_n_0\
    );
\count_value_i[4]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \^q\(2),
      I1 => \^q\(0),
      I2 => \^q\(1),
      I3 => \^q\(3),
      I4 => \^q\(4),
      O => \count_value_i[4]_i_1__0_n_0\
    );
\count_value_i[5]_i_1__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \^q\(3),
      I1 => \count_value_i[5]_i_2__1_n_0\,
      I2 => \^q\(2),
      I3 => \^q\(4),
      I4 => \^q\(5),
      O => \count_value_i[5]_i_1__1_n_0\
    );
\count_value_i[5]_i_2__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000800000000"
    )
        port map (
      I0 => \^q\(1),
      I1 => wr_en,
      I2 => \count_value_i_reg[5]_0\,
      I3 => \count_value_i_reg[1]_0\(0),
      I4 => rst_d1,
      I5 => \^q\(0),
      O => \count_value_i[5]_i_2__1_n_0\
    );
\count_value_i_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => wr_clk,
      CE => ram_wr_en_i,
      D => \count_value_i[0]_i_1__0_n_0\,
      Q => \^q\(0),
      S => \count_value_i_reg[1]_0\(0)
    );
\count_value_i_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => ram_wr_en_i,
      D => \count_value_i[1]_i_1__0_n_0\,
      Q => \^q\(1),
      R => \count_value_i_reg[1]_0\(0)
    );
\count_value_i_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => ram_wr_en_i,
      D => \count_value_i[2]_i_1__0_n_0\,
      Q => \^q\(2),
      R => \count_value_i_reg[1]_0\(0)
    );
\count_value_i_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => ram_wr_en_i,
      D => \count_value_i[3]_i_1__0_n_0\,
      Q => \^q\(3),
      R => \count_value_i_reg[1]_0\(0)
    );
\count_value_i_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => ram_wr_en_i,
      D => \count_value_i[4]_i_1__0_n_0\,
      Q => \^q\(4),
      R => \count_value_i_reg[1]_0\(0)
    );
\count_value_i_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => ram_wr_en_i,
      D => \count_value_i[5]_i_1__1_n_0\,
      Q => \^q\(5),
      R => \count_value_i_reg[1]_0\(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity input_arbiter_fifo_xpm_fifo_reg_bit is
  port (
    rst_d1 : out STD_LOGIC;
    clr_full : out STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    wr_clk : in STD_LOGIC;
    rst : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of input_arbiter_fifo_xpm_fifo_reg_bit : entity is "xpm_fifo_reg_bit";
end input_arbiter_fifo_xpm_fifo_reg_bit;

architecture STRUCTURE of input_arbiter_fifo_xpm_fifo_reg_bit is
  signal \^rst_d1\ : STD_LOGIC;
begin
  rst_d1 <= \^rst_d1\;
d_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => '1',
      D => Q(0),
      Q => \^rst_d1\,
      R => '0'
    );
\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => rst,
      I1 => \^rst_d1\,
      I2 => Q(0),
      O => clr_full
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity input_arbiter_fifo_xpm_fifo_rst is
  port (
    \syncstages_ff_reg[3]\ : out STD_LOGIC;
    ram_wr_en_i : out STD_LOGIC;
    \gen_rst_cc.fifo_wr_rst_cc_reg[2]_0\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    going_full1 : in STD_LOGIC;
    going_afull : in STD_LOGIC;
    rst : in STD_LOGIC;
    almost_full : in STD_LOGIC;
    ram_empty_i : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 1 downto 0 );
    wr_en : in STD_LOGIC;
    \count_value_i_reg[5]\ : in STD_LOGIC;
    rst_d1 : in STD_LOGIC;
    wr_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of input_arbiter_fifo_xpm_fifo_rst : entity is "xpm_fifo_rst";
end input_arbiter_fifo_xpm_fifo_rst;

architecture STRUCTURE of input_arbiter_fifo_xpm_fifo_rst is
  signal \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_2_n_0\ : STD_LOGIC;
  signal \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_4_n_0\ : STD_LOGIC;
  signal \gen_rst_cc.fifo_wr_rst_cc\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^gen_rst_cc.fifo_wr_rst_cc_reg[2]_0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal p_0_in : STD_LOGIC;
  signal \power_on_rst_reg_n_0_[0]\ : STD_LOGIC;
  signal \^ram_wr_en_i\ : STD_LOGIC;
  signal rst_i : STD_LOGIC;
begin
  \gen_rst_cc.fifo_wr_rst_cc_reg[2]_0\(0) <= \^gen_rst_cc.fifo_wr_rst_cc_reg[2]_0\(0);
  ram_wr_en_i <= \^ram_wr_en_i\;
\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00FF00F7000000F0"
    )
        port map (
      I0 => \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_2_n_0\,
      I1 => going_full1,
      I2 => going_afull,
      I3 => \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_4_n_0\,
      I4 => rst,
      I5 => almost_full,
      O => \syncstages_ff_reg[3]\
    );
\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00005455"
    )
        port map (
      I0 => ram_empty_i,
      I1 => rd_en,
      I2 => Q(0),
      I3 => Q(1),
      I4 => \^ram_wr_en_i\,
      O => \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_2_n_0\
    );
\gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => \^gen_rst_cc.fifo_wr_rst_cc_reg[2]_0\(0),
      I1 => rst_d1,
      I2 => rst,
      O => \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_4_n_0\
    );
\gen_rst_cc.fifo_wr_rst_cc[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => p_0_in,
      I1 => rst,
      O => rst_i
    );
\gen_rst_cc.fifo_wr_rst_cc_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => '1',
      D => '0',
      Q => \gen_rst_cc.fifo_wr_rst_cc\(0),
      S => rst_i
    );
\gen_rst_cc.fifo_wr_rst_cc_reg[1]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => '1',
      D => \gen_rst_cc.fifo_wr_rst_cc\(0),
      Q => \gen_rst_cc.fifo_wr_rst_cc\(1),
      S => rst_i
    );
\gen_rst_cc.fifo_wr_rst_cc_reg[2]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => '1',
      D => \gen_rst_cc.fifo_wr_rst_cc\(1),
      Q => \^gen_rst_cc.fifo_wr_rst_cc_reg[2]_0\(0),
      S => rst_i
    );
\gen_sdpram.xpm_memory_base_inst_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0002"
    )
        port map (
      I0 => wr_en,
      I1 => \count_value_i_reg[5]\,
      I2 => \^gen_rst_cc.fifo_wr_rst_cc_reg[2]_0\(0),
      I3 => rst_d1,
      O => \^ram_wr_en_i\
    );
\power_on_rst_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => wr_clk,
      CE => '1',
      D => '0',
      Q => \power_on_rst_reg_n_0_[0]\,
      R => '0'
    );
\power_on_rst_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => wr_clk,
      CE => '1',
      D => \power_on_rst_reg_n_0_[0]\,
      Q => p_0_in,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity input_arbiter_fifo_xpm_memory_base is
  port (
    sleep : in STD_LOGIC;
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    ena : in STD_LOGIC;
    regcea : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 5 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 450 downto 0 );
    injectsbiterra : in STD_LOGIC;
    injectdbiterra : in STD_LOGIC;
    douta : out STD_LOGIC_VECTOR ( 450 downto 0 );
    sbiterra : out STD_LOGIC;
    dbiterra : out STD_LOGIC;
    clkb : in STD_LOGIC;
    rstb : in STD_LOGIC;
    enb : in STD_LOGIC;
    regceb : in STD_LOGIC;
    web : in STD_LOGIC_VECTOR ( 0 to 0 );
    addrb : in STD_LOGIC_VECTOR ( 5 downto 0 );
    dinb : in STD_LOGIC_VECTOR ( 450 downto 0 );
    injectsbiterrb : in STD_LOGIC;
    injectdbiterrb : in STD_LOGIC;
    doutb : out STD_LOGIC_VECTOR ( 450 downto 0 );
    sbiterrb : out STD_LOGIC;
    dbiterrb : out STD_LOGIC
  );
  attribute ADDR_WIDTH_A : integer;
  attribute ADDR_WIDTH_A of input_arbiter_fifo_xpm_memory_base : entity is 6;
  attribute ADDR_WIDTH_B : integer;
  attribute ADDR_WIDTH_B of input_arbiter_fifo_xpm_memory_base : entity is 6;
  attribute AUTO_SLEEP_TIME : integer;
  attribute AUTO_SLEEP_TIME of input_arbiter_fifo_xpm_memory_base : entity is 0;
  attribute BYTE_WRITE_WIDTH_A : integer;
  attribute BYTE_WRITE_WIDTH_A of input_arbiter_fifo_xpm_memory_base : entity is 451;
  attribute BYTE_WRITE_WIDTH_B : integer;
  attribute BYTE_WRITE_WIDTH_B of input_arbiter_fifo_xpm_memory_base : entity is 451;
  attribute CASCADE_HEIGHT : integer;
  attribute CASCADE_HEIGHT of input_arbiter_fifo_xpm_memory_base : entity is 0;
  attribute CLOCKING_MODE : integer;
  attribute CLOCKING_MODE of input_arbiter_fifo_xpm_memory_base : entity is 0;
  attribute ECC_MODE : integer;
  attribute ECC_MODE of input_arbiter_fifo_xpm_memory_base : entity is 0;
  attribute MAX_NUM_CHAR : integer;
  attribute MAX_NUM_CHAR of input_arbiter_fifo_xpm_memory_base : entity is 0;
  attribute MEMORY_INIT_FILE : string;
  attribute MEMORY_INIT_FILE of input_arbiter_fifo_xpm_memory_base : entity is "none";
  attribute MEMORY_INIT_PARAM : string;
  attribute MEMORY_INIT_PARAM of input_arbiter_fifo_xpm_memory_base : entity is "";
  attribute MEMORY_OPTIMIZATION : string;
  attribute MEMORY_OPTIMIZATION of input_arbiter_fifo_xpm_memory_base : entity is "true";
  attribute MEMORY_PRIMITIVE : integer;
  attribute MEMORY_PRIMITIVE of input_arbiter_fifo_xpm_memory_base : entity is 0;
  attribute MEMORY_SIZE : integer;
  attribute MEMORY_SIZE of input_arbiter_fifo_xpm_memory_base : entity is 28864;
  attribute MEMORY_TYPE : integer;
  attribute MEMORY_TYPE of input_arbiter_fifo_xpm_memory_base : entity is 1;
  attribute MESSAGE_CONTROL : integer;
  attribute MESSAGE_CONTROL of input_arbiter_fifo_xpm_memory_base : entity is 0;
  attribute NUM_CHAR_LOC : integer;
  attribute NUM_CHAR_LOC of input_arbiter_fifo_xpm_memory_base : entity is 0;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of input_arbiter_fifo_xpm_memory_base : entity is "xpm_memory_base";
  attribute P_ECC_MODE : string;
  attribute P_ECC_MODE of input_arbiter_fifo_xpm_memory_base : entity is "no_ecc";
  attribute P_ENABLE_BYTE_WRITE_A : integer;
  attribute P_ENABLE_BYTE_WRITE_A of input_arbiter_fifo_xpm_memory_base : entity is 0;
  attribute P_ENABLE_BYTE_WRITE_B : integer;
  attribute P_ENABLE_BYTE_WRITE_B of input_arbiter_fifo_xpm_memory_base : entity is 0;
  attribute P_MAX_DEPTH_DATA : integer;
  attribute P_MAX_DEPTH_DATA of input_arbiter_fifo_xpm_memory_base : entity is 64;
  attribute P_MEMORY_OPT : string;
  attribute P_MEMORY_OPT of input_arbiter_fifo_xpm_memory_base : entity is "yes";
  attribute P_MEMORY_PRIMITIVE : string;
  attribute P_MEMORY_PRIMITIVE of input_arbiter_fifo_xpm_memory_base : entity is "auto";
  attribute P_MIN_WIDTH_DATA : integer;
  attribute P_MIN_WIDTH_DATA of input_arbiter_fifo_xpm_memory_base : entity is 451;
  attribute P_MIN_WIDTH_DATA_A : integer;
  attribute P_MIN_WIDTH_DATA_A of input_arbiter_fifo_xpm_memory_base : entity is 451;
  attribute P_MIN_WIDTH_DATA_B : integer;
  attribute P_MIN_WIDTH_DATA_B of input_arbiter_fifo_xpm_memory_base : entity is 451;
  attribute P_MIN_WIDTH_DATA_ECC : integer;
  attribute P_MIN_WIDTH_DATA_ECC of input_arbiter_fifo_xpm_memory_base : entity is 451;
  attribute P_MIN_WIDTH_DATA_LDW : integer;
  attribute P_MIN_WIDTH_DATA_LDW of input_arbiter_fifo_xpm_memory_base : entity is 4;
  attribute P_MIN_WIDTH_DATA_SHFT : integer;
  attribute P_MIN_WIDTH_DATA_SHFT of input_arbiter_fifo_xpm_memory_base : entity is 451;
  attribute P_NUM_COLS_WRITE_A : integer;
  attribute P_NUM_COLS_WRITE_A of input_arbiter_fifo_xpm_memory_base : entity is 1;
  attribute P_NUM_COLS_WRITE_B : integer;
  attribute P_NUM_COLS_WRITE_B of input_arbiter_fifo_xpm_memory_base : entity is 1;
  attribute P_NUM_ROWS_READ_A : integer;
  attribute P_NUM_ROWS_READ_A of input_arbiter_fifo_xpm_memory_base : entity is 1;
  attribute P_NUM_ROWS_READ_B : integer;
  attribute P_NUM_ROWS_READ_B of input_arbiter_fifo_xpm_memory_base : entity is 1;
  attribute P_NUM_ROWS_WRITE_A : integer;
  attribute P_NUM_ROWS_WRITE_A of input_arbiter_fifo_xpm_memory_base : entity is 1;
  attribute P_NUM_ROWS_WRITE_B : integer;
  attribute P_NUM_ROWS_WRITE_B of input_arbiter_fifo_xpm_memory_base : entity is 1;
  attribute P_SDP_WRITE_MODE : string;
  attribute P_SDP_WRITE_MODE of input_arbiter_fifo_xpm_memory_base : entity is "yes";
  attribute P_WIDTH_ADDR_LSB_READ_A : integer;
  attribute P_WIDTH_ADDR_LSB_READ_A of input_arbiter_fifo_xpm_memory_base : entity is 0;
  attribute P_WIDTH_ADDR_LSB_READ_B : integer;
  attribute P_WIDTH_ADDR_LSB_READ_B of input_arbiter_fifo_xpm_memory_base : entity is 0;
  attribute P_WIDTH_ADDR_LSB_WRITE_A : integer;
  attribute P_WIDTH_ADDR_LSB_WRITE_A of input_arbiter_fifo_xpm_memory_base : entity is 0;
  attribute P_WIDTH_ADDR_LSB_WRITE_B : integer;
  attribute P_WIDTH_ADDR_LSB_WRITE_B of input_arbiter_fifo_xpm_memory_base : entity is 0;
  attribute P_WIDTH_ADDR_READ_A : integer;
  attribute P_WIDTH_ADDR_READ_A of input_arbiter_fifo_xpm_memory_base : entity is 6;
  attribute P_WIDTH_ADDR_READ_B : integer;
  attribute P_WIDTH_ADDR_READ_B of input_arbiter_fifo_xpm_memory_base : entity is 6;
  attribute P_WIDTH_ADDR_WRITE_A : integer;
  attribute P_WIDTH_ADDR_WRITE_A of input_arbiter_fifo_xpm_memory_base : entity is 6;
  attribute P_WIDTH_ADDR_WRITE_B : integer;
  attribute P_WIDTH_ADDR_WRITE_B of input_arbiter_fifo_xpm_memory_base : entity is 6;
  attribute P_WIDTH_COL_WRITE_A : integer;
  attribute P_WIDTH_COL_WRITE_A of input_arbiter_fifo_xpm_memory_base : entity is 451;
  attribute P_WIDTH_COL_WRITE_B : integer;
  attribute P_WIDTH_COL_WRITE_B of input_arbiter_fifo_xpm_memory_base : entity is 451;
  attribute READ_DATA_WIDTH_A : integer;
  attribute READ_DATA_WIDTH_A of input_arbiter_fifo_xpm_memory_base : entity is 451;
  attribute READ_DATA_WIDTH_B : integer;
  attribute READ_DATA_WIDTH_B of input_arbiter_fifo_xpm_memory_base : entity is 451;
  attribute READ_LATENCY_A : integer;
  attribute READ_LATENCY_A of input_arbiter_fifo_xpm_memory_base : entity is 2;
  attribute READ_LATENCY_B : integer;
  attribute READ_LATENCY_B of input_arbiter_fifo_xpm_memory_base : entity is 2;
  attribute READ_RESET_VALUE_A : string;
  attribute READ_RESET_VALUE_A of input_arbiter_fifo_xpm_memory_base : entity is "0";
  attribute READ_RESET_VALUE_B : string;
  attribute READ_RESET_VALUE_B of input_arbiter_fifo_xpm_memory_base : entity is "";
  attribute RST_MODE_A : string;
  attribute RST_MODE_A of input_arbiter_fifo_xpm_memory_base : entity is "SYNC";
  attribute RST_MODE_B : string;
  attribute RST_MODE_B of input_arbiter_fifo_xpm_memory_base : entity is "SYNC";
  attribute SIM_ASSERT_CHK : integer;
  attribute SIM_ASSERT_CHK of input_arbiter_fifo_xpm_memory_base : entity is 0;
  attribute USE_EMBEDDED_CONSTRAINT : integer;
  attribute USE_EMBEDDED_CONSTRAINT of input_arbiter_fifo_xpm_memory_base : entity is 0;
  attribute USE_MEM_INIT : integer;
  attribute USE_MEM_INIT of input_arbiter_fifo_xpm_memory_base : entity is 0;
  attribute USE_MEM_INIT_MMI : integer;
  attribute USE_MEM_INIT_MMI of input_arbiter_fifo_xpm_memory_base : entity is 0;
  attribute VERSION : integer;
  attribute VERSION of input_arbiter_fifo_xpm_memory_base : entity is 0;
  attribute WAKEUP_TIME : integer;
  attribute WAKEUP_TIME of input_arbiter_fifo_xpm_memory_base : entity is 0;
  attribute WRITE_DATA_WIDTH_A : integer;
  attribute WRITE_DATA_WIDTH_A of input_arbiter_fifo_xpm_memory_base : entity is 451;
  attribute WRITE_DATA_WIDTH_B : integer;
  attribute WRITE_DATA_WIDTH_B of input_arbiter_fifo_xpm_memory_base : entity is 451;
  attribute WRITE_MODE_A : integer;
  attribute WRITE_MODE_A of input_arbiter_fifo_xpm_memory_base : entity is 2;
  attribute WRITE_MODE_B : integer;
  attribute WRITE_MODE_B of input_arbiter_fifo_xpm_memory_base : entity is 2;
  attribute WRITE_PROTECT : integer;
  attribute WRITE_PROTECT of input_arbiter_fifo_xpm_memory_base : entity is 1;
  attribute XPM_MODULE : string;
  attribute XPM_MODULE of input_arbiter_fifo_xpm_memory_base : entity is "TRUE";
  attribute keep_hierarchy : string;
  attribute keep_hierarchy of input_arbiter_fifo_xpm_memory_base : entity is "soft";
  attribute rsta_loop_iter : integer;
  attribute rsta_loop_iter of input_arbiter_fifo_xpm_memory_base : entity is 452;
  attribute rstb_loop_iter : integer;
  attribute rstb_loop_iter of input_arbiter_fifo_xpm_memory_base : entity is 452;
end input_arbiter_fifo_xpm_memory_base;

architecture STRUCTURE of input_arbiter_fifo_xpm_memory_base is
  signal \<const0>\ : STD_LOGIC;
  signal \^doutb\ : STD_LOGIC_VECTOR ( 450 downto 0 );
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_0_CASCADEOUTA_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_0_CASCADEOUTB_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_0_DBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_0_SBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_0_ECCPARITY_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_0_RDADDRECC_UNCONNECTED\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_1_CASCADEOUTA_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_1_CASCADEOUTB_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_1_DBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_1_SBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_1_ECCPARITY_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_1_RDADDRECC_UNCONNECTED\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_2_CASCADEOUTA_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_2_CASCADEOUTB_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_2_DBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_2_SBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_2_ECCPARITY_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_2_RDADDRECC_UNCONNECTED\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_3_CASCADEOUTA_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_3_CASCADEOUTB_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_3_DBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_3_SBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_3_ECCPARITY_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_3_RDADDRECC_UNCONNECTED\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_4_CASCADEOUTA_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_4_CASCADEOUTB_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_4_DBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_4_SBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_4_ECCPARITY_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_4_RDADDRECC_UNCONNECTED\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_5_CASCADEOUTA_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_5_CASCADEOUTB_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_5_DBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_5_SBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_5_DOBDO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 31 downto 25 );
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_5_DOPADOP_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_5_DOPBDOP_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_5_ECCPARITY_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \NLW_gen_wr_a.gen_word_narrow.mem_reg_5_RDADDRECC_UNCONNECTED\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  attribute \MEM.PORTA.ADDRESS_BEGIN\ : integer;
  attribute \MEM.PORTA.ADDRESS_BEGIN\ of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is 0;
  attribute \MEM.PORTA.ADDRESS_END\ : integer;
  attribute \MEM.PORTA.ADDRESS_END\ of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is 511;
  attribute \MEM.PORTA.DATA_BIT_LAYOUT\ : string;
  attribute \MEM.PORTA.DATA_BIT_LAYOUT\ of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is "p8_d64";
  attribute \MEM.PORTA.DATA_LSB\ : integer;
  attribute \MEM.PORTA.DATA_LSB\ of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is 0;
  attribute \MEM.PORTA.DATA_MSB\ : integer;
  attribute \MEM.PORTA.DATA_MSB\ of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is 71;
  attribute \MEM.PORTB.ADDRESS_BEGIN\ : integer;
  attribute \MEM.PORTB.ADDRESS_BEGIN\ of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is 0;
  attribute \MEM.PORTB.ADDRESS_END\ : integer;
  attribute \MEM.PORTB.ADDRESS_END\ of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is 511;
  attribute \MEM.PORTB.DATA_BIT_LAYOUT\ : string;
  attribute \MEM.PORTB.DATA_BIT_LAYOUT\ of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is "p8_d64";
  attribute \MEM.PORTB.DATA_LSB\ : integer;
  attribute \MEM.PORTB.DATA_LSB\ of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is 0;
  attribute \MEM.PORTB.DATA_MSB\ : integer;
  attribute \MEM.PORTB.DATA_MSB\ of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is 71;
  attribute METHODOLOGY_DRC_VIOS : string;
  attribute METHODOLOGY_DRC_VIOS of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is "";
  attribute RTL_RAM_BITS : integer;
  attribute RTL_RAM_BITS of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is 28864;
  attribute RTL_RAM_NAME : string;
  attribute RTL_RAM_NAME of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is "gen_wr_a.gen_word_narrow.mem";
  attribute RTL_RAM_TYPE : string;
  attribute RTL_RAM_TYPE of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is "RAM_SDP";
  attribute bram_addr_begin : integer;
  attribute bram_addr_begin of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is 0;
  attribute bram_addr_end : integer;
  attribute bram_addr_end of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is 511;
  attribute bram_slice_begin : integer;
  attribute bram_slice_begin of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is 0;
  attribute bram_slice_end : integer;
  attribute bram_slice_end of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is 71;
  attribute ram_addr_begin : integer;
  attribute ram_addr_begin of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is 0;
  attribute ram_addr_end : integer;
  attribute ram_addr_end of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is 511;
  attribute ram_offset : integer;
  attribute ram_offset of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is 0;
  attribute ram_slice_begin : integer;
  attribute ram_slice_begin of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is 0;
  attribute ram_slice_end : integer;
  attribute ram_slice_end of \gen_wr_a.gen_word_narrow.mem_reg_0\ : label is 71;
  attribute \MEM.PORTA.ADDRESS_BEGIN\ of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is 0;
  attribute \MEM.PORTA.ADDRESS_END\ of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is 511;
  attribute \MEM.PORTA.DATA_BIT_LAYOUT\ of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is "p8_d64";
  attribute \MEM.PORTA.DATA_LSB\ of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is 72;
  attribute \MEM.PORTA.DATA_MSB\ of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is 143;
  attribute \MEM.PORTB.ADDRESS_BEGIN\ of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is 0;
  attribute \MEM.PORTB.ADDRESS_END\ of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is 511;
  attribute \MEM.PORTB.DATA_BIT_LAYOUT\ of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is "p8_d64";
  attribute \MEM.PORTB.DATA_LSB\ of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is 72;
  attribute \MEM.PORTB.DATA_MSB\ of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is 143;
  attribute METHODOLOGY_DRC_VIOS of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is "";
  attribute RTL_RAM_BITS of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is 28864;
  attribute RTL_RAM_NAME of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is "gen_wr_a.gen_word_narrow.mem";
  attribute RTL_RAM_TYPE of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is "RAM_SDP";
  attribute bram_addr_begin of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is 0;
  attribute bram_addr_end of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is 511;
  attribute bram_slice_begin of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is 72;
  attribute bram_slice_end of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is 143;
  attribute ram_addr_begin of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is 0;
  attribute ram_addr_end of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is 511;
  attribute ram_offset of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is 0;
  attribute ram_slice_begin of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is 72;
  attribute ram_slice_end of \gen_wr_a.gen_word_narrow.mem_reg_1\ : label is 143;
  attribute \MEM.PORTA.ADDRESS_BEGIN\ of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is 0;
  attribute \MEM.PORTA.ADDRESS_END\ of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is 511;
  attribute \MEM.PORTA.DATA_BIT_LAYOUT\ of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is "p8_d64";
  attribute \MEM.PORTA.DATA_LSB\ of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is 144;
  attribute \MEM.PORTA.DATA_MSB\ of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is 215;
  attribute \MEM.PORTB.ADDRESS_BEGIN\ of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is 0;
  attribute \MEM.PORTB.ADDRESS_END\ of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is 511;
  attribute \MEM.PORTB.DATA_BIT_LAYOUT\ of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is "p8_d64";
  attribute \MEM.PORTB.DATA_LSB\ of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is 144;
  attribute \MEM.PORTB.DATA_MSB\ of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is 215;
  attribute METHODOLOGY_DRC_VIOS of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is "";
  attribute RTL_RAM_BITS of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is 28864;
  attribute RTL_RAM_NAME of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is "gen_wr_a.gen_word_narrow.mem";
  attribute RTL_RAM_TYPE of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is "RAM_SDP";
  attribute bram_addr_begin of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is 0;
  attribute bram_addr_end of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is 511;
  attribute bram_slice_begin of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is 144;
  attribute bram_slice_end of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is 215;
  attribute ram_addr_begin of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is 0;
  attribute ram_addr_end of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is 511;
  attribute ram_offset of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is 0;
  attribute ram_slice_begin of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is 144;
  attribute ram_slice_end of \gen_wr_a.gen_word_narrow.mem_reg_2\ : label is 215;
  attribute \MEM.PORTA.ADDRESS_BEGIN\ of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is 0;
  attribute \MEM.PORTA.ADDRESS_END\ of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is 511;
  attribute \MEM.PORTA.DATA_BIT_LAYOUT\ of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is "p8_d64";
  attribute \MEM.PORTA.DATA_LSB\ of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is 216;
  attribute \MEM.PORTA.DATA_MSB\ of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is 287;
  attribute \MEM.PORTB.ADDRESS_BEGIN\ of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is 0;
  attribute \MEM.PORTB.ADDRESS_END\ of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is 511;
  attribute \MEM.PORTB.DATA_BIT_LAYOUT\ of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is "p8_d64";
  attribute \MEM.PORTB.DATA_LSB\ of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is 216;
  attribute \MEM.PORTB.DATA_MSB\ of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is 287;
  attribute METHODOLOGY_DRC_VIOS of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is "";
  attribute RTL_RAM_BITS of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is 28864;
  attribute RTL_RAM_NAME of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is "gen_wr_a.gen_word_narrow.mem";
  attribute RTL_RAM_TYPE of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is "RAM_SDP";
  attribute bram_addr_begin of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is 0;
  attribute bram_addr_end of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is 511;
  attribute bram_slice_begin of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is 216;
  attribute bram_slice_end of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is 287;
  attribute ram_addr_begin of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is 0;
  attribute ram_addr_end of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is 511;
  attribute ram_offset of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is 0;
  attribute ram_slice_begin of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is 216;
  attribute ram_slice_end of \gen_wr_a.gen_word_narrow.mem_reg_3\ : label is 287;
  attribute \MEM.PORTA.ADDRESS_BEGIN\ of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is 0;
  attribute \MEM.PORTA.ADDRESS_END\ of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is 511;
  attribute \MEM.PORTA.DATA_BIT_LAYOUT\ of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is "p8_d64";
  attribute \MEM.PORTA.DATA_LSB\ of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is 288;
  attribute \MEM.PORTA.DATA_MSB\ of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is 359;
  attribute \MEM.PORTB.ADDRESS_BEGIN\ of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is 0;
  attribute \MEM.PORTB.ADDRESS_END\ of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is 511;
  attribute \MEM.PORTB.DATA_BIT_LAYOUT\ of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is "p8_d64";
  attribute \MEM.PORTB.DATA_LSB\ of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is 288;
  attribute \MEM.PORTB.DATA_MSB\ of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is 359;
  attribute METHODOLOGY_DRC_VIOS of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is "";
  attribute RTL_RAM_BITS of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is 28864;
  attribute RTL_RAM_NAME of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is "gen_wr_a.gen_word_narrow.mem";
  attribute RTL_RAM_TYPE of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is "RAM_SDP";
  attribute bram_addr_begin of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is 0;
  attribute bram_addr_end of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is 511;
  attribute bram_slice_begin of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is 288;
  attribute bram_slice_end of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is 359;
  attribute ram_addr_begin of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is 0;
  attribute ram_addr_end of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is 511;
  attribute ram_offset of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is 0;
  attribute ram_slice_begin of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is 288;
  attribute ram_slice_end of \gen_wr_a.gen_word_narrow.mem_reg_4\ : label is 359;
  attribute \MEM.PORTA.ADDRESS_BEGIN\ of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is 0;
  attribute \MEM.PORTA.ADDRESS_END\ of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is 511;
  attribute \MEM.PORTA.DATA_BIT_LAYOUT\ of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is "p0_d57";
  attribute \MEM.PORTA.DATA_LSB\ of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is 360;
  attribute \MEM.PORTA.DATA_MSB\ of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is 416;
  attribute \MEM.PORTB.ADDRESS_BEGIN\ of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is 0;
  attribute \MEM.PORTB.ADDRESS_END\ of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is 511;
  attribute \MEM.PORTB.DATA_BIT_LAYOUT\ of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is "p0_d57";
  attribute \MEM.PORTB.DATA_LSB\ of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is 360;
  attribute \MEM.PORTB.DATA_MSB\ of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is 416;
  attribute METHODOLOGY_DRC_VIOS of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is "";
  attribute RTL_RAM_BITS of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is 28864;
  attribute RTL_RAM_NAME of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is "gen_wr_a.gen_word_narrow.mem";
  attribute RTL_RAM_TYPE of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is "RAM_SDP";
  attribute bram_addr_begin of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is 0;
  attribute bram_addr_end of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is 511;
  attribute bram_slice_begin of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is 360;
  attribute bram_slice_end of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is 416;
  attribute ram_addr_begin of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is 0;
  attribute ram_addr_end of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is 511;
  attribute ram_offset of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is 0;
  attribute ram_slice_begin of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is 360;
  attribute ram_slice_end of \gen_wr_a.gen_word_narrow.mem_reg_5\ : label is 416;
begin
  dbiterra <= \<const0>\;
  dbiterrb <= \<const0>\;
  douta(450) <= \<const0>\;
  douta(449) <= \<const0>\;
  douta(448) <= \<const0>\;
  douta(447) <= \<const0>\;
  douta(446) <= \<const0>\;
  douta(445) <= \<const0>\;
  douta(444) <= \<const0>\;
  douta(443) <= \<const0>\;
  douta(442) <= \<const0>\;
  douta(441) <= \<const0>\;
  douta(440) <= \<const0>\;
  douta(439) <= \<const0>\;
  douta(438) <= \<const0>\;
  douta(437) <= \<const0>\;
  douta(436) <= \<const0>\;
  douta(435) <= \<const0>\;
  douta(434) <= \<const0>\;
  douta(433) <= \<const0>\;
  douta(432) <= \<const0>\;
  douta(431) <= \<const0>\;
  douta(430) <= \<const0>\;
  douta(429) <= \<const0>\;
  douta(428) <= \<const0>\;
  douta(427) <= \<const0>\;
  douta(426) <= \<const0>\;
  douta(425) <= \<const0>\;
  douta(424) <= \<const0>\;
  douta(423) <= \<const0>\;
  douta(422) <= \<const0>\;
  douta(421) <= \<const0>\;
  douta(420) <= \<const0>\;
  douta(419) <= \<const0>\;
  douta(418) <= \<const0>\;
  douta(417) <= \<const0>\;
  douta(416) <= \<const0>\;
  douta(415) <= \<const0>\;
  douta(414) <= \<const0>\;
  douta(413) <= \<const0>\;
  douta(412) <= \<const0>\;
  douta(411) <= \<const0>\;
  douta(410) <= \<const0>\;
  douta(409) <= \<const0>\;
  douta(408) <= \<const0>\;
  douta(407) <= \<const0>\;
  douta(406) <= \<const0>\;
  douta(405) <= \<const0>\;
  douta(404) <= \<const0>\;
  douta(403) <= \<const0>\;
  douta(402) <= \<const0>\;
  douta(401) <= \<const0>\;
  douta(400) <= \<const0>\;
  douta(399) <= \<const0>\;
  douta(398) <= \<const0>\;
  douta(397) <= \<const0>\;
  douta(396) <= \<const0>\;
  douta(395) <= \<const0>\;
  douta(394) <= \<const0>\;
  douta(393) <= \<const0>\;
  douta(392) <= \<const0>\;
  douta(391) <= \<const0>\;
  douta(390) <= \<const0>\;
  douta(389) <= \<const0>\;
  douta(388) <= \<const0>\;
  douta(387) <= \<const0>\;
  douta(386) <= \<const0>\;
  douta(385) <= \<const0>\;
  douta(384) <= \<const0>\;
  douta(383) <= \<const0>\;
  douta(382) <= \<const0>\;
  douta(381) <= \<const0>\;
  douta(380) <= \<const0>\;
  douta(379) <= \<const0>\;
  douta(378) <= \<const0>\;
  douta(377) <= \<const0>\;
  douta(376) <= \<const0>\;
  douta(375) <= \<const0>\;
  douta(374) <= \<const0>\;
  douta(373) <= \<const0>\;
  douta(372) <= \<const0>\;
  douta(371) <= \<const0>\;
  douta(370) <= \<const0>\;
  douta(369) <= \<const0>\;
  douta(368) <= \<const0>\;
  douta(367) <= \<const0>\;
  douta(366) <= \<const0>\;
  douta(365) <= \<const0>\;
  douta(364) <= \<const0>\;
  douta(363) <= \<const0>\;
  douta(362) <= \<const0>\;
  douta(361) <= \<const0>\;
  douta(360) <= \<const0>\;
  douta(359) <= \<const0>\;
  douta(358) <= \<const0>\;
  douta(357) <= \<const0>\;
  douta(356) <= \<const0>\;
  douta(355) <= \<const0>\;
  douta(354) <= \<const0>\;
  douta(353) <= \<const0>\;
  douta(352) <= \<const0>\;
  douta(351) <= \<const0>\;
  douta(350) <= \<const0>\;
  douta(349) <= \<const0>\;
  douta(348) <= \<const0>\;
  douta(347) <= \<const0>\;
  douta(346) <= \<const0>\;
  douta(345) <= \<const0>\;
  douta(344) <= \<const0>\;
  douta(343) <= \<const0>\;
  douta(342) <= \<const0>\;
  douta(341) <= \<const0>\;
  douta(340) <= \<const0>\;
  douta(339) <= \<const0>\;
  douta(338) <= \<const0>\;
  douta(337) <= \<const0>\;
  douta(336) <= \<const0>\;
  douta(335) <= \<const0>\;
  douta(334) <= \<const0>\;
  douta(333) <= \<const0>\;
  douta(332) <= \<const0>\;
  douta(331) <= \<const0>\;
  douta(330) <= \<const0>\;
  douta(329) <= \<const0>\;
  douta(328) <= \<const0>\;
  douta(327) <= \<const0>\;
  douta(326) <= \<const0>\;
  douta(325) <= \<const0>\;
  douta(324) <= \<const0>\;
  douta(323) <= \<const0>\;
  douta(322) <= \<const0>\;
  douta(321) <= \<const0>\;
  douta(320) <= \<const0>\;
  douta(319) <= \<const0>\;
  douta(318) <= \<const0>\;
  douta(317) <= \<const0>\;
  douta(316) <= \<const0>\;
  douta(315) <= \<const0>\;
  douta(314) <= \<const0>\;
  douta(313) <= \<const0>\;
  douta(312) <= \<const0>\;
  douta(311) <= \<const0>\;
  douta(310) <= \<const0>\;
  douta(309) <= \<const0>\;
  douta(308) <= \<const0>\;
  douta(307) <= \<const0>\;
  douta(306) <= \<const0>\;
  douta(305) <= \<const0>\;
  douta(304) <= \<const0>\;
  douta(303) <= \<const0>\;
  douta(302) <= \<const0>\;
  douta(301) <= \<const0>\;
  douta(300) <= \<const0>\;
  douta(299) <= \<const0>\;
  douta(298) <= \<const0>\;
  douta(297) <= \<const0>\;
  douta(296) <= \<const0>\;
  douta(295) <= \<const0>\;
  douta(294) <= \<const0>\;
  douta(293) <= \<const0>\;
  douta(292) <= \<const0>\;
  douta(291) <= \<const0>\;
  douta(290) <= \<const0>\;
  douta(289) <= \<const0>\;
  douta(288) <= \<const0>\;
  douta(287) <= \<const0>\;
  douta(286) <= \<const0>\;
  douta(285) <= \<const0>\;
  douta(284) <= \<const0>\;
  douta(283) <= \<const0>\;
  douta(282) <= \<const0>\;
  douta(281) <= \<const0>\;
  douta(280) <= \<const0>\;
  douta(279) <= \<const0>\;
  douta(278) <= \<const0>\;
  douta(277) <= \<const0>\;
  douta(276) <= \<const0>\;
  douta(275) <= \<const0>\;
  douta(274) <= \<const0>\;
  douta(273) <= \<const0>\;
  douta(272) <= \<const0>\;
  douta(271) <= \<const0>\;
  douta(270) <= \<const0>\;
  douta(269) <= \<const0>\;
  douta(268) <= \<const0>\;
  douta(267) <= \<const0>\;
  douta(266) <= \<const0>\;
  douta(265) <= \<const0>\;
  douta(264) <= \<const0>\;
  douta(263) <= \<const0>\;
  douta(262) <= \<const0>\;
  douta(261) <= \<const0>\;
  douta(260) <= \<const0>\;
  douta(259) <= \<const0>\;
  douta(258) <= \<const0>\;
  douta(257) <= \<const0>\;
  douta(256) <= \<const0>\;
  douta(255) <= \<const0>\;
  douta(254) <= \<const0>\;
  douta(253) <= \<const0>\;
  douta(252) <= \<const0>\;
  douta(251) <= \<const0>\;
  douta(250) <= \<const0>\;
  douta(249) <= \<const0>\;
  douta(248) <= \<const0>\;
  douta(247) <= \<const0>\;
  douta(246) <= \<const0>\;
  douta(245) <= \<const0>\;
  douta(244) <= \<const0>\;
  douta(243) <= \<const0>\;
  douta(242) <= \<const0>\;
  douta(241) <= \<const0>\;
  douta(240) <= \<const0>\;
  douta(239) <= \<const0>\;
  douta(238) <= \<const0>\;
  douta(237) <= \<const0>\;
  douta(236) <= \<const0>\;
  douta(235) <= \<const0>\;
  douta(234) <= \<const0>\;
  douta(233) <= \<const0>\;
  douta(232) <= \<const0>\;
  douta(231) <= \<const0>\;
  douta(230) <= \<const0>\;
  douta(229) <= \<const0>\;
  douta(228) <= \<const0>\;
  douta(227) <= \<const0>\;
  douta(226) <= \<const0>\;
  douta(225) <= \<const0>\;
  douta(224) <= \<const0>\;
  douta(223) <= \<const0>\;
  douta(222) <= \<const0>\;
  douta(221) <= \<const0>\;
  douta(220) <= \<const0>\;
  douta(219) <= \<const0>\;
  douta(218) <= \<const0>\;
  douta(217) <= \<const0>\;
  douta(216) <= \<const0>\;
  douta(215) <= \<const0>\;
  douta(214) <= \<const0>\;
  douta(213) <= \<const0>\;
  douta(212) <= \<const0>\;
  douta(211) <= \<const0>\;
  douta(210) <= \<const0>\;
  douta(209) <= \<const0>\;
  douta(208) <= \<const0>\;
  douta(207) <= \<const0>\;
  douta(206) <= \<const0>\;
  douta(205) <= \<const0>\;
  douta(204) <= \<const0>\;
  douta(203) <= \<const0>\;
  douta(202) <= \<const0>\;
  douta(201) <= \<const0>\;
  douta(200) <= \<const0>\;
  douta(199) <= \<const0>\;
  douta(198) <= \<const0>\;
  douta(197) <= \<const0>\;
  douta(196) <= \<const0>\;
  douta(195) <= \<const0>\;
  douta(194) <= \<const0>\;
  douta(193) <= \<const0>\;
  douta(192) <= \<const0>\;
  douta(191) <= \<const0>\;
  douta(190) <= \<const0>\;
  douta(189) <= \<const0>\;
  douta(188) <= \<const0>\;
  douta(187) <= \<const0>\;
  douta(186) <= \<const0>\;
  douta(185) <= \<const0>\;
  douta(184) <= \<const0>\;
  douta(183) <= \<const0>\;
  douta(182) <= \<const0>\;
  douta(181) <= \<const0>\;
  douta(180) <= \<const0>\;
  douta(179) <= \<const0>\;
  douta(178) <= \<const0>\;
  douta(177) <= \<const0>\;
  douta(176) <= \<const0>\;
  douta(175) <= \<const0>\;
  douta(174) <= \<const0>\;
  douta(173) <= \<const0>\;
  douta(172) <= \<const0>\;
  douta(171) <= \<const0>\;
  douta(170) <= \<const0>\;
  douta(169) <= \<const0>\;
  douta(168) <= \<const0>\;
  douta(167) <= \<const0>\;
  douta(166) <= \<const0>\;
  douta(165) <= \<const0>\;
  douta(164) <= \<const0>\;
  douta(163) <= \<const0>\;
  douta(162) <= \<const0>\;
  douta(161) <= \<const0>\;
  douta(160) <= \<const0>\;
  douta(159) <= \<const0>\;
  douta(158) <= \<const0>\;
  douta(157) <= \<const0>\;
  douta(156) <= \<const0>\;
  douta(155) <= \<const0>\;
  douta(154) <= \<const0>\;
  douta(153) <= \<const0>\;
  douta(152) <= \<const0>\;
  douta(151) <= \<const0>\;
  douta(150) <= \<const0>\;
  douta(149) <= \<const0>\;
  douta(148) <= \<const0>\;
  douta(147) <= \<const0>\;
  douta(146) <= \<const0>\;
  douta(145) <= \<const0>\;
  douta(144) <= \<const0>\;
  douta(143) <= \<const0>\;
  douta(142) <= \<const0>\;
  douta(141) <= \<const0>\;
  douta(140) <= \<const0>\;
  douta(139) <= \<const0>\;
  douta(138) <= \<const0>\;
  douta(137) <= \<const0>\;
  douta(136) <= \<const0>\;
  douta(135) <= \<const0>\;
  douta(134) <= \<const0>\;
  douta(133) <= \<const0>\;
  douta(132) <= \<const0>\;
  douta(131) <= \<const0>\;
  douta(130) <= \<const0>\;
  douta(129) <= \<const0>\;
  douta(128) <= \<const0>\;
  douta(127) <= \<const0>\;
  douta(126) <= \<const0>\;
  douta(125) <= \<const0>\;
  douta(124) <= \<const0>\;
  douta(123) <= \<const0>\;
  douta(122) <= \<const0>\;
  douta(121) <= \<const0>\;
  douta(120) <= \<const0>\;
  douta(119) <= \<const0>\;
  douta(118) <= \<const0>\;
  douta(117) <= \<const0>\;
  douta(116) <= \<const0>\;
  douta(115) <= \<const0>\;
  douta(114) <= \<const0>\;
  douta(113) <= \<const0>\;
  douta(112) <= \<const0>\;
  douta(111) <= \<const0>\;
  douta(110) <= \<const0>\;
  douta(109) <= \<const0>\;
  douta(108) <= \<const0>\;
  douta(107) <= \<const0>\;
  douta(106) <= \<const0>\;
  douta(105) <= \<const0>\;
  douta(104) <= \<const0>\;
  douta(103) <= \<const0>\;
  douta(102) <= \<const0>\;
  douta(101) <= \<const0>\;
  douta(100) <= \<const0>\;
  douta(99) <= \<const0>\;
  douta(98) <= \<const0>\;
  douta(97) <= \<const0>\;
  douta(96) <= \<const0>\;
  douta(95) <= \<const0>\;
  douta(94) <= \<const0>\;
  douta(93) <= \<const0>\;
  douta(92) <= \<const0>\;
  douta(91) <= \<const0>\;
  douta(90) <= \<const0>\;
  douta(89) <= \<const0>\;
  douta(88) <= \<const0>\;
  douta(87) <= \<const0>\;
  douta(86) <= \<const0>\;
  douta(85) <= \<const0>\;
  douta(84) <= \<const0>\;
  douta(83) <= \<const0>\;
  douta(82) <= \<const0>\;
  douta(81) <= \<const0>\;
  douta(80) <= \<const0>\;
  douta(79) <= \<const0>\;
  douta(78) <= \<const0>\;
  douta(77) <= \<const0>\;
  douta(76) <= \<const0>\;
  douta(75) <= \<const0>\;
  douta(74) <= \<const0>\;
  douta(73) <= \<const0>\;
  douta(72) <= \<const0>\;
  douta(71) <= \<const0>\;
  douta(70) <= \<const0>\;
  douta(69) <= \<const0>\;
  douta(68) <= \<const0>\;
  douta(67) <= \<const0>\;
  douta(66) <= \<const0>\;
  douta(65) <= \<const0>\;
  douta(64) <= \<const0>\;
  douta(63) <= \<const0>\;
  douta(62) <= \<const0>\;
  douta(61) <= \<const0>\;
  douta(60) <= \<const0>\;
  douta(59) <= \<const0>\;
  douta(58) <= \<const0>\;
  douta(57) <= \<const0>\;
  douta(56) <= \<const0>\;
  douta(55) <= \<const0>\;
  douta(54) <= \<const0>\;
  douta(53) <= \<const0>\;
  douta(52) <= \<const0>\;
  douta(51) <= \<const0>\;
  douta(50) <= \<const0>\;
  douta(49) <= \<const0>\;
  douta(48) <= \<const0>\;
  douta(47) <= \<const0>\;
  douta(46) <= \<const0>\;
  douta(45) <= \<const0>\;
  douta(44) <= \<const0>\;
  douta(43) <= \<const0>\;
  douta(42) <= \<const0>\;
  douta(41) <= \<const0>\;
  douta(40) <= \<const0>\;
  douta(39) <= \<const0>\;
  douta(38) <= \<const0>\;
  douta(37) <= \<const0>\;
  douta(36) <= \<const0>\;
  douta(35) <= \<const0>\;
  douta(34) <= \<const0>\;
  douta(33) <= \<const0>\;
  douta(32) <= \<const0>\;
  douta(31) <= \<const0>\;
  douta(30) <= \<const0>\;
  douta(29) <= \<const0>\;
  douta(28) <= \<const0>\;
  douta(27) <= \<const0>\;
  douta(26) <= \<const0>\;
  douta(25) <= \<const0>\;
  douta(24) <= \<const0>\;
  douta(23) <= \<const0>\;
  douta(22) <= \<const0>\;
  douta(21) <= \<const0>\;
  douta(20) <= \<const0>\;
  douta(19) <= \<const0>\;
  douta(18) <= \<const0>\;
  douta(17) <= \<const0>\;
  douta(16) <= \<const0>\;
  douta(15) <= \<const0>\;
  douta(14) <= \<const0>\;
  douta(13) <= \<const0>\;
  douta(12) <= \<const0>\;
  douta(11) <= \<const0>\;
  douta(10) <= \<const0>\;
  douta(9) <= \<const0>\;
  douta(8) <= \<const0>\;
  douta(7) <= \<const0>\;
  douta(6) <= \<const0>\;
  douta(5) <= \<const0>\;
  douta(4) <= \<const0>\;
  douta(3) <= \<const0>\;
  douta(2) <= \<const0>\;
  douta(1) <= \<const0>\;
  douta(0) <= \<const0>\;
  doutb(450 downto 322) <= \^doutb\(450 downto 322);
  doutb(321) <= \<const0>\;
  doutb(320) <= \<const0>\;
  doutb(319 downto 288) <= \^doutb\(319 downto 288);
  doutb(287) <= \<const0>\;
  doutb(286) <= \<const0>\;
  doutb(285) <= \<const0>\;
  doutb(284) <= \<const0>\;
  doutb(283) <= \<const0>\;
  doutb(282) <= \<const0>\;
  doutb(281) <= \<const0>\;
  doutb(280) <= \<const0>\;
  doutb(279) <= \<const0>\;
  doutb(278) <= \<const0>\;
  doutb(277) <= \<const0>\;
  doutb(276) <= \<const0>\;
  doutb(275) <= \<const0>\;
  doutb(274) <= \<const0>\;
  doutb(273) <= \<const0>\;
  doutb(272) <= \<const0>\;
  doutb(271) <= \<const0>\;
  doutb(270) <= \<const0>\;
  doutb(269) <= \<const0>\;
  doutb(268) <= \<const0>\;
  doutb(267) <= \<const0>\;
  doutb(266) <= \<const0>\;
  doutb(265) <= \<const0>\;
  doutb(264) <= \<const0>\;
  doutb(263) <= \<const0>\;
  doutb(262) <= \<const0>\;
  doutb(261) <= \<const0>\;
  doutb(260) <= \<const0>\;
  doutb(259) <= \<const0>\;
  doutb(258) <= \<const0>\;
  doutb(257) <= \<const0>\;
  doutb(256) <= \<const0>\;
  doutb(255 downto 0) <= \^doutb\(255 downto 0);
  sbiterra <= \<const0>\;
  sbiterrb <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
\gen_wr_a.gen_word_narrow.mem_reg_0\: unisim.vcomponents.RAMB36E1
    generic map(
      DOA_REG => 1,
      DOB_REG => 1,
      EN_ECC_READ => false,
      EN_ECC_WRITE => false,
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_40 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_41 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_42 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_43 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_44 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_45 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_46 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_47 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_48 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_49 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_50 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_51 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_52 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_53 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_54 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_55 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_56 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_57 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_58 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_59 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_60 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_61 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_62 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_63 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_64 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_65 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_66 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_67 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_68 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_69 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_70 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_71 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_72 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_73 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_74 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_75 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_76 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_77 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_78 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_79 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      RAM_MODE => "SDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      READ_WIDTH_A => 72,
      READ_WIDTH_B => 0,
      RSTREG_PRIORITY_A => "RSTREG",
      RSTREG_PRIORITY_B => "RSTREG",
      SIM_COLLISION_CHECK => "ALL",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      WRITE_WIDTH_A => 0,
      WRITE_WIDTH_B => 72
    )
        port map (
      ADDRARDADDR(15 downto 12) => B"1000",
      ADDRARDADDR(11 downto 6) => addrb(5 downto 0),
      ADDRARDADDR(5 downto 0) => B"111111",
      ADDRBWRADDR(15 downto 12) => B"1000",
      ADDRBWRADDR(11 downto 6) => addra(5 downto 0),
      ADDRBWRADDR(5 downto 0) => B"111111",
      CASCADEINA => '0',
      CASCADEINB => '0',
      CASCADEOUTA => \NLW_gen_wr_a.gen_word_narrow.mem_reg_0_CASCADEOUTA_UNCONNECTED\,
      CASCADEOUTB => \NLW_gen_wr_a.gen_word_narrow.mem_reg_0_CASCADEOUTB_UNCONNECTED\,
      CLKARDCLK => clka,
      CLKBWRCLK => clka,
      DBITERR => \NLW_gen_wr_a.gen_word_narrow.mem_reg_0_DBITERR_UNCONNECTED\,
      DIADI(31 downto 0) => dina(31 downto 0),
      DIBDI(31 downto 0) => dina(63 downto 32),
      DIPADIP(3 downto 0) => dina(67 downto 64),
      DIPBDIP(3 downto 0) => dina(71 downto 68),
      DOADO(31 downto 0) => \^doutb\(31 downto 0),
      DOBDO(31 downto 0) => \^doutb\(63 downto 32),
      DOPADOP(3 downto 0) => \^doutb\(67 downto 64),
      DOPBDOP(3 downto 0) => \^doutb\(71 downto 68),
      ECCPARITY(7 downto 0) => \NLW_gen_wr_a.gen_word_narrow.mem_reg_0_ECCPARITY_UNCONNECTED\(7 downto 0),
      ENARDEN => enb,
      ENBWREN => '1',
      INJECTDBITERR => '0',
      INJECTSBITERR => '0',
      RDADDRECC(8 downto 0) => \NLW_gen_wr_a.gen_word_narrow.mem_reg_0_RDADDRECC_UNCONNECTED\(8 downto 0),
      REGCEAREGCE => regceb,
      REGCEB => '0',
      RSTRAMARSTRAM => '0',
      RSTRAMB => '0',
      RSTREGARSTREG => rstb,
      RSTREGB => '0',
      SBITERR => \NLW_gen_wr_a.gen_word_narrow.mem_reg_0_SBITERR_UNCONNECTED\,
      WEA(3 downto 0) => B"0000",
      WEBWE(7) => wea(0),
      WEBWE(6) => wea(0),
      WEBWE(5) => wea(0),
      WEBWE(4) => wea(0),
      WEBWE(3) => wea(0),
      WEBWE(2) => wea(0),
      WEBWE(1) => wea(0),
      WEBWE(0) => wea(0)
    );
\gen_wr_a.gen_word_narrow.mem_reg_1\: unisim.vcomponents.RAMB36E1
    generic map(
      DOA_REG => 1,
      DOB_REG => 1,
      EN_ECC_READ => false,
      EN_ECC_WRITE => false,
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_40 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_41 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_42 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_43 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_44 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_45 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_46 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_47 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_48 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_49 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_50 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_51 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_52 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_53 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_54 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_55 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_56 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_57 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_58 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_59 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_60 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_61 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_62 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_63 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_64 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_65 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_66 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_67 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_68 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_69 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_70 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_71 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_72 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_73 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_74 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_75 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_76 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_77 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_78 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_79 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      RAM_MODE => "SDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      READ_WIDTH_A => 72,
      READ_WIDTH_B => 0,
      RSTREG_PRIORITY_A => "RSTREG",
      RSTREG_PRIORITY_B => "RSTREG",
      SIM_COLLISION_CHECK => "ALL",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      WRITE_WIDTH_A => 0,
      WRITE_WIDTH_B => 72
    )
        port map (
      ADDRARDADDR(15 downto 12) => B"1000",
      ADDRARDADDR(11 downto 6) => addrb(5 downto 0),
      ADDRARDADDR(5 downto 0) => B"111111",
      ADDRBWRADDR(15 downto 12) => B"1000",
      ADDRBWRADDR(11 downto 6) => addra(5 downto 0),
      ADDRBWRADDR(5 downto 0) => B"111111",
      CASCADEINA => '0',
      CASCADEINB => '0',
      CASCADEOUTA => \NLW_gen_wr_a.gen_word_narrow.mem_reg_1_CASCADEOUTA_UNCONNECTED\,
      CASCADEOUTB => \NLW_gen_wr_a.gen_word_narrow.mem_reg_1_CASCADEOUTB_UNCONNECTED\,
      CLKARDCLK => clka,
      CLKBWRCLK => clka,
      DBITERR => \NLW_gen_wr_a.gen_word_narrow.mem_reg_1_DBITERR_UNCONNECTED\,
      DIADI(31 downto 0) => dina(103 downto 72),
      DIBDI(31 downto 0) => dina(135 downto 104),
      DIPADIP(3 downto 0) => dina(139 downto 136),
      DIPBDIP(3 downto 0) => dina(143 downto 140),
      DOADO(31 downto 0) => \^doutb\(103 downto 72),
      DOBDO(31 downto 0) => \^doutb\(135 downto 104),
      DOPADOP(3 downto 0) => \^doutb\(139 downto 136),
      DOPBDOP(3 downto 0) => \^doutb\(143 downto 140),
      ECCPARITY(7 downto 0) => \NLW_gen_wr_a.gen_word_narrow.mem_reg_1_ECCPARITY_UNCONNECTED\(7 downto 0),
      ENARDEN => enb,
      ENBWREN => '1',
      INJECTDBITERR => '0',
      INJECTSBITERR => '0',
      RDADDRECC(8 downto 0) => \NLW_gen_wr_a.gen_word_narrow.mem_reg_1_RDADDRECC_UNCONNECTED\(8 downto 0),
      REGCEAREGCE => regceb,
      REGCEB => '0',
      RSTRAMARSTRAM => '0',
      RSTRAMB => '0',
      RSTREGARSTREG => rstb,
      RSTREGB => '0',
      SBITERR => \NLW_gen_wr_a.gen_word_narrow.mem_reg_1_SBITERR_UNCONNECTED\,
      WEA(3 downto 0) => B"0000",
      WEBWE(7) => wea(0),
      WEBWE(6) => wea(0),
      WEBWE(5) => wea(0),
      WEBWE(4) => wea(0),
      WEBWE(3) => wea(0),
      WEBWE(2) => wea(0),
      WEBWE(1) => wea(0),
      WEBWE(0) => wea(0)
    );
\gen_wr_a.gen_word_narrow.mem_reg_2\: unisim.vcomponents.RAMB36E1
    generic map(
      DOA_REG => 1,
      DOB_REG => 1,
      EN_ECC_READ => false,
      EN_ECC_WRITE => false,
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_40 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_41 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_42 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_43 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_44 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_45 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_46 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_47 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_48 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_49 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_50 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_51 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_52 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_53 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_54 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_55 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_56 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_57 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_58 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_59 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_60 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_61 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_62 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_63 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_64 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_65 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_66 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_67 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_68 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_69 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_70 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_71 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_72 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_73 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_74 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_75 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_76 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_77 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_78 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_79 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      RAM_MODE => "SDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      READ_WIDTH_A => 72,
      READ_WIDTH_B => 0,
      RSTREG_PRIORITY_A => "RSTREG",
      RSTREG_PRIORITY_B => "RSTREG",
      SIM_COLLISION_CHECK => "ALL",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      WRITE_WIDTH_A => 0,
      WRITE_WIDTH_B => 72
    )
        port map (
      ADDRARDADDR(15 downto 12) => B"1000",
      ADDRARDADDR(11 downto 6) => addrb(5 downto 0),
      ADDRARDADDR(5 downto 0) => B"111111",
      ADDRBWRADDR(15 downto 12) => B"1000",
      ADDRBWRADDR(11 downto 6) => addra(5 downto 0),
      ADDRBWRADDR(5 downto 0) => B"111111",
      CASCADEINA => '0',
      CASCADEINB => '0',
      CASCADEOUTA => \NLW_gen_wr_a.gen_word_narrow.mem_reg_2_CASCADEOUTA_UNCONNECTED\,
      CASCADEOUTB => \NLW_gen_wr_a.gen_word_narrow.mem_reg_2_CASCADEOUTB_UNCONNECTED\,
      CLKARDCLK => clka,
      CLKBWRCLK => clka,
      DBITERR => \NLW_gen_wr_a.gen_word_narrow.mem_reg_2_DBITERR_UNCONNECTED\,
      DIADI(31 downto 0) => dina(175 downto 144),
      DIBDI(31 downto 0) => dina(207 downto 176),
      DIPADIP(3 downto 0) => dina(211 downto 208),
      DIPBDIP(3 downto 0) => dina(215 downto 212),
      DOADO(31 downto 0) => \^doutb\(175 downto 144),
      DOBDO(31 downto 0) => \^doutb\(207 downto 176),
      DOPADOP(3 downto 0) => \^doutb\(211 downto 208),
      DOPBDOP(3 downto 0) => \^doutb\(215 downto 212),
      ECCPARITY(7 downto 0) => \NLW_gen_wr_a.gen_word_narrow.mem_reg_2_ECCPARITY_UNCONNECTED\(7 downto 0),
      ENARDEN => enb,
      ENBWREN => '1',
      INJECTDBITERR => '0',
      INJECTSBITERR => '0',
      RDADDRECC(8 downto 0) => \NLW_gen_wr_a.gen_word_narrow.mem_reg_2_RDADDRECC_UNCONNECTED\(8 downto 0),
      REGCEAREGCE => regceb,
      REGCEB => '0',
      RSTRAMARSTRAM => '0',
      RSTRAMB => '0',
      RSTREGARSTREG => rstb,
      RSTREGB => '0',
      SBITERR => \NLW_gen_wr_a.gen_word_narrow.mem_reg_2_SBITERR_UNCONNECTED\,
      WEA(3 downto 0) => B"0000",
      WEBWE(7) => wea(0),
      WEBWE(6) => wea(0),
      WEBWE(5) => wea(0),
      WEBWE(4) => wea(0),
      WEBWE(3) => wea(0),
      WEBWE(2) => wea(0),
      WEBWE(1) => wea(0),
      WEBWE(0) => wea(0)
    );
\gen_wr_a.gen_word_narrow.mem_reg_3\: unisim.vcomponents.RAMB36E1
    generic map(
      DOA_REG => 1,
      DOB_REG => 1,
      EN_ECC_READ => false,
      EN_ECC_WRITE => false,
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_40 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_41 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_42 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_43 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_44 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_45 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_46 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_47 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_48 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_49 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_50 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_51 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_52 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_53 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_54 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_55 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_56 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_57 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_58 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_59 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_60 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_61 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_62 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_63 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_64 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_65 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_66 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_67 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_68 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_69 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_70 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_71 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_72 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_73 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_74 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_75 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_76 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_77 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_78 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_79 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      RAM_MODE => "SDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      READ_WIDTH_A => 72,
      READ_WIDTH_B => 0,
      RSTREG_PRIORITY_A => "RSTREG",
      RSTREG_PRIORITY_B => "RSTREG",
      SIM_COLLISION_CHECK => "ALL",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      WRITE_WIDTH_A => 0,
      WRITE_WIDTH_B => 72
    )
        port map (
      ADDRARDADDR(15 downto 12) => B"1000",
      ADDRARDADDR(11 downto 6) => addrb(5 downto 0),
      ADDRARDADDR(5 downto 0) => B"111111",
      ADDRBWRADDR(15 downto 12) => B"1000",
      ADDRBWRADDR(11 downto 6) => addra(5 downto 0),
      ADDRBWRADDR(5 downto 0) => B"111111",
      CASCADEINA => '0',
      CASCADEINB => '0',
      CASCADEOUTA => \NLW_gen_wr_a.gen_word_narrow.mem_reg_3_CASCADEOUTA_UNCONNECTED\,
      CASCADEOUTB => \NLW_gen_wr_a.gen_word_narrow.mem_reg_3_CASCADEOUTB_UNCONNECTED\,
      CLKARDCLK => clka,
      CLKBWRCLK => clka,
      DBITERR => \NLW_gen_wr_a.gen_word_narrow.mem_reg_3_DBITERR_UNCONNECTED\,
      DIADI(31 downto 0) => dina(247 downto 216),
      DIBDI(31 downto 8) => dina(311 downto 288),
      DIBDI(7 downto 0) => dina(255 downto 248),
      DIPADIP(3 downto 0) => dina(315 downto 312),
      DIPBDIP(3 downto 0) => dina(319 downto 316),
      DOADO(31 downto 0) => \^doutb\(247 downto 216),
      DOBDO(31 downto 8) => \^doutb\(311 downto 288),
      DOBDO(7 downto 0) => \^doutb\(255 downto 248),
      DOPADOP(3 downto 0) => \^doutb\(315 downto 312),
      DOPBDOP(3 downto 0) => \^doutb\(319 downto 316),
      ECCPARITY(7 downto 0) => \NLW_gen_wr_a.gen_word_narrow.mem_reg_3_ECCPARITY_UNCONNECTED\(7 downto 0),
      ENARDEN => enb,
      ENBWREN => '1',
      INJECTDBITERR => '0',
      INJECTSBITERR => '0',
      RDADDRECC(8 downto 0) => \NLW_gen_wr_a.gen_word_narrow.mem_reg_3_RDADDRECC_UNCONNECTED\(8 downto 0),
      REGCEAREGCE => regceb,
      REGCEB => '0',
      RSTRAMARSTRAM => '0',
      RSTRAMB => '0',
      RSTREGARSTREG => rstb,
      RSTREGB => '0',
      SBITERR => \NLW_gen_wr_a.gen_word_narrow.mem_reg_3_SBITERR_UNCONNECTED\,
      WEA(3 downto 0) => B"0000",
      WEBWE(7) => wea(0),
      WEBWE(6) => wea(0),
      WEBWE(5) => wea(0),
      WEBWE(4) => wea(0),
      WEBWE(3) => wea(0),
      WEBWE(2) => wea(0),
      WEBWE(1) => wea(0),
      WEBWE(0) => wea(0)
    );
\gen_wr_a.gen_word_narrow.mem_reg_4\: unisim.vcomponents.RAMB36E1
    generic map(
      DOA_REG => 1,
      DOB_REG => 1,
      EN_ECC_READ => false,
      EN_ECC_WRITE => false,
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_40 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_41 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_42 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_43 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_44 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_45 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_46 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_47 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_48 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_49 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_50 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_51 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_52 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_53 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_54 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_55 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_56 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_57 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_58 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_59 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_60 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_61 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_62 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_63 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_64 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_65 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_66 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_67 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_68 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_69 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_70 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_71 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_72 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_73 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_74 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_75 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_76 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_77 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_78 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_79 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      RAM_MODE => "SDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      READ_WIDTH_A => 72,
      READ_WIDTH_B => 0,
      RSTREG_PRIORITY_A => "RSTREG",
      RSTREG_PRIORITY_B => "RSTREG",
      SIM_COLLISION_CHECK => "ALL",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      WRITE_WIDTH_A => 0,
      WRITE_WIDTH_B => 72
    )
        port map (
      ADDRARDADDR(15 downto 12) => B"1000",
      ADDRARDADDR(11 downto 6) => addrb(5 downto 0),
      ADDRARDADDR(5 downto 0) => B"111111",
      ADDRBWRADDR(15 downto 12) => B"1000",
      ADDRBWRADDR(11 downto 6) => addra(5 downto 0),
      ADDRBWRADDR(5 downto 0) => B"111111",
      CASCADEINA => '0',
      CASCADEINB => '0',
      CASCADEOUTA => \NLW_gen_wr_a.gen_word_narrow.mem_reg_4_CASCADEOUTA_UNCONNECTED\,
      CASCADEOUTB => \NLW_gen_wr_a.gen_word_narrow.mem_reg_4_CASCADEOUTB_UNCONNECTED\,
      CLKARDCLK => clka,
      CLKBWRCLK => clka,
      DBITERR => \NLW_gen_wr_a.gen_word_narrow.mem_reg_4_DBITERR_UNCONNECTED\,
      DIADI(31 downto 0) => dina(353 downto 322),
      DIBDI(31 downto 0) => dina(385 downto 354),
      DIPADIP(3 downto 0) => dina(389 downto 386),
      DIPBDIP(3 downto 0) => dina(393 downto 390),
      DOADO(31 downto 0) => \^doutb\(353 downto 322),
      DOBDO(31 downto 0) => \^doutb\(385 downto 354),
      DOPADOP(3 downto 0) => \^doutb\(389 downto 386),
      DOPBDOP(3 downto 0) => \^doutb\(393 downto 390),
      ECCPARITY(7 downto 0) => \NLW_gen_wr_a.gen_word_narrow.mem_reg_4_ECCPARITY_UNCONNECTED\(7 downto 0),
      ENARDEN => enb,
      ENBWREN => '1',
      INJECTDBITERR => '0',
      INJECTSBITERR => '0',
      RDADDRECC(8 downto 0) => \NLW_gen_wr_a.gen_word_narrow.mem_reg_4_RDADDRECC_UNCONNECTED\(8 downto 0),
      REGCEAREGCE => regceb,
      REGCEB => '0',
      RSTRAMARSTRAM => '0',
      RSTRAMB => '0',
      RSTREGARSTREG => rstb,
      RSTREGB => '0',
      SBITERR => \NLW_gen_wr_a.gen_word_narrow.mem_reg_4_SBITERR_UNCONNECTED\,
      WEA(3 downto 0) => B"0000",
      WEBWE(7) => wea(0),
      WEBWE(6) => wea(0),
      WEBWE(5) => wea(0),
      WEBWE(4) => wea(0),
      WEBWE(3) => wea(0),
      WEBWE(2) => wea(0),
      WEBWE(1) => wea(0),
      WEBWE(0) => wea(0)
    );
\gen_wr_a.gen_word_narrow.mem_reg_5\: unisim.vcomponents.RAMB36E1
    generic map(
      DOA_REG => 1,
      DOB_REG => 1,
      EN_ECC_READ => false,
      EN_ECC_WRITE => false,
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_40 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_41 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_42 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_43 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_44 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_45 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_46 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_47 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_48 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_49 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_50 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_51 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_52 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_53 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_54 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_55 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_56 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_57 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_58 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_59 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_60 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_61 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_62 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_63 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_64 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_65 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_66 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_67 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_68 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_69 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_70 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_71 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_72 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_73 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_74 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_75 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_76 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_77 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_78 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_79 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      RAM_MODE => "SDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      READ_WIDTH_A => 72,
      READ_WIDTH_B => 0,
      RSTREG_PRIORITY_A => "RSTREG",
      RSTREG_PRIORITY_B => "RSTREG",
      SIM_COLLISION_CHECK => "ALL",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      WRITE_WIDTH_A => 0,
      WRITE_WIDTH_B => 72
    )
        port map (
      ADDRARDADDR(15 downto 12) => B"1000",
      ADDRARDADDR(11 downto 6) => addrb(5 downto 0),
      ADDRARDADDR(5 downto 0) => B"111111",
      ADDRBWRADDR(15 downto 12) => B"1000",
      ADDRBWRADDR(11 downto 6) => addra(5 downto 0),
      ADDRBWRADDR(5 downto 0) => B"111111",
      CASCADEINA => '0',
      CASCADEINB => '0',
      CASCADEOUTA => \NLW_gen_wr_a.gen_word_narrow.mem_reg_5_CASCADEOUTA_UNCONNECTED\,
      CASCADEOUTB => \NLW_gen_wr_a.gen_word_narrow.mem_reg_5_CASCADEOUTB_UNCONNECTED\,
      CLKARDCLK => clka,
      CLKBWRCLK => clka,
      DBITERR => \NLW_gen_wr_a.gen_word_narrow.mem_reg_5_DBITERR_UNCONNECTED\,
      DIADI(31 downto 0) => dina(425 downto 394),
      DIBDI(31 downto 25) => B"1111111",
      DIBDI(24 downto 0) => dina(450 downto 426),
      DIPADIP(3 downto 0) => B"1111",
      DIPBDIP(3 downto 0) => B"1111",
      DOADO(31 downto 0) => \^doutb\(425 downto 394),
      DOBDO(31 downto 25) => \NLW_gen_wr_a.gen_word_narrow.mem_reg_5_DOBDO_UNCONNECTED\(31 downto 25),
      DOBDO(24 downto 0) => \^doutb\(450 downto 426),
      DOPADOP(3 downto 0) => \NLW_gen_wr_a.gen_word_narrow.mem_reg_5_DOPADOP_UNCONNECTED\(3 downto 0),
      DOPBDOP(3 downto 0) => \NLW_gen_wr_a.gen_word_narrow.mem_reg_5_DOPBDOP_UNCONNECTED\(3 downto 0),
      ECCPARITY(7 downto 0) => \NLW_gen_wr_a.gen_word_narrow.mem_reg_5_ECCPARITY_UNCONNECTED\(7 downto 0),
      ENARDEN => enb,
      ENBWREN => '1',
      INJECTDBITERR => '0',
      INJECTSBITERR => '0',
      RDADDRECC(8 downto 0) => \NLW_gen_wr_a.gen_word_narrow.mem_reg_5_RDADDRECC_UNCONNECTED\(8 downto 0),
      REGCEAREGCE => regceb,
      REGCEB => '0',
      RSTRAMARSTRAM => '0',
      RSTRAMB => '0',
      RSTREGARSTREG => rstb,
      RSTREGB => '0',
      SBITERR => \NLW_gen_wr_a.gen_word_narrow.mem_reg_5_SBITERR_UNCONNECTED\,
      WEA(3 downto 0) => B"0000",
      WEBWE(7) => wea(0),
      WEBWE(6) => wea(0),
      WEBWE(5) => wea(0),
      WEBWE(4) => wea(0),
      WEBWE(3) => wea(0),
      WEBWE(2) => wea(0),
      WEBWE(1) => wea(0),
      WEBWE(0) => wea(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity input_arbiter_fifo_xpm_fifo_base is
  port (
    sleep : in STD_LOGIC;
    rst : in STD_LOGIC;
    wr_clk : in STD_LOGIC;
    wr_en : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 450 downto 0 );
    full : out STD_LOGIC;
    full_n : out STD_LOGIC;
    prog_full : out STD_LOGIC;
    wr_data_count : out STD_LOGIC_VECTOR ( 6 downto 0 );
    overflow : out STD_LOGIC;
    wr_rst_busy : out STD_LOGIC;
    almost_full : out STD_LOGIC;
    wr_ack : out STD_LOGIC;
    rd_clk : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 450 downto 0 );
    empty : out STD_LOGIC;
    prog_empty : out STD_LOGIC;
    rd_data_count : out STD_LOGIC_VECTOR ( 6 downto 0 );
    underflow : out STD_LOGIC;
    rd_rst_busy : out STD_LOGIC;
    almost_empty : out STD_LOGIC;
    data_valid : out STD_LOGIC;
    injectsbiterr : in STD_LOGIC;
    injectdbiterr : in STD_LOGIC;
    sbiterr : out STD_LOGIC;
    dbiterr : out STD_LOGIC
  );
  attribute CASCADE_HEIGHT : integer;
  attribute CASCADE_HEIGHT of input_arbiter_fifo_xpm_fifo_base : entity is 0;
  attribute CDC_DEST_SYNC_FF : integer;
  attribute CDC_DEST_SYNC_FF of input_arbiter_fifo_xpm_fifo_base : entity is 3;
  attribute COMMON_CLOCK : integer;
  attribute COMMON_CLOCK of input_arbiter_fifo_xpm_fifo_base : entity is 1;
  attribute DOUT_RESET_VALUE : string;
  attribute DOUT_RESET_VALUE of input_arbiter_fifo_xpm_fifo_base : entity is "";
  attribute ECC_MODE : integer;
  attribute ECC_MODE of input_arbiter_fifo_xpm_fifo_base : entity is 0;
  attribute ENABLE_ECC : integer;
  attribute ENABLE_ECC of input_arbiter_fifo_xpm_fifo_base : entity is 0;
  attribute EN_ADV_FEATURE : string;
  attribute EN_ADV_FEATURE of input_arbiter_fifo_xpm_fifo_base : entity is "16'b0001100000001000";
  attribute EN_AE : string;
  attribute EN_AE of input_arbiter_fifo_xpm_fifo_base : entity is "1'b1";
  attribute EN_AF : string;
  attribute EN_AF of input_arbiter_fifo_xpm_fifo_base : entity is "1'b1";
  attribute EN_DVLD : string;
  attribute EN_DVLD of input_arbiter_fifo_xpm_fifo_base : entity is "1'b1";
  attribute EN_OF : string;
  attribute EN_OF of input_arbiter_fifo_xpm_fifo_base : entity is "1'b0";
  attribute EN_PE : string;
  attribute EN_PE of input_arbiter_fifo_xpm_fifo_base : entity is "1'b0";
  attribute EN_PF : string;
  attribute EN_PF of input_arbiter_fifo_xpm_fifo_base : entity is "1'b0";
  attribute EN_RDC : string;
  attribute EN_RDC of input_arbiter_fifo_xpm_fifo_base : entity is "1'b0";
  attribute EN_UF : string;
  attribute EN_UF of input_arbiter_fifo_xpm_fifo_base : entity is "1'b0";
  attribute EN_WACK : string;
  attribute EN_WACK of input_arbiter_fifo_xpm_fifo_base : entity is "1'b0";
  attribute EN_WDC : string;
  attribute EN_WDC of input_arbiter_fifo_xpm_fifo_base : entity is "1'b0";
  attribute FG_EQ_ASYM_DOUT : string;
  attribute FG_EQ_ASYM_DOUT of input_arbiter_fifo_xpm_fifo_base : entity is "1'b0";
  attribute FIFO_MEMORY_TYPE : integer;
  attribute FIFO_MEMORY_TYPE of input_arbiter_fifo_xpm_fifo_base : entity is 0;
  attribute FIFO_MEM_TYPE : integer;
  attribute FIFO_MEM_TYPE of input_arbiter_fifo_xpm_fifo_base : entity is 0;
  attribute FIFO_READ_DEPTH : integer;
  attribute FIFO_READ_DEPTH of input_arbiter_fifo_xpm_fifo_base : entity is 64;
  attribute FIFO_READ_LATENCY : integer;
  attribute FIFO_READ_LATENCY of input_arbiter_fifo_xpm_fifo_base : entity is 0;
  attribute FIFO_SIZE : integer;
  attribute FIFO_SIZE of input_arbiter_fifo_xpm_fifo_base : entity is 28864;
  attribute FIFO_WRITE_DEPTH : integer;
  attribute FIFO_WRITE_DEPTH of input_arbiter_fifo_xpm_fifo_base : entity is 64;
  attribute FULL_RESET_VALUE : integer;
  attribute FULL_RESET_VALUE of input_arbiter_fifo_xpm_fifo_base : entity is 1;
  attribute FULL_RST_VAL : string;
  attribute FULL_RST_VAL of input_arbiter_fifo_xpm_fifo_base : entity is "1'b1";
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of input_arbiter_fifo_xpm_fifo_base : entity is "xpm_fifo_base";
  attribute PE_THRESH_ADJ : integer;
  attribute PE_THRESH_ADJ of input_arbiter_fifo_xpm_fifo_base : entity is 3;
  attribute PE_THRESH_MAX : integer;
  attribute PE_THRESH_MAX of input_arbiter_fifo_xpm_fifo_base : entity is 59;
  attribute PE_THRESH_MIN : integer;
  attribute PE_THRESH_MIN of input_arbiter_fifo_xpm_fifo_base : entity is 5;
  attribute PF_THRESH_ADJ : integer;
  attribute PF_THRESH_ADJ of input_arbiter_fifo_xpm_fifo_base : entity is 9;
  attribute PF_THRESH_MAX : integer;
  attribute PF_THRESH_MAX of input_arbiter_fifo_xpm_fifo_base : entity is 59;
  attribute PF_THRESH_MIN : integer;
  attribute PF_THRESH_MIN of input_arbiter_fifo_xpm_fifo_base : entity is 5;
  attribute PROG_EMPTY_THRESH : integer;
  attribute PROG_EMPTY_THRESH of input_arbiter_fifo_xpm_fifo_base : entity is 5;
  attribute PROG_FULL_THRESH : integer;
  attribute PROG_FULL_THRESH of input_arbiter_fifo_xpm_fifo_base : entity is 11;
  attribute RD_DATA_COUNT_WIDTH : integer;
  attribute RD_DATA_COUNT_WIDTH of input_arbiter_fifo_xpm_fifo_base : entity is 7;
  attribute RD_DC_WIDTH_EXT : integer;
  attribute RD_DC_WIDTH_EXT of input_arbiter_fifo_xpm_fifo_base : entity is 7;
  attribute RD_LATENCY : integer;
  attribute RD_LATENCY of input_arbiter_fifo_xpm_fifo_base : entity is 2;
  attribute RD_MODE : integer;
  attribute RD_MODE of input_arbiter_fifo_xpm_fifo_base : entity is 1;
  attribute RD_PNTR_WIDTH : integer;
  attribute RD_PNTR_WIDTH of input_arbiter_fifo_xpm_fifo_base : entity is 6;
  attribute READ_DATA_WIDTH : integer;
  attribute READ_DATA_WIDTH of input_arbiter_fifo_xpm_fifo_base : entity is 451;
  attribute READ_MODE : integer;
  attribute READ_MODE of input_arbiter_fifo_xpm_fifo_base : entity is 1;
  attribute RELATED_CLOCKS : integer;
  attribute RELATED_CLOCKS of input_arbiter_fifo_xpm_fifo_base : entity is 0;
  attribute REMOVE_WR_RD_PROT_LOGIC : integer;
  attribute REMOVE_WR_RD_PROT_LOGIC of input_arbiter_fifo_xpm_fifo_base : entity is 0;
  attribute SIM_ASSERT_CHK : integer;
  attribute SIM_ASSERT_CHK of input_arbiter_fifo_xpm_fifo_base : entity is 0;
  attribute USE_ADV_FEATURES : integer;
  attribute USE_ADV_FEATURES of input_arbiter_fifo_xpm_fifo_base : entity is 825765944;
  attribute VERSION : integer;
  attribute VERSION of input_arbiter_fifo_xpm_fifo_base : entity is 0;
  attribute WAKEUP_TIME : integer;
  attribute WAKEUP_TIME of input_arbiter_fifo_xpm_fifo_base : entity is 0;
  attribute WIDTH_RATIO : integer;
  attribute WIDTH_RATIO of input_arbiter_fifo_xpm_fifo_base : entity is 1;
  attribute WRITE_DATA_WIDTH : integer;
  attribute WRITE_DATA_WIDTH of input_arbiter_fifo_xpm_fifo_base : entity is 451;
  attribute WR_DATA_COUNT_WIDTH : integer;
  attribute WR_DATA_COUNT_WIDTH of input_arbiter_fifo_xpm_fifo_base : entity is 7;
  attribute WR_DC_WIDTH_EXT : integer;
  attribute WR_DC_WIDTH_EXT of input_arbiter_fifo_xpm_fifo_base : entity is 7;
  attribute WR_DEPTH_LOG : integer;
  attribute WR_DEPTH_LOG of input_arbiter_fifo_xpm_fifo_base : entity is 6;
  attribute WR_PNTR_WIDTH : integer;
  attribute WR_PNTR_WIDTH of input_arbiter_fifo_xpm_fifo_base : entity is 6;
  attribute WR_RD_RATIO : integer;
  attribute WR_RD_RATIO of input_arbiter_fifo_xpm_fifo_base : entity is 0;
  attribute WR_WIDTH_LOG : integer;
  attribute WR_WIDTH_LOG of input_arbiter_fifo_xpm_fifo_base : entity is 9;
  attribute XPM_MODULE : string;
  attribute XPM_MODULE of input_arbiter_fifo_xpm_fifo_base : entity is "TRUE";
  attribute both_stages_valid : integer;
  attribute both_stages_valid of input_arbiter_fifo_xpm_fifo_base : entity is 3;
  attribute invalid : integer;
  attribute invalid of input_arbiter_fifo_xpm_fifo_base : entity is 0;
  attribute keep_hierarchy : string;
  attribute keep_hierarchy of input_arbiter_fifo_xpm_fifo_base : entity is "soft";
  attribute stage1_valid : integer;
  attribute stage1_valid of input_arbiter_fifo_xpm_fifo_base : entity is 2;
  attribute stage2_valid : integer;
  attribute stage2_valid of input_arbiter_fifo_xpm_fifo_base : entity is 1;
end input_arbiter_fifo_xpm_fifo_base;

architecture STRUCTURE of input_arbiter_fifo_xpm_fifo_base is
  signal \<const0>\ : STD_LOGIC;
  signal aempty_fwft_i0 : STD_LOGIC;
  signal \^almost_empty\ : STD_LOGIC;
  signal \^almost_full\ : STD_LOGIC;
  signal clr_full : STD_LOGIC;
  signal \count_value_i__0\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal curr_fwft_state : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal data_valid_fwft1 : STD_LOGIC;
  signal \^dout\ : STD_LOGIC_VECTOR ( 450 downto 0 );
  signal \gen_fwft.empty_fwft_i_reg_n_0\ : STD_LOGIC;
  signal \gen_fwft.gdvld_fwft.data_valid_fwft_i_1_n_0\ : STD_LOGIC;
  signal \gen_fwft.ram_regout_en\ : STD_LOGIC;
  signal \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_n_0\ : STD_LOGIC;
  signal going_afull : STD_LOGIC;
  signal going_full1 : STD_LOGIC;
  signal leaving_empty0 : STD_LOGIC;
  signal \next_fwft_state__0\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ram_empty_i : STD_LOGIC;
  signal ram_empty_i0 : STD_LOGIC;
  signal ram_wr_en_i : STD_LOGIC;
  signal rd_pntr_ext : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal rdp_inst_n_1 : STD_LOGIC;
  signal rdp_inst_n_10 : STD_LOGIC;
  signal rdp_inst_n_11 : STD_LOGIC;
  signal rdpp1_inst_n_0 : STD_LOGIC;
  signal rdpp1_inst_n_1 : STD_LOGIC;
  signal rdpp1_inst_n_2 : STD_LOGIC;
  signal rdpp1_inst_n_3 : STD_LOGIC;
  signal rdpp1_inst_n_4 : STD_LOGIC;
  signal rdpp1_inst_n_5 : STD_LOGIC;
  signal rst_d1 : STD_LOGIC;
  signal wr_pntr_ext : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal wrpp2_inst_n_0 : STD_LOGIC;
  signal wrpp2_inst_n_1 : STD_LOGIC;
  signal wrpp2_inst_n_2 : STD_LOGIC;
  signal wrpp2_inst_n_3 : STD_LOGIC;
  signal wrpp2_inst_n_4 : STD_LOGIC;
  signal wrpp2_inst_n_5 : STD_LOGIC;
  signal xpm_fifo_rst_inst_n_0 : STD_LOGIC;
  signal xpm_fifo_rst_inst_n_2 : STD_LOGIC;
  signal \NLW_gen_sdpram.xpm_memory_base_inst_dbiterra_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_sdpram.xpm_memory_base_inst_dbiterrb_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_sdpram.xpm_memory_base_inst_sbiterra_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_sdpram.xpm_memory_base_inst_sbiterrb_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_sdpram.xpm_memory_base_inst_douta_UNCONNECTED\ : STD_LOGIC_VECTOR ( 450 downto 0 );
  signal \NLW_gen_sdpram.xpm_memory_base_inst_doutb_UNCONNECTED\ : STD_LOGIC_VECTOR ( 321 downto 256 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_gen_fwft.curr_fwft_state[0]_i_1\ : label is "soft_lutpair9";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_gen_fwft.curr_fwft_state_reg[0]\ : label is "invalid:00,stage1_valid:01,both_stages_valid:10,stage2_valid:11";
  attribute FSM_ENCODED_STATES of \FSM_sequential_gen_fwft.curr_fwft_state_reg[1]\ : label is "invalid:00,stage1_valid:01,both_stages_valid:10,stage2_valid:11";
  attribute SOFT_HLUTNM of \gen_fwft.gdvld_fwft.data_valid_fwft_i_1\ : label is "soft_lutpair9";
  attribute ADDR_WIDTH_A : integer;
  attribute ADDR_WIDTH_A of \gen_sdpram.xpm_memory_base_inst\ : label is 6;
  attribute ADDR_WIDTH_B : integer;
  attribute ADDR_WIDTH_B of \gen_sdpram.xpm_memory_base_inst\ : label is 6;
  attribute AUTO_SLEEP_TIME : integer;
  attribute AUTO_SLEEP_TIME of \gen_sdpram.xpm_memory_base_inst\ : label is 0;
  attribute BYTE_WRITE_WIDTH_A : integer;
  attribute BYTE_WRITE_WIDTH_A of \gen_sdpram.xpm_memory_base_inst\ : label is 451;
  attribute BYTE_WRITE_WIDTH_B : integer;
  attribute BYTE_WRITE_WIDTH_B of \gen_sdpram.xpm_memory_base_inst\ : label is 451;
  attribute CASCADE_HEIGHT of \gen_sdpram.xpm_memory_base_inst\ : label is 0;
  attribute CLOCKING_MODE : integer;
  attribute CLOCKING_MODE of \gen_sdpram.xpm_memory_base_inst\ : label is 0;
  attribute ECC_MODE of \gen_sdpram.xpm_memory_base_inst\ : label is 0;
  attribute KEEP_HIERARCHY of \gen_sdpram.xpm_memory_base_inst\ : label is "soft";
  attribute MAX_NUM_CHAR : integer;
  attribute MAX_NUM_CHAR of \gen_sdpram.xpm_memory_base_inst\ : label is 0;
  attribute \MEM.ADDRESS_SPACE\ : boolean;
  attribute \MEM.ADDRESS_SPACE\ of \gen_sdpram.xpm_memory_base_inst\ : label is std.standard.true;
  attribute \MEM.ADDRESS_SPACE_BEGIN\ : integer;
  attribute \MEM.ADDRESS_SPACE_BEGIN\ of \gen_sdpram.xpm_memory_base_inst\ : label is 0;
  attribute \MEM.ADDRESS_SPACE_DATA_LSB\ : integer;
  attribute \MEM.ADDRESS_SPACE_DATA_LSB\ of \gen_sdpram.xpm_memory_base_inst\ : label is 0;
  attribute \MEM.ADDRESS_SPACE_DATA_MSB\ : integer;
  attribute \MEM.ADDRESS_SPACE_DATA_MSB\ of \gen_sdpram.xpm_memory_base_inst\ : label is 416;
  attribute \MEM.ADDRESS_SPACE_END\ : integer;
  attribute \MEM.ADDRESS_SPACE_END\ of \gen_sdpram.xpm_memory_base_inst\ : label is 511;
  attribute \MEM.CORE_MEMORY_WIDTH\ : integer;
  attribute \MEM.CORE_MEMORY_WIDTH\ of \gen_sdpram.xpm_memory_base_inst\ : label is 417;
  attribute MEMORY_INIT_FILE : string;
  attribute MEMORY_INIT_FILE of \gen_sdpram.xpm_memory_base_inst\ : label is "none";
  attribute MEMORY_INIT_PARAM : string;
  attribute MEMORY_INIT_PARAM of \gen_sdpram.xpm_memory_base_inst\ : label is "";
  attribute MEMORY_OPTIMIZATION : string;
  attribute MEMORY_OPTIMIZATION of \gen_sdpram.xpm_memory_base_inst\ : label is "true";
  attribute MEMORY_PRIMITIVE : integer;
  attribute MEMORY_PRIMITIVE of \gen_sdpram.xpm_memory_base_inst\ : label is 0;
  attribute MEMORY_SIZE : integer;
  attribute MEMORY_SIZE of \gen_sdpram.xpm_memory_base_inst\ : label is 28864;
  attribute MEMORY_TYPE : integer;
  attribute MEMORY_TYPE of \gen_sdpram.xpm_memory_base_inst\ : label is 1;
  attribute MESSAGE_CONTROL : integer;
  attribute MESSAGE_CONTROL of \gen_sdpram.xpm_memory_base_inst\ : label is 0;
  attribute NUM_CHAR_LOC : integer;
  attribute NUM_CHAR_LOC of \gen_sdpram.xpm_memory_base_inst\ : label is 0;
  attribute P_ECC_MODE : string;
  attribute P_ECC_MODE of \gen_sdpram.xpm_memory_base_inst\ : label is "no_ecc";
  attribute P_ENABLE_BYTE_WRITE_A : integer;
  attribute P_ENABLE_BYTE_WRITE_A of \gen_sdpram.xpm_memory_base_inst\ : label is 0;
  attribute P_ENABLE_BYTE_WRITE_B : integer;
  attribute P_ENABLE_BYTE_WRITE_B of \gen_sdpram.xpm_memory_base_inst\ : label is 0;
  attribute P_MAX_DEPTH_DATA : integer;
  attribute P_MAX_DEPTH_DATA of \gen_sdpram.xpm_memory_base_inst\ : label is 64;
  attribute P_MEMORY_OPT : string;
  attribute P_MEMORY_OPT of \gen_sdpram.xpm_memory_base_inst\ : label is "yes";
  attribute P_MEMORY_PRIMITIVE : string;
  attribute P_MEMORY_PRIMITIVE of \gen_sdpram.xpm_memory_base_inst\ : label is "auto";
  attribute P_MIN_WIDTH_DATA : integer;
  attribute P_MIN_WIDTH_DATA of \gen_sdpram.xpm_memory_base_inst\ : label is 451;
  attribute P_MIN_WIDTH_DATA_A : integer;
  attribute P_MIN_WIDTH_DATA_A of \gen_sdpram.xpm_memory_base_inst\ : label is 451;
  attribute P_MIN_WIDTH_DATA_B : integer;
  attribute P_MIN_WIDTH_DATA_B of \gen_sdpram.xpm_memory_base_inst\ : label is 451;
  attribute P_MIN_WIDTH_DATA_ECC : integer;
  attribute P_MIN_WIDTH_DATA_ECC of \gen_sdpram.xpm_memory_base_inst\ : label is 451;
  attribute P_MIN_WIDTH_DATA_LDW : integer;
  attribute P_MIN_WIDTH_DATA_LDW of \gen_sdpram.xpm_memory_base_inst\ : label is 4;
  attribute P_MIN_WIDTH_DATA_SHFT : integer;
  attribute P_MIN_WIDTH_DATA_SHFT of \gen_sdpram.xpm_memory_base_inst\ : label is 451;
  attribute P_NUM_COLS_WRITE_A : integer;
  attribute P_NUM_COLS_WRITE_A of \gen_sdpram.xpm_memory_base_inst\ : label is 1;
  attribute P_NUM_COLS_WRITE_B : integer;
  attribute P_NUM_COLS_WRITE_B of \gen_sdpram.xpm_memory_base_inst\ : label is 1;
  attribute P_NUM_ROWS_READ_A : integer;
  attribute P_NUM_ROWS_READ_A of \gen_sdpram.xpm_memory_base_inst\ : label is 1;
  attribute P_NUM_ROWS_READ_B : integer;
  attribute P_NUM_ROWS_READ_B of \gen_sdpram.xpm_memory_base_inst\ : label is 1;
  attribute P_NUM_ROWS_WRITE_A : integer;
  attribute P_NUM_ROWS_WRITE_A of \gen_sdpram.xpm_memory_base_inst\ : label is 1;
  attribute P_NUM_ROWS_WRITE_B : integer;
  attribute P_NUM_ROWS_WRITE_B of \gen_sdpram.xpm_memory_base_inst\ : label is 1;
  attribute P_SDP_WRITE_MODE : string;
  attribute P_SDP_WRITE_MODE of \gen_sdpram.xpm_memory_base_inst\ : label is "yes";
  attribute P_WIDTH_ADDR_LSB_READ_A : integer;
  attribute P_WIDTH_ADDR_LSB_READ_A of \gen_sdpram.xpm_memory_base_inst\ : label is 0;
  attribute P_WIDTH_ADDR_LSB_READ_B : integer;
  attribute P_WIDTH_ADDR_LSB_READ_B of \gen_sdpram.xpm_memory_base_inst\ : label is 0;
  attribute P_WIDTH_ADDR_LSB_WRITE_A : integer;
  attribute P_WIDTH_ADDR_LSB_WRITE_A of \gen_sdpram.xpm_memory_base_inst\ : label is 0;
  attribute P_WIDTH_ADDR_LSB_WRITE_B : integer;
  attribute P_WIDTH_ADDR_LSB_WRITE_B of \gen_sdpram.xpm_memory_base_inst\ : label is 0;
  attribute P_WIDTH_ADDR_READ_A : integer;
  attribute P_WIDTH_ADDR_READ_A of \gen_sdpram.xpm_memory_base_inst\ : label is 6;
  attribute P_WIDTH_ADDR_READ_B : integer;
  attribute P_WIDTH_ADDR_READ_B of \gen_sdpram.xpm_memory_base_inst\ : label is 6;
  attribute P_WIDTH_ADDR_WRITE_A : integer;
  attribute P_WIDTH_ADDR_WRITE_A of \gen_sdpram.xpm_memory_base_inst\ : label is 6;
  attribute P_WIDTH_ADDR_WRITE_B : integer;
  attribute P_WIDTH_ADDR_WRITE_B of \gen_sdpram.xpm_memory_base_inst\ : label is 6;
  attribute P_WIDTH_COL_WRITE_A : integer;
  attribute P_WIDTH_COL_WRITE_A of \gen_sdpram.xpm_memory_base_inst\ : label is 451;
  attribute P_WIDTH_COL_WRITE_B : integer;
  attribute P_WIDTH_COL_WRITE_B of \gen_sdpram.xpm_memory_base_inst\ : label is 451;
  attribute READ_DATA_WIDTH_A : integer;
  attribute READ_DATA_WIDTH_A of \gen_sdpram.xpm_memory_base_inst\ : label is 451;
  attribute READ_DATA_WIDTH_B : integer;
  attribute READ_DATA_WIDTH_B of \gen_sdpram.xpm_memory_base_inst\ : label is 451;
  attribute READ_LATENCY_A : integer;
  attribute READ_LATENCY_A of \gen_sdpram.xpm_memory_base_inst\ : label is 2;
  attribute READ_LATENCY_B : integer;
  attribute READ_LATENCY_B of \gen_sdpram.xpm_memory_base_inst\ : label is 2;
  attribute READ_RESET_VALUE_A : string;
  attribute READ_RESET_VALUE_A of \gen_sdpram.xpm_memory_base_inst\ : label is "0";
  attribute READ_RESET_VALUE_B : string;
  attribute READ_RESET_VALUE_B of \gen_sdpram.xpm_memory_base_inst\ : label is "";
  attribute RST_MODE_A : string;
  attribute RST_MODE_A of \gen_sdpram.xpm_memory_base_inst\ : label is "SYNC";
  attribute RST_MODE_B : string;
  attribute RST_MODE_B of \gen_sdpram.xpm_memory_base_inst\ : label is "SYNC";
  attribute SIM_ASSERT_CHK of \gen_sdpram.xpm_memory_base_inst\ : label is 0;
  attribute USE_EMBEDDED_CONSTRAINT : integer;
  attribute USE_EMBEDDED_CONSTRAINT of \gen_sdpram.xpm_memory_base_inst\ : label is 0;
  attribute USE_MEM_INIT : integer;
  attribute USE_MEM_INIT of \gen_sdpram.xpm_memory_base_inst\ : label is 0;
  attribute USE_MEM_INIT_MMI : integer;
  attribute USE_MEM_INIT_MMI of \gen_sdpram.xpm_memory_base_inst\ : label is 0;
  attribute VERSION of \gen_sdpram.xpm_memory_base_inst\ : label is 0;
  attribute WAKEUP_TIME of \gen_sdpram.xpm_memory_base_inst\ : label is 0;
  attribute WRITE_DATA_WIDTH_A : integer;
  attribute WRITE_DATA_WIDTH_A of \gen_sdpram.xpm_memory_base_inst\ : label is 451;
  attribute WRITE_DATA_WIDTH_B : integer;
  attribute WRITE_DATA_WIDTH_B of \gen_sdpram.xpm_memory_base_inst\ : label is 451;
  attribute WRITE_MODE_A : integer;
  attribute WRITE_MODE_A of \gen_sdpram.xpm_memory_base_inst\ : label is 2;
  attribute WRITE_MODE_B : integer;
  attribute WRITE_MODE_B of \gen_sdpram.xpm_memory_base_inst\ : label is 2;
  attribute WRITE_PROTECT : integer;
  attribute WRITE_PROTECT of \gen_sdpram.xpm_memory_base_inst\ : label is 1;
  attribute XPM_MODULE of \gen_sdpram.xpm_memory_base_inst\ : label is "TRUE";
  attribute rsta_loop_iter : integer;
  attribute rsta_loop_iter of \gen_sdpram.xpm_memory_base_inst\ : label is 452;
  attribute rstb_loop_iter : integer;
  attribute rstb_loop_iter of \gen_sdpram.xpm_memory_base_inst\ : label is 452;
begin
  almost_empty <= \^almost_empty\;
  almost_full <= \^almost_full\;
  dbiterr <= \<const0>\;
  dout(450 downto 322) <= \^dout\(450 downto 322);
  dout(321) <= \<const0>\;
  dout(320) <= \<const0>\;
  dout(319 downto 288) <= \^dout\(319 downto 288);
  dout(287) <= \<const0>\;
  dout(286) <= \<const0>\;
  dout(285) <= \<const0>\;
  dout(284) <= \<const0>\;
  dout(283) <= \<const0>\;
  dout(282) <= \<const0>\;
  dout(281) <= \<const0>\;
  dout(280) <= \<const0>\;
  dout(279) <= \<const0>\;
  dout(278) <= \<const0>\;
  dout(277) <= \<const0>\;
  dout(276) <= \<const0>\;
  dout(275) <= \<const0>\;
  dout(274) <= \<const0>\;
  dout(273) <= \<const0>\;
  dout(272) <= \<const0>\;
  dout(271) <= \<const0>\;
  dout(270) <= \<const0>\;
  dout(269) <= \<const0>\;
  dout(268) <= \<const0>\;
  dout(267) <= \<const0>\;
  dout(266) <= \<const0>\;
  dout(265) <= \<const0>\;
  dout(264) <= \<const0>\;
  dout(263) <= \<const0>\;
  dout(262) <= \<const0>\;
  dout(261) <= \<const0>\;
  dout(260) <= \<const0>\;
  dout(259) <= \<const0>\;
  dout(258) <= \<const0>\;
  dout(257) <= \<const0>\;
  dout(256) <= \<const0>\;
  dout(255 downto 0) <= \^dout\(255 downto 0);
  empty <= \<const0>\;
  full <= \<const0>\;
  overflow <= \<const0>\;
  prog_empty <= \<const0>\;
  prog_full <= \<const0>\;
  rd_data_count(6) <= \<const0>\;
  rd_data_count(5) <= \<const0>\;
  rd_data_count(4) <= \<const0>\;
  rd_data_count(3) <= \<const0>\;
  rd_data_count(2) <= \<const0>\;
  rd_data_count(1) <= \<const0>\;
  rd_data_count(0) <= \<const0>\;
  rd_rst_busy <= \<const0>\;
  sbiterr <= \<const0>\;
  underflow <= \<const0>\;
  wr_ack <= \<const0>\;
  wr_data_count(6) <= \<const0>\;
  wr_data_count(5) <= \<const0>\;
  wr_data_count(4) <= \<const0>\;
  wr_data_count(3) <= \<const0>\;
  wr_data_count(2) <= \<const0>\;
  wr_data_count(1) <= \<const0>\;
  wr_data_count(0) <= \<const0>\;
  wr_rst_busy <= \<const0>\;
\FSM_sequential_gen_fwft.curr_fwft_state[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6A85"
    )
        port map (
      I0 => curr_fwft_state(0),
      I1 => rd_en,
      I2 => curr_fwft_state(1),
      I3 => ram_empty_i,
      O => \next_fwft_state__0\(0)
    );
\FSM_sequential_gen_fwft.curr_fwft_state[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7C"
    )
        port map (
      I0 => rd_en,
      I1 => curr_fwft_state(1),
      I2 => curr_fwft_state(0),
      O => \next_fwft_state__0\(1)
    );
\FSM_sequential_gen_fwft.curr_fwft_state_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => '1',
      D => \next_fwft_state__0\(0),
      Q => curr_fwft_state(0),
      R => xpm_fifo_rst_inst_n_2
    );
\FSM_sequential_gen_fwft.curr_fwft_state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => '1',
      D => \next_fwft_state__0\(1),
      Q => curr_fwft_state(1),
      R => xpm_fifo_rst_inst_n_2
    );
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
\gen_fwft.empty_fwft_i_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F380"
    )
        port map (
      I0 => rd_en,
      I1 => curr_fwft_state(0),
      I2 => curr_fwft_state(1),
      I3 => \gen_fwft.empty_fwft_i_reg_n_0\,
      O => data_valid_fwft1
    );
\gen_fwft.empty_fwft_i_reg\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => wr_clk,
      CE => '1',
      D => data_valid_fwft1,
      Q => \gen_fwft.empty_fwft_i_reg_n_0\,
      S => xpm_fifo_rst_inst_n_2
    );
\gen_fwft.gae_fwft.aempty_fwft_i_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FDDD4000"
    )
        port map (
      I0 => curr_fwft_state(0),
      I1 => ram_empty_i,
      I2 => curr_fwft_state(1),
      I3 => rd_en,
      I4 => \^almost_empty\,
      O => aempty_fwft_i0
    );
\gen_fwft.gae_fwft.aempty_fwft_i_reg\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => wr_clk,
      CE => '1',
      D => aempty_fwft_i0,
      Q => \^almost_empty\,
      S => xpm_fifo_rst_inst_n_2
    );
\gen_fwft.gdvld_fwft.data_valid_fwft_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3575"
    )
        port map (
      I0 => \gen_fwft.empty_fwft_i_reg_n_0\,
      I1 => curr_fwft_state(1),
      I2 => curr_fwft_state(0),
      I3 => rd_en,
      O => \gen_fwft.gdvld_fwft.data_valid_fwft_i_1_n_0\
    );
\gen_fwft.gdvld_fwft.data_valid_fwft_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => '1',
      D => \gen_fwft.gdvld_fwft.data_valid_fwft_i_1_n_0\,
      Q => data_valid,
      R => xpm_fifo_rst_inst_n_2
    );
\gen_pntr_flags_cc.gaf_cc.ram_afull_i_reg\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => wr_clk,
      CE => '1',
      D => xpm_fifo_rst_inst_n_0,
      Q => \^almost_full\,
      S => xpm_fifo_rst_inst_n_2
    );
\gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => wr_clk,
      CE => '1',
      D => rdp_inst_n_10,
      Q => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_n_0\,
      S => xpm_fifo_rst_inst_n_2
    );
\gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => wr_clk,
      CE => '1',
      D => rdp_inst_n_11,
      Q => full_n,
      R => xpm_fifo_rst_inst_n_2
    );
\gen_pntr_flags_cc.ram_empty_i_reg\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => wr_clk,
      CE => '1',
      D => ram_empty_i0,
      Q => ram_empty_i,
      S => xpm_fifo_rst_inst_n_2
    );
\gen_sdpram.xpm_memory_base_inst\: entity work.input_arbiter_fifo_xpm_memory_base
     port map (
      addra(5 downto 0) => wr_pntr_ext(5 downto 0),
      addrb(5 downto 0) => rd_pntr_ext(5 downto 0),
      clka => wr_clk,
      clkb => '0',
      dbiterra => \NLW_gen_sdpram.xpm_memory_base_inst_dbiterra_UNCONNECTED\,
      dbiterrb => \NLW_gen_sdpram.xpm_memory_base_inst_dbiterrb_UNCONNECTED\,
      dina(450 downto 322) => din(450 downto 322),
      dina(321 downto 320) => B"00",
      dina(319 downto 288) => din(319 downto 288),
      dina(287 downto 256) => B"00000000000000000000000000000000",
      dina(255 downto 0) => din(255 downto 0),
      dinb(450 downto 0) => B"0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      douta(450 downto 0) => \NLW_gen_sdpram.xpm_memory_base_inst_douta_UNCONNECTED\(450 downto 0),
      doutb(450 downto 322) => \^dout\(450 downto 322),
      doutb(321 downto 320) => \NLW_gen_sdpram.xpm_memory_base_inst_doutb_UNCONNECTED\(321 downto 320),
      doutb(319 downto 288) => \^dout\(319 downto 288),
      doutb(287 downto 256) => \NLW_gen_sdpram.xpm_memory_base_inst_doutb_UNCONNECTED\(287 downto 256),
      doutb(255 downto 0) => \^dout\(255 downto 0),
      ena => '0',
      enb => rdp_inst_n_1,
      injectdbiterra => '0',
      injectdbiterrb => '0',
      injectsbiterra => '0',
      injectsbiterrb => '0',
      regcea => '0',
      regceb => \gen_fwft.ram_regout_en\,
      rsta => '0',
      rstb => xpm_fifo_rst_inst_n_2,
      sbiterra => \NLW_gen_sdpram.xpm_memory_base_inst_sbiterra_UNCONNECTED\,
      sbiterrb => \NLW_gen_sdpram.xpm_memory_base_inst_sbiterrb_UNCONNECTED\,
      sleep => sleep,
      wea(0) => ram_wr_en_i,
      web(0) => '0'
    );
\gen_sdpram.xpm_memory_base_inst_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"62"
    )
        port map (
      I0 => curr_fwft_state(0),
      I1 => curr_fwft_state(1),
      I2 => rd_en,
      O => \gen_fwft.ram_regout_en\
    );
rdp_inst: entity work.\input_arbiter_fifo_xpm_counter_updn__parameterized2\
     port map (
      \FSM_sequential_gen_fwft.curr_fwft_state_reg[1]\ => rdp_inst_n_1,
      Q(5 downto 0) => rd_pntr_ext(5 downto 0),
      clr_full => clr_full,
      \count_value_i_reg[0]_0\(1 downto 0) => curr_fwft_state(1 downto 0),
      \count_value_i_reg[5]_0\(0) => xpm_fifo_rst_inst_n_2,
      \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0\(5) => wrpp2_inst_n_0,
      \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0\(4) => wrpp2_inst_n_1,
      \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0\(3) => wrpp2_inst_n_2,
      \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0\(2) => wrpp2_inst_n_3,
      \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0\(1) => wrpp2_inst_n_4,
      \gen_pntr_flags_cc.gaf_cc.ram_afull_i_i_3_0\(0) => wrpp2_inst_n_5,
      \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg\ => rdp_inst_n_10,
      \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_0\ => rdp_inst_n_11,
      \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_1\ => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_n_0\,
      \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_3_0\(5 downto 0) => wr_pntr_ext(5 downto 0),
      \gen_pntr_flags_cc.gen_full_rst_val.ram_full_n_i_4_0\(5 downto 0) => \count_value_i__0\(5 downto 0),
      going_afull => going_afull,
      going_full1 => going_full1,
      leaving_empty0 => leaving_empty0,
      ram_empty_i => ram_empty_i,
      ram_wr_en_i => ram_wr_en_i,
      rd_en => rd_en,
      wr_clk => wr_clk
    );
rdpp1_inst: entity work.\input_arbiter_fifo_xpm_counter_updn__parameterized3\
     port map (
      E(0) => rdp_inst_n_1,
      Q(5) => rdpp1_inst_n_0,
      Q(4) => rdpp1_inst_n_1,
      Q(3) => rdpp1_inst_n_2,
      Q(2) => rdpp1_inst_n_3,
      Q(1) => rdpp1_inst_n_4,
      Q(0) => rdpp1_inst_n_5,
      \count_value_i_reg[1]_0\(1 downto 0) => curr_fwft_state(1 downto 0),
      \count_value_i_reg[1]_1\(0) => xpm_fifo_rst_inst_n_2,
      ram_empty_i => ram_empty_i,
      rd_en => rd_en,
      wr_clk => wr_clk
    );
rst_d1_inst: entity work.input_arbiter_fifo_xpm_fifo_reg_bit
     port map (
      Q(0) => xpm_fifo_rst_inst_n_2,
      clr_full => clr_full,
      rst => rst,
      rst_d1 => rst_d1,
      wr_clk => wr_clk
    );
wrp_inst: entity work.\input_arbiter_fifo_xpm_counter_updn__parameterized2_0\
     port map (
      Q(5 downto 0) => wr_pntr_ext(5 downto 0),
      \count_value_i_reg[0]_0\(0) => xpm_fifo_rst_inst_n_2,
      \count_value_i_reg[5]_0\ => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_n_0\,
      \gen_pntr_flags_cc.ram_empty_i_reg\ => rdp_inst_n_1,
      \gen_pntr_flags_cc.ram_empty_i_reg_0\(5) => rdpp1_inst_n_0,
      \gen_pntr_flags_cc.ram_empty_i_reg_0\(4) => rdpp1_inst_n_1,
      \gen_pntr_flags_cc.ram_empty_i_reg_0\(3) => rdpp1_inst_n_2,
      \gen_pntr_flags_cc.ram_empty_i_reg_0\(2) => rdpp1_inst_n_3,
      \gen_pntr_flags_cc.ram_empty_i_reg_0\(1) => rdpp1_inst_n_4,
      \gen_pntr_flags_cc.ram_empty_i_reg_0\(0) => rdpp1_inst_n_5,
      leaving_empty0 => leaving_empty0,
      ram_empty_i => ram_empty_i,
      ram_empty_i0 => ram_empty_i0,
      ram_wr_en_i => ram_wr_en_i,
      rst_d1 => rst_d1,
      wr_clk => wr_clk,
      wr_en => wr_en
    );
wrpp1_inst: entity work.\input_arbiter_fifo_xpm_counter_updn__parameterized3_1\
     port map (
      Q(5 downto 0) => \count_value_i__0\(5 downto 0),
      \count_value_i_reg[1]_0\(0) => xpm_fifo_rst_inst_n_2,
      \count_value_i_reg[5]_0\ => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_n_0\,
      ram_wr_en_i => ram_wr_en_i,
      rst_d1 => rst_d1,
      wr_clk => wr_clk,
      wr_en => wr_en
    );
wrpp2_inst: entity work.\input_arbiter_fifo_xpm_counter_updn__parameterized0\
     port map (
      Q(5) => wrpp2_inst_n_0,
      Q(4) => wrpp2_inst_n_1,
      Q(3) => wrpp2_inst_n_2,
      Q(2) => wrpp2_inst_n_3,
      Q(1) => wrpp2_inst_n_4,
      Q(0) => wrpp2_inst_n_5,
      \count_value_i_reg[1]_0\(0) => xpm_fifo_rst_inst_n_2,
      \count_value_i_reg[5]_0\ => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_n_0\,
      ram_wr_en_i => ram_wr_en_i,
      rst_d1 => rst_d1,
      wr_clk => wr_clk,
      wr_en => wr_en
    );
xpm_fifo_rst_inst: entity work.input_arbiter_fifo_xpm_fifo_rst
     port map (
      Q(1 downto 0) => curr_fwft_state(1 downto 0),
      almost_full => \^almost_full\,
      \count_value_i_reg[5]\ => \gen_pntr_flags_cc.gen_full_rst_val.ram_full_i_reg_n_0\,
      \gen_rst_cc.fifo_wr_rst_cc_reg[2]_0\(0) => xpm_fifo_rst_inst_n_2,
      going_afull => going_afull,
      going_full1 => going_full1,
      ram_empty_i => ram_empty_i,
      ram_wr_en_i => ram_wr_en_i,
      rd_en => rd_en,
      rst => rst,
      rst_d1 => rst_d1,
      \syncstages_ff_reg[3]\ => xpm_fifo_rst_inst_n_0,
      wr_clk => wr_clk,
      wr_en => wr_en
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity input_arbiter_fifo_xpm_fifo_axis is
  port (
    s_aresetn : in STD_LOGIC;
    s_aclk : in STD_LOGIC;
    m_aclk : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 255 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tdest : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_tstrb : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tdest : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    prog_full_axis : out STD_LOGIC;
    wr_data_count_axis : out STD_LOGIC_VECTOR ( 6 downto 0 );
    almost_full_axis : out STD_LOGIC;
    prog_empty_axis : out STD_LOGIC;
    rd_data_count_axis : out STD_LOGIC_VECTOR ( 6 downto 0 );
    almost_empty_axis : out STD_LOGIC;
    injectsbiterr_axis : in STD_LOGIC;
    injectdbiterr_axis : in STD_LOGIC;
    sbiterr_axis : out STD_LOGIC;
    dbiterr_axis : out STD_LOGIC
  );
  attribute AXIS_DATA_WIDTH : integer;
  attribute AXIS_DATA_WIDTH of input_arbiter_fifo_xpm_fifo_axis : entity is 451;
  attribute AXIS_FINAL_DATA_WIDTH : integer;
  attribute AXIS_FINAL_DATA_WIDTH of input_arbiter_fifo_xpm_fifo_axis : entity is 451;
  attribute CASCADE_HEIGHT : integer;
  attribute CASCADE_HEIGHT of input_arbiter_fifo_xpm_fifo_axis : entity is 0;
  attribute CDC_SYNC_STAGES : integer;
  attribute CDC_SYNC_STAGES of input_arbiter_fifo_xpm_fifo_axis : entity is 3;
  attribute CLOCKING_MODE : string;
  attribute CLOCKING_MODE of input_arbiter_fifo_xpm_fifo_axis : entity is "common_clock";
  attribute ECC_MODE : string;
  attribute ECC_MODE of input_arbiter_fifo_xpm_fifo_axis : entity is "no_ecc";
  attribute EN_ADV_FEATURE_AXIS : string;
  attribute EN_ADV_FEATURE_AXIS of input_arbiter_fifo_xpm_fifo_axis : entity is "16'b0001100000001000";
  attribute EN_ADV_FEATURE_AXIS_INT : string;
  attribute EN_ADV_FEATURE_AXIS_INT of input_arbiter_fifo_xpm_fifo_axis : entity is "16'b0001100000001000";
  attribute EN_ALMOST_EMPTY_INT : string;
  attribute EN_ALMOST_EMPTY_INT of input_arbiter_fifo_xpm_fifo_axis : entity is "1'b1";
  attribute EN_ALMOST_FULL_INT : string;
  attribute EN_ALMOST_FULL_INT of input_arbiter_fifo_xpm_fifo_axis : entity is "1'b1";
  attribute EN_DATA_VALID_INT : string;
  attribute EN_DATA_VALID_INT of input_arbiter_fifo_xpm_fifo_axis : entity is "1'b1";
  attribute FIFO_DEPTH : integer;
  attribute FIFO_DEPTH of input_arbiter_fifo_xpm_fifo_axis : entity is 64;
  attribute FIFO_MEMORY_TYPE : string;
  attribute FIFO_MEMORY_TYPE of input_arbiter_fifo_xpm_fifo_axis : entity is "auto";
  attribute LOG_DEPTH_AXIS : integer;
  attribute LOG_DEPTH_AXIS of input_arbiter_fifo_xpm_fifo_axis : entity is 6;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of input_arbiter_fifo_xpm_fifo_axis : entity is "xpm_fifo_axis";
  attribute PACKET_FIFO : string;
  attribute PACKET_FIFO of input_arbiter_fifo_xpm_fifo_axis : entity is "true";
  attribute PKT_SIZE_LT8 : string;
  attribute PKT_SIZE_LT8 of input_arbiter_fifo_xpm_fifo_axis : entity is "1'b0";
  attribute PROG_EMPTY_THRESH : integer;
  attribute PROG_EMPTY_THRESH of input_arbiter_fifo_xpm_fifo_axis : entity is 5;
  attribute PROG_FULL_THRESH : integer;
  attribute PROG_FULL_THRESH of input_arbiter_fifo_xpm_fifo_axis : entity is 11;
  attribute P_COMMON_CLOCK : integer;
  attribute P_COMMON_CLOCK of input_arbiter_fifo_xpm_fifo_axis : entity is 1;
  attribute P_ECC_MODE : integer;
  attribute P_ECC_MODE of input_arbiter_fifo_xpm_fifo_axis : entity is 0;
  attribute P_FIFO_MEMORY_TYPE : integer;
  attribute P_FIFO_MEMORY_TYPE of input_arbiter_fifo_xpm_fifo_axis : entity is 0;
  attribute P_PKT_MODE : integer;
  attribute P_PKT_MODE of input_arbiter_fifo_xpm_fifo_axis : entity is 1;
  attribute RD_DATA_COUNT_WIDTH : integer;
  attribute RD_DATA_COUNT_WIDTH of input_arbiter_fifo_xpm_fifo_axis : entity is 7;
  attribute RELATED_CLOCKS : integer;
  attribute RELATED_CLOCKS of input_arbiter_fifo_xpm_fifo_axis : entity is 0;
  attribute SIM_ASSERT_CHK : integer;
  attribute SIM_ASSERT_CHK of input_arbiter_fifo_xpm_fifo_axis : entity is 0;
  attribute TDATA_OFFSET : integer;
  attribute TDATA_OFFSET of input_arbiter_fifo_xpm_fifo_axis : entity is 256;
  attribute TDATA_WIDTH : integer;
  attribute TDATA_WIDTH of input_arbiter_fifo_xpm_fifo_axis : entity is 256;
  attribute TDEST_OFFSET : integer;
  attribute TDEST_OFFSET of input_arbiter_fifo_xpm_fifo_axis : entity is 322;
  attribute TDEST_WIDTH : integer;
  attribute TDEST_WIDTH of input_arbiter_fifo_xpm_fifo_axis : entity is 1;
  attribute TID_OFFSET : integer;
  attribute TID_OFFSET of input_arbiter_fifo_xpm_fifo_axis : entity is 321;
  attribute TID_WIDTH : integer;
  attribute TID_WIDTH of input_arbiter_fifo_xpm_fifo_axis : entity is 1;
  attribute TKEEP_OFFSET : integer;
  attribute TKEEP_OFFSET of input_arbiter_fifo_xpm_fifo_axis : entity is 320;
  attribute TSTRB_OFFSET : integer;
  attribute TSTRB_OFFSET of input_arbiter_fifo_xpm_fifo_axis : entity is 288;
  attribute TUSER_MAX_WIDTH : integer;
  attribute TUSER_MAX_WIDTH of input_arbiter_fifo_xpm_fifo_axis : entity is 3773;
  attribute TUSER_OFFSET : integer;
  attribute TUSER_OFFSET of input_arbiter_fifo_xpm_fifo_axis : entity is 450;
  attribute TUSER_WIDTH : integer;
  attribute TUSER_WIDTH of input_arbiter_fifo_xpm_fifo_axis : entity is 128;
  attribute USE_ADV_FEATURES : integer;
  attribute USE_ADV_FEATURES of input_arbiter_fifo_xpm_fifo_axis : entity is 825765944;
  attribute USE_ADV_FEATURES_INT : integer;
  attribute USE_ADV_FEATURES_INT of input_arbiter_fifo_xpm_fifo_axis : entity is 825765944;
  attribute WR_DATA_COUNT_WIDTH : integer;
  attribute WR_DATA_COUNT_WIDTH of input_arbiter_fifo_xpm_fifo_axis : entity is 7;
  attribute XPM_MODULE : string;
  attribute XPM_MODULE of input_arbiter_fifo_xpm_fifo_axis : entity is "TRUE";
  attribute dont_touch : string;
  attribute dont_touch of input_arbiter_fifo_xpm_fifo_axis : entity is "true";
end input_arbiter_fifo_xpm_fifo_axis;

architecture STRUCTURE of input_arbiter_fifo_xpm_fifo_axis is
  signal \<const0>\ : STD_LOGIC;
  signal \^almost_full_axis\ : STD_LOGIC;
  signal axis_pkt_read : STD_LOGIC;
  signal axis_rd_eop1 : STD_LOGIC;
  signal axis_wr_eop_d1 : STD_LOGIC;
  signal data_valid_axis : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_3_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_4_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_5_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_6_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_2_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_3_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_4_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_5_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_2_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_3_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_4_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_5_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_2_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_3_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_4_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_5_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_2_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_3_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_4_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_5_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_2_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_3_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_4_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_5_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_2_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_3_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_4_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_5_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_2_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_3_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_4_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_5_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_1\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_2\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_3\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_4\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_5\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_6\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_7\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_1\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_2\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_1\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_2\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_3\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_4\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_5\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_6\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_7\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_1\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_2\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_3\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_4\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_5\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_6\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_7\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_1\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_2\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_3\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_4\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_5\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_6\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_7\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_1\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_2\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_3\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_4\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_5\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_6\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_7\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_10_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_11_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_12_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_13_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_14_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_17_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_18_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_19_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_1_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_20_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_21_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_22_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_23_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_24_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_25_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_26_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_27_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_28_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_30_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_31_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_32_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_33_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_34_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_35_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_36_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_37_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_38_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_39_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_3_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_40_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_41_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_42_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_43_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_44_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_45_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_5_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_6_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_7_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_8_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_i_9_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16_n_1\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16_n_2\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16_n_3\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29_n_1\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29_n_2\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29_n_3\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2_n_1\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2_n_2\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2_n_3\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4_n_0\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4_n_1\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4_n_2\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4_n_3\ : STD_LOGIC;
  signal \gaxis_pkt_fifo_cc.axis_wr_eop_d1_i_1_n_0\ : STD_LOGIC;
  signal \gaxis_rst_sync.xpm_cdc_sync_rst_inst_i_1_n_0\ : STD_LOGIC;
  signal \^m_axis_tlast\ : STD_LOGIC;
  signal p_3_in : STD_LOGIC;
  signal rst_axis : STD_LOGIC;
  signal \^s_axis_tready\ : STD_LOGIC;
  signal \NLW_gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_xpm_fifo_base_inst_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_xpm_fifo_base_inst_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_xpm_fifo_base_inst_full_UNCONNECTED : STD_LOGIC;
  signal NLW_xpm_fifo_base_inst_overflow_UNCONNECTED : STD_LOGIC;
  signal NLW_xpm_fifo_base_inst_prog_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_xpm_fifo_base_inst_prog_full_UNCONNECTED : STD_LOGIC;
  signal NLW_xpm_fifo_base_inst_rd_rst_busy_UNCONNECTED : STD_LOGIC;
  signal NLW_xpm_fifo_base_inst_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_xpm_fifo_base_inst_underflow_UNCONNECTED : STD_LOGIC;
  signal NLW_xpm_fifo_base_inst_wr_ack_UNCONNECTED : STD_LOGIC;
  signal NLW_xpm_fifo_base_inst_wr_rst_busy_UNCONNECTED : STD_LOGIC;
  signal NLW_xpm_fifo_base_inst_dout_UNCONNECTED : STD_LOGIC_VECTOR ( 321 downto 256 );
  signal NLW_xpm_fifo_base_inst_rd_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_xpm_fifo_base_inst_wr_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2\ : label is 11;
  attribute ADDER_THRESHOLD of \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1\ : label is 11;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gaxis_pkt_fifo_cc.axis_pkt_read_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \gaxis_pkt_fifo_cc.axis_pkt_read_i_15\ : label is "soft_lutpair11";
  attribute COMPARATOR_THRESHOLD : integer;
  attribute COMPARATOR_THRESHOLD of \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16\ : label is 11;
  attribute COMPARATOR_THRESHOLD of \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2\ : label is 11;
  attribute COMPARATOR_THRESHOLD of \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29\ : label is 11;
  attribute COMPARATOR_THRESHOLD of \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4\ : label is 11;
  attribute DEF_VAL : string;
  attribute DEF_VAL of \gaxis_rst_sync.xpm_cdc_sync_rst_inst\ : label is "1'b0";
  attribute DEST_SYNC_FF : integer;
  attribute DEST_SYNC_FF of \gaxis_rst_sync.xpm_cdc_sync_rst_inst\ : label is 4;
  attribute INIT : string;
  attribute INIT of \gaxis_rst_sync.xpm_cdc_sync_rst_inst\ : label is "0";
  attribute INIT_SYNC_FF : integer;
  attribute INIT_SYNC_FF of \gaxis_rst_sync.xpm_cdc_sync_rst_inst\ : label is 1;
  attribute KEEP_HIERARCHY : string;
  attribute KEEP_HIERARCHY of \gaxis_rst_sync.xpm_cdc_sync_rst_inst\ : label is "true";
  attribute SIM_ASSERT_CHK of \gaxis_rst_sync.xpm_cdc_sync_rst_inst\ : label is 0;
  attribute VERSION : integer;
  attribute VERSION of \gaxis_rst_sync.xpm_cdc_sync_rst_inst\ : label is 0;
  attribute XPM_CDC : string;
  attribute XPM_CDC of \gaxis_rst_sync.xpm_cdc_sync_rst_inst\ : label is "SYNC_RST";
  attribute XPM_MODULE of \gaxis_rst_sync.xpm_cdc_sync_rst_inst\ : label is "TRUE";
  attribute SOFT_HLUTNM of m_axis_tvalid_INST_0 : label is "soft_lutpair10";
  attribute CASCADE_HEIGHT of xpm_fifo_base_inst : label is 0;
  attribute CDC_DEST_SYNC_FF : integer;
  attribute CDC_DEST_SYNC_FF of xpm_fifo_base_inst : label is 3;
  attribute COMMON_CLOCK : integer;
  attribute COMMON_CLOCK of xpm_fifo_base_inst : label is 1;
  attribute DOUT_RESET_VALUE : string;
  attribute DOUT_RESET_VALUE of xpm_fifo_base_inst : label is "";
  attribute ECC_MODE_integer : integer;
  attribute ECC_MODE_integer of xpm_fifo_base_inst : label is 0;
  attribute ENABLE_ECC : integer;
  attribute ENABLE_ECC of xpm_fifo_base_inst : label is 0;
  attribute EN_ADV_FEATURE : string;
  attribute EN_ADV_FEATURE of xpm_fifo_base_inst : label is "16'b0001100000001000";
  attribute EN_AE : string;
  attribute EN_AE of xpm_fifo_base_inst : label is "1'b1";
  attribute EN_AF : string;
  attribute EN_AF of xpm_fifo_base_inst : label is "1'b1";
  attribute EN_DVLD : string;
  attribute EN_DVLD of xpm_fifo_base_inst : label is "1'b1";
  attribute EN_OF : string;
  attribute EN_OF of xpm_fifo_base_inst : label is "1'b0";
  attribute EN_PE : string;
  attribute EN_PE of xpm_fifo_base_inst : label is "1'b0";
  attribute EN_PF : string;
  attribute EN_PF of xpm_fifo_base_inst : label is "1'b0";
  attribute EN_RDC : string;
  attribute EN_RDC of xpm_fifo_base_inst : label is "1'b0";
  attribute EN_UF : string;
  attribute EN_UF of xpm_fifo_base_inst : label is "1'b0";
  attribute EN_WACK : string;
  attribute EN_WACK of xpm_fifo_base_inst : label is "1'b0";
  attribute EN_WDC : string;
  attribute EN_WDC of xpm_fifo_base_inst : label is "1'b0";
  attribute FG_EQ_ASYM_DOUT : string;
  attribute FG_EQ_ASYM_DOUT of xpm_fifo_base_inst : label is "1'b0";
  attribute FIFO_MEMORY_TYPE_integer : integer;
  attribute FIFO_MEMORY_TYPE_integer of xpm_fifo_base_inst : label is 0;
  attribute FIFO_MEM_TYPE : integer;
  attribute FIFO_MEM_TYPE of xpm_fifo_base_inst : label is 0;
  attribute FIFO_READ_DEPTH : integer;
  attribute FIFO_READ_DEPTH of xpm_fifo_base_inst : label is 64;
  attribute FIFO_READ_LATENCY : integer;
  attribute FIFO_READ_LATENCY of xpm_fifo_base_inst : label is 0;
  attribute FIFO_SIZE : integer;
  attribute FIFO_SIZE of xpm_fifo_base_inst : label is 28864;
  attribute FIFO_WRITE_DEPTH : integer;
  attribute FIFO_WRITE_DEPTH of xpm_fifo_base_inst : label is 64;
  attribute FULL_RESET_VALUE : integer;
  attribute FULL_RESET_VALUE of xpm_fifo_base_inst : label is 1;
  attribute FULL_RST_VAL : string;
  attribute FULL_RST_VAL of xpm_fifo_base_inst : label is "1'b1";
  attribute KEEP_HIERARCHY of xpm_fifo_base_inst : label is "soft";
  attribute PE_THRESH_ADJ : integer;
  attribute PE_THRESH_ADJ of xpm_fifo_base_inst : label is 3;
  attribute PE_THRESH_MAX : integer;
  attribute PE_THRESH_MAX of xpm_fifo_base_inst : label is 59;
  attribute PE_THRESH_MIN : integer;
  attribute PE_THRESH_MIN of xpm_fifo_base_inst : label is 5;
  attribute PF_THRESH_ADJ : integer;
  attribute PF_THRESH_ADJ of xpm_fifo_base_inst : label is 9;
  attribute PF_THRESH_MAX : integer;
  attribute PF_THRESH_MAX of xpm_fifo_base_inst : label is 59;
  attribute PF_THRESH_MIN : integer;
  attribute PF_THRESH_MIN of xpm_fifo_base_inst : label is 5;
  attribute PROG_EMPTY_THRESH of xpm_fifo_base_inst : label is 5;
  attribute PROG_FULL_THRESH of xpm_fifo_base_inst : label is 11;
  attribute RD_DATA_COUNT_WIDTH of xpm_fifo_base_inst : label is 7;
  attribute RD_DC_WIDTH_EXT : integer;
  attribute RD_DC_WIDTH_EXT of xpm_fifo_base_inst : label is 7;
  attribute RD_LATENCY : integer;
  attribute RD_LATENCY of xpm_fifo_base_inst : label is 2;
  attribute RD_MODE : integer;
  attribute RD_MODE of xpm_fifo_base_inst : label is 1;
  attribute RD_PNTR_WIDTH : integer;
  attribute RD_PNTR_WIDTH of xpm_fifo_base_inst : label is 6;
  attribute READ_DATA_WIDTH : integer;
  attribute READ_DATA_WIDTH of xpm_fifo_base_inst : label is 451;
  attribute READ_MODE : integer;
  attribute READ_MODE of xpm_fifo_base_inst : label is 1;
  attribute RELATED_CLOCKS of xpm_fifo_base_inst : label is 0;
  attribute REMOVE_WR_RD_PROT_LOGIC : integer;
  attribute REMOVE_WR_RD_PROT_LOGIC of xpm_fifo_base_inst : label is 0;
  attribute SIM_ASSERT_CHK of xpm_fifo_base_inst : label is 0;
  attribute USE_ADV_FEATURES of xpm_fifo_base_inst : label is 825765944;
  attribute VERSION of xpm_fifo_base_inst : label is 0;
  attribute WAKEUP_TIME : integer;
  attribute WAKEUP_TIME of xpm_fifo_base_inst : label is 0;
  attribute WIDTH_RATIO : integer;
  attribute WIDTH_RATIO of xpm_fifo_base_inst : label is 1;
  attribute WRITE_DATA_WIDTH : integer;
  attribute WRITE_DATA_WIDTH of xpm_fifo_base_inst : label is 451;
  attribute WR_DATA_COUNT_WIDTH of xpm_fifo_base_inst : label is 7;
  attribute WR_DC_WIDTH_EXT : integer;
  attribute WR_DC_WIDTH_EXT of xpm_fifo_base_inst : label is 7;
  attribute WR_DEPTH_LOG : integer;
  attribute WR_DEPTH_LOG of xpm_fifo_base_inst : label is 6;
  attribute WR_PNTR_WIDTH : integer;
  attribute WR_PNTR_WIDTH of xpm_fifo_base_inst : label is 6;
  attribute WR_RD_RATIO : integer;
  attribute WR_RD_RATIO of xpm_fifo_base_inst : label is 0;
  attribute WR_WIDTH_LOG : integer;
  attribute WR_WIDTH_LOG of xpm_fifo_base_inst : label is 9;
  attribute XPM_MODULE of xpm_fifo_base_inst : label is "TRUE";
  attribute both_stages_valid : integer;
  attribute both_stages_valid of xpm_fifo_base_inst : label is 3;
  attribute invalid : integer;
  attribute invalid of xpm_fifo_base_inst : label is 0;
  attribute stage1_valid : integer;
  attribute stage1_valid of xpm_fifo_base_inst : label is 2;
  attribute stage2_valid : integer;
  attribute stage2_valid of xpm_fifo_base_inst : label is 1;
  attribute SOFT_HLUTNM of xpm_fifo_base_inst_i_1 : label is "soft_lutpair11";
begin
  almost_full_axis <= \^almost_full_axis\;
  dbiterr_axis <= \<const0>\;
  m_axis_tdest(0) <= \<const0>\;
  m_axis_tid(0) <= \<const0>\;
  m_axis_tlast <= \^m_axis_tlast\;
  m_axis_tstrb(31) <= \<const0>\;
  m_axis_tstrb(30) <= \<const0>\;
  m_axis_tstrb(29) <= \<const0>\;
  m_axis_tstrb(28) <= \<const0>\;
  m_axis_tstrb(27) <= \<const0>\;
  m_axis_tstrb(26) <= \<const0>\;
  m_axis_tstrb(25) <= \<const0>\;
  m_axis_tstrb(24) <= \<const0>\;
  m_axis_tstrb(23) <= \<const0>\;
  m_axis_tstrb(22) <= \<const0>\;
  m_axis_tstrb(21) <= \<const0>\;
  m_axis_tstrb(20) <= \<const0>\;
  m_axis_tstrb(19) <= \<const0>\;
  m_axis_tstrb(18) <= \<const0>\;
  m_axis_tstrb(17) <= \<const0>\;
  m_axis_tstrb(16) <= \<const0>\;
  m_axis_tstrb(15) <= \<const0>\;
  m_axis_tstrb(14) <= \<const0>\;
  m_axis_tstrb(13) <= \<const0>\;
  m_axis_tstrb(12) <= \<const0>\;
  m_axis_tstrb(11) <= \<const0>\;
  m_axis_tstrb(10) <= \<const0>\;
  m_axis_tstrb(9) <= \<const0>\;
  m_axis_tstrb(8) <= \<const0>\;
  m_axis_tstrb(7) <= \<const0>\;
  m_axis_tstrb(6) <= \<const0>\;
  m_axis_tstrb(5) <= \<const0>\;
  m_axis_tstrb(4) <= \<const0>\;
  m_axis_tstrb(3) <= \<const0>\;
  m_axis_tstrb(2) <= \<const0>\;
  m_axis_tstrb(1) <= \<const0>\;
  m_axis_tstrb(0) <= \<const0>\;
  prog_empty_axis <= \<const0>\;
  prog_full_axis <= \<const0>\;
  rd_data_count_axis(6) <= \<const0>\;
  rd_data_count_axis(5) <= \<const0>\;
  rd_data_count_axis(4) <= \<const0>\;
  rd_data_count_axis(3) <= \<const0>\;
  rd_data_count_axis(2) <= \<const0>\;
  rd_data_count_axis(1) <= \<const0>\;
  rd_data_count_axis(0) <= \<const0>\;
  s_axis_tready <= \^s_axis_tready\;
  sbiterr_axis <= \<const0>\;
  wr_data_count_axis(6) <= \<const0>\;
  wr_data_count_axis(5) <= \<const0>\;
  wr_data_count_axis(4) <= \<const0>\;
  wr_data_count_axis(3) <= \<const0>\;
  wr_data_count_axis(2) <= \<const0>\;
  wr_data_count_axis(1) <= \<const0>\;
  wr_data_count_axis(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => axis_wr_eop_d1,
      I1 => m_axis_tready,
      I2 => data_valid_axis,
      I3 => \^m_axis_tlast\,
      I4 => axis_pkt_read,
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(3),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_3_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(2),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_4_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(1),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_5_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(0),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_6_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(15),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_2_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(14),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_3_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(13),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_4_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(12),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_5_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(19),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_2_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(18),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_3_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(17),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_4_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(16),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_5_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(23),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_2_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(22),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_3_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(21),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_4_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(20),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_5_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(27),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_2_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(26),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_3_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(25),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_4_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(24),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_5_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(31),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_2_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(30),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_3_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(29),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_4_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(28),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_5_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(7),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_2_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(6),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_3_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(5),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_4_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(4),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_5_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(11),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_2_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(10),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_3_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(9),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_4_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF00008000FFFF"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      I4 => axis_wr_eop_d1,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(8),
      O => \gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_5_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_7\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(0),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_0\,
      CO(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_1\,
      CO(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_2\,
      CO(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(3 downto 1),
      DI(0) => '1',
      O(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_4\,
      O(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_5\,
      O(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_6\,
      O(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_7\,
      S(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_3_n_0\,
      S(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_4_n_0\,
      S(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_5_n_0\,
      S(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_6_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_5\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(10),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_4\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(11),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_7\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(12),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_0\,
      CO(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_0\,
      CO(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_1\,
      CO(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_2\,
      CO(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(15 downto 12),
      O(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_4\,
      O(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_5\,
      O(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_6\,
      O(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_7\,
      S(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_2_n_0\,
      S(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_3_n_0\,
      S(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_4_n_0\,
      S(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[12]_i_5_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_6\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(13),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_5\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(14),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_4\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(15),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_7\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(16),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[12]_i_1_n_0\,
      CO(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_0\,
      CO(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_1\,
      CO(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_2\,
      CO(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(19 downto 16),
      O(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_4\,
      O(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_5\,
      O(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_6\,
      O(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_7\,
      S(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_2_n_0\,
      S(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_3_n_0\,
      S(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_4_n_0\,
      S(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[16]_i_5_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_6\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(17),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_5\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(18),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_4\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(19),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_6\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(1),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_7\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(20),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[16]_i_1_n_0\,
      CO(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_0\,
      CO(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_1\,
      CO(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_2\,
      CO(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(23 downto 20),
      O(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_4\,
      O(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_5\,
      O(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_6\,
      O(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_7\,
      S(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_2_n_0\,
      S(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_3_n_0\,
      S(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_4_n_0\,
      S(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[20]_i_5_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_6\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(21),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_5\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(22),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_4\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(23),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_7\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(24),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[20]_i_1_n_0\,
      CO(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_0\,
      CO(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_1\,
      CO(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_2\,
      CO(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(27 downto 24),
      O(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_4\,
      O(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_5\,
      O(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_6\,
      O(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_7\,
      S(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_2_n_0\,
      S(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_3_n_0\,
      S(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_4_n_0\,
      S(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[24]_i_5_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_6\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(25),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_5\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(26),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_4\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(27),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_7\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(28),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[24]_i_1_n_0\,
      CO(3) => \NLW_gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_1\,
      CO(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_2\,
      CO(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2 downto 0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(30 downto 28),
      O(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_4\,
      O(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_5\,
      O(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_6\,
      O(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_7\,
      S(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_2_n_0\,
      S(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_3_n_0\,
      S(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_4_n_0\,
      S(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[28]_i_5_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_6\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(29),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_5\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(2),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_5\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(30),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[28]_i_1_n_4\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(31),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_4\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(3),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_7\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(4),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[0]_i_2_n_0\,
      CO(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_0\,
      CO(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_1\,
      CO(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_2\,
      CO(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(7 downto 4),
      O(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_4\,
      O(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_5\,
      O(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_6\,
      O(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_7\,
      S(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_2_n_0\,
      S(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_3_n_0\,
      S(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_4_n_0\,
      S(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[4]_i_5_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_6\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(5),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_5\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(6),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_4\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(7),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_7\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(8),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[4]_i_1_n_0\,
      CO(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_0\,
      CO(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_1\,
      CO(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_2\,
      CO(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(11 downto 8),
      O(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_4\,
      O(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_5\,
      O(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_6\,
      O(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_7\,
      S(3) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_2_n_0\,
      S(2) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_3_n_0\,
      S(1) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_4_n_0\,
      S(0) => \gaxis_pkt_fifo_cc.axis_pkt_cnt[8]_i_5_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_aclk,
      CE => \gaxis_pkt_fifo_cc.axis_pkt_cnt[0]_i_1_n_0\,
      D => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg[8]_i_1_n_6\,
      Q => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(9),
      R => rst_axis
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000FEEE"
    )
        port map (
      I0 => axis_pkt_read,
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2_n_0\,
      I2 => data_valid_axis,
      I3 => \^almost_full_axis\,
      I4 => \gaxis_pkt_fifo_cc.axis_pkt_read_i_3_n_0\,
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_1_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_10\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(28),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(29),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_10_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_11\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(26),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(27),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_11_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_12\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(24),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(25),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_12_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_read_i_25_n_0\,
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(30),
      I2 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(31),
      I3 => \gaxis_pkt_fifo_cc.axis_pkt_read_i_26_n_0\,
      I4 => \gaxis_pkt_fifo_cc.axis_pkt_read_i_27_n_0\,
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_read_i_28_n_0\,
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_13_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_14\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(24),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(25),
      I2 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(26),
      I3 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(27),
      I4 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(28),
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(29),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_14_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_15\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => m_axis_tready,
      I1 => data_valid_axis,
      I2 => \^m_axis_tlast\,
      I3 => axis_pkt_read,
      O => p_3_in
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_17\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(22),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(23),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_17_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_18\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(20),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(21),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_18_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_19\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(18),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(19),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_19_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_20\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(16),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(17),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_20_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_21\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(22),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(23),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_21_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_22\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(20),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(21),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_22_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_23\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(18),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(19),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_23_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_24\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(16),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(17),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_24_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_25\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFEF"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(1),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(2),
      I2 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(0),
      I3 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(3),
      I4 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(4),
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(5),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_25_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_26\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(12),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(13),
      I2 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(14),
      I3 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(15),
      I4 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(16),
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(17),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_26_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_27\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(18),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(19),
      I2 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(20),
      I3 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(21),
      I4 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(22),
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(23),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_27_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_28\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(6),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(7),
      I2 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(8),
      I3 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(9),
      I4 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(10),
      I5 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(11),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_28_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAABAAAA"
    )
        port map (
      I0 => rst_axis,
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_read_i_13_n_0\,
      I2 => \gaxis_pkt_fifo_cc.axis_pkt_read_i_14_n_0\,
      I3 => axis_wr_eop_d1,
      I4 => p_3_in,
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_3_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_30\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(14),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(15),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_30_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_31\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(12),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(13),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_31_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_32\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(10),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(11),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_32_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_33\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(8),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(9),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_33_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_34\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(14),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(15),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_34_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_35\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(12),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(13),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_35_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_36\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(10),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(11),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_36_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_37\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(8),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(9),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_37_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_38\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(6),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(7),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_38_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_39\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(4),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(5),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_39_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_40\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(2),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(3),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_40_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_41\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(0),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(1),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_41_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_42\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(6),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(7),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_42_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_43\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(4),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(5),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_43_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_44\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(2),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(3),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_44_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_45\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(0),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(1),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_45_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(30),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(31),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_5_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(28),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(29),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_6_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_7\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(26),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(27),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_7_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(24),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(25),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_8_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(31),
      I1 => \gaxis_pkt_fifo_cc.axis_pkt_cnt_reg\(30),
      O => \gaxis_pkt_fifo_cc.axis_pkt_read_i_9_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_aclk,
      CE => '1',
      D => \gaxis_pkt_fifo_cc.axis_pkt_read_i_1_n_0\,
      Q => axis_pkt_read,
      R => '0'
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16\: unisim.vcomponents.CARRY4
     port map (
      CI => \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29_n_0\,
      CO(3) => \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16_n_0\,
      CO(2) => \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16_n_1\,
      CO(1) => \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16_n_2\,
      CO(0) => \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16_n_3\,
      CYINIT => '0',
      DI(3) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_30_n_0\,
      DI(2) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_31_n_0\,
      DI(1) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_32_n_0\,
      DI(0) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_33_n_0\,
      O(3 downto 0) => \NLW_gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16_O_UNCONNECTED\(3 downto 0),
      S(3) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_34_n_0\,
      S(2) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_35_n_0\,
      S(1) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_36_n_0\,
      S(0) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_37_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4_n_0\,
      CO(3) => \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2_n_0\,
      CO(2) => \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2_n_1\,
      CO(1) => \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2_n_2\,
      CO(0) => \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2_n_3\,
      CYINIT => '0',
      DI(3) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_5_n_0\,
      DI(2) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_6_n_0\,
      DI(1) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_7_n_0\,
      DI(0) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_8_n_0\,
      O(3 downto 0) => \NLW_gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_2_O_UNCONNECTED\(3 downto 0),
      S(3) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_9_n_0\,
      S(2) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_10_n_0\,
      S(1) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_11_n_0\,
      S(0) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_12_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29_n_0\,
      CO(2) => \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29_n_1\,
      CO(1) => \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29_n_2\,
      CO(0) => \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29_n_3\,
      CYINIT => '0',
      DI(3) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_38_n_0\,
      DI(2) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_39_n_0\,
      DI(1) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_40_n_0\,
      DI(0) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_41_n_0\,
      O(3 downto 0) => \NLW_gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_29_O_UNCONNECTED\(3 downto 0),
      S(3) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_42_n_0\,
      S(2) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_43_n_0\,
      S(1) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_44_n_0\,
      S(0) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_45_n_0\
    );
\gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4\: unisim.vcomponents.CARRY4
     port map (
      CI => \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_16_n_0\,
      CO(3) => \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4_n_0\,
      CO(2) => \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4_n_1\,
      CO(1) => \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4_n_2\,
      CO(0) => \gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4_n_3\,
      CYINIT => '0',
      DI(3) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_17_n_0\,
      DI(2) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_18_n_0\,
      DI(1) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_19_n_0\,
      DI(0) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_20_n_0\,
      O(3 downto 0) => \NLW_gaxis_pkt_fifo_cc.axis_pkt_read_reg_i_4_O_UNCONNECTED\(3 downto 0),
      S(3) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_21_n_0\,
      S(2) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_22_n_0\,
      S(1) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_23_n_0\,
      S(0) => \gaxis_pkt_fifo_cc.axis_pkt_read_i_24_n_0\
    );
\gaxis_pkt_fifo_cc.axis_wr_eop_d1_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => s_axis_tlast,
      I1 => \^s_axis_tready\,
      I2 => s_axis_tvalid,
      I3 => rst_axis,
      O => \gaxis_pkt_fifo_cc.axis_wr_eop_d1_i_1_n_0\
    );
\gaxis_pkt_fifo_cc.axis_wr_eop_d1_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_aclk,
      CE => '1',
      D => \gaxis_pkt_fifo_cc.axis_wr_eop_d1_i_1_n_0\,
      Q => axis_wr_eop_d1,
      R => '0'
    );
\gaxis_rst_sync.xpm_cdc_sync_rst_inst\: entity work.input_arbiter_fifo_xpm_cdc_sync_rst
     port map (
      dest_clk => s_aclk,
      dest_rst => rst_axis,
      src_rst => \gaxis_rst_sync.xpm_cdc_sync_rst_inst_i_1_n_0\
    );
\gaxis_rst_sync.xpm_cdc_sync_rst_inst_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => s_aresetn,
      O => \gaxis_rst_sync.xpm_cdc_sync_rst_inst_i_1_n_0\
    );
m_axis_tvalid_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => data_valid_axis,
      I1 => axis_pkt_read,
      O => m_axis_tvalid
    );
xpm_fifo_base_inst: entity work.input_arbiter_fifo_xpm_fifo_base
     port map (
      almost_empty => almost_empty_axis,
      almost_full => \^almost_full_axis\,
      data_valid => data_valid_axis,
      dbiterr => NLW_xpm_fifo_base_inst_dbiterr_UNCONNECTED,
      din(450) => s_axis_tlast,
      din(449 downto 322) => s_axis_tuser(127 downto 0),
      din(321 downto 320) => B"00",
      din(319 downto 288) => s_axis_tkeep(31 downto 0),
      din(287 downto 256) => B"00000000000000000000000000000000",
      din(255 downto 0) => s_axis_tdata(255 downto 0),
      dout(450) => \^m_axis_tlast\,
      dout(449 downto 322) => m_axis_tuser(127 downto 0),
      dout(321 downto 320) => NLW_xpm_fifo_base_inst_dout_UNCONNECTED(321 downto 320),
      dout(319 downto 288) => m_axis_tkeep(31 downto 0),
      dout(287 downto 256) => NLW_xpm_fifo_base_inst_dout_UNCONNECTED(287 downto 256),
      dout(255 downto 0) => m_axis_tdata(255 downto 0),
      empty => NLW_xpm_fifo_base_inst_empty_UNCONNECTED,
      full => NLW_xpm_fifo_base_inst_full_UNCONNECTED,
      full_n => \^s_axis_tready\,
      injectdbiterr => '0',
      injectsbiterr => '0',
      overflow => NLW_xpm_fifo_base_inst_overflow_UNCONNECTED,
      prog_empty => NLW_xpm_fifo_base_inst_prog_empty_UNCONNECTED,
      prog_full => NLW_xpm_fifo_base_inst_prog_full_UNCONNECTED,
      rd_clk => '0',
      rd_data_count(6 downto 0) => NLW_xpm_fifo_base_inst_rd_data_count_UNCONNECTED(6 downto 0),
      rd_en => axis_rd_eop1,
      rd_rst_busy => NLW_xpm_fifo_base_inst_rd_rst_busy_UNCONNECTED,
      rst => rst_axis,
      sbiterr => NLW_xpm_fifo_base_inst_sbiterr_UNCONNECTED,
      sleep => '0',
      underflow => NLW_xpm_fifo_base_inst_underflow_UNCONNECTED,
      wr_ack => NLW_xpm_fifo_base_inst_wr_ack_UNCONNECTED,
      wr_clk => s_aclk,
      wr_data_count(6 downto 0) => NLW_xpm_fifo_base_inst_wr_data_count_UNCONNECTED(6 downto 0),
      wr_en => s_axis_tvalid,
      wr_rst_busy => NLW_xpm_fifo_base_inst_wr_rst_busy_UNCONNECTED
    );
xpm_fifo_base_inst_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => axis_pkt_read,
      I1 => data_valid_axis,
      I2 => m_axis_tready,
      O => axis_rd_eop1
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity input_arbiter_fifo_axis_data_fifo_v2_0_3_top is
  port (
    s_axis_aclk : in STD_LOGIC;
    s_axis_aresetn : in STD_LOGIC;
    s_axis_aclken : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 255 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tdest : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    almost_full : out STD_LOGIC;
    prog_full : out STD_LOGIC;
    axis_wr_data_count : out STD_LOGIC_VECTOR ( 31 downto 0 );
    injectsbiterr : in STD_LOGIC;
    injectdbiterr : in STD_LOGIC;
    m_axis_aclk : in STD_LOGIC;
    m_axis_aclken : in STD_LOGIC;
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_tstrb : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tdest : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    almost_empty : out STD_LOGIC;
    prog_empty : out STD_LOGIC;
    axis_rd_data_count : out STD_LOGIC_VECTOR ( 31 downto 0 );
    sbiterr : out STD_LOGIC;
    dbiterr : out STD_LOGIC
  );
  attribute C_ACLKEN_CONV_MODE : integer;
  attribute C_ACLKEN_CONV_MODE of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 0;
  attribute C_AXIS_SIGNAL_SET : string;
  attribute C_AXIS_SIGNAL_SET of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is "32'b00000000000000000000000010011011";
  attribute C_AXIS_TDATA_WIDTH : integer;
  attribute C_AXIS_TDATA_WIDTH of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 256;
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 1;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 1;
  attribute C_AXIS_TUSER_WIDTH : integer;
  attribute C_AXIS_TUSER_WIDTH of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 128;
  attribute C_ECC_MODE : integer;
  attribute C_ECC_MODE of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 0;
  attribute C_FAMILY : string;
  attribute C_FAMILY of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is "zynq";
  attribute C_FIFO_DEPTH : integer;
  attribute C_FIFO_DEPTH of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 64;
  attribute C_FIFO_MEMORY_TYPE : string;
  attribute C_FIFO_MEMORY_TYPE of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is "auto";
  attribute C_FIFO_MODE : integer;
  attribute C_FIFO_MODE of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 2;
  attribute C_IS_ACLK_ASYNC : integer;
  attribute C_IS_ACLK_ASYNC of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 0;
  attribute C_PROG_EMPTY_THRESH : integer;
  attribute C_PROG_EMPTY_THRESH of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 5;
  attribute C_PROG_FULL_THRESH : integer;
  attribute C_PROG_FULL_THRESH of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 11;
  attribute C_SYNCHRONIZER_STAGE : integer;
  attribute C_SYNCHRONIZER_STAGE of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 3;
  attribute C_USE_ADV_FEATURES : integer;
  attribute C_USE_ADV_FEATURES of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 825765944;
  attribute G_INDX_SS_TDATA : integer;
  attribute G_INDX_SS_TDATA of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 1;
  attribute G_INDX_SS_TDEST : integer;
  attribute G_INDX_SS_TDEST of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 6;
  attribute G_INDX_SS_TID : integer;
  attribute G_INDX_SS_TID of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 5;
  attribute G_INDX_SS_TKEEP : integer;
  attribute G_INDX_SS_TKEEP of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 3;
  attribute G_INDX_SS_TLAST : integer;
  attribute G_INDX_SS_TLAST of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 4;
  attribute G_INDX_SS_TREADY : integer;
  attribute G_INDX_SS_TREADY of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 0;
  attribute G_INDX_SS_TSTRB : integer;
  attribute G_INDX_SS_TSTRB of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 2;
  attribute G_INDX_SS_TUSER : integer;
  attribute G_INDX_SS_TUSER of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 7;
  attribute G_MASK_SS_TDATA : integer;
  attribute G_MASK_SS_TDATA of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 2;
  attribute G_MASK_SS_TDEST : integer;
  attribute G_MASK_SS_TDEST of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 64;
  attribute G_MASK_SS_TID : integer;
  attribute G_MASK_SS_TID of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 32;
  attribute G_MASK_SS_TKEEP : integer;
  attribute G_MASK_SS_TKEEP of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 8;
  attribute G_MASK_SS_TLAST : integer;
  attribute G_MASK_SS_TLAST of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 16;
  attribute G_MASK_SS_TREADY : integer;
  attribute G_MASK_SS_TREADY of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 1;
  attribute G_MASK_SS_TSTRB : integer;
  attribute G_MASK_SS_TSTRB of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 4;
  attribute G_MASK_SS_TUSER : integer;
  attribute G_MASK_SS_TUSER of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 128;
  attribute G_TASK_SEVERITY_ERR : integer;
  attribute G_TASK_SEVERITY_ERR of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 2;
  attribute G_TASK_SEVERITY_INFO : integer;
  attribute G_TASK_SEVERITY_INFO of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 0;
  attribute G_TASK_SEVERITY_WARNING : integer;
  attribute G_TASK_SEVERITY_WARNING of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 1;
  attribute LP_CDC_SYNC_STAGES : integer;
  attribute LP_CDC_SYNC_STAGES of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 3;
  attribute LP_CLOCKING_MODE : string;
  attribute LP_CLOCKING_MODE of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is "common_clock";
  attribute LP_ECC_MODE : string;
  attribute LP_ECC_MODE of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is "no_ecc";
  attribute LP_FIFO_DEPTH : integer;
  attribute LP_FIFO_DEPTH of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 64;
  attribute LP_FIFO_MEMORY_TYPE : string;
  attribute LP_FIFO_MEMORY_TYPE of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is "auto";
  attribute LP_M_ACLKEN_CAN_TOGGLE : integer;
  attribute LP_M_ACLKEN_CAN_TOGGLE of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 0;
  attribute LP_PACKET_FIFO : string;
  attribute LP_PACKET_FIFO of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is "true";
  attribute LP_PROG_EMPTY_THRESH : integer;
  attribute LP_PROG_EMPTY_THRESH of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 5;
  attribute LP_PROG_FULL_THRESH : integer;
  attribute LP_PROG_FULL_THRESH of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 11;
  attribute LP_RD_DATA_COUNT_WIDTH : integer;
  attribute LP_RD_DATA_COUNT_WIDTH of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 7;
  attribute LP_RELATED_CLOCKS : integer;
  attribute LP_RELATED_CLOCKS of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 0;
  attribute LP_S_ACLKEN_CAN_TOGGLE : integer;
  attribute LP_S_ACLKEN_CAN_TOGGLE of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 0;
  attribute LP_TDATA_WIDTH : integer;
  attribute LP_TDATA_WIDTH of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 256;
  attribute LP_TDEST_WIDTH : integer;
  attribute LP_TDEST_WIDTH of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 1;
  attribute LP_TID_WIDTH : integer;
  attribute LP_TID_WIDTH of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 1;
  attribute LP_TUSER_WIDTH : integer;
  attribute LP_TUSER_WIDTH of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 128;
  attribute LP_USE_ADV_FEATURES : integer;
  attribute LP_USE_ADV_FEATURES of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 825765944;
  attribute LP_WR_DATA_COUNT_WIDTH : integer;
  attribute LP_WR_DATA_COUNT_WIDTH of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is 7;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of input_arbiter_fifo_axis_data_fifo_v2_0_3_top : entity is "axis_data_fifo_v2_0_3_top";
end input_arbiter_fifo_axis_data_fifo_v2_0_3_top;

architecture STRUCTURE of input_arbiter_fifo_axis_data_fifo_v2_0_3_top is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^axis_rd_data_count\ : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \^axis_wr_data_count\ : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \NLW_gen_fifo.xpm_fifo_axis_inst_m_axis_tdest_UNCONNECTED\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \NLW_gen_fifo.xpm_fifo_axis_inst_m_axis_tid_UNCONNECTED\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \NLW_gen_fifo.xpm_fifo_axis_inst_m_axis_tstrb_UNCONNECTED\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  attribute AXIS_DATA_WIDTH : integer;
  attribute AXIS_DATA_WIDTH of \gen_fifo.xpm_fifo_axis_inst\ : label is 451;
  attribute AXIS_FINAL_DATA_WIDTH : integer;
  attribute AXIS_FINAL_DATA_WIDTH of \gen_fifo.xpm_fifo_axis_inst\ : label is 451;
  attribute CASCADE_HEIGHT : integer;
  attribute CASCADE_HEIGHT of \gen_fifo.xpm_fifo_axis_inst\ : label is 0;
  attribute CDC_SYNC_STAGES : integer;
  attribute CDC_SYNC_STAGES of \gen_fifo.xpm_fifo_axis_inst\ : label is 3;
  attribute CLOCKING_MODE : string;
  attribute CLOCKING_MODE of \gen_fifo.xpm_fifo_axis_inst\ : label is "common_clock";
  attribute ECC_MODE : string;
  attribute ECC_MODE of \gen_fifo.xpm_fifo_axis_inst\ : label is "no_ecc";
  attribute EN_ADV_FEATURE_AXIS : string;
  attribute EN_ADV_FEATURE_AXIS of \gen_fifo.xpm_fifo_axis_inst\ : label is "16'b0001100000001000";
  attribute EN_ADV_FEATURE_AXIS_INT : string;
  attribute EN_ADV_FEATURE_AXIS_INT of \gen_fifo.xpm_fifo_axis_inst\ : label is "16'b0001100000001000";
  attribute EN_ALMOST_EMPTY_INT : string;
  attribute EN_ALMOST_EMPTY_INT of \gen_fifo.xpm_fifo_axis_inst\ : label is "1'b1";
  attribute EN_ALMOST_FULL_INT : string;
  attribute EN_ALMOST_FULL_INT of \gen_fifo.xpm_fifo_axis_inst\ : label is "1'b1";
  attribute EN_DATA_VALID_INT : string;
  attribute EN_DATA_VALID_INT of \gen_fifo.xpm_fifo_axis_inst\ : label is "1'b1";
  attribute FIFO_DEPTH : integer;
  attribute FIFO_DEPTH of \gen_fifo.xpm_fifo_axis_inst\ : label is 64;
  attribute FIFO_MEMORY_TYPE : string;
  attribute FIFO_MEMORY_TYPE of \gen_fifo.xpm_fifo_axis_inst\ : label is "auto";
  attribute LOG_DEPTH_AXIS : integer;
  attribute LOG_DEPTH_AXIS of \gen_fifo.xpm_fifo_axis_inst\ : label is 6;
  attribute PACKET_FIFO : string;
  attribute PACKET_FIFO of \gen_fifo.xpm_fifo_axis_inst\ : label is "true";
  attribute PKT_SIZE_LT8 : string;
  attribute PKT_SIZE_LT8 of \gen_fifo.xpm_fifo_axis_inst\ : label is "1'b0";
  attribute PROG_EMPTY_THRESH : integer;
  attribute PROG_EMPTY_THRESH of \gen_fifo.xpm_fifo_axis_inst\ : label is 5;
  attribute PROG_FULL_THRESH : integer;
  attribute PROG_FULL_THRESH of \gen_fifo.xpm_fifo_axis_inst\ : label is 11;
  attribute P_COMMON_CLOCK : integer;
  attribute P_COMMON_CLOCK of \gen_fifo.xpm_fifo_axis_inst\ : label is 1;
  attribute P_ECC_MODE : integer;
  attribute P_ECC_MODE of \gen_fifo.xpm_fifo_axis_inst\ : label is 0;
  attribute P_FIFO_MEMORY_TYPE : integer;
  attribute P_FIFO_MEMORY_TYPE of \gen_fifo.xpm_fifo_axis_inst\ : label is 0;
  attribute P_PKT_MODE : integer;
  attribute P_PKT_MODE of \gen_fifo.xpm_fifo_axis_inst\ : label is 1;
  attribute RD_DATA_COUNT_WIDTH : integer;
  attribute RD_DATA_COUNT_WIDTH of \gen_fifo.xpm_fifo_axis_inst\ : label is 7;
  attribute RELATED_CLOCKS : integer;
  attribute RELATED_CLOCKS of \gen_fifo.xpm_fifo_axis_inst\ : label is 0;
  attribute SIM_ASSERT_CHK : integer;
  attribute SIM_ASSERT_CHK of \gen_fifo.xpm_fifo_axis_inst\ : label is 0;
  attribute TDATA_OFFSET : integer;
  attribute TDATA_OFFSET of \gen_fifo.xpm_fifo_axis_inst\ : label is 256;
  attribute TDATA_WIDTH : integer;
  attribute TDATA_WIDTH of \gen_fifo.xpm_fifo_axis_inst\ : label is 256;
  attribute TDEST_OFFSET : integer;
  attribute TDEST_OFFSET of \gen_fifo.xpm_fifo_axis_inst\ : label is 322;
  attribute TDEST_WIDTH : integer;
  attribute TDEST_WIDTH of \gen_fifo.xpm_fifo_axis_inst\ : label is 1;
  attribute TID_OFFSET : integer;
  attribute TID_OFFSET of \gen_fifo.xpm_fifo_axis_inst\ : label is 321;
  attribute TID_WIDTH : integer;
  attribute TID_WIDTH of \gen_fifo.xpm_fifo_axis_inst\ : label is 1;
  attribute TKEEP_OFFSET : integer;
  attribute TKEEP_OFFSET of \gen_fifo.xpm_fifo_axis_inst\ : label is 320;
  attribute TSTRB_OFFSET : integer;
  attribute TSTRB_OFFSET of \gen_fifo.xpm_fifo_axis_inst\ : label is 288;
  attribute TUSER_MAX_WIDTH : integer;
  attribute TUSER_MAX_WIDTH of \gen_fifo.xpm_fifo_axis_inst\ : label is 3773;
  attribute TUSER_OFFSET : integer;
  attribute TUSER_OFFSET of \gen_fifo.xpm_fifo_axis_inst\ : label is 450;
  attribute TUSER_WIDTH : integer;
  attribute TUSER_WIDTH of \gen_fifo.xpm_fifo_axis_inst\ : label is 128;
  attribute USE_ADV_FEATURES : integer;
  attribute USE_ADV_FEATURES of \gen_fifo.xpm_fifo_axis_inst\ : label is 825765944;
  attribute USE_ADV_FEATURES_INT : integer;
  attribute USE_ADV_FEATURES_INT of \gen_fifo.xpm_fifo_axis_inst\ : label is 825765944;
  attribute WR_DATA_COUNT_WIDTH : integer;
  attribute WR_DATA_COUNT_WIDTH of \gen_fifo.xpm_fifo_axis_inst\ : label is 7;
  attribute XPM_MODULE : string;
  attribute XPM_MODULE of \gen_fifo.xpm_fifo_axis_inst\ : label is "TRUE";
begin
  axis_rd_data_count(31) <= \<const0>\;
  axis_rd_data_count(30) <= \<const0>\;
  axis_rd_data_count(29) <= \<const0>\;
  axis_rd_data_count(28) <= \<const0>\;
  axis_rd_data_count(27) <= \<const0>\;
  axis_rd_data_count(26) <= \<const0>\;
  axis_rd_data_count(25) <= \<const0>\;
  axis_rd_data_count(24) <= \<const0>\;
  axis_rd_data_count(23) <= \<const0>\;
  axis_rd_data_count(22) <= \<const0>\;
  axis_rd_data_count(21) <= \<const0>\;
  axis_rd_data_count(20) <= \<const0>\;
  axis_rd_data_count(19) <= \<const0>\;
  axis_rd_data_count(18) <= \<const0>\;
  axis_rd_data_count(17) <= \<const0>\;
  axis_rd_data_count(16) <= \<const0>\;
  axis_rd_data_count(15) <= \<const0>\;
  axis_rd_data_count(14) <= \<const0>\;
  axis_rd_data_count(13) <= \<const0>\;
  axis_rd_data_count(12) <= \<const0>\;
  axis_rd_data_count(11) <= \<const0>\;
  axis_rd_data_count(10) <= \<const0>\;
  axis_rd_data_count(9) <= \<const0>\;
  axis_rd_data_count(8) <= \<const0>\;
  axis_rd_data_count(7) <= \<const0>\;
  axis_rd_data_count(6 downto 0) <= \^axis_rd_data_count\(6 downto 0);
  axis_wr_data_count(31) <= \<const0>\;
  axis_wr_data_count(30) <= \<const0>\;
  axis_wr_data_count(29) <= \<const0>\;
  axis_wr_data_count(28) <= \<const0>\;
  axis_wr_data_count(27) <= \<const0>\;
  axis_wr_data_count(26) <= \<const0>\;
  axis_wr_data_count(25) <= \<const0>\;
  axis_wr_data_count(24) <= \<const0>\;
  axis_wr_data_count(23) <= \<const0>\;
  axis_wr_data_count(22) <= \<const0>\;
  axis_wr_data_count(21) <= \<const0>\;
  axis_wr_data_count(20) <= \<const0>\;
  axis_wr_data_count(19) <= \<const0>\;
  axis_wr_data_count(18) <= \<const0>\;
  axis_wr_data_count(17) <= \<const0>\;
  axis_wr_data_count(16) <= \<const0>\;
  axis_wr_data_count(15) <= \<const0>\;
  axis_wr_data_count(14) <= \<const0>\;
  axis_wr_data_count(13) <= \<const0>\;
  axis_wr_data_count(12) <= \<const0>\;
  axis_wr_data_count(11) <= \<const0>\;
  axis_wr_data_count(10) <= \<const0>\;
  axis_wr_data_count(9) <= \<const0>\;
  axis_wr_data_count(8) <= \<const0>\;
  axis_wr_data_count(7) <= \<const0>\;
  axis_wr_data_count(6 downto 0) <= \^axis_wr_data_count\(6 downto 0);
  m_axis_tdest(0) <= \<const0>\;
  m_axis_tid(0) <= \<const0>\;
  m_axis_tstrb(31) <= \<const1>\;
  m_axis_tstrb(30) <= \<const1>\;
  m_axis_tstrb(29) <= \<const1>\;
  m_axis_tstrb(28) <= \<const1>\;
  m_axis_tstrb(27) <= \<const1>\;
  m_axis_tstrb(26) <= \<const1>\;
  m_axis_tstrb(25) <= \<const1>\;
  m_axis_tstrb(24) <= \<const1>\;
  m_axis_tstrb(23) <= \<const1>\;
  m_axis_tstrb(22) <= \<const1>\;
  m_axis_tstrb(21) <= \<const1>\;
  m_axis_tstrb(20) <= \<const1>\;
  m_axis_tstrb(19) <= \<const1>\;
  m_axis_tstrb(18) <= \<const1>\;
  m_axis_tstrb(17) <= \<const1>\;
  m_axis_tstrb(16) <= \<const1>\;
  m_axis_tstrb(15) <= \<const1>\;
  m_axis_tstrb(14) <= \<const1>\;
  m_axis_tstrb(13) <= \<const1>\;
  m_axis_tstrb(12) <= \<const1>\;
  m_axis_tstrb(11) <= \<const1>\;
  m_axis_tstrb(10) <= \<const1>\;
  m_axis_tstrb(9) <= \<const1>\;
  m_axis_tstrb(8) <= \<const1>\;
  m_axis_tstrb(7) <= \<const1>\;
  m_axis_tstrb(6) <= \<const1>\;
  m_axis_tstrb(5) <= \<const1>\;
  m_axis_tstrb(4) <= \<const1>\;
  m_axis_tstrb(3) <= \<const1>\;
  m_axis_tstrb(2) <= \<const1>\;
  m_axis_tstrb(1) <= \<const1>\;
  m_axis_tstrb(0) <= \<const1>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
     port map (
      P => \<const1>\
    );
\gen_fifo.xpm_fifo_axis_inst\: entity work.input_arbiter_fifo_xpm_fifo_axis
     port map (
      almost_empty_axis => almost_empty,
      almost_full_axis => almost_full,
      dbiterr_axis => dbiterr,
      injectdbiterr_axis => injectdbiterr,
      injectsbiterr_axis => injectsbiterr,
      m_aclk => s_axis_aclk,
      m_axis_tdata(255 downto 0) => m_axis_tdata(255 downto 0),
      m_axis_tdest(0) => \NLW_gen_fifo.xpm_fifo_axis_inst_m_axis_tdest_UNCONNECTED\(0),
      m_axis_tid(0) => \NLW_gen_fifo.xpm_fifo_axis_inst_m_axis_tid_UNCONNECTED\(0),
      m_axis_tkeep(31 downto 0) => m_axis_tkeep(31 downto 0),
      m_axis_tlast => m_axis_tlast,
      m_axis_tready => m_axis_tready,
      m_axis_tstrb(31 downto 0) => \NLW_gen_fifo.xpm_fifo_axis_inst_m_axis_tstrb_UNCONNECTED\(31 downto 0),
      m_axis_tuser(127 downto 0) => m_axis_tuser(127 downto 0),
      m_axis_tvalid => m_axis_tvalid,
      prog_empty_axis => prog_empty,
      prog_full_axis => prog_full,
      rd_data_count_axis(6 downto 0) => \^axis_rd_data_count\(6 downto 0),
      s_aclk => s_axis_aclk,
      s_aresetn => s_axis_aresetn,
      s_axis_tdata(255 downto 0) => s_axis_tdata(255 downto 0),
      s_axis_tdest(0) => '0',
      s_axis_tid(0) => '0',
      s_axis_tkeep(31 downto 0) => s_axis_tkeep(31 downto 0),
      s_axis_tlast => s_axis_tlast,
      s_axis_tready => s_axis_tready,
      s_axis_tstrb(31 downto 0) => B"00000000000000000000000000000000",
      s_axis_tuser(127 downto 0) => s_axis_tuser(127 downto 0),
      s_axis_tvalid => s_axis_tvalid,
      sbiterr_axis => sbiterr,
      wr_data_count_axis(6 downto 0) => \^axis_wr_data_count\(6 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity input_arbiter_fifo is
  port (
    s_axis_aresetn : in STD_LOGIC;
    s_axis_aclk : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 255 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of input_arbiter_fifo : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of input_arbiter_fifo : entity is "input_arbiter_fifo,axis_data_fifo_v2_0_3_top,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of input_arbiter_fifo : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of input_arbiter_fifo : entity is "axis_data_fifo_v2_0_3_top,Vivado 2020.1";
end input_arbiter_fifo;

architecture STRUCTURE of input_arbiter_fifo is
  signal NLW_inst_almost_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_almost_full_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_prog_empty_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_prog_full_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_axis_rd_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_inst_axis_wr_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_inst_m_axis_tdest_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axis_tid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axis_tstrb_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  attribute C_ACLKEN_CONV_MODE : integer;
  attribute C_ACLKEN_CONV_MODE of inst : label is 0;
  attribute C_AXIS_SIGNAL_SET : string;
  attribute C_AXIS_SIGNAL_SET of inst : label is "32'b00000000000000000000000010011011";
  attribute C_AXIS_TDATA_WIDTH : integer;
  attribute C_AXIS_TDATA_WIDTH of inst : label is 256;
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of inst : label is 1;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of inst : label is 1;
  attribute C_AXIS_TUSER_WIDTH : integer;
  attribute C_AXIS_TUSER_WIDTH of inst : label is 128;
  attribute C_ECC_MODE : integer;
  attribute C_ECC_MODE of inst : label is 0;
  attribute C_FAMILY : string;
  attribute C_FAMILY of inst : label is "zynq";
  attribute C_FIFO_DEPTH : integer;
  attribute C_FIFO_DEPTH of inst : label is 64;
  attribute C_FIFO_MEMORY_TYPE : string;
  attribute C_FIFO_MEMORY_TYPE of inst : label is "auto";
  attribute C_FIFO_MODE : integer;
  attribute C_FIFO_MODE of inst : label is 2;
  attribute C_IS_ACLK_ASYNC : integer;
  attribute C_IS_ACLK_ASYNC of inst : label is 0;
  attribute C_PROG_EMPTY_THRESH : integer;
  attribute C_PROG_EMPTY_THRESH of inst : label is 5;
  attribute C_PROG_FULL_THRESH : integer;
  attribute C_PROG_FULL_THRESH of inst : label is 11;
  attribute C_SYNCHRONIZER_STAGE : integer;
  attribute C_SYNCHRONIZER_STAGE of inst : label is 3;
  attribute C_USE_ADV_FEATURES : integer;
  attribute C_USE_ADV_FEATURES of inst : label is 825765944;
  attribute G_INDX_SS_TDATA : integer;
  attribute G_INDX_SS_TDATA of inst : label is 1;
  attribute G_INDX_SS_TDEST : integer;
  attribute G_INDX_SS_TDEST of inst : label is 6;
  attribute G_INDX_SS_TID : integer;
  attribute G_INDX_SS_TID of inst : label is 5;
  attribute G_INDX_SS_TKEEP : integer;
  attribute G_INDX_SS_TKEEP of inst : label is 3;
  attribute G_INDX_SS_TLAST : integer;
  attribute G_INDX_SS_TLAST of inst : label is 4;
  attribute G_INDX_SS_TREADY : integer;
  attribute G_INDX_SS_TREADY of inst : label is 0;
  attribute G_INDX_SS_TSTRB : integer;
  attribute G_INDX_SS_TSTRB of inst : label is 2;
  attribute G_INDX_SS_TUSER : integer;
  attribute G_INDX_SS_TUSER of inst : label is 7;
  attribute G_MASK_SS_TDATA : integer;
  attribute G_MASK_SS_TDATA of inst : label is 2;
  attribute G_MASK_SS_TDEST : integer;
  attribute G_MASK_SS_TDEST of inst : label is 64;
  attribute G_MASK_SS_TID : integer;
  attribute G_MASK_SS_TID of inst : label is 32;
  attribute G_MASK_SS_TKEEP : integer;
  attribute G_MASK_SS_TKEEP of inst : label is 8;
  attribute G_MASK_SS_TLAST : integer;
  attribute G_MASK_SS_TLAST of inst : label is 16;
  attribute G_MASK_SS_TREADY : integer;
  attribute G_MASK_SS_TREADY of inst : label is 1;
  attribute G_MASK_SS_TSTRB : integer;
  attribute G_MASK_SS_TSTRB of inst : label is 4;
  attribute G_MASK_SS_TUSER : integer;
  attribute G_MASK_SS_TUSER of inst : label is 128;
  attribute G_TASK_SEVERITY_ERR : integer;
  attribute G_TASK_SEVERITY_ERR of inst : label is 2;
  attribute G_TASK_SEVERITY_INFO : integer;
  attribute G_TASK_SEVERITY_INFO of inst : label is 0;
  attribute G_TASK_SEVERITY_WARNING : integer;
  attribute G_TASK_SEVERITY_WARNING of inst : label is 1;
  attribute LP_CDC_SYNC_STAGES : integer;
  attribute LP_CDC_SYNC_STAGES of inst : label is 3;
  attribute LP_CLOCKING_MODE : string;
  attribute LP_CLOCKING_MODE of inst : label is "common_clock";
  attribute LP_ECC_MODE : string;
  attribute LP_ECC_MODE of inst : label is "no_ecc";
  attribute LP_FIFO_DEPTH : integer;
  attribute LP_FIFO_DEPTH of inst : label is 64;
  attribute LP_FIFO_MEMORY_TYPE : string;
  attribute LP_FIFO_MEMORY_TYPE of inst : label is "auto";
  attribute LP_M_ACLKEN_CAN_TOGGLE : integer;
  attribute LP_M_ACLKEN_CAN_TOGGLE of inst : label is 0;
  attribute LP_PACKET_FIFO : string;
  attribute LP_PACKET_FIFO of inst : label is "true";
  attribute LP_PROG_EMPTY_THRESH : integer;
  attribute LP_PROG_EMPTY_THRESH of inst : label is 5;
  attribute LP_PROG_FULL_THRESH : integer;
  attribute LP_PROG_FULL_THRESH of inst : label is 11;
  attribute LP_RD_DATA_COUNT_WIDTH : integer;
  attribute LP_RD_DATA_COUNT_WIDTH of inst : label is 7;
  attribute LP_RELATED_CLOCKS : integer;
  attribute LP_RELATED_CLOCKS of inst : label is 0;
  attribute LP_S_ACLKEN_CAN_TOGGLE : integer;
  attribute LP_S_ACLKEN_CAN_TOGGLE of inst : label is 0;
  attribute LP_TDATA_WIDTH : integer;
  attribute LP_TDATA_WIDTH of inst : label is 256;
  attribute LP_TDEST_WIDTH : integer;
  attribute LP_TDEST_WIDTH of inst : label is 1;
  attribute LP_TID_WIDTH : integer;
  attribute LP_TID_WIDTH of inst : label is 1;
  attribute LP_TUSER_WIDTH : integer;
  attribute LP_TUSER_WIDTH of inst : label is 128;
  attribute LP_USE_ADV_FEATURES : integer;
  attribute LP_USE_ADV_FEATURES of inst : label is 825765944;
  attribute LP_WR_DATA_COUNT_WIDTH : integer;
  attribute LP_WR_DATA_COUNT_WIDTH of inst : label is 7;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of m_axis_tlast : signal is "xilinx.com:interface:axis:1.0 M_AXIS TLAST";
  attribute X_INTERFACE_INFO of m_axis_tready : signal is "xilinx.com:interface:axis:1.0 M_AXIS TREADY";
  attribute X_INTERFACE_INFO of m_axis_tvalid : signal is "xilinx.com:interface:axis:1.0 M_AXIS TVALID";
  attribute X_INTERFACE_INFO of s_axis_aclk : signal is "xilinx.com:signal:clock:1.0 S_CLKIF CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of s_axis_aclk : signal is "XIL_INTERFACENAME S_CLKIF, ASSOCIATED_BUSIF S_AXIS, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axis_aresetn : signal is "xilinx.com:signal:reset:1.0 S_RSTIF RST";
  attribute X_INTERFACE_PARAMETER of s_axis_aresetn : signal is "XIL_INTERFACENAME S_RSTIF, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axis_tlast : signal is "xilinx.com:interface:axis:1.0 S_AXIS TLAST";
  attribute X_INTERFACE_INFO of s_axis_tready : signal is "xilinx.com:interface:axis:1.0 S_AXIS TREADY";
  attribute X_INTERFACE_INFO of s_axis_tvalid : signal is "xilinx.com:interface:axis:1.0 S_AXIS TVALID";
  attribute X_INTERFACE_INFO of m_axis_tdata : signal is "xilinx.com:interface:axis:1.0 M_AXIS TDATA";
  attribute X_INTERFACE_INFO of m_axis_tkeep : signal is "xilinx.com:interface:axis:1.0 M_AXIS TKEEP";
  attribute X_INTERFACE_INFO of m_axis_tuser : signal is "xilinx.com:interface:axis:1.0 M_AXIS TUSER";
  attribute X_INTERFACE_PARAMETER of m_axis_tuser : signal is "XIL_INTERFACENAME M_AXIS, TDATA_NUM_BYTES 32, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 128, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axis_tdata : signal is "xilinx.com:interface:axis:1.0 S_AXIS TDATA";
  attribute X_INTERFACE_INFO of s_axis_tkeep : signal is "xilinx.com:interface:axis:1.0 S_AXIS TKEEP";
  attribute X_INTERFACE_INFO of s_axis_tuser : signal is "xilinx.com:interface:axis:1.0 S_AXIS TUSER";
  attribute X_INTERFACE_PARAMETER of s_axis_tuser : signal is "XIL_INTERFACENAME S_AXIS, TDATA_NUM_BYTES 32, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 128, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0";
begin
inst: entity work.input_arbiter_fifo_axis_data_fifo_v2_0_3_top
     port map (
      almost_empty => NLW_inst_almost_empty_UNCONNECTED,
      almost_full => NLW_inst_almost_full_UNCONNECTED,
      axis_rd_data_count(31 downto 0) => NLW_inst_axis_rd_data_count_UNCONNECTED(31 downto 0),
      axis_wr_data_count(31 downto 0) => NLW_inst_axis_wr_data_count_UNCONNECTED(31 downto 0),
      dbiterr => NLW_inst_dbiterr_UNCONNECTED,
      injectdbiterr => '0',
      injectsbiterr => '0',
      m_axis_aclk => '0',
      m_axis_aclken => '1',
      m_axis_tdata(255 downto 0) => m_axis_tdata(255 downto 0),
      m_axis_tdest(0) => NLW_inst_m_axis_tdest_UNCONNECTED(0),
      m_axis_tid(0) => NLW_inst_m_axis_tid_UNCONNECTED(0),
      m_axis_tkeep(31 downto 0) => m_axis_tkeep(31 downto 0),
      m_axis_tlast => m_axis_tlast,
      m_axis_tready => m_axis_tready,
      m_axis_tstrb(31 downto 0) => NLW_inst_m_axis_tstrb_UNCONNECTED(31 downto 0),
      m_axis_tuser(127 downto 0) => m_axis_tuser(127 downto 0),
      m_axis_tvalid => m_axis_tvalid,
      prog_empty => NLW_inst_prog_empty_UNCONNECTED,
      prog_full => NLW_inst_prog_full_UNCONNECTED,
      s_axis_aclk => s_axis_aclk,
      s_axis_aclken => '1',
      s_axis_aresetn => s_axis_aresetn,
      s_axis_tdata(255 downto 0) => s_axis_tdata(255 downto 0),
      s_axis_tdest(0) => '0',
      s_axis_tid(0) => '0',
      s_axis_tkeep(31 downto 0) => s_axis_tkeep(31 downto 0),
      s_axis_tlast => s_axis_tlast,
      s_axis_tready => s_axis_tready,
      s_axis_tstrb(31 downto 0) => B"11111111111111111111111111111111",
      s_axis_tuser(127 downto 0) => s_axis_tuser(127 downto 0),
      s_axis_tvalid => s_axis_tvalid,
      sbiterr => NLW_inst_sbiterr_UNCONNECTED
    );
end STRUCTURE;
