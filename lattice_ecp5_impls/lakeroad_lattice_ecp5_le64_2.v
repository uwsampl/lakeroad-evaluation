/* Generated by Yosys 0.19 (git sha1 a45c131b37c, clang 13.1.6 -fPIC -Os) */

module lakeroad_lattice_ecp5_le64_2(a, b, out0);
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
  wire _35_;
  wire _36_;
  wire _37_;
  wire _38_;
  wire _39_;
  wire _40_;
  wire _41_;
  wire _42_;
  wire _43_;
  wire _44_;
  wire _45_;
  wire _46_;
  wire _47_;
  wire _48_;
  wire _49_;
  wire _50_;
  wire _51_;
  wire _52_;
  wire _53_;
  wire _54_;
  wire _55_;
  wire _56_;
  wire _57_;
  wire _58_;
  wire _59_;
  wire _60_;
  wire _61_;
  wire _62_;
  wire _63_;
  wire _64_;
  wire _65_;
  wire _66_;
  wire _67_;
  wire _68_;
  wire _69_;
  wire _70_;
  wire _71_;
  wire _72_;
  wire _73_;
  wire _74_;
  wire _75_;
  wire _76_;
  wire _77_;
  wire _78_;
  wire _79_;
  wire _80_;
  wire _81_;
  wire _82_;
  wire _83_;
  wire _84_;
  wire _85_;
  wire _86_;
  wire _87_;
  wire _88_;
  wire _89_;
  wire _90_;
  wire _91_;
  wire _92_;
  wire _93_;
  wire _94_;
  input [63:0] a;
  wire [63:0] a;
  input [63:0] b;
  wire [63:0] b;
  output out0;
  wire out0;
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_0 (
    .A0(a[0]),
    .A1(a[1]),
    .B0(b[0]),
    .B1(b[1]),
    .C0(1'h1),
    .C1(1'h0),
    .CIN(1'h1),
    .COUT(_92_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_94_),
    .S1(_93_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_1 (
    .A0(a[2]),
    .A1(a[3]),
    .B0(b[2]),
    .B1(b[3]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_92_),
    .COUT(_57_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_91_),
    .S1(_90_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_10 (
    .A0(a[20]),
    .A1(a[21]),
    .B0(b[20]),
    .B1(b[21]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_22_),
    .COUT(_86_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_89_),
    .S1(_87_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_11 (
    .A0(a[22]),
    .A1(a[23]),
    .B0(b[22]),
    .B1(b[23]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_86_),
    .COUT(_83_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_85_),
    .S1(_84_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_12 (
    .A0(a[24]),
    .A1(a[25]),
    .B0(b[24]),
    .B1(b[25]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_83_),
    .COUT(_80_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_82_),
    .S1(_81_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_13 (
    .A0(a[26]),
    .A1(a[27]),
    .B0(b[26]),
    .B1(b[27]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_80_),
    .COUT(_76_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_79_),
    .S1(_78_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_14 (
    .A0(a[28]),
    .A1(a[29]),
    .B0(b[28]),
    .B1(b[29]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_76_),
    .COUT(_73_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_75_),
    .S1(_74_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_15 (
    .A0(a[30]),
    .A1(a[31]),
    .B0(b[30]),
    .B1(b[31]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_73_),
    .COUT(_70_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_72_),
    .S1(_71_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_16 (
    .A0(a[32]),
    .A1(a[33]),
    .B0(b[32]),
    .B1(b[33]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_70_),
    .COUT(_67_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_69_),
    .S1(_68_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_17 (
    .A0(a[34]),
    .A1(a[35]),
    .B0(b[34]),
    .B1(b[35]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_67_),
    .COUT(_63_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_65_),
    .S1(_64_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_18 (
    .A0(a[36]),
    .A1(a[37]),
    .B0(b[36]),
    .B1(b[37]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_63_),
    .COUT(_60_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_62_),
    .S1(_61_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_19 (
    .A0(a[38]),
    .A1(a[39]),
    .B0(b[38]),
    .B1(b[39]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_60_),
    .COUT(_53_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_59_),
    .S1(_58_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_2 (
    .A0(a[4]),
    .A1(a[5]),
    .B0(b[4]),
    .B1(b[5]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_57_),
    .COUT(_20_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_56_),
    .S1(_54_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_20 (
    .A0(a[40]),
    .A1(a[41]),
    .B0(b[40]),
    .B1(b[41]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_53_),
    .COUT(_50_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_52_),
    .S1(_51_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_21 (
    .A0(a[42]),
    .A1(a[43]),
    .B0(b[42]),
    .B1(b[43]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_50_),
    .COUT(_47_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_49_),
    .S1(_48_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_22 (
    .A0(a[44]),
    .A1(a[45]),
    .B0(b[44]),
    .B1(b[45]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_47_),
    .COUT(_43_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_46_),
    .S1(_45_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_23 (
    .A0(a[46]),
    .A1(a[47]),
    .B0(b[46]),
    .B1(b[47]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_43_),
    .COUT(_40_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_42_),
    .S1(_41_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_24 (
    .A0(a[48]),
    .A1(a[49]),
    .B0(b[48]),
    .B1(b[49]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_40_),
    .COUT(_37_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_39_),
    .S1(_38_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_25 (
    .A0(a[50]),
    .A1(a[51]),
    .B0(b[50]),
    .B1(b[51]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_37_),
    .COUT(_34_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_36_),
    .S1(_35_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_26 (
    .A0(a[52]),
    .A1(a[53]),
    .B0(b[52]),
    .B1(b[53]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_34_),
    .COUT(_30_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_32_),
    .S1(_31_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_27 (
    .A0(a[54]),
    .A1(a[55]),
    .B0(b[54]),
    .B1(b[55]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_30_),
    .COUT(_27_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_29_),
    .S1(_28_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_28 (
    .A0(a[56]),
    .A1(a[57]),
    .B0(b[56]),
    .B1(b[57]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_27_),
    .COUT(_24_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_26_),
    .S1(_25_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_29 (
    .A0(a[58]),
    .A1(a[59]),
    .B0(b[58]),
    .B1(b[59]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_24_),
    .COUT(_17_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_23_),
    .S1(_21_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_3 (
    .A0(a[6]),
    .A1(a[7]),
    .B0(b[6]),
    .B1(b[7]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_20_),
    .COUT(_10_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_19_),
    .S1(_18_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_30 (
    .A0(a[60]),
    .A1(a[61]),
    .B0(b[60]),
    .B1(b[61]),
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
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_31 (
    .A0(a[62]),
    .A1(a[63]),
    .B0(b[62]),
    .B1(b[63]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_14_),
    .COUT(out0),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_13_),
    .S1(_12_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_4 (
    .A0(a[8]),
    .A1(a[9]),
    .B0(b[8]),
    .B1(b[9]),
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
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_5 (
    .A0(a[10]),
    .A1(a[11]),
    .B0(b[10]),
    .B1(b[11]),
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
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_6 (
    .A0(a[12]),
    .A1(a[13]),
    .B0(b[12]),
    .B1(b[13]),
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
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_7 (
    .A0(a[14]),
    .A1(a[15]),
    .B0(b[14]),
    .B1(b[15]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_01_),
    .COUT(_66_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_88_),
    .S1(_77_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_8 (
    .A0(a[16]),
    .A1(a[17]),
    .B0(b[16]),
    .B1(b[17]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_66_),
    .COUT(_33_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_55_),
    .S1(_44_)
  );
  CCU2C #(
    .INIT0(16'h19ec),
    .INIT1(16'h19ec),
    .INJECT1_0("NO"),
    .INJECT1_1("NO")
  ) CCU2C_9 (
    .A0(a[18]),
    .A1(a[19]),
    .B0(b[18]),
    .B1(b[19]),
    .C0(1'h0),
    .C1(1'h0),
    .CIN(_33_),
    .COUT(_22_),
    .D0(1'h1),
    .D1(1'h1),
    .S0(_11_),
    .S1(_00_)
  );
endmodule

