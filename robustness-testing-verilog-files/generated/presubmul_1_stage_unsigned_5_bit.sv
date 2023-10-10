(* use_dsp = "yes" *) module presubmul_1_stage_unsigned_5_bit(
	input  [4:0] a,
	input  [4:0] b,
	input  [4:0] c,
	input  [4:0] d,
	output [4:0] out,
	input clk);

	logic  [9:0] stage0;

	always @(posedge clk) begin
	stage0 <= (d - a) * b;

	end

	assign out = stage0;
endmodule
