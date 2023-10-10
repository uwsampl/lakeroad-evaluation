(* use_dsp = "yes" *) module subsubsquare_a_3_stage_unsigned_8_bit(
	input  [7:0] a,
	input  [7:0] c,
	input  [7:0] d,
	output [7:0] out,
	input clk);

	logic  [15:0] stage0;
	logic  [15:0] stage1;
	logic  [15:0] stage2;

	always @(posedge clk) begin
	stage0 <= c - ((d - a) * (d - a));
	stage1 <= stage0;
	stage2 <= stage1;
	end

	assign out = stage2;
endmodule
