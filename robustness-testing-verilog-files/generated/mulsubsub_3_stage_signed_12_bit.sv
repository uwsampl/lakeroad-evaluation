(* use_dsp = "yes" *) module mulsubsub_3_stage_signed_12_bit(
	input signed [11:0] a,
	input signed [11:0] b,
	input signed [11:0] c,
	input signed [11:0] d,
	output [11:0] out,
	input clk);

	logic signed [23:0] stage0;
	logic signed [23:0] stage1;
	logic signed [23:0] stage2;

	always @(posedge clk) begin
	stage0 <= (a * b) - (c - d);
	stage1 <= stage0;
	stage2 <= stage1;
	end

	assign out = stage2;
endmodule
