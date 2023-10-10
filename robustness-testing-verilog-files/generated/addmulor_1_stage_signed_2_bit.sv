(* use_dsp = "yes" *) module addmulor_1_stage_signed_2_bit(
	input signed [1:0] a,
	input signed [1:0] b,
	input signed [1:0] c,
	input signed [1:0] d,
	output [1:0] out,
	input clk);

	logic signed [3:0] stage0;

	always @(posedge clk) begin
	stage0 <= ((d + a) * b) | c;

	end

	assign out = stage0;
endmodule
