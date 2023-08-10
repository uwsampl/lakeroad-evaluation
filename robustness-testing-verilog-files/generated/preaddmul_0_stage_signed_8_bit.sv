(* use_dsp = "yes" *) module preaddmul_0_stage_signed_8_bit(
	input signed [7:0] d,
	input signed [7:0] a,
	input signed [7:0] b,
	output [7:0] out,
	input clk);

	assign out = (d + a) * b;
endmodule
