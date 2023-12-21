(* use_dsp = "yes" *) module mulor_0_stage_unsigned_16_bit(
	input  [15:0] a,
	input  [15:0] b,
	input  [15:0] c,
	output [15:0] out
	);

	assign out = (a * b) | c;
endmodule
