/* Generated by Yosys 0.19 (git sha1 a45c131b37c, clang 13.1.6 -fPIC -Os) */

module lakeroad_lattice_ecp5_ge16_2(a, b, out0);
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
  wire _11_;
  wire _12_;
  wire _13_;
  wire _14_;
  wire _15_;
  wire _16_;
  wire _17_;
  wire _18_;
  wire _19_;
  wire _20_;
  wire _21_;
  wire _22_;
  input [15:0] a;
  wire [15:0] a;
  input [15:0] b;
  wire [15:0] b;
  output out0;
  wire out0;
  CCU2C #(
    .INIT0(16'h494d),
    .INIT1(16'h494d),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_0 (
    .A0(b[0]),
    .A1(b[1]),
    .B0(a[0]),
    .B1(a[1]),
    .C0(1'h1),
    .C1(1'h0),
    .CIN(1'h1),
    .COUT(_13_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_15_),
    .S1(_14_)
  );
  CCU2C #(
    .INIT0(16'h494d),
    .INIT1(16'h494d),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_1 (
    .A0(b[2]),
    .A1(b[3]),
    .B0(a[2]),
    .B1(a[3]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_13_),
    .COUT(_09_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_12_),
    .S1(_10_)
  );
  CCU2C #(
    .INIT0(16'h494d),
    .INIT1(16'h494d),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_2 (
    .A0(b[4]),
    .A1(b[5]),
    .B0(a[4]),
    .B1(a[5]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_09_),
    .COUT(_06_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_08_),
    .S1(_07_)
  );
  CCU2C #(
    .INIT0(16'h494d),
    .INIT1(16'h494d),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_3 (
    .A0(b[6]),
    .A1(b[7]),
    .B0(a[6]),
    .B1(a[7]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_06_),
    .COUT(_03_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_05_),
    .S1(_04_)
  );
  CCU2C #(
    .INIT0(16'h494d),
    .INIT1(16'h494d),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_4 (
    .A0(b[8]),
    .A1(b[9]),
    .B0(a[8]),
    .B1(a[9]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_03_),
    .COUT(_22_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_02_),
    .S1(_01_)
  );
  CCU2C #(
    .INIT0(16'h494d),
    .INIT1(16'h494d),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_5 (
    .A0(b[10]),
    .A1(b[11]),
    .B0(a[10]),
    .B1(a[11]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_22_),
    .COUT(_19_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_21_),
    .S1(_20_)
  );
  CCU2C #(
    .INIT0(16'h494d),
    .INIT1(16'h494d),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_6 (
    .A0(b[12]),
    .A1(b[13]),
    .B0(a[12]),
    .B1(a[13]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_19_),
    .COUT(_16_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_18_),
    .S1(_17_)
  );
  CCU2C #(
    .INIT0(16'h494d),
    .INIT1(16'h494d),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_7 (
    .A0(b[14]),
    .A1(b[15]),
    .B0(a[14]),
    .B1(a[15]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_16_),
    .COUT(out0),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_11_),
    .S1(_00_)
  );
endmodule
