(* use_dsp = "yes" *) module subsquare_b_2_stage_unsigned_1_bit(
	input  [0:0] b,
	input  [0:0] d,
	output [0:0] out,
	input clk);

	logic  [1:0] stage0;
	logic  [1:0] stage1;

	always @(posedge clk) begin
	stage0 <= (d - b) * (d - b);
	stage1 <= stage0;
	end

	assign out = stage1;
endmodule
