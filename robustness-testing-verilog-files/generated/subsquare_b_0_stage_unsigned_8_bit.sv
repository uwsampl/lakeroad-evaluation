(* use_dsp = "yes" *) module subsquare_b_0_stage_unsigned_8_bit(
	input  [7:0] b,
	input  [7:0] d,
	output [7:0] out,
	input clk);

	assign out = (d - b) * (d - b);
endmodule
