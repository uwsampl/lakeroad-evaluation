(* use_dsp = "yes" *) module mult_0_stage_signed_3_bit(
	input signed [2:0] a,
	input signed [2:0] b,
	output [2:0] out,
	input clk);

	assign out = a * b;
endmodule
