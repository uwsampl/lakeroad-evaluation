(* use_dsp = "yes" *) module subaddsquare_b_1_stage_unsigned_7_bit(
	input  [6:0] b,
	input  [6:0] c,
	input  [6:0] d,
	output [6:0] out,
	input clk);

	logic  [13:0] stage0;

	always @(posedge clk) begin
	stage0 <= c - ((d + b) * (d + b));

	end

	assign out = stage0;
endmodule
