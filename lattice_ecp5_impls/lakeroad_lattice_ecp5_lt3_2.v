/* Generated by Yosys 0.19 (git sha1 a45c131b37c, clang 13.1.6 -fPIC -Os) */

module lakeroad_lattice_ecp5_lt3_2(a, b, out0);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  wire _4_;
  input [2:0] a;
  wire [2:0] a;
  input [2:0] b;
  wire [2:0] b;
  output out0;
  wire out0;
  CCU2C #(
    .INIT0(16'h95fd),
    .INIT1(16'h95fd),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_0 (
    .A0(a[0]),
    .A1(a[1]),
    .B0(b[0]),
    .B1(b[1]),
    .C0(1'h1),
    .C1(1'h1),
    .CIN(1'h0),
    .COUT(_2_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_4_),
    .S1(_3_)
  );
  CCU2C #(
    .INIT0(16'h95fd),
    .INIT1(16'h95fd),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_1 (
    .A0(a[2]),
    .A1(1'h0),
    .B0(b[2]),
    .B1(1'h0),
    .C0(1'h1),
    .C1(1'h1),
    .CIN(_2_),
    .COUT(out0),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_1_),
    .S1(_0_)
  );
endmodule

