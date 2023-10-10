(* use_dsp = "yes" *) module muladd_2_stage_signed_2_bit(
	input signed [1:0] a,
	input signed [1:0] b,
	input signed [1:0] c,
	output [1:0] out,
	input clk);

	logic signed [3:0] stage0;
	logic signed [3:0] stage1;

	always @(posedge clk) begin
	stage0 <= (a * b) + c;
	stage1 <= stage0;
	end

	assign out = stage1;
endmodule
