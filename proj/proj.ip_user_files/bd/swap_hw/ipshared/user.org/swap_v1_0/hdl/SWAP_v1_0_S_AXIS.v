
      `timescale 1 ns / 1 ps

	   module SWAP_v1_0_S_AXIS #
	   (
            parameter integer ADDR_WIDTH = 5,
            parameter integer C_S_AXIS_TDATA_WIDTH = 32
        )
        (
            input wire [C_S_AXIS_TDATA_WIDTH-1 : 0] RAND_NUM,
            output reg [C_S_AXIS_TDATA_WIDTH-1 : 0] DATA_OUT,
            output reg [ADDR_WIDTH-1:0] ADDR_OUT,
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
    
        parameter [1:0] IDLE = 2'b00, SWAP = 2'b10;
        reg [1:0] mst_exec_state;
        
        reg [ADDR_WIDTH-1:0] addr [C_S_AXIS_TDATA_WIDTH-1 : 0];
        reg [ADDR_WIDTH-1:0] count;
        
        wire axis_tready;
        
        wire rand_en;
        wire swap_en;
        wire swap_done;

/*
*   STATE MACHINE DESCRIPTION
*/        
        always @(posedge S_AXIS_ACLK) begin  
          if (!S_AXIS_ARESETN) begin
              mst_exec_state <= IDLE;
          end else begin
            case (mst_exec_state)
              IDLE: 
                if (S_AXIS_TVALID) begin
                    mst_exec_state <= SWAP;
                end else begin
                    mst_exec_state <= IDLE;
                end
              
              SWAP: 
                if (swap_done) begin
                    mst_exec_state <= IDLE;
                end else begin
                    mst_exec_state <= SWAP;
                end
             
             endcase
          end
        end
/*
*   STATE MACHINE DESCRIPTION UNTIL HERE
*/
       
/*
*	GET THE RANDOM NUMBER FOR SWAPPING HERE
*/
        always @(posedge S_AXIS_ACLK) begin
           if (!S_AXIS_ARESETN) begin
               addr[0] <= 0;
           end else begin
               if (rand_en) begin
                    addr[0] <= 5'h00 ^ {RAND_NUM[0], RAND_NUM[1], RAND_NUM[2], RAND_NUM[3], RAND_NUM[4]};
                    addr[1] <= 5'h01 ^ {RAND_NUM[0], RAND_NUM[1], RAND_NUM[2], RAND_NUM[3], RAND_NUM[4]};
                    addr[2] <= 5'h02 ^ {RAND_NUM[0], RAND_NUM[1], RAND_NUM[2], RAND_NUM[3], RAND_NUM[5]};
                    addr[3] <= 5'h03 ^ {RAND_NUM[0], RAND_NUM[1], RAND_NUM[2], RAND_NUM[3], RAND_NUM[5]};
                    addr[4] <= 5'h04 ^ {RAND_NUM[0], RAND_NUM[1], RAND_NUM[2], RAND_NUM[6], RAND_NUM[7]};
                    addr[5] <= 5'h05 ^ {RAND_NUM[0], RAND_NUM[1], RAND_NUM[2], RAND_NUM[6], RAND_NUM[7]};
                    addr[6] <= 5'h06 ^ {RAND_NUM[0], RAND_NUM[1], RAND_NUM[2], RAND_NUM[6], RAND_NUM[8]};
                    addr[7] <= 5'h07 ^ {RAND_NUM[0], RAND_NUM[1], RAND_NUM[2], RAND_NUM[6], RAND_NUM[8]};
                    addr[8] <= 5'h08 ^ {RAND_NUM[0], RAND_NUM[1], RAND_NUM[9], RAND_NUM[10], RAND_NUM[11]};
                    addr[9] <= 5'h09 ^ {RAND_NUM[0], RAND_NUM[1], RAND_NUM[9], RAND_NUM[10], RAND_NUM[11]};
                    addr[10] <= 5'h0a ^ {RAND_NUM[0], RAND_NUM[1], RAND_NUM[9], RAND_NUM[10], RAND_NUM[12]};
                    addr[11] <= 5'h0b ^ {RAND_NUM[0], RAND_NUM[1], RAND_NUM[9], RAND_NUM[10], RAND_NUM[12]};
                    addr[12] <= 5'h0c ^ {RAND_NUM[0], RAND_NUM[1], RAND_NUM[9], RAND_NUM[13], RAND_NUM[14]};
                    addr[13] <= 5'h0d ^ {RAND_NUM[0], RAND_NUM[1], RAND_NUM[9], RAND_NUM[13], RAND_NUM[14]};
                    addr[14] <= 5'h0e ^ {RAND_NUM[0], RAND_NUM[1], RAND_NUM[9], RAND_NUM[13], RAND_NUM[15]};
                    addr[15] <= 5'h0f ^ {RAND_NUM[0], RAND_NUM[1], RAND_NUM[9], RAND_NUM[13], RAND_NUM[15]};
                    addr[16] <= 5'h10 ^ {RAND_NUM[0], RAND_NUM[16], RAND_NUM[17], RAND_NUM[18], RAND_NUM[19]};
                    addr[17] <= 5'h11 ^ {RAND_NUM[0], RAND_NUM[16], RAND_NUM[17], RAND_NUM[18], RAND_NUM[19]};
                    addr[18] <= 5'h12 ^ {RAND_NUM[0], RAND_NUM[16], RAND_NUM[17], RAND_NUM[18], RAND_NUM[20]};
                    addr[19] <= 5'h13 ^ {RAND_NUM[0], RAND_NUM[16], RAND_NUM[17], RAND_NUM[18], RAND_NUM[20]};
                    addr[20] <= 5'h14 ^ {RAND_NUM[0], RAND_NUM[16], RAND_NUM[17], RAND_NUM[21], RAND_NUM[22]};
                    addr[21] <= 5'h15 ^ {RAND_NUM[0], RAND_NUM[16], RAND_NUM[17], RAND_NUM[21], RAND_NUM[22]};
                    addr[22] <= 5'h16 ^ {RAND_NUM[0], RAND_NUM[16], RAND_NUM[17], RAND_NUM[21], RAND_NUM[23]};
                    addr[23] <= 5'h17 ^ {RAND_NUM[0], RAND_NUM[16], RAND_NUM[17], RAND_NUM[21], RAND_NUM[23]};
                    addr[24] <= 5'h18 ^ {RAND_NUM[0], RAND_NUM[16], RAND_NUM[24], RAND_NUM[25], RAND_NUM[26]};
                    addr[25] <= 5'h19 ^ {RAND_NUM[0], RAND_NUM[16], RAND_NUM[24], RAND_NUM[25], RAND_NUM[26]};
                    addr[26] <= 5'h1a ^ {RAND_NUM[0], RAND_NUM[16], RAND_NUM[24], RAND_NUM[25], RAND_NUM[27]};
                    addr[27] <= 5'h1b ^ {RAND_NUM[0], RAND_NUM[16], RAND_NUM[24], RAND_NUM[25], RAND_NUM[27]};
                    addr[28] <= 5'h1c ^ {RAND_NUM[0], RAND_NUM[16], RAND_NUM[24], RAND_NUM[28], RAND_NUM[29]};
                    addr[29] <= 5'h1d ^ {RAND_NUM[0], RAND_NUM[16], RAND_NUM[24], RAND_NUM[28], RAND_NUM[29]};
                    addr[30] <= 5'h1e ^ {RAND_NUM[0], RAND_NUM[16], RAND_NUM[24], RAND_NUM[28], RAND_NUM[30]};
                    addr[31] <= 5'h1f ^ {RAND_NUM[0], RAND_NUM[16], RAND_NUM[24], RAND_NUM[28], RAND_NUM[30]};
               end else begin
                  addr[0] <= addr[0];
               end
          end
       end 
/*
*    PREP FOR SWAP UNTIL HERE
*/ 

/*
*	GET THE RANDOM NUMBER FOR SWAPPING HERE
*/
        always @(posedge S_AXIS_ACLK) begin
           if (!S_AXIS_ARESETN) begin
               DATA_OUT <= 0;
               VALID_OUT <= 0;
               LAST_OUT <= 0;
               count <= 0;
           end else begin
               if (swap_en && !S_AXIS_TLAST) begin
                   ADDR_OUT<= addr[count];    //address of the FIFO where you put an incoming data
                   DATA_OUT <= S_AXIS_TDATA;        //this is an incoming data----------------^^^^^^^^
                   VALID_OUT <= 1;
                   LAST_OUT <= 0;
                   count <= count + 1;
               end else if (swap_en && S_AXIS_TLAST) begin
                   ADDR_OUT <= addr[count];
                   DATA_OUT <= S_AXIS_TDATA;
                   VALID_OUT <= 1;
                   LAST_OUT <= 1;
                   count <= 0;
               end else begin
                   VALID_OUT <= 0;
                   LAST_OUT <= 0;
               end
           end
        end 
/*
*    PREP FOR SWAP UNTIL HERE
*/

        assign rand_en = (mst_exec_state == IDLE) & S_AXIS_TVALID;
        
        assign swap_en = (mst_exec_state == SWAP) & S_AXIS_TVALID;
        assign swap_done = (mst_exec_state == SWAP) & S_AXIS_TVALID & S_AXIS_TLAST;
        
        assign S_AXIS_TREADY = axis_tready;
        assign axis_tready = (mst_exec_state == SWAP) & S_AXIS_TVALID;
       
    
        endmodule
