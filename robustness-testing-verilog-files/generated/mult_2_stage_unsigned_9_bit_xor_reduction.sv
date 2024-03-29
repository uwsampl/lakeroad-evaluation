(* use_dsp = "yes" *) module mult_2_stage_unsigned_9_bit_xor_reduction(
	input  [8:0] a,
	input  [8:0] b,
	output [8:0] out,
	input clk);

	logic  [17:0] stage0;
	logic  [17:0] stage1;

	always @(posedge clk) begin
	stage0 <= a * b;
	stage1 <= stage0;
	end

	assign out = ^(stage1);
endmodule
