(* use_dsp = "yes" *) module addsquare_a_3_stage_signed_6_bit(
	input signed [5:0] a,
	input signed [5:0] d,
	output [5:0] out,
	input clk);

	logic signed [11:0] stage0;
	logic signed [11:0] stage1;
	logic signed [11:0] stage2;

	always @(posedge clk) begin
	stage0 <= (d + a) * (d + a);
	stage1 <= stage0;
	stage2 <= stage1;
	end

	assign out = stage2;
endmodule
