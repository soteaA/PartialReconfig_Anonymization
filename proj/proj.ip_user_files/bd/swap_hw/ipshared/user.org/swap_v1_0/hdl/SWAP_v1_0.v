
`timescale 1 ns / 1 ps

	module SWAP_v1_0 #
	(
		parameter integer ADDR_WIDTH = 5,
		parameter integer C_S_AXIS_TDATA_WIDTH	= 32,

        parameter integer MAX_WINDOW_SIZE = 32,
		parameter integer C_M_AXIS_TDATA_WIDTH	= 32,
		parameter integer C_M_AXIS_START_COUNT	= 32
	)
	(
	    input wire loadseed_i,
	    input wire [C_S_AXIS_TDATA_WIDTH-1 : 0] seed_i,
	    
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
	
	 wire [C_S_AXIS_TDATA_WIDTH-1 : 0] rand_num;
	wire [C_S_AXIS_TDATA_WIDTH-1 : 0] mid_data;
	wire [ADDR_WIDTH-1 : 0] mid_addr;
	wire mid_valid;
	wire mid_last;

    RAND # (
        .DATA_WIDTH(C_S_AXIS_TDATA_WIDTH)
    ) RAND_0 (
        .clk(s_axis_aclk),
        .rst_n(s_axis_aresetn),
        .loadseed_i(loadseed_i),
        .seed_i(seed_i),
        .rand_num(rand_num)
    );
    
	SWAP_v1_0_S_AXIS # ( 
	    .ADDR_WIDTH(ADDR_WIDTH),
		.C_S_AXIS_TDATA_WIDTH(C_S_AXIS_TDATA_WIDTH)
	) SWAP_v1_0_S_AXIS_inst (
	    .RAND_NUM(rand_num),
	    .DATA_OUT(mid_data),
	    .ADDR_OUT(mid_addr),
	    .VALID_OUT(mid_valid),
	    .LAST_OUT(mid_last),
	    
		.S_AXIS_ACLK(s_axis_aclk),
		.S_AXIS_ARESETN(s_axis_aresetn),
		.S_AXIS_TREADY(s_axis_tready),
		.S_AXIS_TDATA(s_axis_tdata),
		.S_AXIS_TSTRB(s_axis_tstrb),
		.S_AXIS_TLAST(s_axis_tlast),
		.S_AXIS_TVALID(s_axis_tvalid)
	);

	SWAP_v1_0_M_AXIS # ( 
	    .ADDR_WIDTH(ADDR_WIDTH),
	    .MAX_WINDOW_SIZE(MAX_WINDOW_SIZE),
	    
		.C_M_AXIS_TDATA_WIDTH(C_M_AXIS_TDATA_WIDTH),
		.C_M_START_COUNT(C_M_AXIS_START_COUNT)
	) SWAP_v1_0_M_AXIS_inst (
	    .DATA_IN(mid_data),
	    .ADDR_IN(mid_addr),
	    .VALID_IN(mid_valid),
	    .LAST_IN(mid_last),
	    
		.M_AXIS_ACLK(m_axis_aclk),
		.M_AXIS_ARESETN(m_axis_aresetn),
		.M_AXIS_TVALID(m_axis_tvalid),
		.M_AXIS_TDATA(m_axis_tdata),
		.M_AXIS_TSTRB(m_axis_tstrb),
		.M_AXIS_TLAST(m_axis_tlast),
		.M_AXIS_TREADY(m_axis_tready)
	);

	endmodule
