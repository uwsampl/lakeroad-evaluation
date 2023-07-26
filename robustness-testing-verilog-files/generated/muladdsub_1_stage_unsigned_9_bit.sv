(* use_dsp = "yes" *) module muladdsub_1_stage_unsigned_9_bit(
	input  [8:0] a,
	input  [8:0] b,
	input  [8:0] c,
	input  [8:0] d,
	output [8:0] out,
	input clk);

	logic  [17:0] stage0;

	always @(posedge clk) begin
	stage0 <= (a * b) + (c - d);

	end

	assign out = stage0;
endmodule
