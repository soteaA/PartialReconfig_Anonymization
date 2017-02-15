module sum_reg # (
        parameter integer K_SIZE = 8,
        parameter integer DATA_WIDTH = 32
    )(
        
        input wire clk, rst_n,
        input wire [DATA_WIDTH-1:0] ina,
        input wire valid_in,
        input wire last_in,
        output reg [DATA_WIDTH-1:0] out,
        output reg valid_out,
        output reg last_out
	);

	reg [5:0] count;

always @(posedge clk) begin
	if (!rst_n) begin
		out <= 0;
		count <= 0;
	end else begin
		if (valid_in && count == 0) begin
			out <= ina;
			valid_out <= 0;
			count <= count + 1;
		end else if (valid_in && count < K_SIZE - 1) begin
			out <= out + ina;
			valid_out <= 0;
			count <= count + 1;
		end else if (valid_in && count == K_SIZE- 1) begin
			out <= (out + ina) >> 3;
			valid_out <= 1;
			count <= 0;
		end else begin
			out <= out;
			valid_out <= 0;
		end

		last_out <= last_in;
	end
end

endmodule
