(* use_dsp = "yes" *) module preaddmul_2_stage_unsigned_17_bit(
	input  [16:0] d,
	input  [16:0] a,
	input  [16:0] b,
	output [16:0] out,
	input clk);

	logic  [33:0] stage0;
	logic  [33:0] stage1;

	always @(posedge clk) begin
	stage0 <= (d + a) * b;
	stage1 <= stage0;
	end

	assign out = stage1;
endmodule
