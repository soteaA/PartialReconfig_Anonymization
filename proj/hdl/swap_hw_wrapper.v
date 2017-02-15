//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.3 (lin64) Build 1368829 Mon Sep 28 20:06:39 MDT 2015
//Date        : Mon Jun 13 17:54:00 2016
//Host        : einsamerwolf-HP-Z840-Workstation running 64-bit Ubuntu 14.04.4 LTS
//Command     : generate_target swap_hw_wrapper.bd
//Design      : swap_hw_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`default_nettype none
`timescale 1 ps / 1 ps

module anon_pr
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

  assign led_o = 2'b10;

  swap_hw swap_hw_pr
       (.M_AXIS_tdata(M_AXIS_tdata),
        .M_AXIS_tlast(M_AXIS_tlast),
        .M_AXIS_tready(M_AXIS_tready),
        .M_AXIS_tstrb(M_AXIS_tstrb),
        .M_AXIS_tvalid(M_AXIS_tvalid),
        .S_AXIS_tdata(S_AXIS_tdata),
        .S_AXIS_tlast(S_AXIS_tlast),
        .S_AXIS_tready(S_AXIS_tready),
        .S_AXIS_tstrb(S_AXIS_tstrb),
        .S_AXIS_tvalid(S_AXIS_tvalid),
        .m_axis_aclk(m_axis_aclk),
        .m_axis_aresetn(m_axis_aresetn),
        .s_axis_aclk(s_axis_aclk),
        .s_axis_aresetn(s_axis_aresetn));
endmodule
`default_nettype wire
