module lakeroad_xilinx_ultrascale_plus_add8(a, b, out0);
  input [7:0] a;
  wire [7:0] a;
  input [7:0] b;
  wire [7:0] b;
  wire [7:0] co_3;
  wire [7:0] luts_O5_0;
  wire [7:0] luts_O6_1;
  wire [7:0] o_2;
  output [7:0] out0;
  wire [7:0] out0;
  LUT6_2 #(
    .INIT(64'h6000000080000000)
  ) A_LUT_0 (
    .I0(a[0]),
    .I1(b[0]),
    .I2(1'h1),
    .I3(1'h1),
    .I4(1'h1),
    .I5(1'h1),
    .O5(luts_O5_0[0]),
    .O6(luts_O6_1[0])
  );
  LUT6_2 #(
    .INIT(64'h6000000080000000)
  ) B_LUT_1 (
    .I0(a[1]),
    .I1(b[1]),
    .I2(1'h1),
    .I3(1'h1),
    .I4(1'h1),
    .I5(1'h1),
    .O5(luts_O5_0[1]),
    .O6(luts_O6_1[1])
  );
  LUT6_2 #(
    .INIT(64'h6000000080000000)
  ) C_LUT_2 (
    .I0(a[2]),
    .I1(b[2]),
    .I2(1'h1),
    .I3(1'h1),
    .I4(1'h1),
    .I5(1'h1),
    .O5(luts_O5_0[2]),
    .O6(luts_O6_1[2])
  );
  LUT6_2 #(
    .INIT(64'h6000000080000000)
  ) D_LUT_3 (
    .I0(a[3]),
    .I1(b[3]),
    .I2(1'h1),
    .I3(1'h1),
    .I4(1'h1),
    .I5(1'h1),
    .O5(luts_O5_0[3]),
    .O6(luts_O6_1[3])
  );
  LUT6_2 #(
    .INIT(64'h6000000080000000)
  ) E_LUT_4 (
    .I0(a[4]),
    .I1(b[4]),
    .I2(1'h1),
    .I3(1'h1),
    .I4(1'h1),
    .I5(1'h1),
    .O5(luts_O5_0[4]),
    .O6(luts_O6_1[4])
  );
  LUT6_2 #(
    .INIT(64'h6000000080000000)
  ) F_LUT_5 (
    .I0(a[5]),
    .I1(b[5]),
    .I2(1'h1),
    .I3(1'h1),
    .I4(1'h1),
    .I5(1'h1),
    .O5(luts_O5_0[5]),
    .O6(luts_O6_1[5])
  );
  LUT6_2 #(
    .INIT(64'h6000000080000000)
  ) G_LUT_6 (
    .I0(a[6]),
    .I1(b[6]),
    .I2(1'h1),
    .I3(1'h1),
    .I4(1'h1),
    .I5(1'h1),
    .O5(luts_O5_0[6]),
    .O6(luts_O6_1[6])
  );
  LUT6_2 #(
    .INIT(64'h6000000080000000)
  ) H_LUT_7 (
    .I0(a[7]),
    .I1(b[7]),
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
    .CO(co_3),
    .DI(luts_O5_0),
    .O(out0),
    .S(luts_O6_1)
  );
  assign o_2[7] = out0[7];
  assign o_2[6] = out0[6];
  assign o_2[5] = out0[5];
  assign o_2[4] = out0[4];
  assign o_2[3] = out0[3];
  assign o_2[2] = out0[2];
  assign o_2[1] = out0[1];
  assign o_2[0] = out0[0];
endmodule

module baseline(a, b, out0);
  input [7:0] a;
  input [7:0] b;
  output [7:0] out0;
  wire zero;
  wire [8-1:0] p;
  GND GND(.G(zero));
  LUT2 #(.INIT(4'h6)) l0 (.I0(a[0]), .I1(b[0]), .O(p[0]));
  LUT2 #(.INIT(4'h6)) l1 (.I0(a[1]), .I1(b[1]), .O(p[1]));
  LUT2 #(.INIT(4'h6)) l2 (.I0(a[2]), .I1(b[2]), .O(p[2]));
  LUT2 #(.INIT(4'h6)) l3 (.I0(a[3]), .I1(b[3]), .O(p[3]));
  LUT2 #(.INIT(4'h6)) l4 (.I0(a[4]), .I1(b[4]), .O(p[4]));
  LUT2 #(.INIT(4'h6)) l5 (.I0(a[5]), .I1(b[5]), .O(p[5]));
  LUT2 #(.INIT(4'h6)) l6 (.I0(a[6]), .I1(b[6]), .O(p[6]));
  LUT2 #(.INIT(4'h6)) l7 (.I0(a[7]), .I1(b[7]), .O(p[7]));
  CARRY8 #(.CARRY_TYPE("SINGLE_CY8")) carry0 (.CI(zero), .CI_TOP(zero), .DI(a), .S(p), .O(out0), .CO());
endmodule

module main #
(
    parameter W = 8,
    parameter N = 4
)
(
    input clock,
    input reset,
    input [W-1:0] a [N-1:0],
    input [W-1:0] b [N-1:0],
    output [W-1:0] y [N-1:0]
);

    logic [W-1:0] r [N-1:0];
    logic [W-1:0] s [N-1:0];
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin
            //lakeroad_xilinx_ultrascale_plus_add8 inst (.a(a[i]), .b(b[i]), .out0(s[i]));
            baseline inst (.a(a[i]), .b(b[i]), .out0(s[i]));
            always_ff @(posedge clock) begin
                if (reset) begin
                    r[i] <= 0;
                end else begin
                    r[i] <= s[i];
                end
            end
            assign y[i] = r[i];
        end
    endgenerate

    //genvar i;
    //generate
    //    for (i = 0; i < N; i = i + 1) begin
    //        assign y[i] = a[i] + b [i];
    //    end
    //endgenerate
endmodule
