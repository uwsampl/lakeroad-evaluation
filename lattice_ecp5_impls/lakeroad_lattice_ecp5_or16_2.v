/* Generated by Yosys 0.16+41 (git sha1 29c0a5958, x86_64-apple-darwin20.2-clang 10.0.0-4ubuntu1 -fPIC -Os) */

module lakeroad_lattice_ecp5_or16_2(a, b, out0);
  input [15:0] a;
  wire [15:0] a;
  input [15:0] b;
  wire [15:0] b;
  output [15:0] out0;
  wire [15:0] out0;
  LUT4 #(
    .INIT(16'hefff)
  ) A_LUT_0 (
    .A(a[0]),
    .B(b[0]),
    .C(1'h1),
    .D(1'h1),
    .Z(out0[0])
  );
  LUT4 #(
    .INIT(16'hefff)
  ) A_LUT_8 (
    .A(a[8]),
    .B(b[8]),
    .C(1'h1),
    .D(1'h1),
    .Z(out0[8])
  );
  LUT4 #(
    .INIT(16'hefff)
  ) B_LUT_1 (
    .A(a[1]),
    .B(b[1]),
    .C(1'h1),
    .D(1'h1),
    .Z(out0[1])
  );
  LUT4 #(
    .INIT(16'hefff)
  ) B_LUT_9 (
    .A(a[9]),
    .B(b[9]),
    .C(1'h1),
    .D(1'h1),
    .Z(out0[9])
  );
  LUT4 #(
    .INIT(16'hefff)
  ) C_LUT_10 (
    .A(a[10]),
    .B(b[10]),
    .C(1'h1),
    .D(1'h1),
    .Z(out0[10])
  );
  LUT4 #(
    .INIT(16'hefff)
  ) C_LUT_2 (
    .A(a[2]),
    .B(b[2]),
    .C(1'h1),
    .D(1'h1),
    .Z(out0[2])
  );
  LUT4 #(
    .INIT(16'hefff)
  ) D_LUT_11 (
    .A(a[11]),
    .B(b[11]),
    .C(1'h1),
    .D(1'h1),
    .Z(out0[11])
  );
  LUT4 #(
    .INIT(16'hefff)
  ) D_LUT_3 (
    .A(a[3]),
    .B(b[3]),
    .C(1'h1),
    .D(1'h1),
    .Z(out0[3])
  );
  LUT4 #(
    .INIT(16'hefff)
  ) E_LUT_12 (
    .A(a[12]),
    .B(b[12]),
    .C(1'h1),
    .D(1'h1),
    .Z(out0[12])
  );
  LUT4 #(
    .INIT(16'hefff)
  ) E_LUT_4 (
    .A(a[4]),
    .B(b[4]),
    .C(1'h1),
    .D(1'h1),
    .Z(out0[4])
  );
  LUT4 #(
    .INIT(16'hefff)
  ) F_LUT_13 (
    .A(a[13]),
    .B(b[13]),
    .C(1'h1),
    .D(1'h1),
    .Z(out0[13])
  );
  LUT4 #(
    .INIT(16'hefff)
  ) F_LUT_5 (
    .A(a[5]),
    .B(b[5]),
    .C(1'h1),
    .D(1'h1),
    .Z(out0[5])
  );
  LUT4 #(
    .INIT(16'hefff)
  ) G_LUT_14 (
    .A(a[14]),
    .B(b[14]),
    .C(1'h1),
    .D(1'h1),
    .Z(out0[14])
  );
  LUT4 #(
    .INIT(16'hefff)
  ) G_LUT_6 (
    .A(a[6]),
    .B(b[6]),
    .C(1'h1),
    .D(1'h1),
    .Z(out0[6])
  );
  LUT4 #(
    .INIT(16'hefff)
  ) H_LUT_15 (
    .A(a[15]),
    .B(b[15]),
    .C(1'h1),
    .D(1'h1),
    .Z(out0[15])
  );
  LUT4 #(
    .INIT(16'hefff)
  ) H_LUT_7 (
    .A(a[7]),
    .B(b[7]),
    .C(1'h1),
    .D(1'h1),
    .Z(out0[7])
  );
endmodule

