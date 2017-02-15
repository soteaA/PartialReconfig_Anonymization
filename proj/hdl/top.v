//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.3 (lin64) Build 1368829 Mon Sep 28 20:06:39 MDT 2015
//Date        : Mon Jun 13 19:22:45 2016
//Host        : einsamerwolf-HP-Z840-Workstation running 64-bit Ubuntu 14.04.4 LTS
//Command     : generate_target anon_hw_wrapper.bd
//Design      : anon_hw_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`default_nettype none
`timescale 1 ps / 1 ps

module top
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
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    gpio_0_tri_i_0,
    led_o
    );
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
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  input [0:0]gpio_0_tri_i_0;
  output [1:0]led_o;

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
  wire M_AXIS_MM2S_tready_d;
  wire M_AXIS_MM2S_tvalid;
  wire [31:0]S_AXIS_S2MM_tdata;
  wire [31:0]S_AXIS_S2MM_tdata_d;
  wire [3:0]S_AXIS_S2MM_tkeep;
  wire [3:0]S_AXIS_S2MM_tkeep_d;
  wire S_AXIS_S2MM_tlast;
  wire S_AXIS_S2MM_tlast_d;
  wire S_AXIS_S2MM_tready;
  wire S_AXIS_S2MM_tvalid;
  wire S_AXIS_S2MM_tvalid_d;
  wire [3:0]axi_pr_decouple_tri_o;
  wire [0:0]gpio_0_tri_i_0;
  wire [1:0]led_o;
  wire [0:0]peripheral_aresetn;

  wire [1:0]led;
  wire [3:0]S_AXIS_S2MM_tstrb_d;
  wire [3:0]S_AXIS_tstrb;

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
        .axi_pr_decouple_tri_o(axi_pr_decouple_tri_o),
        .peripheral_aresetn(peripheral_aresetn));

  anon_pr anon_pr_inst
       (.M_AXIS_tdata(S_AXIS_S2MM_tdata_d),
	.M_AXIS_tlast(S_AXIS_S2MM_tlast_d),
	.M_AXIS_tready(S_AXIS_S2MM_tready),
	.M_AXIS_tstrb(S_AXIS_S2MM_tstrb_d),
	.M_AXIS_tvalid(S_AXIS_S2MM_tvalid_d),

	.S_AXIS_tdata(M_AXIS_MM2S_tdata),
	.S_AXIS_tlast(M_AXIS_MM2S_tlast),
	.S_AXIS_tready(M_AXIS_MM2S_tready_d),
	.S_AXIS_tstrb(S_AXIS_tstrb),
	.S_AXIS_tvalid(M_AXIS_MM2S_tvalid),

	.m_axis_aclk(FCLK_CLK0),
	.m_axis_aresetn(peripheral_aresetn),
	.s_axis_aclk(FCLK_CLK0),
	.s_axis_aresetn(peripheral_aresetn),

	.led_o(led));

  assign led_o = led;

  assign S_AXIS_S2MM_tkeep = 4'hf;
  assign S_AXIS_tstrb = 4'hf;

  assign M_AXIS_MM2S_tready = (axi_pr_decouple_tri_o[0]) ? M_AXIS_MM2S_tready_d : 0;
  assign S_AXIS_S2MM_tdata = (axi_pr_decouple_tri_o[0]) ? S_AXIS_S2MM_tdata_d : 0;
  assign S_AXIS_S2MM_tvalid = (axi_pr_decouple_tri_o[0]) ? S_AXIS_S2MM_tvalid_d : 0;
  assign S_AXIS_S2MM_tlast = (axi_pr_decouple_tri_o[0]) ? S_AXIS_S2MM_tlast_d : 0;

endmodule

(*black_box*) module anon_pr
	(
	output wire [31:0] M_AXIS_tdata,
	output wire M_AXIS_tlast,
	input wire M_AXIS_tready,
	output wire [3:0] M_AXIS_tstrb,
	output wire M_AXIS_tvalid,

	input wire [31:0] S_AXIS_tdata,
	input wire S_AXIS_tlast,
	output wire S_AXIS_tready,
	input wire [3:0] S_AXIS_tstrb,
	input wire S_AXIS_tvalid,

	input wire m_axis_aclk,
	input wire m_axis_aresetn,
	input wire s_axis_aclk,
	input wire s_axis_aresetn,

	output wire [1:0] led_o
	);
endmodule

`default_nettype wire
