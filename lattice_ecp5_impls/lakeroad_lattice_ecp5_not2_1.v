/* Generated by Yosys 0.16+41 (git sha1 29c0a5958, x86_64-apple-darwin20.2-clang 10.0.0-4ubuntu1 -fPIC -Os) */

module lakeroad_lattice_ecp5_not2_1(a, out0);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  wire _4_;
  wire _5_;
  input [1:0] a;
  wire [1:0] a;
  output [1:0] out0;
  wire [1:0] out0;
  LUT4 #(
    .INIT(16'h7fff)
  ) A_LUT_0 (
    .A(a[0]),
    .B(1'h1),
    .C(1'h1),
    .D(1'h1),
    .Z(out0[0])
  );
  LUT4 #(
    .INIT(16'h7fff)
  ) B_LUT_1 (
    .A(a[1]),
    .B(1'h1),
    .C(1'h1),
    .D(1'h1),
    .Z(out0[1])
  );
  LUT4 #(
    .INIT(16'h0000)
  ) C_LUT_2 (
    .A(1'h0),
    .B(1'h0),
    .C(1'h0),
    .D(1'h0),
    .Z(_5_)
  );
  LUT4 #(
    .INIT(16'h0000)
  ) D_LUT_3 (
    .A(1'h0),
    .B(1'h0),
    .C(1'h0),
    .D(1'h0),
    .Z(_4_)
  );
  LUT4 #(
    .INIT(16'h0000)
  ) E_LUT_4 (
    .A(1'h0),
    .B(1'h0),
    .C(1'h0),
    .D(1'h0),
    .Z(_3_)
  );
  LUT4 #(
    .INIT(16'h0000)
  ) F_LUT_5 (
    .A(1'h0),
    .B(1'h0),
    .C(1'h0),
    .D(1'h0),
    .Z(_2_)
  );
  LUT4 #(
    .INIT(16'h0000)
  ) G_LUT_6 (
    .A(1'h0),
    .B(1'h0),
    .C(1'h0),
    .D(1'h0),
    .Z(_1_)
  );
  LUT4 #(
    .INIT(16'h0000)
  ) H_LUT_7 (
    .A(1'h0),
    .B(1'h0),
    .C(1'h0),
    .D(1'h0),
    .Z(_0_)
  );
endmodule

