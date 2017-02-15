
`timescale 1 ns / 1 ps

	module MASK_v1_0_S_AXIS #
	(
	    parameter integer MASK_WIDTH = 5,
		parameter integer C_S_AXIS_TDATA_WIDTH	= 32
	)
	(
	    input wire [MASK_WIDTH-1:0] MASK_LEVEL,
	    output reg [C_S_AXIS_TDATA_WIDTH-1 : 0] DATA_OUT,
	    output reg VALID_OUT,
	    output reg LAST_OUT,
	     
		input wire  S_AXIS_ACLK,
		input wire  S_AXIS_ARESETN,
		output wire  S_AXIS_TREADY,
		input wire [C_S_AXIS_TDATA_WIDTH-1 : 0] S_AXIS_TDATA,
		input wire [(C_S_AXIS_TDATA_WIDTH/8)-1 : 0] S_AXIS_TSTRB,
		input wire  S_AXIS_TLAST,
		input wire  S_AXIS_TVALID
	);
	function integer clogb2 (input integer bit_depth);
	  begin
	    for(clogb2=0; bit_depth>0; clogb2=clogb2+1)
	      bit_depth = bit_depth >> 1;
	  end
	endfunction

	parameter [1:0] IDLE = 2'b00, DATA_IN = 2'b01 ;
	reg [1:0] mst_exec_state;
	
	wire axis_tready;
	wire data_in_en;
	wire data_in_done; 
	
//	wire [MASK_WIDTH-1:0] MASK_LEVEL;
//	assign MASK_LEVEL = 5'b01000;
	
	always @(posedge S_AXIS_ACLK) begin  
	  if (!S_AXIS_ARESETN) begin
	      mst_exec_state <= IDLE;
	  end else
	    case (mst_exec_state)
	      IDLE: 
	        if (S_AXIS_TVALID) begin
	            mst_exec_state <= DATA_IN;
	        end else begin
	            mst_exec_state <= IDLE;
	        end
	      DATA_IN: 
	        if (data_in_done) begin
	            mst_exec_state <= IDLE;
	        end else begin
	            mst_exec_state <= DATA_IN;
	        end
	    endcase
	end
	
	always @(posedge S_AXIS_ACLK) begin
	   if (!S_AXIS_ARESETN) begin
	       DATA_OUT <= 32'h0;
	       VALID_OUT <= 0;
	       LAST_OUT <= 0;
	   end else begin
	       if (data_in_en) begin
	           if (S_AXIS_TLAST) LAST_OUT <= 1;
	           else LAST_OUT <= 0;
	           VALID_OUT <= 1;
	           case (MASK_LEVEL)
	           0: DATA_OUT <= S_AXIS_TDATA & 32'hffff_ffff;
	           1: DATA_OUT <= S_AXIS_TDATA & 32'hffff_fffe;
	           2: DATA_OUT <= S_AXIS_TDATA & 32'hffff_fffc;
	           3: DATA_OUT <= S_AXIS_TDATA & 32'hffff_fff8;
	           4: DATA_OUT <= S_AXIS_TDATA & 32'hffff_fff0;
	           5: DATA_OUT <= S_AXIS_TDATA & 32'hffff_ffe0;
	           6: DATA_OUT <= S_AXIS_TDATA & 32'hffff_ffc0;
	           7: DATA_OUT <= S_AXIS_TDATA & 32'hffff_ff80;
	           8: DATA_OUT <= S_AXIS_TDATA & 32'hffff_ff00;
	           9: DATA_OUT <= S_AXIS_TDATA & 32'hffff_fe00;
	           10: DATA_OUT <= S_AXIS_TDATA & 32'hffff_fc00;
	           11: DATA_OUT <= S_AXIS_TDATA & 32'hffff_f800;
	           12: DATA_OUT <= S_AXIS_TDATA & 32'hffff_f000;
	           13: DATA_OUT <= S_AXIS_TDATA & 32'hffff_e000;
	           14: DATA_OUT <= S_AXIS_TDATA & 32'hffff_c000;
	           15: DATA_OUT <= S_AXIS_TDATA & 32'hffff_8000;
	           16: DATA_OUT <= S_AXIS_TDATA & 32'hffff_0000;
	           17: DATA_OUT <= S_AXIS_TDATA & 32'hfffe_0000;
	           18: DATA_OUT <= S_AXIS_TDATA & 32'hfffc_0000;
	           19: DATA_OUT <= S_AXIS_TDATA & 32'hfff8_0000;
	           20: DATA_OUT <= S_AXIS_TDATA & 32'hfff0_0000;
	           21: DATA_OUT <= S_AXIS_TDATA & 32'hffe0_0000;
	           22: DATA_OUT <= S_AXIS_TDATA & 32'hffc0_0000;
	           23: DATA_OUT <= S_AXIS_TDATA & 32'hff80_0000;
	           24: DATA_OUT <= S_AXIS_TDATA & 32'hff00_0000;
	           25: DATA_OUT <= S_AXIS_TDATA & 32'hfe00_0000;
	           26: DATA_OUT <= S_AXIS_TDATA & 32'hfc00_0000;
	           27: DATA_OUT <= S_AXIS_TDATA & 32'hf800_0000;
	           28: DATA_OUT <= S_AXIS_TDATA & 32'hf000_0000;
	           29: DATA_OUT <= S_AXIS_TDATA & 32'he000_0000;
	           30: DATA_OUT <= S_AXIS_TDATA & 32'hc000_0000;
	           31: DATA_OUT <= S_AXIS_TDATA & 32'h8000_0000;
	           default: DATA_OUT <= 32'hffff_ffff;
	           endcase
	         end else begin
	           VALID_OUT <= 0;
	           LAST_OUT <= 0;
	         end
	       end
	     end
	     
	assign S_AXIS_TREADY = axis_tready;
	assign axis_tready = (mst_exec_state == DATA_IN);
	assign data_in_en = S_AXIS_TVALID && axis_tready;
	assign data_in_done = S_AXIS_TLAST;

	endmodule
