(* use_dsp = "yes" *) module addmuladd_0_stage_unsigned_16_bit(
	input  [15:0] a,
	input  [15:0] b,
	input  [15:0] c,
	input  [15:0] d,
	output [15:0] out
	);

	assign out = ((d + a) * b) + c;
endmodule
