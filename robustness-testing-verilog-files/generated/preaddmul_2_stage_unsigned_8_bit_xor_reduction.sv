(* use_dsp = "yes" *) module preaddmul_2_stage_unsigned_8_bit_xor_reduction(
	input  [7:0] d,
	input  [7:0] a,
	input  [7:0] b,
	output [7:0] out,
	input clk);

	logic  [15:0] stage0;
	logic  [15:0] stage1;

	always @(posedge clk) begin
	stage0 <= (d + a) * b;
	stage1 <= stage0;
	end

	assign out = ^(stage1);
endmodule
