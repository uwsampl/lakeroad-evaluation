(* use_dsp = "yes" *) module preaddmul_1_stage_unsigned_12_bit_xor_reduction(
	input  [11:0] d,
	input  [11:0] a,
	input  [11:0] b,
	output [11:0] out,
	input clk);

	logic  [23:0] stage0;

	always @(posedge clk) begin
	stage0 <= (d + a) * b;

	end

	assign out = ^(stage0);
endmodule
