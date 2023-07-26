(* use_dsp = "yes" *) module mulsub_1_stage_unsigned_9_bit_xor_reduction(
	input  [8:0] a,
	input  [8:0] b,
	input  [8:0] c,
	output [8:0] out,
	input clk);

	logic  [17:0] stage0;

	always @(posedge clk) begin
	stage0 <= (a * b) - c;

	end

	assign out = ^(stage0);
endmodule
