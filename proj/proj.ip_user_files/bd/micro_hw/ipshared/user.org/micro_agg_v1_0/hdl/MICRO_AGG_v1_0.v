`default_nettype none

`include "def.h"
`timescale 1 ns / 1 ps

	module MICRO_AGG_v1_0 #
	(
	    parameter integer K_SIZE = 8,  //micro aggregate 8 data
		parameter integer C_S_AXIS_TDATA_WIDTH	= 32,

		parameter integer C_M_AXIS_TDATA_WIDTH	= 32,
		parameter integer C_M_AXIS_START_COUNT	= 32
	)
	(
		input wire  s_axis_aclk,
		input wire  s_axis_aresetn,
		output wire  s_axis_tready,
		input wire [C_S_AXIS_TDATA_WIDTH-1 : 0] s_axis_tdata,
		input wire [(C_S_AXIS_TDATA_WIDTH/8)-1 : 0] s_axis_tstrb,
		input wire  s_axis_tlast,
		input wire  s_axis_tvalid,

		// Ports of Axi Master Bus Interface M_AXIS
		input wire  m_axis_aclk,
		input wire  m_axis_aresetn,
		output wire  m_axis_tvalid,
		output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] m_axis_tdata,
		output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] m_axis_tstrb,
		output wire  m_axis_tlast,
		input wire  m_axis_tready
	);
	
	
	wire [`DATA_W-1:0] out0, out1, out2, out3, out4, out5;
	wire valid_out0, valid_out1, valid_out2, valid_out3, valid_out4, valid_out5;
	wire last_out0, last_out1, last_out2, last_out3, last_out4, last_out5;

// Instantiation of Axi Bus Interface S_AXIS
	MICRO_AGG_v1_0_S_AXIS # ( 
		.C_S_AXIS_TDATA_WIDTH(C_S_AXIS_TDATA_WIDTH)
	) MICRO_AGG_v1_0_S_AXIS_inst (
        .DATA_OUT(out0),
        .VALID_OUT(valid_out0),
        .LAST_OUT(last_out0),
		.S_AXIS_ACLK(s_axis_aclk),
		.S_AXIS_ARESETN(s_axis_aresetn),
		.S_AXIS_TREADY(s_axis_tready),
		.S_AXIS_TDATA(s_axis_tdata),
		.S_AXIS_TSTRB(s_axis_tstrb),
		.S_AXIS_TLAST(s_axis_tlast),
		.S_AXIS_TVALID(s_axis_tvalid)
	);
	
	four f0(.clk(s_axis_aclk), .rst_n(s_axis_aresetn), .in(out0), .valid_in(valid_out0), .last_in(last_out0), .out(out1), .valid_out(valid_out1), .last_out(last_out1));
    eight e0(.clk(s_axis_aclk), .rst_n(s_axis_aresetn), .in(out1), .valid_in(valid_out1), .last_in(last_out1), .out(out2), .valid_out(valid_out2), .last_out(last_out2));
    steen s0(.clk(s_axis_aclk), .rst_n(s_axis_aresetn), .in(out2), .valid_in(valid_out2), .last_in(last_out2), .out(out3), .valid_out(valid_out3), .last_out(last_out3));
    thtwo t0(.clk(s_axis_aclk), .rst_n(s_axis_aresetn), .in(out3), .valid_in(valid_out3), .last_in(last_out3), .out(out4), .valid_out(valid_out4), .last_out(last_out4));
    sum_reg sr0(.clk(s_axis_aclk), .rst_n(s_axis_aresetn), .ina(out4), .valid_in(valid_out4), .last_in(last_out4), .out(out5), .valid_out(valid_out5), .last_out(last_out5));


// Instantiation of Axi Bus Interface M_AXIS
	MICRO_AGG_v1_0_M_AXIS # ( 
	    .K_SIZE(K_SIZE),
		.C_M_AXIS_TDATA_WIDTH(C_M_AXIS_TDATA_WIDTH),
		.C_M_START_COUNT(C_M_AXIS_START_COUNT)
	) MICRO_AGG_v1_0_M_AXIS_inst (
	 	.MICRO_IN(out5),
 	    .MICRO_VALID_IN(valid_out5),
 	    .MICRO_LAST_IN(last_out5),
		.M_AXIS_ACLK(m_axis_aclk),
		.M_AXIS_ARESETN(m_axis_aresetn),
		.M_AXIS_TVALID(m_axis_tvalid),
		.M_AXIS_TDATA(m_axis_tdata),
		.M_AXIS_TSTRB(m_axis_tstrb),
		.M_AXIS_TLAST(m_axis_tlast),
		.M_AXIS_TREADY(m_axis_tready)
	);

	// Add user logic here

	// User logic ends

	endmodule
	
`default_nettype wire

