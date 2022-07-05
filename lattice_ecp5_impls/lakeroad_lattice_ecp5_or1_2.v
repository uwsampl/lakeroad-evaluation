/* Generated by Yosys 0.16+41 (git sha1 29c0a5958, x86_64-apple-darwin20.2-clang 10.0.0-4ubuntu1 -fPIC -Os) */

module lakeroad_lattice_ecp5_or1_2(a, b, out0);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  wire _4_;
  wire _5_;
  wire _6_;
  input a;
  wire a;
  input b;
  wire b;
  output out0;
  wire out0;
  LUT4 #(
    .INIT(16'hefff)
  ) A_LUT_0 (
    .A(a),
    .B(b),
    .C(1'h1),
    .D(1'h1),
    .Z(out0)
  );
  LUT4 #(
    .INIT(16'h0000)
  ) B_LUT_1 (
    .A(1'h0),
    .B(1'h0),
    .C(1'h0),
    .D(1'h0),
    .Z(_6_)
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

