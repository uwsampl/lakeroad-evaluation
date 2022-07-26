/* Generated by Yosys 0.19 (git sha1 a45c131b37c, clang 13.1.6 -fPIC -Os) */

module lakeroad_lattice_ecp5_ge24_2(a, b, out0);
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
  wire _23_;
  wire _24_;
  wire _25_;
  wire _26_;
  wire _27_;
  wire _28_;
  wire _29_;
  wire _30_;
  wire _31_;
  wire _32_;
  wire _33_;
  wire _34_;
  input [23:0] a;
  wire [23:0] a;
  input [23:0] b;
  wire [23:0] b;
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
    .COUT(_26_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_28_),
    .S1(_27_)
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
    .CIN(_26_),
    .COUT(_17_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_25_),
    .S1(_24_)
  );
  CCU2C #(
    .INIT0(16'h494d),
    .INIT1(16'h494d),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_10 (
    .A0(b[20]),
    .A1(b[21]),
    .B0(a[20]),
    .B1(a[21]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_22_),
    .COUT(_20_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_23_),
    .S1(_21_)
  );
  CCU2C #(
    .INIT0(16'h494d),
    .INIT1(16'h494d),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_11 (
    .A0(b[22]),
    .A1(b[23]),
    .B0(a[22]),
    .B1(a[23]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_20_),
    .COUT(out0),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_19_),
    .S1(_18_)
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
    .CIN(_17_),
    .COUT(_14_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_16_),
    .S1(_15_)
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
    .CIN(_14_),
    .COUT(_10_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_13_),
    .S1(_12_)
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
    .CIN(_10_),
    .COUT(_07_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_09_),
    .S1(_08_)
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
    .CIN(_07_),
    .COUT(_04_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_06_),
    .S1(_05_)
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
    .CIN(_04_),
    .COUT(_01_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_03_),
    .S1(_02_)
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
    .CIN(_01_),
    .COUT(_32_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_34_),
    .S1(_33_)
  );
  CCU2C #(
    .INIT0(16'h494d),
    .INIT1(16'h494d),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_8 (
    .A0(b[16]),
    .A1(b[17]),
    .B0(a[16]),
    .B1(a[17]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_32_),
    .COUT(_29_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_31_),
    .S1(_30_)
  );
  CCU2C #(
    .INIT0(16'h494d),
    .INIT1(16'h494d),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_9 (
    .A0(b[18]),
    .A1(b[19]),
    .B0(a[18]),
    .B1(a[19]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_29_),
    .COUT(_22_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_11_),
    .S1(_00_)
  );
endmodule

