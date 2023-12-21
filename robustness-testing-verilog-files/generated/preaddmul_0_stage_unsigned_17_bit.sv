(* use_dsp = "yes" *) module preaddmul_0_stage_unsigned_17_bit(
	input  [16:0] a,
	input  [16:0] b,
	input  [16:0] d,
	output [16:0] out
	);

	assign out = (d + a) * b;
endmodule
