
`timescale 1 ns / 1 ps

	module NOISE_v1_0 #
	(
	    parameter integer COUNT_WIDTH = 5,
        parameter integer REG_DEPTH = 32,
        parameter integer REG_ADDR = 5,
           
		parameter integer C_S_AXIS_TDATA_WIDTH	= 32,

		parameter integer C_M_AXIS_TDATA_WIDTH	= 32,
		parameter integer C_M_AXIS_START_COUNT	= 32
	)
	(
	    input wire  loadseed_i,
	    input wire  [C_S_AXIS_TDATA_WIDTH-1 : 0] seed_i,
	    
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
	    
	    wire [C_S_AXIS_TDATA_WIDTH-1 : 0] DATA;
	    wire VALID;
	    wire LAST;
	    wire [COUNT_WIDTH-1 : 0] COUNT;
	    
// Instantiation of Axi Bus Interface S_AXIS
	NOISE_v1_0_S_AXIS # ( 
	    .COUNT_WIDTH(COUNT_WIDTH),
        .REG_DEPTH(REG_DEPTH),
        .REG_ADDR(REG_ADDR),
        
		.C_S_AXIS_TDATA_WIDTH(C_S_AXIS_TDATA_WIDTH)
	) NOISE_v1_0_S_AXIS_inst (
	    .DATA_OUT(DATA),
        .VALID_OUT(VALID),
        .LAST_OUT(LAST),
        .COUNT_OUT(COUNT),
        
		.S_AXIS_ACLK(s_axis_aclk),
		.S_AXIS_ARESETN(s_axis_aresetn),
		.S_AXIS_TREADY(s_axis_tready),
		.S_AXIS_TDATA(s_axis_tdata),
		.S_AXIS_TSTRB(s_axis_tstrb),
		.S_AXIS_TLAST(s_axis_tlast),
		.S_AXIS_TVALID(s_axis_tvalid)
	);

// Instantiation of Axi Bus Interface M_AXIS
	NOISE_v1_0_M_AXIS # ( 
	    .COUNT_WIDTH(COUNT_WIDTH),
        .REG_DEPTH(REG_DEPTH),
        .REG_ADDR(REG_ADDR),
            
		.C_M_AXIS_TDATA_WIDTH(C_M_AXIS_TDATA_WIDTH),
		.C_M_START_COUNT(C_M_AXIS_START_COUNT)
	) NOISE_v1_0_M_AXIS_inst (
	    .loadseed_i(loadseed_i),
        .seed_i(seed_i),
        .DATA_IN(DATA),
        .VALID_IN(VALID),
        .LAST_IN(LAST),
        .COUNT_IN(COUNT),
            
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
