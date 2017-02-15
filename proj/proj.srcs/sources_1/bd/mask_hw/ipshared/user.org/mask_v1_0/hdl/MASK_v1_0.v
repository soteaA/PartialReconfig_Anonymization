
`timescale 1 ns / 1 ps

	module MASK_v1_0 #
	(
	    parameter integer MAX_WINDOW_SIZE = 32,
	    parameter integer MASK_WIDTH = 5,
	    
		parameter integer C_S_AXIS_TDATA_WIDTH	= 32,

		parameter integer C_M_AXIS_TDATA_WIDTH	= 32,
		parameter integer C_M_AXIS_START_COUNT	= 32
	)
	(
	    input wire [MASK_WIDTH-1:0] mask_level,
	    
		input wire  s_axis_aclk,
		input wire  s_axis_aresetn,
		output wire  s_axis_tready,
		input wire [C_S_AXIS_TDATA_WIDTH-1 : 0] s_axis_tdata,
		input wire [(C_S_AXIS_TDATA_WIDTH/8)-1 : 0] s_axis_tstrb,
		input wire  s_axis_tlast,
		input wire  s_axis_tvalid,

		input wire  m_axis_aclk,
		input wire  m_axis_aresetn,
		output wire  m_axis_tvalid,
		output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] m_axis_tdata,
		output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] m_axis_tstrb,
		output wire  m_axis_tlast,
		input wire  m_axis_tready
	);
	   
	    wire [C_S_AXIS_TDATA_WIDTH-1 : 0] masked_data;
	    wire valid;
	    wire last;

	MASK_v1_0_S_AXIS # ( 
	    .MASK_WIDTH(MASK_WIDTH),
		.C_S_AXIS_TDATA_WIDTH(C_S_AXIS_TDATA_WIDTH)
	) MASK_v1_0_S_AXIS_inst (
	    .MASK_LEVEL(mask_level),
	    .DATA_OUT(masked_data),
	    .VALID_OUT(valid),
	    .LAST_OUT(last),
		.S_AXIS_ACLK(s_axis_aclk),
		.S_AXIS_ARESETN(s_axis_aresetn),
		.S_AXIS_TREADY(s_axis_tready),
		.S_AXIS_TDATA(s_axis_tdata),
		.S_AXIS_TSTRB(s_axis_tstrb),
		.S_AXIS_TLAST(s_axis_tlast),
		.S_AXIS_TVALID(s_axis_tvalid)
	);

	MASK_v1_0_M_AXIS # ( 
	    .MAX_WINDOW_SIZE(MAX_WINDOW_SIZE),
		.C_M_AXIS_TDATA_WIDTH(C_M_AXIS_TDATA_WIDTH),
		.C_M_START_COUNT(C_M_AXIS_START_COUNT)
	) MASK_v1_0_M_AXIS_inst (
	    .DATA_IN(masked_data),
	    .VALID_IN(valid),
	    .LAST_IN(last),
		.M_AXIS_ACLK(m_axis_aclk),
		.M_AXIS_ARESETN(m_axis_aresetn),
		.M_AXIS_TVALID(m_axis_tvalid),
		.M_AXIS_TDATA(m_axis_tdata),
		.M_AXIS_TSTRB(m_axis_tstrb),
		.M_AXIS_TLAST(m_axis_tlast),
		.M_AXIS_TREADY(m_axis_tready)
	);


	endmodule
