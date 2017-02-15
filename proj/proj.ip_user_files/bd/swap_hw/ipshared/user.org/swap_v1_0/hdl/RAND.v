//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Random Number Generator                                     ////
////                                                              ////
////  This file is part of the SystemC RNG                        ////
////                                                              ////
////  Description:                                                ////
////                                                              ////
////  Implementation of random number generator                   ////
////                                                              ////
////  To Do:                                                      ////
////   - done                                                     ////
////                                                              ////
////  Author(s):                                                  ////
////      - Javier Castillo, javier.castillo@urjc.es              ////
////                                                              ////
////  This core is provided by Universidad Rey Juan Carlos        ////
////  http://www.escet.urjc.es/~jmartine                          ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: not supported by cvs2svn $
// Revision 1.3  2005/07/30 20:07:26  jcastillo
// Correct bit 28. Correct assignation to bit 31
//
// Revision 1.2  2005/07/29 09:13:06  jcastillo
// Correct bit 28 of CASR
//
// Revision 1.1  2004/09/23 09:43:06  jcastillo
// Verilog first import
//

`timescale 1 ns / 1 ps

module RAND # (
    parameter integer DATA_WIDTH = 32
) (
    input wire clk,
    input wire rst_n,
    input wire loadseed_i,
    input wire [DATA_WIDTH-1:0] seed_i,
    output reg [DATA_WIDTH-1:0] rand_num
  );

reg [42:0] LFSR_reg;
reg [36:0] CASR_reg;
reg loadseed_flag;

//CASR:
always @(posedge clk) begin
   if (!rst_n ) begin
      CASR_reg <= (1);
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
always @(posedge clk) begin
   if (!rst_n ) begin
      LFSR_reg <= (1);
	  outbitLFSR <= 0;
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


//combinate:
always @(posedge clk) begin
   if (!rst_n ) begin
      rand_num <= (0);
   end else begin
      rand_num  <= (LFSR_reg [31:0]^CASR_reg[31:0]);
	end
end


endmodule
