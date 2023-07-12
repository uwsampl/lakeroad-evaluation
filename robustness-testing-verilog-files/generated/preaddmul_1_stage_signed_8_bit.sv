(* use_dsp = "yes" *) module preaddmul_1_stage_signed_8_bit(
	input signed [7:0] d,
	input signed [7:0] a,
	input signed [7:0] b,
	output [7:0] out,
	input clk);

	logic signed [15:0] stage0;

	always @(posedge clk) begin
	stage0 <= (d + a) * b;

	end

	assign out = stage0;
endmodule
