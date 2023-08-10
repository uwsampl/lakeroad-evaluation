(* use_dsp = "yes" *) module mulsub_0_stage_unsigned_8_bit(
	input  [7:0] a,
	input  [7:0] b,
	input  [7:0] c,
	output [7:0] out,
	input clk);

	assign out = (a * b) - c;
endmodule
