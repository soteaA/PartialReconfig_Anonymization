
`timescale 1 ns / 1 ps

	module SWAP_v1_0_M_AXIS #
	(
	    parameter integer ADDR_WIDTH = 5,
	    parameter integer MAX_WINDOW_SIZE = 32,
	    
		parameter integer C_M_AXIS_TDATA_WIDTH	= 32,
		parameter integer C_M_START_COUNT	= 32
	)
	(
	    input wire [C_M_AXIS_TDATA_WIDTH-1 : 0] DATA_IN,
	    input wire [ADDR_WIDTH-1 : 0] ADDR_IN,
	    input wire VALID_IN,
	    input wire LAST_IN,
	    
		input wire  M_AXIS_ACLK,
		input wire  M_AXIS_ARESETN,
		output wire  M_AXIS_TVALID,
		output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] M_AXIS_TDATA,
		output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] M_AXIS_TSTRB,
		output wire  M_AXIS_TLAST,
		input wire  M_AXIS_TREADY
	);
	localparam NUMBER_OF_OUTPUT_WORDS = 32;  //MAX_WINDOW_SIZE                                               
	                                                                                     
	function integer clogb2 (input integer bit_depth);                                   
	  begin                                                                              
	    for(clogb2=0; bit_depth>0; clogb2=clogb2+1)                                      
	      bit_depth = bit_depth >> 1;                                                    
	  end                                                                                
	endfunction                                                                          
	                                                                                    
	localparam bit_num  = clogb2(NUMBER_OF_OUTPUT_WORDS-1);                                
	                                                                                     
	parameter [1:0] DATA_WRITE = 2'b01, SEND_STREAM = 2'b10;    
	reg [1:0] mst_exec_state;
	
	/*
	*  All the parameters down here are meant to be related to the FIFO
	*
	*** How are those parameters used in the program?? ***
	*
	*  write_pointer : pointing out where the incoming data should be written
	*  read_pointer : pointing out which data should be read out
	*  real_data_num : the total number of data that are written and should be read out
	*/
	reg [C_M_AXIS_TDATA_WIDTH-1 : 0] fifo [MAX_WINDOW_SIZE-1:0];   
//	reg [bit_num-1:0] write_pointer;                                                         
	reg [bit_num-1:0] read_pointer;  

	wire  	axis_tvalid;
	reg  	axis_tvalid_delay;
	wire  	axis_tlast;
	reg  	axis_tlast_delay;
	reg [C_M_AXIS_TDATA_WIDTH-1 : 0] stream_data_out;
	
	wire write_en;
	wire write_done;
	wire tx_en;
	wire tx_done;

/*
*   STATE_MACHINE_DESCRIPTION
*/
	always @(posedge M_AXIS_ACLK) begin                                                                     
	  if (!M_AXIS_ARESETN) begin                                                                 
	      mst_exec_state <= DATA_WRITE;                                                                                               
	  end else                                                                    
	    case (mst_exec_state)                                                 
	      DATA_WRITE:                                                       
	        if (write_done) begin                                                           
	            mst_exec_state <= SEND_STREAM;                               
	        end else begin                                                    
	            mst_exec_state <= DATA_WRITE;                              
	        end                                                             
	                                                                          
	      SEND_STREAM:                                                        
	        if (tx_done) begin                                                           
	            mst_exec_state <= DATA_WRITE;                                       
	        end else begin                                                           
	            mst_exec_state <= SEND_STREAM;                                
	        end                                                             
	    endcase                                                               
	end         
/*
*   STATE_MACHINE_DESCRIPTION ENDS HERE
*/     
	
/*
*   DATA_WRITE_INTO_THE_FIFO
*/   
	always @(posedge M_AXIS_ACLK) begin
	   if (!M_AXIS_ARESETN) begin 
	       fifo[0] <= 0;
	   end else begin
	       if (write_en) begin
	           fifo[ADDR_IN] <= DATA_IN;
	      end else begin
	           fifo[0] <= fifo[0];
	      end
	   end
    end         
/*
*   DATA_WRITE PHASE ENDS HERE
*/                     

/*                                                              
*   SEND_STREAM_DATA
*/
    always @(posedge M_AXIS_ACLK) begin
        if (!M_AXIS_ARESETN) begin
            read_pointer <= 0;
        end else begin
            if (tx_en && read_pointer <  MAX_WINDOW_SIZE - 1) begin
                read_pointer <= read_pointer + 1;
                stream_data_out <= fifo[read_pointer];
            end else if (tx_en && read_pointer ==  MAX_WINDOW_SIZE - 1) begin
                read_pointer <= 0;
                stream_data_out <= fifo[read_pointer];
            end else begin
                read_pointer <= read_pointer;
            end
        end
    end
/*
*   SEND_STREAM_DATA PHASE ENDS HERE
*/
	                                                                                               
	                                                                                               
	always @(posedge M_AXIS_ACLK) begin                                                                                          
	  if (!M_AXIS_ARESETN) begin                                                                                      
	      axis_tvalid_delay <= 1'b0;                                                               
	      axis_tlast_delay <= 1'b0;                                                                
	  end else begin                                                                                      
	      axis_tvalid_delay <= axis_tvalid;                                                        
	      axis_tlast_delay <= axis_tlast;                                                          
	  end                                                                                        
	end                                                                                                                                                     

    assign M_AXIS_TVALID = axis_tvalid_delay;
	assign M_AXIS_TDATA	= stream_data_out;
	assign M_AXIS_TLAST	= axis_tlast_delay;
	assign M_AXIS_TSTRB	= {(C_M_AXIS_TDATA_WIDTH/8){1'b1}};
	assign axis_tvalid = ((mst_exec_state == SEND_STREAM) & (read_pointer <= MAX_WINDOW_SIZE - 1));
    assign axis_tlast = tx_en & (read_pointer == MAX_WINDOW_SIZE - 1); 
    
    assign write_en = (mst_exec_state == DATA_WRITE) & VALID_IN;
    assign write_done = write_en & LAST_IN;
    
	assign tx_en = M_AXIS_TREADY & axis_tvalid; 
	assign tx_done = axis_tlast;  
	   
	endmodule
