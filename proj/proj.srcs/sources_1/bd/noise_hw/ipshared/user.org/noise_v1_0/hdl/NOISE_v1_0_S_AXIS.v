
`timescale 1 ns / 1 ps

	module NOISE_v1_0_S_AXIS #
	(
	    parameter integer COUNT_WIDTH = 5,
	    parameter integer REG_DEPTH = 32,
	    parameter integer REG_ADDR = 5,
	    
		parameter integer C_S_AXIS_TDATA_WIDTH	= 32
	)
	(
	    output reg [C_S_AXIS_TDATA_WIDTH-1 : 0] DATA_OUT,
	    output reg VALID_OUT,
	    output reg LAST_OUT,
	    output reg [COUNT_WIDTH-1 : 0] COUNT_OUT,
	    
	    input wire  S_AXIS_ACLK,
		input wire  S_AXIS_ARESETN,
		output wire  S_AXIS_TREADY,
		input wire [C_S_AXIS_TDATA_WIDTH-1 : 0] S_AXIS_TDATA,
		input wire [(C_S_AXIS_TDATA_WIDTH/8)-1 : 0] S_AXIS_TSTRB,
		input wire  S_AXIS_TLAST,
		input wire  S_AXIS_TVALID
	);
	
	/*
	* these are the buffers for storing the incoming / processed data
	*
	* data_fifo for data, count_fifo for count(= how much do you right-shift?)
	*/
	    reg [C_S_AXIS_TDATA_WIDTH-1:0] data_fifo [REG_DEPTH-1:0];
        reg [COUNT_WIDTH-1:0] count_reg [REG_DEPTH-1:0];
        
        reg [REG_ADDR-1:0] wr_addr, rd_addr, out_addr;
        reg [REG_ADDR-1:0] real_data_num;
        wire [C_S_AXIS_TDATA_WIDTH-1:0] mid_data0, mid_data1, mid_data2, mid_data3, mid_data4, mid_data5, mid_data6, mid_data7;
        wire [C_S_AXIS_TDATA_WIDTH-1:0] mid_data8, mid_data9, mid_data10, mid_data11, mid_data12, mid_data13, mid_data14, mid_data15;
        wire [C_S_AXIS_TDATA_WIDTH-1:0] mid_data16, mid_data17, mid_data18, mid_data19, mid_data20, mid_data21, mid_data22, mid_data23;
        wire [C_S_AXIS_TDATA_WIDTH-1:0] mid_data24, mid_data25, mid_data26, mid_data27, mid_data28, mid_data29, mid_data30, mid_data31;
        wire [C_S_AXIS_TDATA_WIDTH-1:0] msb_all;
//        wire [DATA_W-1:0] d_mem0, d_mem1, d_mem2, d_mem3, d_mem4, d_mem5, d_mem6, d_mem7;
//        wire [DATA_W-1:0] c_mem0, c_mem1, c_mem2, c_mem3, c_mem4, c_mem5, c_mem6, c_mem7;
    
//        reg [COUNT_WIDTH-1:0] tmp_count;
    
        wire detect_done;
    
        wire wren;
        wire write_done;
        wire proc_en;
        wire proc_done;
        wire out_en;
        wire out_done;
        
	function integer clogb2 (input integer bit_depth);
	  begin
	    for(clogb2=0; bit_depth>0; clogb2=clogb2+1)
	      bit_depth = bit_depth >> 1;
	  end
	endfunction

	parameter [1:0] IDLE = 2'b00, WRITE_FIFO = 2'b01, PROC = 2'b10, OUTPUT = 2'b11;
	reg [1:0] mst_exec_state;
	
	wire axis_tready;
	
	always @(posedge S_AXIS_ACLK) begin  
	  if (!S_AXIS_ARESETN) begin
	      mst_exec_state <= IDLE;
	  end else
	    case (mst_exec_state)
	      IDLE: 
	        if (S_AXIS_TVALID) begin
	            mst_exec_state <= WRITE_FIFO;
	        end else begin
	            mst_exec_state <= IDLE;
	        end
	      WRITE_FIFO: 
	        if (write_done) begin
	            mst_exec_state <= PROC;
	        end else begin
	            mst_exec_state <= WRITE_FIFO;
	        end
	        
	      PROC:
	        if (proc_done) begin
	           mst_exec_state <= OUTPUT;
	        end else begin
	           mst_exec_state <= PROC;
	        end
	        
	      OUTPUT:
	        if (out_done) begin
	           mst_exec_state <= IDLE;
	        end else begin
	           mst_exec_state <= OUTPUT;
	        end
	        
	    endcase
	end
	
	/*
	*  WRITING DATA INTO THE FIFO
	*/
	always @(posedge S_AXIS_ACLK) begin
	   if (!S_AXIS_ARESETN) begin
	       wr_addr <= 0;
           real_data_num <= 0;
	   end else begin
	       if (wren && !S_AXIS_TLAST) begin
	           data_fifo[wr_addr] <= S_AXIS_TDATA;
               wr_addr <= wr_addr + 1;
           end else if (wren && S_AXIS_TLAST) begin
               data_fifo[wr_addr] <= S_AXIS_TDATA;
               real_data_num <= wr_addr;
               wr_addr <= 0;
	       end else begin
	           wr_addr <= wr_addr;
	       end
	   end
	end
	
	/*
	*  PROCESSING DATA AND DETERMINE 'COUNT'
	*/
	always @(posedge S_AXIS_ACLK) begin
	   if (!S_AXIS_ARESETN) begin
	       count_reg[0] <= 0;
	       count_reg[1] <= 0;
	       count_reg[2] <= 0;
	       count_reg[3] <= 0;
	       count_reg[4] <= 0;
	       count_reg[5] <= 0;
	       count_reg[6] <= 0;
	       count_reg[7] <= 0;
	       count_reg[8] <= 0;
	       count_reg[9] <= 0;
	       count_reg[10] <= 0;
	       count_reg[11] <= 0;
	       count_reg[12] <= 0;
	       count_reg[13] <= 0;
	       count_reg[14] <= 0;
	       count_reg[15] <= 0;
	       count_reg[16] <= 0;
	       count_reg[17] <= 0;
	       count_reg[18] <= 0;
	       count_reg[19] <= 0;
	       count_reg[20] <= 0;
	       count_reg[21] <= 0;
	       count_reg[22] <= 0;
	       count_reg[23] <= 0;
	       count_reg[24] <= 0;
	       count_reg[25] <= 0;
	       count_reg[26] <= 0;
	       count_reg[27] <= 0;
	       count_reg[28] <= 0;
	       count_reg[29] <= 0;
	       count_reg[30] <= 0;
	       count_reg[31] <= 0;         
	   end else begin
	       if (!detect_done && proc_en) begin
	           count_reg[0] <= (mid_data0[31]) ? count_reg[0] : count_reg[0] + 1;
	           count_reg[1] <= (mid_data1[31]) ? count_reg[1] : count_reg[1] + 1;
	           count_reg[2] <= (mid_data2[31]) ? count_reg[2] : count_reg[2] + 1;
	           count_reg[3] <= (mid_data3[31]) ? count_reg[3] : count_reg[3] + 1;
	           count_reg[4] <= (mid_data4[31]) ? count_reg[4] : count_reg[4] + 1;
	           count_reg[5] <= (mid_data5[31]) ? count_reg[5] : count_reg[5] + 1;
	           count_reg[6] <= (mid_data6[31]) ? count_reg[6] : count_reg[6] + 1;
	           count_reg[7] <= (mid_data7[31]) ? count_reg[7] : count_reg[7] + 1;
	           count_reg[8] <= (mid_data8[31]) ? count_reg[8] : count_reg[8] + 1;
	           count_reg[9] <= (mid_data9[31]) ? count_reg[9] : count_reg[9] + 1;
	           count_reg[10] <= (mid_data10[31]) ? count_reg[10] : count_reg[10] + 1;
	           count_reg[11] <= (mid_data11[31]) ? count_reg[11] : count_reg[11] + 1;
	           count_reg[12] <= (mid_data12[31]) ? count_reg[12] : count_reg[12] + 1;
	           count_reg[13] <= (mid_data13[31]) ? count_reg[13] : count_reg[13] + 1;
	           count_reg[14] <= (mid_data14[31]) ? count_reg[14] : count_reg[14] + 1;
	           count_reg[15] <= (mid_data15[31]) ? count_reg[15] : count_reg[15] + 1;
	           count_reg[16] <= (mid_data16[31]) ? count_reg[16] : count_reg[16] + 1;
	           count_reg[17] <= (mid_data17[31]) ? count_reg[17] : count_reg[17] + 1;
	           count_reg[18] <= (mid_data18[31]) ? count_reg[18] : count_reg[18] + 1;
	           count_reg[19] <= (mid_data19[31]) ? count_reg[19] : count_reg[19] + 1;
	           count_reg[20] <= (mid_data20[31]) ? count_reg[20] : count_reg[20] + 1;
	           count_reg[21] <= (mid_data21[31]) ? count_reg[21] : count_reg[21] + 1;
	           count_reg[22] <= (mid_data22[31]) ? count_reg[22] : count_reg[22] + 1;
	           count_reg[23] <= (mid_data23[31]) ? count_reg[23] : count_reg[23] + 1;
	           count_reg[24] <= (mid_data24[31]) ? count_reg[24] : count_reg[24] + 1;
	           count_reg[25] <= (mid_data25[31]) ? count_reg[25] : count_reg[25] + 1;
	           count_reg[26] <= (mid_data26[31]) ? count_reg[26] : count_reg[26] + 1;
	           count_reg[27] <= (mid_data27[31]) ? count_reg[27] : count_reg[27] + 1;
	           count_reg[28] <= (mid_data28[31]) ? count_reg[28] : count_reg[28] + 1;
	           count_reg[29] <= (mid_data29[31]) ? count_reg[29] : count_reg[29] + 1;
	           count_reg[30] <= (mid_data30[31]) ? count_reg[30] : count_reg[30] + 1;
	           count_reg[31] <= (mid_data31[31]) ? count_reg[31] : count_reg[31] + 1;
	       end else begin
	           count_reg[0] <= count_reg[0];
	       end
	   end
    end
    
    assign mid_data0 = data_fifo[0] << count_reg[0];
    assign mid_data1 = data_fifo[1] << count_reg[1];
    assign mid_data2 = data_fifo[2] << count_reg[2];
    assign mid_data3 = data_fifo[3] << count_reg[3];
    assign mid_data4 = data_fifo[4] << count_reg[4];
    assign mid_data5 = data_fifo[5] << count_reg[5];
    assign mid_data6 = data_fifo[6] << count_reg[6];
    assign mid_data7 = data_fifo[7] << count_reg[7];
    assign mid_data8 = data_fifo[8] << count_reg[8];
    assign mid_data9 = data_fifo[9] << count_reg[9];
    assign mid_data10 = data_fifo[10] << count_reg[10];
    assign mid_data11 = data_fifo[11] << count_reg[11];
    assign mid_data12 = data_fifo[12] << count_reg[12];
    assign mid_data13 = data_fifo[13] << count_reg[13];
    assign mid_data14 = data_fifo[14] << count_reg[14];
    assign mid_data15 = data_fifo[15] << count_reg[15];
    assign mid_data16 = data_fifo[16] << count_reg[16];
    assign mid_data17 = data_fifo[17] << count_reg[17];
    assign mid_data18 = data_fifo[18] << count_reg[18];
    assign mid_data19 = data_fifo[19] << count_reg[19];
    assign mid_data20 = data_fifo[20] << count_reg[20];
    assign mid_data21 = data_fifo[21] << count_reg[21];
    assign mid_data22 = data_fifo[22] << count_reg[22];
    assign mid_data23 = data_fifo[23] << count_reg[23];
    assign mid_data24 = data_fifo[24] << count_reg[24];
    assign mid_data25 = data_fifo[25] << count_reg[25];
    assign mid_data26 = data_fifo[26] << count_reg[26];
    assign mid_data27 = data_fifo[27] << count_reg[27];
    assign mid_data28 = data_fifo[28] << count_reg[28];
    assign mid_data29 = data_fifo[29] << count_reg[29];
    assign mid_data30 = data_fifo[30] << count_reg[30];
    assign mid_data31 = data_fifo[31] << count_reg[31];
    
    assign detect_done = & msb_all;
	assign msb_all = {mid_data0[31], mid_data1[31], mid_data2[31], mid_data3[31], mid_data4[31], mid_data5[31], mid_data6[31], mid_data7[31], 
	                  mid_data8[31], mid_data9[31], mid_data10[31], mid_data11[31], mid_data12[31], mid_data13[31], mid_data14[31], mid_data15[31], 
	                  mid_data16[31], mid_data17[31], mid_data18[31], mid_data19[31], mid_data20[31], mid_data21[31], mid_data22[31], mid_data23[31], 
	                  mid_data24[31], mid_data25[31], mid_data26[31], mid_data27[31], mid_data28[31], mid_data29[31], mid_data30[31], mid_data31[31]};
    
    /*
    *   OUTPUT THE DATA TO THE MASTER INTERFACE
    */
    always @(posedge S_AXIS_ACLK) begin
        if (!S_AXIS_ARESETN) begin
            out_addr <= 0;
        end else begin
            if (out_en && out_addr < real_data_num) begin
                DATA_OUT <= data_fifo[out_addr];
                VALID_OUT <= 1;
                COUNT_OUT <= count_reg[out_addr] + 1;
                LAST_OUT <= 0;
                out_addr <= out_addr + 1;
            end else if (out_en && out_addr == real_data_num) begin
                DATA_OUT <= data_fifo[out_addr];
                VALID_OUT <= 1;
                COUNT_OUT <= count_reg[out_addr] + 1;
                LAST_OUT <= 1;
                out_addr <= 0;
            end else begin
                out_addr <= out_addr;
                VALID_OUT <= 0;
                LAST_OUT <= 0;
            end
        end
    end
	     
	assign S_AXIS_TREADY = axis_tready;
	assign axis_tready = (mst_exec_state == WRITE_FIFO);
	
	assign wren = S_AXIS_TVALID && axis_tready;
	assign write_done = (wren & S_AXIS_TLAST);
	
	assign proc_en = (mst_exec_state == PROC);
    assign proc_done = (proc_en & detect_done);

    assign out_en = (mst_exec_state == OUTPUT);
    assign out_done = out_en & (out_addr == real_data_num);

	endmodule
