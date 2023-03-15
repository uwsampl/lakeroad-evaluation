/* Generated by Yosys 0.15+50 (git sha1 6318db615, clang 10.0.0-4ubuntu1 -fPIC -Os) */

(* use_dsp = "yes" *)
(* top =  1  *)
(* src = "submodules/chhsiao121_HLS__final_gesture/vivado_project/base/project_1/project_1.srcs/sources_1/bd/base/ipshared/b9a3/hdl/verilog/color_convert_maccud.v:7.23-28.10" *)
module color_convert_maccud_DSP48_1(in0, in1, in2, dout);
  (* src = "submodules/chhsiao121_HLS__final_gesture/vivado_project/base/project_1/project_1.srcs/sources_1/bd/base/ipshared/b9a3/hdl/verilog/color_convert_maccud.v:24.13-24.18" *)
  wire [47:0] _0_;
  (* src = "submodules/chhsiao121_HLS__final_gesture/vivado_project/base/project_1/project_1.srcs/sources_1/bd/base/ipshared/b9a3/hdl/verilog/color_convert_maccud.v:23.13-23.18" *)
  wire [42:0] _1_;
  (* src = "submodules/chhsiao121_HLS__final_gesture/vivado_project/base/project_1/project_1.srcs/sources_1/bd/base/ipshared/b9a3/hdl/verilog/color_convert_maccud.v:13.28-13.29" *)
  wire [24:0] a;
  (* src = "submodules/chhsiao121_HLS__final_gesture/vivado_project/base/project_1/project_1.srcs/sources_1/bd/base/ipshared/b9a3/hdl/verilog/color_convert_maccud.v:14.28-14.29" *)
  wire [17:0] b;
  (* src = "submodules/chhsiao121_HLS__final_gesture/vivado_project/base/project_1/project_1.srcs/sources_1/bd/base/ipshared/b9a3/hdl/verilog/color_convert_maccud.v:15.28-15.29" *)
  wire [47:0] c;
  (* src = "submodules/chhsiao121_HLS__final_gesture/vivado_project/base/project_1/project_1.srcs/sources_1/bd/base/ipshared/b9a3/hdl/verilog/color_convert_maccud.v:11.24-11.28" *)
  output [19:0] dout;
  wire [19:0] dout;
  (* src = "submodules/chhsiao121_HLS__final_gesture/vivado_project/base/project_1/project_1.srcs/sources_1/bd/base/ipshared/b9a3/hdl/verilog/color_convert_maccud.v:8.22-8.25" *)
  input [7:0] in0;
  wire [7:0] in0;
  (* src = "submodules/chhsiao121_HLS__final_gesture/vivado_project/base/project_1/project_1.srcs/sources_1/bd/base/ipshared/b9a3/hdl/verilog/color_convert_maccud.v:9.23-9.26" *)
  input [9:0] in1;
  wire [9:0] in1;
  (* src = "submodules/chhsiao121_HLS__final_gesture/vivado_project/base/project_1/project_1.srcs/sources_1/bd/base/ipshared/b9a3/hdl/verilog/color_convert_maccud.v:10.23-10.26" *)
  input [18:0] in2;
  wire [18:0] in2;
  (* src = "submodules/chhsiao121_HLS__final_gesture/vivado_project/base/project_1/project_1.srcs/sources_1/bd/base/ipshared/b9a3/hdl/verilog/color_convert_maccud.v:16.28-16.29" *)
  wire [42:0] m;
  (* src = "submodules/chhsiao121_HLS__final_gesture/vivado_project/base/project_1/project_1.srcs/sources_1/bd/base/ipshared/b9a3/hdl/verilog/color_convert_maccud.v:17.28-17.29" *)
  wire [47:0] p;
  assign _0_ = $signed(m) + (* src = "submodules/chhsiao121_HLS__final_gesture/vivado_project/base/project_1/project_1.srcs/sources_1/bd/base/ipshared/b9a3/hdl/verilog/color_convert_maccud.v:24.13-24.18" *) $signed(c);
  assign _1_ = $signed(a) * (* src = "submodules/chhsiao121_HLS__final_gesture/vivado_project/base/project_1/project_1.srcs/sources_1/bd/base/ipshared/b9a3/hdl/verilog/color_convert_maccud.v:23.13-23.18" *) $signed(b);
  assign a = { 17'h00000, in0 };
  assign b = { in1[9], in1[9], in1[9], in1[9], in1[9], in1[9], in1[9], in1[9], in1 };
  assign c = { in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2[18], in2 };
  assign m = _1_;
  assign p = _0_;
  assign dout = p[19:0];
endmodule
