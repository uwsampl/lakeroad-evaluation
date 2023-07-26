(* use_dsp = "yes" *) module mulsubadd_3_stage_signed_11_bit(
	input signed [10:0] a,
	input signed [10:0] b,
	input signed [10:0] c,
	input signed [10:0] d,
	output [10:0] out,
	input clk);

	logic signed [21:0] stage0;
	logic signed [21:0] stage1;
	logic signed [21:0] stage2;

	always @(posedge clk) begin
	stage0 <= (a * b) - (c + d);
	stage1 <= stage0;
	stage2 <= stage1;
	end

	assign out = stage2;
endmodule
