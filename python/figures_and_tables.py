"""DoIt tasks for creating paper figures and tables."""

import doit
import pandas as pd
import utils
from pathlib import Path
from typing import Union


@doit.task_params(
    [
        {
            "name": "gathered_data_filepath",
            "default": str(
                utils.output_dir() / "gathered_data" / "lakeroad_sofa_results.csv"
            ),
            "type": str,
        },
        {
            "name": "csv_filepath",
            "default": str(utils.output_dir() / "figures" / "sofa_figure.csv"),
            "type": str,
        },
        {
            "name": "tex_filepath",
            "default": str(utils.output_dir() / "figures" / "sofa_figure.tex"),
            "type": str,
        },
        {
            "name": "excel_filepath",
            "default": str(utils.output_dir() / "figures" / "sofa_figure.xlsx"),
            "type": str,
        },
    ]
)
def task_make_sofa_figure(
    gathered_data_filepath: Union[str, Path],
    csv_filepath: Union[str, Path],
    tex_filepath: Union[str, Path],
    excel_filepath: Union[str, Path],
):
    gathered_data_filepath = Path(gathered_data_filepath)
    csv_filepath = Path(csv_filepath)
    tex_filepath = Path(tex_filepath)
    excel_filepath = Path(excel_filepath)

    instruction_col = ("", "", "Instr")
    template_col = ("", "", "Template")
    lakeroad_runtime_col = ("SOFA", "Lakeroad", "Runtime in sec")
    lakeroad_num_luts_col = ("SOFA", "Lakeroad", "#LUTs")
    diamond_support_col = ("SOFA", "Diamond", "Support")
    vivado_support_col = ("SOFA", "Vivado", "Support")

    columns = pd.MultiIndex.from_tuples(
        [
            instruction_col,
            template_col,
            lakeroad_runtime_col,
            lakeroad_num_luts_col,
            diamond_support_col,
            vivado_support_col,
        ]
    )

    def _impl():
        csv_filepath.parent.mkdir(parents=True, exist_ok=True)
        tex_filepath.parent.mkdir(parents=True, exist_ok=True)
        excel_filepath.parent.mkdir(parents=True, exist_ok=True)

        data = pd.read_csv(gathered_data_filepath)
        table = pd.DataFrame(columns=columns)

        def add_row(instr, arity, template):
            # Row of raw data that we'll convert into an output table row.
            raw_data_row = data.loc[
                (data["module_name"] == f"lakeroad_sofa_{instr}_{arity}")
                & (data["template"] == template)
            ].squeeze()

            match template:
                case "bitwise":
                    short_template = "BW"
                case "bitwise-with-carry":
                    short_template = "Carry"
                case "multiplication":
                    short_template = "Mult"
                case "comparison":
                    short_template = "Comp"
                case _:
                    raise Exception(f"Unknown template: {template}")
            out_row = pd.DataFrame(
                [
                    [
                        instr,
                        short_template,
                        raw_data_row["lakeroad_runtime_s"],
                        raw_data_row["frac_lut4"],
                        "X",
                        "X",
                    ]
                ],
                columns=columns,
            )
            nonlocal table
            table = pd.concat([table, out_row], ignore_index=True)

        add_row("and8", 2, "bitwise")
        add_row("and16", 2, "bitwise")
        add_row("and32", 2, "bitwise")
        add_row("or8", 2, "bitwise")
        add_row("or16", 2, "bitwise")
        add_row("or32", 2, "bitwise")
        add_row("xor8", 2, "bitwise")
        add_row("xor16", 2, "bitwise")
        add_row("xor32", 2, "bitwise")
        add_row("not8", 1, "bitwise")
        add_row("not16", 1, "bitwise")
        add_row("not32", 1, "bitwise")
        add_row("mux8", 3, "bitwise")
        add_row("mux16", 3, "bitwise")
        add_row("mux32", 3, "bitwise")
        add_row("add8", 2, "bitwise-with-carry")
        add_row("add16", 2, "bitwise-with-carry")
        add_row("add32", 2, "bitwise-with-carry")
        add_row("sub8", 2, "bitwise-with-carry")
        add_row("sub16", 2, "bitwise-with-carry")
        add_row("sub32", 2, "bitwise-with-carry")
        add_row("mul8", 2, "multiplication")
        table = pd.concat(
            [
                table,
                pd.DataFrame(
                    [
                        ["mul16", "-", "-", "-", "X", "X"],
                        ["mul32", "-", "-", "-", "X", "X"],
                    ],
                    columns=columns,
                ),
            ],
            ignore_index=True,
        )
        add_row("eq8", 2, "comparison")
        add_row("eq16", 2, "comparison")
        add_row("eq32", 2, "comparison")
        add_row("neq8", 2, "comparison")
        add_row("neq16", 2, "comparison")
        add_row("neq32", 2, "comparison")
        add_row("ugt8", 2, "comparison")
        add_row("ugt16", 2, "comparison")
        add_row("ugt32", 2, "comparison")
        add_row("ult8", 2, "comparison")
        add_row("ult16", 2, "comparison")
        add_row("ult32", 2, "comparison")
        add_row("uge8", 2, "comparison")
        add_row("uge16", 2, "comparison")
        add_row("uge32", 2, "comparison")
        add_row("ule8", 2, "comparison")
        add_row("ule16", 2, "comparison")
        add_row("ule32", 2, "comparison")

        table.to_csv(
            csv_filepath,
        )
        styler = table.style.format(precision=1).hide(axis="index")
        styler.to_latex(tex_filepath)
        styler.to_excel(excel_filepath)

    return {"actions": [(_impl,)], "file_dep": [gathered_data_filepath]}


@doit.task_params(
    [
        {
            "name": "gathered_lakeroad_data_filepath",
            "default": str(
                utils.output_dir()
                / "gathered_data"
                / "lakeroad_lattice_ecp5_diamond_results.csv"
            ),
            "type": str,
        },
        {
            "name": "gathered_diamond_data_filepath",
            "default": str(
                utils.output_dir() / "gathered_data" / "diamond_baseline.csv"
            ),
            "type": str,
        },
        {
            "name": "gathered_yosys_data_filepath",
            "default": str(
                utils.output_dir() / "gathered_data" / "yosys_lattice_ecp5_baseline.csv"
            ),
            "type": str,
        },
        {
            "name": "csv_filepath",
            "default": str(utils.output_dir() / "figures" / "lattice_ecp5_figure.csv"),
            "type": str,
        },
        {
            "name": "tex_filepath",
            "default": str(utils.output_dir() / "figures" / "lattice_ecp5_figure.tex"),
            "type": str,
        },
        {
            "name": "excel_filepath",
            "default": str(utils.output_dir() / "figures" / "lattice_ecp5_figure.xlsx"),
            "type": str,
        },
    ]
)
def task_make_lattice_ecp5_figure(
    gathered_lakeroad_data_filepath: Union[str, Path],
    gathered_diamond_data_filepath: Union[str, Path],
    gathered_yosys_data_filepath: Union[str, Path],
    csv_filepath: Union[str, Path],
    tex_filepath: Union[str, Path],
    excel_filepath: Union[str, Path],
):
    gathered_lakeroad_data_filepath = Path(gathered_lakeroad_data_filepath)
    gathered_diamond_data_filepath = Path(gathered_diamond_data_filepath)
    gathered_yosys_data_filepath = Path(gathered_yosys_data_filepath)
    csv_filepath = Path(csv_filepath)
    tex_filepath = Path(tex_filepath)
    excel_filepath = Path(excel_filepath)

    columns = pd.MultiIndex.from_tuples(
        [
            ("", "", "Instr"),
            ("", "", "Template"),
            ("Lattice ECP5", "Lakeroad", "Runtime in sec"),
            ("Lattice ECP5", "Lakeroad", "#LUTs"),
            ("Lattice ECP5", "Lakeroad", "#CCU2Cs"),
            ("Lattice ECP5", "Lakeroad", "MUL? (sec)"),
            ("Lattice ECP5", "Yosys", "Runtime in sec"),
            ("Lattice ECP5", "Yosys", "#LUTs"),
            ("Lattice ECP5", "Yosys", "#muxes"),
            ("Lattice ECP5", "Yosys", "#CCU2Cs"),
            ("Lattice ECP5", "Yosys", "#MUL"),
            ("Lattice ECP5", "Diamond", "Runtime in sec"),
            ("Lattice ECP5", "Diamond", "#LUTs"),
            ("Lattice ECP5", "Diamond", "#CCU2Cs"),
            ("Lattice ECP5", "Diamond", "#MUL"),
            ("Lattice ECP5", "Diamond", "#ALU"),
            ("Lattice ECP5", "Vivado", "Support"),
        ]
    )

    def _impl():
        csv_filepath.parent.mkdir(parents=True, exist_ok=True)
        tex_filepath.parent.mkdir(parents=True, exist_ok=True)
        excel_filepath.parent.mkdir(parents=True, exist_ok=True)

        lakeroad_data = pd.read_csv(gathered_lakeroad_data_filepath)
        diamond_data = pd.read_csv(gathered_diamond_data_filepath)
        yosys_data = pd.read_csv(gathered_yosys_data_filepath)
        table = pd.DataFrame(columns=columns)

        def add_row(instr, arity, template):
            # Row of raw data that we'll convert into an output table row.
            raw_lakeroad_data_row = lakeroad_data.loc[
                (
                    lakeroad_data["module_name"]
                    == f"lakeroad_lattice_ecp5_{instr}_{arity}"
                )
                & (lakeroad_data["template"] == template)
            ].squeeze()
            assert raw_lakeroad_data_row.empty or isinstance(
                raw_lakeroad_data_row, pd.Series
            )

            dsp_impl = lakeroad_data.loc[
                (
                    lakeroad_data["module_name"]
                    == f"lakeroad_lattice_ecp5_{instr}_{arity}"
                )
                & (lakeroad_data["template"] == "lattice-ecp5-dsp")
            ].squeeze()
            assert dsp_impl.empty or isinstance(dsp_impl, pd.Series)

            raw_yosys_data_row = yosys_data.loc[
                yosys_data["identifier"] == f"{instr}_{arity}"
            ].squeeze()
            assert isinstance(raw_yosys_data_row, pd.Series)

            raw_diamond_data_row = diamond_data.loc[
                diamond_data["identifier"] == f"{instr}_{arity}"
            ].squeeze()
            assert isinstance(raw_diamond_data_row, pd.Series)

            match template:
                case "bitwise":
                    short_template = "BW"
                case "bitwise-with-carry":
                    short_template = "Carry"
                case "multiplication":
                    short_template = "Mult"
                case "comparison":
                    short_template = "Comp"
                case _:
                    raise Exception(f"Unknown template: {template}")

            # If we don't actually have an implementation, the template is blank.
            if raw_lakeroad_data_row.empty:
                short_template = "--"

            out_row = pd.DataFrame(
                [
                    [
                        instr,
                        short_template,
                        raw_lakeroad_data_row["lakeroad_runtime_s"]
                        if not raw_lakeroad_data_row.empty
                        else None,
                        raw_lakeroad_data_row["LUT4"]
                        if not raw_lakeroad_data_row.empty
                        else None,
                        raw_lakeroad_data_row["CCU2C"]
                        if not raw_lakeroad_data_row.empty
                        else None,
                        None
                        if dsp_impl.empty
                        else f"✓({dsp_impl['lakeroad_runtime_s']})",
                        raw_yosys_data_row["yosys_runtime_s"],
                        raw_yosys_data_row["LUT4"],
                        raw_yosys_data_row["L6MUX21"] + raw_yosys_data_row["PFUMX"],
                        raw_yosys_data_row["CCU2C"],
                        raw_yosys_data_row["MULT18X18D"],
                        raw_diamond_data_row["diamond_cpu_time"],
                        raw_diamond_data_row["num_LUT4"],
                        raw_diamond_data_row["num_CCU2C"],
                        raw_diamond_data_row["num_MULT18X18D"]
                        + raw_diamond_data_row["num_MULT9X9D"],
                        raw_diamond_data_row["num_ALU54B"],
                        "X",
                    ]
                ],
                columns=columns,
            )
            nonlocal table
            table = pd.concat([table, out_row], ignore_index=True)

        add_row("and8", 2, "bitwise")
        add_row("and16", 2, "bitwise")
        add_row("and32", 2, "bitwise")
        add_row("or8", 2, "bitwise")
        add_row("or16", 2, "bitwise")
        add_row("or32", 2, "bitwise")
        add_row("xor8", 2, "bitwise")
        add_row("xor16", 2, "bitwise")
        add_row("xor32", 2, "bitwise")
        add_row("not8", 1, "bitwise")
        add_row("not16", 1, "bitwise")
        add_row("not32", 1, "bitwise")
        add_row("mux8", 3, "bitwise")
        add_row("mux16", 3, "bitwise")
        add_row("mux32", 3, "bitwise")
        add_row("add8", 2, "bitwise-with-carry")
        add_row("add16", 2, "bitwise-with-carry")
        add_row("add32", 2, "bitwise-with-carry")
        add_row("sub8", 2, "bitwise-with-carry")
        add_row("sub16", 2, "bitwise-with-carry")
        add_row("sub32", 2, "bitwise-with-carry")
        add_row("mul8", 2, "multiplication")
        add_row("mul16", 2, "multiplication")
        add_row("mul32", 2, "multiplication")
        # table = pd.concat(
        #    [
        #        table,
        #        pd.DataFrame(
        #            [
        #                ["mul16", "-", "-", "-", "X", "X"],
        #                ["mul32", "-", "-", "-", "X", "X"],
        #            ],
        #            columns=columns,
        #        ),
        #    ],
        #    ignore_index=True,
        # )
        add_row("eq8", 2, "comparison")
        add_row("eq16", 2, "comparison")
        add_row("eq32", 2, "comparison")
        add_row("neq8", 2, "comparison")
        add_row("neq16", 2, "comparison")
        add_row("neq32", 2, "comparison")
        add_row("ugt8", 2, "comparison")
        add_row("ugt16", 2, "comparison")
        add_row("ugt32", 2, "comparison")
        add_row("ult8", 2, "comparison")
        add_row("ult16", 2, "comparison")
        add_row("ult32", 2, "comparison")
        add_row("uge8", 2, "comparison")
        add_row("uge16", 2, "comparison")
        add_row("uge32", 2, "comparison")
        add_row("ule8", 2, "comparison")
        add_row("ule16", 2, "comparison")
        add_row("ule32", 2, "comparison")

        table.to_csv(
            csv_filepath,
        )
        styler = table.style.format(precision=1).hide(axis="index")
        styler.to_latex(tex_filepath)
        styler.to_excel(excel_filepath)

    return {
        "actions": [(_impl, [])],
        "file_dep": [
            gathered_diamond_data_filepath,
            gathered_yosys_data_filepath,
            gathered_lakeroad_data_filepath,
        ],
        "targets": [csv_filepath, tex_filepath, excel_filepath],
    }


@doit.task_params(
    [
        {
            "name": "gathered_lakeroad_data_filepath",
            "default": str(
                utils.output_dir()
                / "gathered_data"
                / "lakeroad_xilinx_ultrascale_plus_vivado_results.csv"
            ),
            "type": str,
        },
        {
            "name": "gathered_vivado_data_filepath",
            "default": str(
                utils.output_dir() / "gathered_data" / "vivado_baseline.csv"
            ),
            "type": str,
        },
        {
            "name": "gathered_yosys_data_filepath",
            "default": str(
                utils.output_dir()
                / "gathered_data"
                / "yosys_xilinx_ultrascale_plus_baseline.csv"
            ),
            "type": str,
        },
        {
            "name": "csv_filepath",
            "default": str(
                utils.output_dir() / "figures" / "xilinx_ultrascale_plus_figure.csv"
            ),
            "type": str,
        },
        {
            "name": "tex_filepath",
            "default": str(
                utils.output_dir() / "figures" / "xilinx_ultrascale_plus_figure.tex"
            ),
            "type": str,
        },
        {
            "name": "excel_filepath",
            "default": str(
                utils.output_dir() / "figures" / "xilinx_ultrascale_plus_figure.xlsx"
            ),
            "type": str,
        },
    ]
)
def task_make_xilinx_ultrascale_plus_figure(
    gathered_lakeroad_data_filepath: Union[str, Path],
    gathered_vivado_data_filepath: Union[str, Path],
    gathered_yosys_data_filepath: Union[str, Path],
    csv_filepath: Union[str, Path],
    tex_filepath: Union[str, Path],
    excel_filepath: Union[str, Path],
):
    gathered_lakeroad_data_filepath = Path(gathered_lakeroad_data_filepath)
    gathered_vivado_data_filepath = Path(gathered_vivado_data_filepath)
    gathered_yosys_data_filepath = Path(gathered_yosys_data_filepath)
    csv_filepath = Path(csv_filepath)
    tex_filepath = Path(tex_filepath)
    excel_filepath = Path(excel_filepath)

    columns = pd.MultiIndex.from_tuples(
        [
            ("", "", "Instr"),
            ("", "", "Template"),
            ("Xilinx UltraScale+", "Lakeroad", "Runtime in sec"),
            ("Xilinx UltraScale+", "Lakeroad", "#LUTs"),
            ("Xilinx UltraScale+", "Lakeroad", "#CARRY8s"),
            ("Xilinx UltraScale+", "Lakeroad", "DSP? (sec)"),
            ("Xilinx UltraScale+", "Yosys", "Runtime in sec"),
            ("Xilinx UltraScale+", "Yosys", "#LUTs"),
            ("Xilinx UltraScale+", "Yosys", "#muxes"),
            ("Xilinx UltraScale+", "Yosys", "#CARRY4s"),
            ("Xilinx UltraScale+", "Yosys", "#INVs"),
            ("Xilinx UltraScale+", "Yosys", "#DSPs"),
            ("Xilinx UltraScale+", "Vivado", "Runtime in sec"),
            ("Xilinx UltraScale+", "Vivado", "#LUTs"),
            ("Xilinx UltraScale+", "Vivado", "#CARRY8s"),
            ("Xilinx UltraScale+", "Vivado", "#DSPs"),
            ("Xilinx UltraScale+", "Diamond", "Support"),
        ]
    )

    def _impl():
        csv_filepath.parent.mkdir(parents=True, exist_ok=True)
        tex_filepath.parent.mkdir(parents=True, exist_ok=True)
        excel_filepath.parent.mkdir(parents=True, exist_ok=True)

        lakeroad_data = pd.read_csv(gathered_lakeroad_data_filepath)
        vivado_data = pd.read_csv(gathered_vivado_data_filepath)
        yosys_data = pd.read_csv(gathered_yosys_data_filepath)
        table = pd.DataFrame(columns=columns)

        def add_row(instr, arity, template):
            # Row of raw data that we'll convert into an output table row.
            raw_lakeroad_data_row = lakeroad_data.loc[
                (
                    lakeroad_data["module_name"]
                    == f"lakeroad_xilinx_ultrascale_plus_{instr}_{arity}"
                )
                & (lakeroad_data["template"] == template)
            ].squeeze()
            assert raw_lakeroad_data_row.empty or isinstance(
                raw_lakeroad_data_row, pd.Series
            )

            dsp_impl = lakeroad_data.loc[
                (
                    lakeroad_data["module_name"]
                    == f"lakeroad_xilinx_ultrascale_plus_{instr}_{arity}"
                )
                & (lakeroad_data["template"] == "xilinx-ultrascale-plus-dsp48e2")
            ].squeeze()
            assert dsp_impl.empty or isinstance(dsp_impl, pd.Series)

            raw_yosys_data_row = yosys_data.loc[
                yosys_data["identifier"] == f"{instr}_{arity}"
            ].squeeze()
            assert isinstance(raw_yosys_data_row, pd.Series)

            raw_vivado_data_row = vivado_data.loc[
                vivado_data["identifier"] == f"{instr}_{arity}"
            ].squeeze()
            assert isinstance(raw_vivado_data_row, pd.Series)

            match template:
                case "bitwise":
                    short_template = "BW"
                case "bitwise-with-carry":
                    short_template = "Carry"
                case "multiplication":
                    short_template = "Mult"
                case "comparison":
                    short_template = "Comp"
                case _:
                    raise Exception(f"Unknown template: {template}")

            # If we don't actually have an implementation, the template is blank.
            if raw_lakeroad_data_row.empty:
                short_template = "--"

            out_row = pd.DataFrame(
                [
                    [
                        instr,
                        short_template,
                        raw_lakeroad_data_row["lakeroad_runtime_s"]
                        if not raw_lakeroad_data_row.empty
                        else None,
                        # LUTs
                        (
                            (
                                raw_lakeroad_data_row["LUT2"]
                                if "LUT2" in raw_lakeroad_data_row
                                else 0
                            )
                            + (
                                raw_lakeroad_data_row["LUT3"]
                                if "LUT3" in raw_lakeroad_data_row
                                else 0
                            )
                            + (
                                raw_lakeroad_data_row["LUT4"]
                                if "LUT4" in raw_lakeroad_data_row
                                else 0
                            )
                            + (
                                raw_lakeroad_data_row["LUT5"]
                                if "LUT5" in raw_lakeroad_data_row
                                else 0
                            )
                            + (
                                raw_lakeroad_data_row["LUT6"]
                                if "LUT6" in raw_lakeroad_data_row
                                else 0
                            )
                            + (
                                raw_lakeroad_data_row["LUT6_2"]
                                if "LUT6_2" in raw_lakeroad_data_row
                                else 0
                            )
                        )
                        if not raw_lakeroad_data_row.empty
                        else None,
                        # Carries
                        (
                            (
                                raw_lakeroad_data_row["CARRY4"]
                                if "CARRY4" in raw_lakeroad_data_row
                                else 0
                            )
                            + (
                                raw_lakeroad_data_row["CARRY8"]
                                if "CARRY8" in raw_lakeroad_data_row
                                else 0
                            )
                        )
                        if not raw_lakeroad_data_row.empty
                        else None,
                        None
                        if dsp_impl.empty
                        else f"✓({dsp_impl['lakeroad_runtime_s']})",
                        raw_yosys_data_row["yosys_runtime_s"],
                        raw_yosys_data_row["LUT4"],
                        # Yosys muxes
                        raw_yosys_data_row["MUXF7"] + raw_yosys_data_row["MUXF8"],
                        raw_yosys_data_row["CARRY4"],
                        raw_yosys_data_row["INV"],
                        raw_yosys_data_row["DSP48E2"],
                        raw_vivado_data_row["synth_time"],
                        raw_vivado_data_row["clb_luts"],
                        raw_vivado_data_row["carry8s"],
                        "TODO",
                        "X",
                    ]
                ],
                columns=columns,
            )
            nonlocal table
            table = pd.concat([table, out_row], ignore_index=True)

        add_row("and8", 2, "bitwise")
        add_row("and16", 2, "bitwise")
        add_row("and32", 2, "bitwise")
        add_row("or8", 2, "bitwise")
        add_row("or16", 2, "bitwise")
        add_row("or32", 2, "bitwise")
        add_row("xor8", 2, "bitwise")
        add_row("xor16", 2, "bitwise")
        add_row("xor32", 2, "bitwise")
        add_row("not8", 1, "bitwise")
        add_row("not16", 1, "bitwise")
        add_row("not32", 1, "bitwise")
        add_row("mux8", 3, "bitwise")
        add_row("mux16", 3, "bitwise")
        add_row("mux32", 3, "bitwise")
        add_row("add8", 2, "bitwise-with-carry")
        add_row("add16", 2, "bitwise-with-carry")
        add_row("add32", 2, "bitwise-with-carry")
        add_row("sub8", 2, "bitwise-with-carry")
        add_row("sub16", 2, "bitwise-with-carry")
        add_row("sub32", 2, "bitwise-with-carry")
        add_row("mul8", 2, "multiplication")
        add_row("mul16", 2, "multiplication")
        add_row("mul32", 2, "multiplication")
        # table = pd.concat(
        #    [
        #        table,
        #        pd.DataFrame(
        #            [
        #                ["mul16", "-", "-", "-", "X", "X"],
        #                ["mul32", "-", "-", "-", "X", "X"],
        #            ],
        #            columns=columns,
        #        ),
        #    ],
        #    ignore_index=True,
        # )
        add_row("eq8", 2, "comparison")
        add_row("eq16", 2, "comparison")
        add_row("eq32", 2, "comparison")
        add_row("neq8", 2, "comparison")
        add_row("neq16", 2, "comparison")
        add_row("neq32", 2, "comparison")
        add_row("ugt8", 2, "comparison")
        add_row("ugt16", 2, "comparison")
        add_row("ugt32", 2, "comparison")
        add_row("ult8", 2, "comparison")
        add_row("ult16", 2, "comparison")
        add_row("ult32", 2, "comparison")
        add_row("uge8", 2, "comparison")
        add_row("uge16", 2, "comparison")
        add_row("uge32", 2, "comparison")
        add_row("ule8", 2, "comparison")
        add_row("ule16", 2, "comparison")
        add_row("ule32", 2, "comparison")

        table.to_csv(
            csv_filepath,
        )
        styler = table.style.format(precision=1).hide(axis="index")
        styler.to_latex(tex_filepath)
        styler.to_excel(excel_filepath)

    return {
        "actions": [(_impl, [])],
        "file_dep": [
            gathered_vivado_data_filepath,
            gathered_yosys_data_filepath,
            gathered_lakeroad_data_filepath,
        ],
        "targets": [csv_filepath, tex_filepath, excel_filepath],
    }
