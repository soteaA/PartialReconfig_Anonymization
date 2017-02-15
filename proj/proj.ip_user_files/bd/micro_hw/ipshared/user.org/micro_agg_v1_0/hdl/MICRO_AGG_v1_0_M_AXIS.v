
`timescale 1 ns / 1 ps

	module MICRO_AGG_v1_0_M_AXIS #
	(
	    parameter integer K_SIZE = 8,  
	    
		parameter integer C_M_AXIS_TDATA_WIDTH	= 32,
		parameter integer C_M_START_COUNT	= 32
	)
	(
		input wire  [C_M_AXIS_TDATA_WIDTH-1 : 0] MICRO_IN,
        input wire MICRO_VALID_IN,
        input wire MICRO_LAST_IN,
		// Do not modify the ports beyond this line
        input wire  M_AXIS_ACLK,
		input wire  M_AXIS_ARESETN,
		output wire  M_AXIS_TVALID,
		output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] M_AXIS_TDATA,
		output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] M_AXIS_TSTRB,
		output wire  M_AXIS_TLAST,
		input wire  M_AXIS_TREADY
	);
	localparam NUMBER_OF_OUTPUT_WORDS = 32;                                               
	                                                                                     
	function integer clogb2 (input integer bit_depth);                                   
	  begin                                                                              
	    for(clogb2=0; bit_depth>0; clogb2=clogb2+1)                                      
	      bit_depth = bit_depth >> 1;                                                    
	  end                                                                                
	endfunction                                                                          
	                                                                                     
	localparam bit_num  = clogb2(NUMBER_OF_OUTPUT_WORDS - 1);                                
	                                                                                     
	parameter [1:0] IDLE = 2'b00, SEND_STREAM = 2'b01; 
	reg [1:0] mst_exec_state;                                                            
	reg [bit_num-1:0] write_pointer, read_pointer;                                                      
	
	wire  	axis_tvalid;
	reg  	axis_tvalid_delay;
	wire  	axis_tlast;
	reg  	axis_tlast_delay;
	reg [C_M_AXIS_TDATA_WIDTH-1 : 0] stream_data_out;
	wire  	fifo_wren, tx_en;
	reg write_done, tx_done;
	reg  [C_M_AXIS_TDATA_WIDTH-1 : 0] add_in_fifo [0:NUMBER_OF_OUTPUT_WORDS-1];

	always @(posedge M_AXIS_ACLK) begin                                                                     
	  if (!M_AXIS_ARESETN) begin                                                                 
	      mst_exec_state <= IDLE;                                                        
	  end else                                                                    
	    case (mst_exec_state)                                                 
	      IDLE:                                                               
	        if(write_done) begin                                                 
	            mst_exec_state  <= SEND_STREAM;                              
	        end else begin
	           mst_exec_state <= IDLE;
	        end
	                                                             
	      SEND_STREAM:                                                        
	        if (tx_done) begin                                                           
	            mst_exec_state <= IDLE;                                       
	        end else begin                                                           
	            mst_exec_state <= SEND_STREAM;                                
	        end                                                             
	    endcase                                                               
	end                                                                       

   always@(posedge M_AXIS_ACLK) begin
    if(!M_AXIS_ARESETN)  begin
        write_pointer <= 0;
        write_done <= 1'b0;
    end else begin
        if (write_pointer <= NUMBER_OF_OUTPUT_WORDS-1) begin
            if ((write_pointer == NUMBER_OF_OUTPUT_WORDS - K_SIZE && fifo_wren) | MICRO_LAST_IN) begin
                write_done <= 1'b1;
                write_pointer <= 0;
            end else if (fifo_wren) begin
                write_pointer <= write_pointer + K_SIZE;
                write_done <= 1'b0;
            end else begin
                write_pointer <= write_pointer;
                write_done <= 1'b0;
            end  
        end
    end
   end
    
    always @( posedge M_AXIS_ACLK ) begin
        if(!M_AXIS_ARESETN)  begin
                add_in_fifo[0] <= 100;
                add_in_fifo[1] <= 0;
                add_in_fifo[2] <= 0;
                add_in_fifo[3] <= 0;
        end else begin
            if (fifo_wren) begin
                add_in_fifo[write_pointer] <= MICRO_IN;
                add_in_fifo[write_pointer + 1] <= MICRO_IN;
                add_in_fifo[write_pointer + 2] <= MICRO_IN;
                add_in_fifo[write_pointer + 3] <= MICRO_IN;
                add_in_fifo[write_pointer + 4] <= MICRO_IN;
                add_in_fifo[write_pointer + 5] <= MICRO_IN;
                add_in_fifo[write_pointer + 6] <= MICRO_IN;
                add_in_fifo[write_pointer + 7] <= MICRO_IN;
            end else begin
                add_in_fifo[write_pointer] <= add_in_fifo[write_pointer];
            end
        end  
    end
                                   
	always @(posedge M_AXIS_ACLK) begin                                                                                          
	  if (!M_AXIS_ARESETN) begin                                                                                      
	      axis_tvalid_delay <= 1'b0;                                                               
	      axis_tlast_delay <= 1'b0;                                                                
	  end else begin                                                                                      
	      axis_tvalid_delay <= axis_tvalid;                                                        
	      axis_tlast_delay <= axis_tlast;                                                          
	  end                                                                                        
	end                                                                                            
    
    always@(posedge M_AXIS_ACLK) begin                                                                            
	  if(!M_AXIS_ARESETN) begin                                                                        
	      read_pointer <= 0;                                                         
	      tx_done <= 1'b0;                                                           
	  end else                                                                           
	    if (read_pointer <= NUMBER_OF_OUTPUT_WORDS-1) begin                                                                      
	        if (read_pointer == NUMBER_OF_OUTPUT_WORDS-1 && tx_en)  begin                                                                      
                tx_done <= 1'b1;     
                read_pointer <= 0;                                                    
            end else if (tx_en) begin                                                                  
	            read_pointer <= read_pointer + 1;                                    
	            tx_done <= 1'b0;                                                     
	        end else begin
	            read_pointer <= read_pointer;
	            tx_done <= 1'b0;
	        end                                                         
	    end                                                                        
	end                                                                              
	                                                     
	    always @( posedge M_AXIS_ACLK )                  
	    begin                                            
	      if(!M_AXIS_ARESETN) begin                                        
	          stream_data_out <= 1;                      
	      end else if (tx_en) begin                                        
	          stream_data_out <= add_in_fifo[read_pointer];   
	      end                                          
	    end                                              

	assign M_AXIS_TVALID = axis_tvalid_delay;
	assign M_AXIS_TDATA	= stream_data_out;
	assign M_AXIS_TLAST	= axis_tlast_delay;
	assign M_AXIS_TSTRB	= {(C_M_AXIS_TDATA_WIDTH/8){1'b1}};
    assign fifo_wren = ((mst_exec_state == IDLE) && MICRO_VALID_IN && (write_pointer < NUMBER_OF_OUTPUT_WORDS));
    assign axis_tvalid = ((mst_exec_state == SEND_STREAM) && (read_pointer < NUMBER_OF_OUTPUT_WORDS) && !tx_done);
    assign axis_tlast = (read_pointer == NUMBER_OF_OUTPUT_WORDS-1);                                
    assign tx_en = M_AXIS_TREADY && axis_tvalid;   
        
	endmodule
