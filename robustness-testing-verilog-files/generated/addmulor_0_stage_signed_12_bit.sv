(* use_dsp = "yes" *) module addmulor_0_stage_signed_12_bit(
	input signed [11:0] a,
	input signed [11:0] b,
	input signed [11:0] c,
	input signed [11:0] d,
	output [11:0] out
	);

	assign out = ((d + a) * b) | c;
endmodule
