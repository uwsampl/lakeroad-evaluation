(* use_dsp = "yes" *) module addaddsquare_a_1_stage_signed_7_bit(
	input signed [6:0] a,
	input signed [6:0] c,
	input signed [6:0] d,
	output [6:0] out,
	input clk);

	logic signed [13:0] stage0;

	always @(posedge clk) begin
	stage0 <= c + ((d + a) * (d + a));

	end

	assign out = stage0;
endmodule
