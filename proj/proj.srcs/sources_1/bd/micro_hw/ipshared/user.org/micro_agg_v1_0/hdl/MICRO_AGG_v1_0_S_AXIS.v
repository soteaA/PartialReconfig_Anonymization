
`timescale 1 ns / 1 ps
`include "def.h"

	module MICRO_AGG_v1_0_S_AXIS #
	(
		parameter integer C_S_AXIS_TDATA_WIDTH	= 32
	)
	(
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
	
	/*
    *    if you need some FIFOs or regfiles or anything, then add them down here
    */
        reg [`DATA_W-1:0] buff;
    
    /*
    *    FINITE STATE MACHINE DEFINITION down here
    */
    parameter [1:0] IDLE = 2'b00, S0 = 2'b01, S1 = 2'b10, S2 = 2'b11;
        reg [1:0] state;
    
    /*
    *    any wire discriptions down here
    */
        reg delay_last;
    
        wire we;
        wire S0_enable;
        wire S1_enable;
        wire S2_enable;
    
        wire S0toS1;
        wire S1toS2;
        wire S2toS1, S2toIDLE;
    
    /*
    *    FSM discription down here
    */
    always @(posedge S_AXIS_ACLK) begin
        if (!S_AXIS_ARESETN) begin
            state <= IDLE;
        end else begin
            case (state)
            IDLE : begin
                if (S_AXIS_TVALID) begin
                    state <= S0;
                end else begin
                    state <= IDLE;
                end
            end
    
            S0 : begin
                if (S0toS1) begin
                    state <= S1;
                end else begin
                    state <= S0;
                end
            end
    
            S1 : begin
                if (S1toS2) begin
                    state <= S2;
                end else begin
                    state <= S1;
                end
            end
    
            S2 : begin
                if (S2toIDLE) begin
                    state <= IDLE;
                end else if (S2toS1) begin
                    state <= S1;
                end else begin
                    state <= S2;
                end
            end
    
            endcase
        end
    end
    
    /*
    *    User programs should be added down here
    */
    always @(posedge S_AXIS_ACLK) begin
        if (!S_AXIS_ARESETN) begin
            buff <= 0;
        end else begin
            if (S0_enable) begin
                buff <= S_AXIS_TDATA;
                VALID_OUT <= 0;
                LAST_OUT <= 0;
            end else if (S1_enable) begin
                DATA_OUT <= (S_AXIS_TDATA > buff) ? S_AXIS_TDATA : buff;
                VALID_OUT <= 1;
                LAST_OUT <= 0;
                buff <= (S_AXIS_TDATA > buff) ? buff : S_AXIS_TDATA;
            end else if (S2_enable) begin
                DATA_OUT <= buff;
                VALID_OUT <= 1;
                LAST_OUT <= (S2toIDLE) ? 1 : 0;
                buff <= (we) ? S_AXIS_TDATA : buff;
            end else begin
                VALID_OUT <= 0;
                LAST_OUT <= 0;
            end
        end
    end
    
    always @(posedge S_AXIS_ACLK) begin
        if (!S_AXIS_ARESETN) begin
            delay_last <= 0;
        end else begin
            if (S_AXIS_TLAST) begin
                delay_last <= 1;
            end else if (S2toIDLE) begin
                delay_last <= 0;
            end else begin
                delay_last <= 0;
            end
        end
    end
    
    /*
    *    any wire dicription down here
    */
    assign S_AXIS_TREADY = (state != IDLE) & S_AXIS_TVALID;
    assign we = S_AXIS_TREADY;
    
    assign S0_enable = (state == S0) & we;
    assign S1_enable = (state == S1) & we;
    assign S2_enable = (state == S2);
    
    assign S0toS1 = (state == S0) & we;
    assign S1toS2 = (state == S1) & we;
    assign S2toS1 = (state == S2) & we & !delay_last;
    assign S2toIDLE = (state == S2) & delay_last;
    
    endmodule
