(* use_dsp = "yes" *) module preaddmul_0_stage_unsigned_11_bit(
	input  [10:0] d,
	input  [10:0] a,
	input  [10:0] b,
	output [10:0] out,
	input clk);

	assign out = (d + a) * b;
endmodule
