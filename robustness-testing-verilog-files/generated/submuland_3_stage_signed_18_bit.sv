(* use_dsp = "yes" *) module submuland_3_stage_signed_18_bit(
	input signed [17:0] a,
	input signed [17:0] b,
	input signed [17:0] c,
	input signed [17:0] d,
	output [17:0] out,
	input clk);

	logic signed [35:0] stage0;
	logic signed [35:0] stage1;
	logic signed [35:0] stage2;

	always @(posedge clk) begin
	stage0 <= ((d - a) * b) & c;
	stage1 <= stage0;
	stage2 <= stage1;
	end

	assign out = stage2;
endmodule
