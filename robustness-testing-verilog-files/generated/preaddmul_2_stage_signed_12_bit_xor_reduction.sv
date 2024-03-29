(* use_dsp = "yes" *) module preaddmul_2_stage_signed_12_bit_xor_reduction(
	input signed [11:0] d,
	input signed [11:0] a,
	input signed [11:0] b,
	output [11:0] out,
	input clk);

	logic signed [23:0] stage0;
	logic signed [23:0] stage1;

	always @(posedge clk) begin
	stage0 <= (d + a) * b;
	stage1 <= stage0;
	end

	assign out = ^(stage1);
endmodule
