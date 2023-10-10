(* use_dsp = "yes" *) module addmuland_0_stage_signed_14_bit(
	input signed [13:0] a,
	input signed [13:0] b,
	input signed [13:0] c,
	input signed [13:0] d,
	output [13:0] out
	);

	assign out = ((d + a) * b) & c;
endmodule
