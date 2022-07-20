/* Generated by Yosys 0.15+50 (git sha1 6318db615, x86_64-apple-darwin20.2-clang 10.0.0-4ubuntu1 -fPIC -Os) */

module lakeroad_sofa_xor2_2(a, b, out0);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input [1:0] a;
  wire [1:0] a;
  input [1:0] b;
  wire [1:0] b;
  wire lut4_out_0;
  wire lut4_out_1;
  output [1:0] out0;
  wire [1:0] out0;
  frac_lut4 lut4_0 (
    .in({ 2'h0, b[0], a[0] }),
    .lut3_out({ _3_, _2_ }),
    .lut4_out(out0[0]),
    .mode(1'h0),
    .mode_inv(1'h0),
    .sram(16'heffe),
    .sram_inv(16'h0000)
  );
  frac_lut4 lut4_1 (
    .in({ 2'h0, b[1], a[1] }),
    .lut3_out({ _1_, _0_ }),
    .lut4_out(out0[1]),
    .mode(1'h0),
    .mode_inv(1'h0),
    .sram(16'heffe),
    .sram_inv(16'h0000)
  );
  assign lut4_out_0 = out0[0];
  assign lut4_out_1 = out0[1];
endmodule

