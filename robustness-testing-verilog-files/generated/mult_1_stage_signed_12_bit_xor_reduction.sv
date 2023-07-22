(* use_dsp = "yes" *) module mult_1_stage_signed_12_bit_xor_reduction(
	input signed [11:0] a,
	input signed [11:0] b,
	output [11:0] out,
	input clk);

	logic signed [23:0] stage0;

	always @(posedge clk) begin
	stage0 <= a * b;

	end

	assign out = ^(stage0);
endmodule