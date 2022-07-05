/* Generated by Yosys 0.16+41 (git sha1 29c0a5958, x86_64-apple-darwin20.2-clang 10.0.0-4ubuntu1 -fPIC -Os) */

module lakeroad_lattice_ecp5_sub8_2(a, b, out0);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input [7:0] a;
  wire [7:0] a;
  input [7:0] b;
  wire [7:0] b;
  output [7:0] out0;
  wire [7:0] out0;
  CCU2C #(
    .INIT0(16'h9ffb),
    .INIT1(16'h9ffb),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_0 (
    .A0(a[0]),
    .A1(a[1]),
    .B0(b[0]),
    .B1(b[1]),
    .C0(1'h1),
    .C1(1'h1),
    .CIN(1'h1),
    .COUT(_3_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(out0[0]),
    .S1(out0[1])
  );
  CCU2C #(
    .INIT0(16'h9ffb),
    .INIT1(16'h9ffb),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_1 (
    .A0(a[2]),
    .A1(a[3]),
    .B0(b[2]),
    .B1(b[3]),
    .C0(1'h1),
    .C1(1'h1),
    .CIN(_3_),
    .COUT(_2_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(out0[2]),
    .S1(out0[3])
  );
  CCU2C #(
    .INIT0(16'h9ffb),
    .INIT1(16'h9ffb),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_2 (
    .A0(a[4]),
    .A1(a[5]),
    .B0(b[4]),
    .B1(b[5]),
    .C0(1'h1),
    .C1(1'h1),
    .CIN(_2_),
    .COUT(_1_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(out0[4]),
    .S1(out0[5])
  );
  CCU2C #(
    .INIT0(16'h9ffb),
    .INIT1(16'h9ffb),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_3 (
    .A0(a[6]),
    .A1(a[7]),
    .B0(b[6]),
    .B1(b[7]),
    .C0(1'h1),
    .C1(1'h1),
    .CIN(_1_),
    .COUT(_0_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(out0[6]),
    .S1(out0[7])
  );
endmodule

