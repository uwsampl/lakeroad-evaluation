/* Generated by Yosys 0.19 (git sha1 a45c131b37c, clang 13.1.6 -fPIC -Os) */

module lakeroad_lattice_ecp5_eq7_2(a, b, out0);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  wire _10_;
  input [6:0] a;
  wire [6:0] a;
  input [6:0] b;
  wire [6:0] b;
  output out0;
  wire out0;
  CCU2C #(
    .INIT0(16'h9d99),
    .INIT1(16'h9d99),
    .INJECT1_0("YES"),
    .INJECT1_1("NO")
  ) CCU2C_0 (
    .A0(a[1]),
    .A1(a[0]),
    .B0(b[1]),
    .B1(b[0]),
    .C0(1'h1),
    .C1(1'h1),
    .CIN(1'h1),
    .COUT(_10_),
    .D0(1'h0),
    .D1(1'h1),
    .S0(_02_),
    .S1(_01_)
  );
  CCU2C #(
    .INIT0(16'h9d99),
    .INIT1(16'h9d99),
    .INJECT1_0("YES"),
    .INJECT1_1("NO")
  ) CCU2C_1 (
    .A0(a[3]),
    .A1(a[2]),
    .B0(b[3]),
    .B1(b[2]),
    .C0(1'h1),
    .C1(1'h1),
    .CIN(_10_),
    .COUT(_07_),
    .D0(1'h0),
    .D1(1'h0),
    .S0(_09_),
    .S1(_08_)
  );
  CCU2C #(
    .INIT0(16'h9d99),
    .INIT1(16'h9d99),
    .INJECT1_0("YES"),
    .INJECT1_1("NO")
  ) CCU2C_2 (
    .A0(a[5]),
    .A1(a[4]),
    .B0(b[5]),
    .B1(b[4]),
    .C0(1'h1),
    .C1(1'h1),
    .CIN(_07_),
    .COUT(_04_),
    .D0(1'h0),
    .D1(1'h0),
    .S0(_06_),
    .S1(_05_)
  );
  CCU2C #(
    .INIT0(16'h9d99),
    .INIT1(16'h9d99),
    .INJECT1_0("YES"),
    .INJECT1_1("NO")
  ) CCU2C_3 (
    .A0(1'h0),
    .A1(a[6]),
    .B0(1'h0),
    .B1(b[6]),
    .C0(1'h1),
    .C1(1'h1),
    .CIN(_04_),
    .COUT(out0),
    .D0(1'h0),
    .D1(1'h0),
    .S0(_03_),
    .S1(_00_)
  );
endmodule

