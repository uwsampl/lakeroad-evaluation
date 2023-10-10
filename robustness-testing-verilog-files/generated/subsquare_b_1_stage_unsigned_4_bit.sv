(* use_dsp = "yes" *) module subsquare_b_1_stage_unsigned_4_bit(
	input  [3:0] b,
	input  [3:0] d,
	output [3:0] out,
	input clk);

	logic  [7:0] stage0;

	always @(posedge clk) begin
	stage0 <= (d - b) * (d - b);

	end

	assign out = stage0;
endmodule
