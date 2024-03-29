(* use_dsp = "yes" *) module muladd_2_stage_signed_13_bit_xor_reduction(
	input signed [12:0] a,
	input signed [12:0] b,
	input signed [12:0] c,
	output [12:0] out,
	input clk);

	logic signed [25:0] stage0;
	logic signed [25:0] stage1;

	always @(posedge clk) begin
	stage0 <= (a * b) + c;
	stage1 <= stage0;
	end

	assign out = ^(stage1);
endmodule
