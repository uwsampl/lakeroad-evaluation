(* use_dsp = "yes" *) module addmuland_0_stage_unsigned_11_bit(
	input  [10:0] a,
	input  [10:0] b,
	input  [10:0] c,
	input  [10:0] d,
	output [10:0] out
	);

	assign out = ((d + a) * b) & c;
endmodule
