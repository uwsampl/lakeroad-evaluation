(* use_dsp = "yes" *) module preaddmul_0_stage_unsigned_15_bit(
	input  [14:0] d,
	input  [14:0] a,
	input  [14:0] b,
	output [14:0] out,
	input clk);

	assign out = (d + a) * b;
endmodule
