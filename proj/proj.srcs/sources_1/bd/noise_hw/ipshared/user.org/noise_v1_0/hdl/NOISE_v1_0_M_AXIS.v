
`timescale 1 ns / 1 ps

	module NOISE_v1_0_M_AXIS #
	(
	    parameter integer COUNT_WIDTH = 5,
        parameter integer REG_DEPTH = 32,
        parameter integer REG_ADDR = 5,
	    
		parameter integer C_M_AXIS_TDATA_WIDTH	= 32,
		parameter integer C_M_START_COUNT	= 32
	)
	(
	    input wire loadseed_i,
	    input wire [C_M_AXIS_TDATA_WIDTH-1 : 0] seed_i,
	    input wire [C_M_AXIS_TDATA_WIDTH-1 : 0] DATA_IN,
	    input wire VALID_IN,
	    input wire LAST_IN,
	    input wire [COUNT_WIDTH-1 : 0] COUNT_IN,
	    
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
	                                                                                    
	localparam bit_num  = clogb2(NUMBER_OF_OUTPUT_WORDS-1);                                
	                                                                                     
	parameter [1:0] PROC_DATA_WRITE = 2'b01, SEND_STREAM = 2'b10;    
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
	reg [C_M_AXIS_TDATA_WIDTH-1 : 0] fifo [REG_DEPTH-1:0];   
	reg [bit_num-1:0] write_pointer;                                                         
	reg [bit_num-1:0] read_pointer;  
	reg [REG_ADDR-1:0] real_data_num;                                                      

	wire  	axis_tvalid;
	reg  	axis_tvalid_delay;
	wire  	axis_tlast;
	reg  	axis_tlast_delay;
	reg [C_M_AXIS_TDATA_WIDTH-1 : 0] stream_data_out;
	
	wire data_wren;
	wire write_done;
	wire tx_en;
	wire tx_done;
	
	wire [C_M_AXIS_TDATA_WIDTH-1 : 0] mask;
	wire [C_M_AXIS_TDATA_WIDTH-1 : 0] masked_rnd;
	
	reg [42:0] LFSR_reg;
    reg [36:0] CASR_reg;
    reg loadseed_flag;
    
//CASR:
always @(posedge M_AXIS_ACLK) begin
   if (!M_AXIS_ARESETN) begin
      CASR_reg <= (1);
      loadseed_flag <= 0;
   end else begin
      if (loadseed_i && !loadseed_flag) begin
         CASR_reg <= {5'b10101, seed_i};
         loadseed_flag <= 1;
      end else begin
         CASR_reg [36]<=CASR_reg [35]^CASR_reg [0];
         CASR_reg [35]<=CASR_reg [34]^CASR_reg [36];
         CASR_reg [34]<=CASR_reg [33]^CASR_reg [35];
         CASR_reg [33]<=CASR_reg [32]^CASR_reg [34];
         CASR_reg [32]<=CASR_reg [31]^CASR_reg [33];
         CASR_reg [31]<=CASR_reg [30]^CASR_reg [32];
         CASR_reg [30]<=CASR_reg [29]^CASR_reg [31];
         CASR_reg [29]<=CASR_reg [28]^CASR_reg [30];
         CASR_reg [28]<=CASR_reg [27]^CASR_reg [29];
         CASR_reg [27]<=CASR_reg [26]^CASR_reg [27]^CASR_reg [28];
         CASR_reg [26]<=CASR_reg [25]^CASR_reg [27];
         CASR_reg [25]<=CASR_reg [24]^CASR_reg [26];
         CASR_reg [24]<=CASR_reg [23]^CASR_reg [25];
         CASR_reg [23]<=CASR_reg [22]^CASR_reg [24];
         CASR_reg [22]<=CASR_reg [21]^CASR_reg [23];
         CASR_reg [21]<=CASR_reg [20]^CASR_reg [22];
         CASR_reg [20]<=CASR_reg [19]^CASR_reg [21];
         CASR_reg [19]<=CASR_reg [18]^CASR_reg [20];
         CASR_reg [18]<=CASR_reg [17]^CASR_reg [19];
         CASR_reg [17]<=CASR_reg [16]^CASR_reg [18];
         CASR_reg [16]<=CASR_reg [15]^CASR_reg [17];
         CASR_reg [15]<=CASR_reg [14]^CASR_reg [16];
         CASR_reg [14]<=CASR_reg [13]^CASR_reg [15];
         CASR_reg [13]<=CASR_reg [12]^CASR_reg [14];
         CASR_reg [12]<=CASR_reg [11]^CASR_reg [13];
         CASR_reg [11]<=CASR_reg [10]^CASR_reg [12];
         CASR_reg [10]<=CASR_reg [9]^CASR_reg [11];
         CASR_reg [9]<=CASR_reg [8]^CASR_reg [10];
         CASR_reg [8]<=CASR_reg [7]^CASR_reg [9];
         CASR_reg [7]<=CASR_reg [6]^CASR_reg [8];
         CASR_reg [6]<=CASR_reg [5]^CASR_reg [7];
         CASR_reg [5]<=CASR_reg [4]^CASR_reg [6];
         CASR_reg [4]<=CASR_reg [3]^CASR_reg [5];
         CASR_reg [3]<=CASR_reg [2]^CASR_reg [4];
         CASR_reg [2]<=CASR_reg [1]^CASR_reg [3];
         CASR_reg [1]<=CASR_reg [0]^CASR_reg [2];
         CASR_reg [0]<=CASR_reg [36]^CASR_reg [1];
    
      end
   end
end
    
    
//LFSR:
reg outbitLFSR;
always @(posedge M_AXIS_ACLK) begin
   if (!M_AXIS_ARESETN) begin
      LFSR_reg <= (1);
   end else begin
      if (loadseed_i && !loadseed_flag) begin
         LFSR_reg <= {7'b1101101, seed_i, 4'b1010};
      end else begin

         outbitLFSR <=LFSR_reg [42];
         LFSR_reg [42]<=LFSR_reg [41];
         LFSR_reg [41]<=LFSR_reg [40]^outbitLFSR ;
         LFSR_reg [40]<=LFSR_reg [39];
         LFSR_reg [39]<=LFSR_reg [38];
         LFSR_reg [38]<=LFSR_reg [37];
         LFSR_reg [37]<=LFSR_reg [36];
         LFSR_reg [36]<=LFSR_reg [35];
         LFSR_reg [35]<=LFSR_reg [34];
         LFSR_reg [34]<=LFSR_reg [33];
         LFSR_reg [33]<=LFSR_reg [32];
         LFSR_reg [32]<=LFSR_reg [31];
         LFSR_reg [31]<=LFSR_reg [30];
         LFSR_reg [30]<=LFSR_reg [29];
         LFSR_reg [29]<=LFSR_reg [28];
         LFSR_reg [28]<=LFSR_reg [27];
         LFSR_reg [27]<=LFSR_reg [26];
         LFSR_reg [26]<=LFSR_reg [25];
         LFSR_reg [25]<=LFSR_reg [24];
         LFSR_reg [24]<=LFSR_reg [23];
         LFSR_reg [23]<=LFSR_reg [22];
         LFSR_reg [22]<=LFSR_reg [21];
         LFSR_reg [21]<=LFSR_reg [20];
         LFSR_reg [20]<=LFSR_reg [19]^outbitLFSR ;
         LFSR_reg [19]<=LFSR_reg [18];
         LFSR_reg [18]<=LFSR_reg [17];
         LFSR_reg [17]<=LFSR_reg [16];
         LFSR_reg [16]<=LFSR_reg [15];
         LFSR_reg [15]<=LFSR_reg [14];
         LFSR_reg [14]<=LFSR_reg [13];
         LFSR_reg [13]<=LFSR_reg [12];
         LFSR_reg [12]<=LFSR_reg [11];
         LFSR_reg [11]<=LFSR_reg [10];
         LFSR_reg [10]<=LFSR_reg [9];
         LFSR_reg [9]<=LFSR_reg [8];
         LFSR_reg [8]<=LFSR_reg [7];
         LFSR_reg [7]<=LFSR_reg [6];
         LFSR_reg [6]<=LFSR_reg [5];
         LFSR_reg [5]<=LFSR_reg [4];
         LFSR_reg [4]<=LFSR_reg [3];
         LFSR_reg [3]<=LFSR_reg [2];
         LFSR_reg [2]<=LFSR_reg [1];
         LFSR_reg [1]<=LFSR_reg [0]^outbitLFSR ;
         LFSR_reg [0]<=LFSR_reg [42];
 
      end
   end
end

/*
*   STATE_MACHINE_DESCRIPTION
*/
	always @(posedge M_AXIS_ACLK) begin                                                                     
	  if (!M_AXIS_ARESETN) begin                                                                 
	      mst_exec_state <= PROC_DATA_WRITE;                                                                                               
	  end else                                                                    
	    case (mst_exec_state)                                                 
	      PROC_DATA_WRITE:                                                       
	        if (write_done) begin                                                           
	            mst_exec_state <= SEND_STREAM;                               
	        end else begin                                                    
	            mst_exec_state <= PROC_DATA_WRITE;                              
	        end                                                             
	                                                                          
	      SEND_STREAM:                                                        
	        if (tx_done) begin                                                           
	            mst_exec_state <= PROC_DATA_WRITE;                                       
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
	       write_pointer <= 0;
	       real_data_num <= 0;
	   end else begin
	       if (data_wren && !LAST_IN) begin
	           write_pointer <= write_pointer + 1;
	       end else if (data_wren && LAST_IN) begin
	           real_data_num <= write_pointer;
	           write_pointer <= 0;
	       end else begin
	           write_pointer <= write_pointer;
	       end
	   end
    end
    
    always @(posedge M_AXIS_ACLK) begin
        if (!M_AXIS_ARESETN) begin
            fifo[0] <= 32'h0;
        end else begin
            if (data_wren) begin
                fifo[write_pointer] <= DATA_IN + masked_rnd;
            end else begin
                fifo[write_pointer] <= fifo[write_pointer];
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
            if (tx_en && read_pointer < real_data_num) begin
                read_pointer <= read_pointer + 1;
                stream_data_out <= fifo[read_pointer];
            end else if (tx_en && read_pointer == real_data_num) begin
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
	assign axis_tvalid = ((mst_exec_state == SEND_STREAM) & (read_pointer <= real_data_num));
    assign axis_tlast = tx_en & (read_pointer == real_data_num); 
    
    assign mask = 32'hffff_ffff >> COUNT_IN;
    assign masked_rnd = (LFSR_reg [31:0]^CASR_reg[31:0]) & mask;
    
    assign data_wren = (mst_exec_state == PROC_DATA_WRITE) & VALID_IN;
    assign write_done = data_wren & LAST_IN;
    
	assign tx_en = M_AXIS_TREADY & axis_tvalid; 
	assign tx_done = axis_tlast;  
	   
	endmodule
