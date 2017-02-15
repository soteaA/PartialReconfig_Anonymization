//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.3 (lin64) Build 1368829 Mon Sep 28 20:06:39 MDT 2015
//Date        : Sat Sep 24 16:45:16 2016
//Host        : einsamerwolf-HP-Z840-Workstation running 64-bit Ubuntu 14.04.5 LTS
//Command     : generate_target anon_hw_wrapper.bd
//Design      : anon_hw_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module anon_hw_wrapper
   (DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FCLK_CLK0,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    M_AXIS_MM2S_tdata,
    M_AXIS_MM2S_tkeep,
    M_AXIS_MM2S_tlast,
    M_AXIS_MM2S_tready,
    M_AXIS_MM2S_tvalid,
    S_AXIS_S2MM_tdata,
    S_AXIS_S2MM_tkeep,
    S_AXIS_S2MM_tlast,
    S_AXIS_S2MM_tready,
    S_AXIS_S2MM_tvalid,
    axi_pr_decouple_tri_io,
    gpio_0_tri_io,
    peripheral_aresetn);
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  output FCLK_CLK0;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  output [31:0]M_AXIS_MM2S_tdata;
  output [3:0]M_AXIS_MM2S_tkeep;
  output M_AXIS_MM2S_tlast;
  input M_AXIS_MM2S_tready;
  output M_AXIS_MM2S_tvalid;
  input [31:0]S_AXIS_S2MM_tdata;
  input [3:0]S_AXIS_S2MM_tkeep;
  input S_AXIS_S2MM_tlast;
  output S_AXIS_S2MM_tready;
  input S_AXIS_S2MM_tvalid;
  inout [3:0]axi_pr_decouple_tri_io;
  inout [0:0]gpio_0_tri_io;
  output [0:0]peripheral_aresetn;

  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FCLK_CLK0;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire [31:0]M_AXIS_MM2S_tdata;
  wire [3:0]M_AXIS_MM2S_tkeep;
  wire M_AXIS_MM2S_tlast;
  wire M_AXIS_MM2S_tready;
  wire M_AXIS_MM2S_tvalid;
  wire [31:0]S_AXIS_S2MM_tdata;
  wire [3:0]S_AXIS_S2MM_tkeep;
  wire S_AXIS_S2MM_tlast;
  wire S_AXIS_S2MM_tready;
  wire S_AXIS_S2MM_tvalid;
  wire [0:0]axi_pr_decouple_tri_i_0;
  wire [1:1]axi_pr_decouple_tri_i_1;
  wire [2:2]axi_pr_decouple_tri_i_2;
  wire [3:3]axi_pr_decouple_tri_i_3;
  wire [0:0]axi_pr_decouple_tri_io_0;
  wire [1:1]axi_pr_decouple_tri_io_1;
  wire [2:2]axi_pr_decouple_tri_io_2;
  wire [3:3]axi_pr_decouple_tri_io_3;
  wire [0:0]axi_pr_decouple_tri_o_0;
  wire [1:1]axi_pr_decouple_tri_o_1;
  wire [2:2]axi_pr_decouple_tri_o_2;
  wire [3:3]axi_pr_decouple_tri_o_3;
  wire [0:0]axi_pr_decouple_tri_t_0;
  wire [1:1]axi_pr_decouple_tri_t_1;
  wire [2:2]axi_pr_decouple_tri_t_2;
  wire [3:3]axi_pr_decouple_tri_t_3;
  wire [0:0]gpio_0_tri_i_0;
  wire [0:0]gpio_0_tri_io_0;
  wire [0:0]gpio_0_tri_o_0;
  wire [0:0]gpio_0_tri_t_0;
  wire [0:0]peripheral_aresetn;

  anon_hw anon_hw_i
       (.DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FCLK_CLK0(FCLK_CLK0),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .GPIO_0_tri_i(gpio_0_tri_i_0),
        .GPIO_0_tri_o(gpio_0_tri_o_0),
        .GPIO_0_tri_t(gpio_0_tri_t_0),
        .M_AXIS_MM2S_tdata(M_AXIS_MM2S_tdata),
        .M_AXIS_MM2S_tkeep(M_AXIS_MM2S_tkeep),
        .M_AXIS_MM2S_tlast(M_AXIS_MM2S_tlast),
        .M_AXIS_MM2S_tready(M_AXIS_MM2S_tready),
        .M_AXIS_MM2S_tvalid(M_AXIS_MM2S_tvalid),
        .S_AXIS_S2MM_tdata(S_AXIS_S2MM_tdata),
        .S_AXIS_S2MM_tkeep(S_AXIS_S2MM_tkeep),
        .S_AXIS_S2MM_tlast(S_AXIS_S2MM_tlast),
        .S_AXIS_S2MM_tready(S_AXIS_S2MM_tready),
        .S_AXIS_S2MM_tvalid(S_AXIS_S2MM_tvalid),
        .axi_pr_decouple_tri_i({axi_pr_decouple_tri_i_3,axi_pr_decouple_tri_i_2,axi_pr_decouple_tri_i_1,axi_pr_decouple_tri_i_0}),
        .axi_pr_decouple_tri_o({axi_pr_decouple_tri_o_3,axi_pr_decouple_tri_o_2,axi_pr_decouple_tri_o_1,axi_pr_decouple_tri_o_0}),
        .axi_pr_decouple_tri_t({axi_pr_decouple_tri_t_3,axi_pr_decouple_tri_t_2,axi_pr_decouple_tri_t_1,axi_pr_decouple_tri_t_0}),
        .peripheral_aresetn(peripheral_aresetn));
  IOBUF axi_pr_decouple_tri_iobuf_0
       (.I(axi_pr_decouple_tri_o_0),
        .IO(axi_pr_decouple_tri_io[0]),
        .O(axi_pr_decouple_tri_i_0),
        .T(axi_pr_decouple_tri_t_0));
  IOBUF axi_pr_decouple_tri_iobuf_1
       (.I(axi_pr_decouple_tri_o_1),
        .IO(axi_pr_decouple_tri_io[1]),
        .O(axi_pr_decouple_tri_i_1),
        .T(axi_pr_decouple_tri_t_1));
  IOBUF axi_pr_decouple_tri_iobuf_2
       (.I(axi_pr_decouple_tri_o_2),
        .IO(axi_pr_decouple_tri_io[2]),
        .O(axi_pr_decouple_tri_i_2),
        .T(axi_pr_decouple_tri_t_2));
  IOBUF axi_pr_decouple_tri_iobuf_3
       (.I(axi_pr_decouple_tri_o_3),
        .IO(axi_pr_decouple_tri_io[3]),
        .O(axi_pr_decouple_tri_i_3),
        .T(axi_pr_decouple_tri_t_3));
  IOBUF gpio_0_tri_iobuf_0
       (.I(gpio_0_tri_o_0),
        .IO(gpio_0_tri_io[0]),
        .O(gpio_0_tri_i_0),
        .T(gpio_0_tri_t_0));
endmodule
