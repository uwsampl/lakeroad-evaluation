(* use_dsp = "yes" *) module addmuladd_1_stage_signed_17_bit_xor_reduction(
	input signed [16:0] a,
	input signed [16:0] b,
	input signed [16:0] c,
	input signed [16:0] d,
	output [16:0] out,
	input clk);

	logic signed [33:0] stage0;

	always @(posedge clk) begin
	stage0 <= ((d + a) * b) + c;

	end

	assign out = ^(stage0);
endmodule
