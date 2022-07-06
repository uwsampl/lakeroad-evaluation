/* Generated by Yosys 0.15+50 (git sha1 6318db615, x86_64-apple-darwin20.2-clang 10.0.0-4ubuntu1 -fPIC -Os) */

module lakeroad_xilinx_ultrascale_plus_ugt5_2(a, b, out0);
  input [4:0] a;
  wire [4:0] a;
  input [4:0] b;
  wire [4:0] b;
  wire [7:0] co_3;
  wire [7:0] luts_O5_0;
  wire [7:0] luts_O6_1;
  wire [7:0] o_2;
  output out0;
  wire out0;
  LUT6_2 #(
    .INIT(64'h9fffffffdfffffff)
  ) A_LUT_0 (
    .I0(b[0]),
    .I1(a[0]),
    .I2(1'h1),
    .I3(1'h1),
    .I4(1'h1),
    .I5(1'h1),
    .O5(luts_O5_0[0]),
    .O6(luts_O6_1[0])
  );
  LUT6_2 #(
    .INIT(64'h9fffffffdfffffff)
  ) B_LUT_1 (
    .I0(b[1]),
    .I1(a[1]),
    .I2(1'h1),
    .I3(1'h1),
    .I4(1'h1),
    .I5(1'h1),
    .O5(luts_O5_0[1]),
    .O6(luts_O6_1[1])
  );
  LUT6_2 #(
    .INIT(64'h9fffffffdfffffff)
  ) C_LUT_2 (
    .I0(b[2]),
    .I1(a[2]),
    .I2(1'h1),
    .I3(1'h1),
    .I4(1'h1),
    .I5(1'h1),
    .O5(luts_O5_0[2]),
    .O6(luts_O6_1[2])
  );
  LUT6_2 #(
    .INIT(64'h9fffffffdfffffff)
  ) D_LUT_3 (
    .I0(b[3]),
    .I1(a[3]),
    .I2(1'h1),
    .I3(1'h1),
    .I4(1'h1),
    .I5(1'h1),
    .O5(luts_O5_0[3]),
    .O6(luts_O6_1[3])
  );
  LUT6_2 #(
    .INIT(64'h9fffffffdfffffff)
  ) E_LUT_4 (
    .I0(b[4]),
    .I1(a[4]),
    .I2(1'h1),
    .I3(1'h1),
    .I4(1'h1),
    .I5(1'h1),
    .O5(luts_O5_0[4]),
    .O6(luts_O6_1[4])
  );
  LUT6_2 #(
    .INIT(64'h9fffffffdfffffff)
  ) F_LUT_5 (
    .I0(1'h0),
    .I1(1'h0),
    .I2(1'h1),
    .I3(1'h1),
    .I4(1'h1),
    .I5(1'h1),
    .O5(luts_O5_0[5]),
    .O6(luts_O6_1[5])
  );
  LUT6_2 #(
    .INIT(64'h9fffffffdfffffff)
  ) G_LUT_6 (
    .I0(1'h0),
    .I1(1'h0),
    .I2(1'h1),
    .I3(1'h1),
    .I4(1'h1),
    .I5(1'h1),
    .O5(luts_O5_0[6]),
    .O6(luts_O6_1[6])
  );
  LUT6_2 #(
    .INIT(64'h9fffffffdfffffff)
  ) H_LUT_7 (
    .I0(1'h0),
    .I1(1'h0),
    .I2(1'h1),
    .I3(1'h1),
    .I4(1'h1),
    .I5(1'h1),
    .O5(luts_O5_0[7]),
    .O6(luts_O6_1[7])
  );
  CARRY8 carry_8 (
    .CI(1'h0),
    .CI_TOP(1'h0),
    .CO({ out0, co_3[6:0] }),
    .DI(luts_O5_0),
    .O(o_2),
    .S(luts_O6_1)
  );
  assign co_3[7] = out0;
endmodule
