(* use_dsp = "yes" *) module muland_0_stage_signed_3_bit(
	input signed [2:0] a,
	input signed [2:0] b,
	input signed [2:0] c,
	output [2:0] out,
	input clk);

	assign out = (a * b) & c;
endmodule
