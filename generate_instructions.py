"""Generate YAML file of instructions to generate with Lakeroad.

By default, prints to stdout. To write to a file, use the --output-file
argument."""
from email.policy import default
import yaml
from pathlib import Path


def _make_instruction(instruction_name, bitwidth, arity, instruction, architecture):

    # Desired Verilog module name. We will pass this to Lakeroad when
    # implementing the instruction.
    architecture_with_underscores = architecture.replace("-", "_")
    verilog_module_name = (
        f"lakeroad_{architecture_with_underscores}_{instruction_name}{bitwidth}_{arity}"
    )

    # Desired filepath of the Verilog file generated by Lakeroad. This is the
    # filepath we will pass to Lakeroad when implementing the instruction.
    relative_verilog_filepath = (
        Path("lakeroad_impls")
        / architecture_with_underscores
        / f"{verilog_module_name}.v"
    )

    out = {
        "instruction_name": instruction_name,
        "bitwidth": bitwidth,
        "arity": arity,
        "instruction": instruction,
        "architecture": architecture,
        "verilog_module_name": verilog_module_name,
        "relative_verilog_filepath": str(relative_verilog_filepath),
    }

    match architecture:
        case "xilinx-ultrascale-plus":
            out["vivado"] = {
                # Output file after synthesis, optimization, placement, and routing.
                "synth_opt_place_route_relative_filepath": str(
                    Path("synthesis_results")
                    / architecture_with_underscores
                    / f"{verilog_module_name}_synth_opt_place_route.sv"
                ),
                "log_filepath": str(
                    Path("synthesis_results")
                    / architecture_with_underscores
                    / f"{verilog_module_name}_vivado.log"
                ),
            }
        case "lattice-ecp5":
            out["yosys"] = {
                "synth_json_relative_filepath": str(
                    Path("synthesis_results")
                    / architecture_with_underscores
                    / f"{verilog_module_name}_yosys_synth.json"
                ),
                "synth_sv_relative_filepath": str(
                    Path("synthesis_results")
                    / architecture_with_underscores
                    / f"{verilog_module_name}_yosys_synth.sv"
                ),
                "yosys_log_filepath": str(
                    Path("synthesis_results")
                    / architecture_with_underscores
                    / f"{verilog_module_name}_yosys.log"
                ),
                "nextpnr_log_filepath": str(
                    Path("synthesis_results")
                    / architecture_with_underscores
                    / f"{verilog_module_name}_nextpnr.log"
                ),
                "nextpnr_output_sv_filepath": str(
                    Path("synthesis_results")
                    / architecture_with_underscores
                    / f"{verilog_module_name}_nextpnr.sv"
                ),
            }
        case "sofa":
            # TODO
            pass
        case _:
            NotImplementedError(f"Architecture {architecture} not supported.")

    return out


def _make_instructions():
    for bw in [1, 2, 3, 4, 5, 6, 7, 8, 16, 32, 64, 128]:
        yield _make_instruction(
            "and",
            bw,
            2,
            f"(bvand (var a {bw}) (var b {bw}))",
            "xilinx-ultrascale-plus",
        )

        yield _make_instruction(
            "or",
            bw,
            2,
            f"(bvor (var a {bw}) (var b {bw}))",
            "xilinx-ultrascale-plus",
        )
        yield _make_instruction(
            "xor",
            bw,
            2,
            f"(bvxor (var a {bw}) (var b {bw}))",
            "xilinx-ultrascale-plus",
        )
        yield _make_instruction(
            "not",
            bw,
            1,
            f"(bvnot (var a {bw}))",
            "xilinx-ultrascale-plus",
        )
        yield _make_instruction(
            "add",
            bw,
            2,
            f"(bvadd (var a {bw}) (var b {bw}))",
            "xilinx-ultrascale-plus",
        )
        yield _make_instruction(
            "sub",
            bw,
            2,
            f"(bvsub (var a {bw}) (var b {bw}))",
            "xilinx-ultrascale-plus",
        )
        yield _make_instruction(
            "eq",
            bw,
            2,
            f"(bool->bitvector (bveq (var a {bw}) (var b {bw})))",
            "xilinx-ultrascale-plus",
        )
        yield _make_instruction(
            "neq",
            bw,
            2,
            f"(bool->bitvector (not (bveq (var a {bw}) (var b {bw}))))",
            "xilinx-ultrascale-plus",
        )
        yield _make_instruction(
            "ugt",
            bw,
            2,
            f"(bool->bitvector (bvugt (var a {bw}) (var b {bw})))",
            "xilinx-ultrascale-plus",
        )
        yield _make_instruction(
            "ult",
            bw,
            2,
            f"(bool->bitvector (bvult (var a {bw}) (var b {bw})))",
            "xilinx-ultrascale-plus",
        )
        yield _make_instruction(
            "uge",
            bw,
            2,
            f"(bool->bitvector (bvuge (var a {bw}) (var b {bw})))",
            "xilinx-ultrascale-plus",
        )
        yield _make_instruction(
            "ule",
            bw,
            2,
            f"(bool->bitvector (bvule (var a {bw}) (var b {bw})))",
            "xilinx-ultrascale-plus",
        )
        yield _make_instruction(
            "mux",
            bw,
            3,
            f"(circt-comb-mux (var a 1) (var b {bw}) (var c {bw}))",
            "xilinx-ultrascale-plus",
        )

        # Lattice ECP5
        yield _make_instruction(
            "and",
            bw,
            2,
            f"(bvand (var a {bw}) (var b {bw}))",
            "lattice-ecp5",
        )
        yield _make_instruction(
            "or",
            bw,
            2,
            f"(bvor (var a {bw}) (var b {bw}))",
            "lattice-ecp5",
        )
        yield _make_instruction(
            "xor",
            bw,
            2,
            f"(bvxor (var a {bw}) (var b {bw}))",
            "lattice-ecp5",
        )
        yield _make_instruction(
            "not",
            bw,
            1,
            f"(bvnot (var a {bw}))",
            "lattice-ecp5",
        )
        yield _make_instruction(
            "add",
            bw,
            2,
            f"(bvadd (var a {bw}) (var b {bw}))",
            "lattice-ecp5",
        )
        yield _make_instruction(
            "sub",
            bw,
            2,
            f"(bvsub (var a {bw}) (var b {bw}))",
            "lattice-ecp5",
        )
        yield _make_instruction(
            "eq",
            bw,
            2,
            f"(bool->bitvector (bveq (var a {bw}) (var b {bw})))",
            "lattice-ecp5",
        )
        yield _make_instruction(
            "neq",
            bw,
            2,
            f"(bool->bitvector (not (bveq (var a {bw}) (var b {bw}))))",
            "lattice-ecp5",
        )
        yield _make_instruction(
            "ugt",
            bw,
            2,
            f"(bool->bitvector (bvugt (var a {bw}) (var b {bw})))",
            "lattice-ecp5",
        )
        yield _make_instruction(
            "ult",
            bw,
            2,
            f"(bool->bitvector (bvult (var a {bw}) (var b {bw})))",
            "lattice-ecp5",
        )
        yield _make_instruction(
            "uge",
            bw,
            2,
            f"(bool->bitvector (bvuge (var a {bw}) (var b {bw})))",
            "lattice-ecp5",
        )
        yield _make_instruction(
            "ule",
            bw,
            2,
            f"(bool->bitvector (bvule (var a {bw}) (var b {bw})))",
            "lattice-ecp5",
        )
        yield _make_instruction(
            "mux",
            bw,
            3,
            f"(circt-comb-mux (var a 1) (var b {bw}) (var c {bw}))",
            "lattice-ecp5",
        )

        # SOFA
        yield _make_instruction(
            "and",
            bw,
            2,
            f"(bvand (var a {bw}) (var b {bw}))",
            "sofa",
        )
        yield _make_instruction(
            "or",
            bw,
            2,
            f"(bvor (var a {bw}) (var b {bw}))",
            "sofa",
        )
        yield _make_instruction(
            "xor",
            bw,
            2,
            f"(bvxor (var a {bw}) (var b {bw}))",
            "sofa",
        )
        yield _make_instruction(
            "not",
            bw,
            1,
            f"(bvnot (var a {bw}))",
            "sofa",
        )
        yield _make_instruction(
            "mux",
            bw,
            3,
            f"(circt-comb-mux (var a 1) (var b {bw}) (var c {bw}))",
            "sofa",
        )
        yield _make_instruction(
            "add",
            bw,
            2,
            f"(bvadd (var a {bw}) (var b {bw}))",
            "sofa",
        )
        yield _make_instruction(
            "sub",
            bw,
            2,
            f"(bvsub (var a {bw}) (var b {bw}))",
            "sofa",
        )
        yield _make_instruction(
            "eq",
            bw,
            2,
            f"(bool->bitvector (bveq (var a {bw}) (var b {bw})))",
            "sofa",
        )
        yield _make_instruction(
            "neq",
            bw,
            2,
            f"(bool->bitvector (not (bveq (var a {bw}) (var b {bw}))))",
            "sofa",
        )
        yield _make_instruction(
            "ugt",
            bw,
            2,
            f"(bool->bitvector (bvugt (var a {bw}) (var b {bw})))",
            "sofa",
        )
        yield _make_instruction(
            "ult",
            bw,
            2,
            f"(bool->bitvector (bvult (var a {bw}) (var b {bw})))",
            "sofa",
        )
        yield _make_instruction(
            "uge",
            bw,
            2,
            f"(bool->bitvector (bvuge (var a {bw}) (var b {bw})))",
            "sofa",
        )
        yield _make_instruction(
            "ule",
            bw,
            2,
            f"(bool->bitvector (bvule (var a {bw}) (var b {bw})))",
            "sofa",
        )


def main(output_file):
    yaml.dump(list(_make_instructions()), stream=output_file)


if __name__ == "__main__":
    import argparse
    import sys

    parser = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument(
        "--output-file", type=argparse.FileType("w"), default=sys.stdout
    )
    args = parser.parse_args()

    main(args.output_file)