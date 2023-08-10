(* use_dsp = "yes" *) module mulsub_0_stage_unsigned_17_bit(
	input  [16:0] a,
	input  [16:0] b,
	input  [16:0] c,
	output [16:0] out,
	input clk);

	assign out = (a * b) - c;
endmodule
