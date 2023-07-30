from typing import Optional, Union

import yaml
import hardware_compilation
import lakeroad
import utils
import json
from typing import List
import pandas
import logging
import verilator
import quartus
import os
from pathlib import Path
import numpy as np


def _visualize_succeeded_vs_failed(
    csv_filepath: Union[str, Path], plot_output_filepath: Union[str, Path]
):
    df = pandas.read_csv(csv_filepath)

    # Make sure we're aware of all columns that may exist. This is so we're sure
    # that we're not forgetting to take some columns into account.
    assert set(df.columns).issubset(
        set(
            [
                "LUT2",
                "LUT3",
                "LUT4",
                "LUT5",
                "LUT6",
                "DSP48E2",
                "tool",
                "architecture",
                "time_s",
                "returncode",
                "lakeroad_synthesis_success",
                "lakeroad_synthesis_timeout",
                "lakeroad_synthesis_failure",
                "identifier",
            ]
        )
    )

    # Column which checks whether the experiment uses one DSP and no other
    # computational units (LUTs).
    df["only_use_one_dsp"] = (df.get("DSP48E2", 0) == 1) & (
        (
            df.get("LUT2", 0)
            + df.get("LUT3", 0)
            + df.get("LUT4", 0)
            + df.get("LUT5", 0)
            + df.get("LUT6", 0)
        )
        == 0
    )

    suc_v_unsuc = pandas.DataFrame({"tool": ["lakeroad", "vivado", "yosys"]})
    suc_v_unsuc["num_experiments"] = suc_v_unsuc["tool"].map(
        lambda t: (df["tool"] == t).sum()
    )
    suc_v_unsuc["num_successful"] = suc_v_unsuc["tool"].map(
        lambda t: ((df["tool"] == t) & df["only_use_one_dsp"]).sum()
    )
    # We ignore Lakeroad, because we'll calculate different
    # successful/unsuccessful columns for Lakeroad.
    suc_v_unsuc["num_unsuccessful"] = suc_v_unsuc["tool"].map(
        lambda t: ((df["tool"] == t) & ~df["only_use_one_dsp"]).sum()
        if t != "lakeroad"
        else 0
    )
    # Lakeroad unsuccessful columns.
    suc_v_unsuc["num_lr_unsat"] = suc_v_unsuc["tool"].map(
        lambda t: (
            (df["tool"] == t)
            & ~df["only_use_one_dsp"]
            & df["lakeroad_synthesis_failure"]
        ).sum()
        if t == "lakeroad"
        else 0
    )
    suc_v_unsuc["num_lr_timeout"] = suc_v_unsuc["tool"].map(
        lambda t: (
            (df["tool"] == t)
            & ~df["only_use_one_dsp"]
            & df["lakeroad_synthesis_timeout"]
        ).sum()
        if t == "lakeroad"
        else 0
    )

    # Sanity check.
    assert suc_v_unsuc["num_experiments"].equals(
        suc_v_unsuc["num_successful"]
        + suc_v_unsuc["num_unsuccessful"]
        + suc_v_unsuc["num_lr_unsat"]
        + suc_v_unsuc["num_lr_timeout"]
    )

    ax = suc_v_unsuc.plot.bar(
        x="tool",
        y=["num_successful", "num_unsuccessful", "num_lr_unsat", "num_lr_timeout"],
        stacked=True,
        rot=0,
    )
    plot_output_filepath = Path(plot_output_filepath)
    plot_output_filepath.parent.mkdir(parents=True, exist_ok=True)
    ax.get_figure().savefig(plot_output_filepath)


def _collect_robustness_benchmark_data(
    filepaths: List[Union[str, Path]], output_filepath: Union[str, Path]
):
    """Collect Robustness benchmark results into a file, but do not process them."""
    # print(filepaths)
    Path(output_filepath).parent.mkdir(parents=True, exist_ok=True)
    failures = []
    real = []
    for f in filepaths:
        if not os.path.exists(f):
            failures.append(f)
        else:
            real.append(f)
    pandas.DataFrame.from_records(
        filter(
            lambda x: x is not None,
            map(lambda f: json.load(open(f)) if os.path.exists(f) else None, filepaths),
        )
    ).to_csv(output_filepath, index=False)
    # pandas.DataFrame.from_records(filter(lambda x: x is not None, map(lambda f: json.load(open(f)) if os.path.exists(f) else None, filepaths))
    #     output_filepath, index=False
    # )
    # write failures to failures.txt
    with open("failures.txt", "w+") as ff:
        for f in failures:
            ff.write(str(f)[61 : (len(str(f))) - 20] + "\n")
    ff.close()
    with open("real.txt", "w+") as fg:
        for f in real:
            fg.write(str(f) + "\n")
    fg.close()


def check_dsp_usage(
    module_name: str,
    tool_name: str,
    resource_utilization_json_filepath: Union[str, Path],
    expect_only_dsp: Optional[bool] = True,
    expect_fail: Optional[bool] = False,
):
    # raise Exception("incorrect dsp usage without expecting a failed mapping")
    with open(resource_utilization_json_filepath, "r") as f:
        resource_utilization = json.load(f)
    """Check if the resource utilization uses DSPs"""
    # create error folder if it doesn't exist
    if tool_name == "vivado":
        # check all the dsps for vivado
        resource_list = ["DSP48E2", "LUT2"]
        # if we only expect a dsp, raise exceptions if we see conflicting results in the resource utilization
        if expect_only_dsp:
            # NO DSP USED
            if (
                "DSP48E2" not in resource_utilization
                or resource_utilization["DSP48E2"] > 1
            ):
                if not expect_fail:
                    raise Exception(
                        "incorrect dsp usage without expecting a failed mapping"
                    )
            # OTHER PRIMITIVES USED
            if "LUT2" in resource_utilization:
                if not expect_fail:
                    raise Exception("lut used without expecting a failed mapping")

    if tool_name == "lakeroad-xilinx":
        resource_list = ["DSP48E2", "LUT2"]
        if expect_only_dsp:
            if (
                "DSP48E2" not in resource_utilization
                or resource_utilization["DSP48E2"] > 1
            ):
                if not expect_fail:
                    raise Exception(
                        "incorrect dsp usage without expecting a failed mapping"
                    )
            if "LUT2" in resource_utilization:
                if not expect_fail:
                    raise Exception("lut used without expecting a failed mapping")
    if tool_name == "yosys-xilinx":
        resource_list = ["DSP48E2", "LUT2"]
        if expect_only_dsp:
            if (
                "DSP48E2" not in resource_utilization
                or resource_utilization["DSP48E2"] > 1
            ):
                if not expect_fail:
                    raise Exception(
                        "incorrect dsp usage without expecting a failed mapping"
                    )
            if "LUT2" in resource_utilization:
                if not expect_fail:
                    raise Exception("lut used without expecting a failed mapping")
    if tool_name == "diamond":
        # Skip all of the non-computational primitives
        resource_skip_set = set(
            [
                "FD1S3AX",
                "GSR",
                "IB",
                "OB",
                "OFS1P3DX",
                "PUR",
                "VHI",
                "VLO",
                "DPR16X4C",
                "IFS1P3DX",
            ]
        )
        computational = resource_utilization.keys() - resource_skip_set

        # check to make sure only dsps are in the computational primitives based off what we expect
        if expect_only_dsp:
            if (
                "MULT9X9D" not in resource_utilization
                and "MULT18X18D" not in resource_utilization
            ):
                if not expect_fail:
                    with open(error_folder_path / "diamond.json", "w+") as f:
                        json.dump(resource_utilization, f)
                    raise Exception(
                        "incorrect dsp usage without expecting a failed mapping"
                    )
                    # raise Exception("lut used without expecting a failed mapping")
            if len(computational) != 1:
                if not expect_fail:
                    with open(error_folder_path / "diamond.json", "w+") as f:
                        json.dump(resource_utilization, f)
                    # raise Exception("incorrect dsp usage withot expecting a failed mapping")
                    raise Exception("extra primitives used" + str(computational))
    if tool_name == "lakeroad-lattice":
        if expect_only_dsp:
            if (
                "MULT18X18D" not in resource_utilization
                or resource_utilization["MULT18X18D"] > 1
            ):
                if not expect_fail:
                    with open(error_folder_path / "diamond.json", "w+") as f:
                        json.dump(resource_utilization, f)
                    # raise Exception("incorrect dsp usage without expecting a failed mapping")
            if len(resource_utilization) != 1:
                if not expect_fail:
                    with open(error_folder_path / "diamond.json", "w+") as f:
                        json.dump(resource_utilization, f)
                    # raise Exception("lut used without expecting a failed mapping")
    if tool_name == "yosys-lattice":
        if expect_only_dsp:
            if (
                "MULT18X18D" not in resource_utilization
                or resource_utilization["MULT18X18D"] > 1
            ):
                if not expect_fail:
                    with open(error_folder_path / "diamond.json", "w+") as f:
                        json.dump(resource_utilization, f)
                    # raise Exception("incorrect dsp usage without expecting a failed mapping")
                    # raise Exception("lut used without expecting a failed mapping")
            if len(resource_utilization) != 1:
                if not expect_fail:
                    with open(error_folder_path / "diamond.json", "w+") as f:
                        json.dump(resource_utilization, f)
                    # raise Exception("incorrect dsp usage without expecting a failed mapping")
                    # raise Exception("lut used without expecting a failed mapping")
    if tool_name == "quartus":
        if expect_only_dsp:
            if "dsps" not in resource_utilization or resource_utilization["dsps"] > 1:
                if not expect_fail:
                    with open(error_folder_path / "diamond.json", "w+") as f:
                        json.dump(resource_utilization, f)
                    # raise Exception("incorrect dsp usage without expecting a failed mapping")
                    # raise Exception("lut used without expecting a failed mapping")
            if len(resource_utilization) != 1:
                if not expect_fail:
                    with open(error_folder_path / "diamond.json", "w+") as f:
                        json.dump(resource_utilization, f)
                    # raise Exception("incorrect dsp usage without expecting a failed mapping")
                    # raise Exception("lut used without expecting a failed mapping")
    if tool_name == "lakeroad-intel":
        if expect_only_dsp:
            if (
                "altmult_accum" not in resource_utilization
                or resource_utilization["altmult_accum"] > 1
            ):
                if not expect_fail:
                    with open(error_folder_path / "diamond.json", "w+") as f:
                        json.dump(resource_utilization, f)
                    # raise Exception("incorrect dsp usage without expecting a failed mapping")
                    # raise Exception("lut used without expecting a failed mapping")
            if len(resource_utilization) != 1:
                if not expect_fail:
                    with open(error_folder_path / "diamond.json", "w+") as f:
                        json.dump(resource_utilization, f)
                    # raise Exception("incorrect dsp usage without expecting a failed mapping")
                    # raise Exception("lut used without expecting a failed mapping")


def task_robustness_experiments():
    """Robustness experiments: finding Verilog files that existing tools can't map"""

    entries = yaml.safe_load(stream=open("robustness-manifest.yml", "r"))
    # entries = yaml.safe_load(stream=open("test-robustness.yaml", "r"))

    # .json file that contains metadata is produced for each entry's synthesis.
    collected_data_output_filepaths = []

    # determines if the compiler fails for the workload we're looking at
    def contains_compiler_fail(entry, tool_name):
        if "expect_fail" in entry:
            if tool_name in entry["expect_fail"]:
                return True
        return False

    # if there is a timeout for lakeroad
    def contains_compiler_timeout(entry):
        if "expect_timeout" in entry:
            return True
        return False

    for entry in entries:
        backends = entry["backends"]
        if "xilinx" in backends:
            # base path for vivado tasks for this entry
            base_path = (
                utils.output_dir()
                / "robustness_experiments"
                / entry["module_name"]
                / "vivado"
            )
            # vivado synthesis
            (
                task,
                (json_filepath, _, _, _),
            ) = hardware_compilation.make_xilinx_ultrascale_plus_vivado_synthesis_task_opt(
                input_filepath=entry["filepath"],
                output_dirpath=base_path,
                module_name=entry["module_name"],
                # TODO(@gussmith23): Hardcoding clock name and period here.
                # 0.5ns chosen after a few iterations.
                clock_info=("clk", 0.5, (0.0, 0.25)),
                name=f"{entry['module_name']}:vivado",
                # Makes Vivado try harder to put things on DSPs.
                directive="AreaMultThresholdDSP",
                # If our timing constraints are aggressive enough, it won't meet
                # timing. This is okay; don't fail. We want aggressive
                # constraints so we know Vivado is trying as hard as it can.
                fail_if_constraints_not_met=False,
                extra_summary_fields={
                    "identifier": entry["module_name"],
                    "architecture": "xilinx-ultrascale-plus",
                    "tool": "vivado",
                },
            )
            yield task
            collected_data_output_filepaths.append(json_filepath)

            # Lakeroad Synthesis for xilinx backend
            base_path = (
                utils.output_dir()
                / "robustness_experiments"
                / entry["module_name"]
                / "lakeroad_xilinx_ultrascale_plus"
            )

            (task, (json_filepath, _, _)) = lakeroad.make_lakeroad_task(
                out_dirpath=base_path,
                template="dsp",
                out_module_name="output",
                architecture="xilinx-ultrascale-plus",
                verilog_module_filepath=entry["filepath"],
                top_module_name=entry["module_name"],
                clock_name="clk",
                name=entry["module_name"] + ":lakeroad-xilinx",
                initiation_interval=entry["stages"],
                inputs=entry["inputs"],
                verilog_module_out_signal=("out", entry["bitwidth"]),
                timeout=utils.get_manifest()["completeness_experiments"]["lakeroad"][
                    "timeout"
                ],
                extra_summary_fields={
                    "identifier": entry["module_name"],
                    "architecture": "xilinx-ultrascale-plus",
                    "tool": "lakeroad",
                },
            )
            yield task

            collected_data_output_filepaths.append(json_filepath)

            # yield verilator.make_verilator_task(
            #     f"{entry['module_name']}:lakeroad:verilator",
            #     obj_dir_dir=base_path / "verilator_obj_dir",
            #     test_module_filepath=base_path / "output.v",
            #     ground_truth_module_filepath=entry["filepath"],
            #     module_inputs=entry["inputs"],
            #     clock_name="clk",
            #     initiation_interval=entry["stages"],
            #     testbench_cc_filepath=base_path / "testbench.cc",
            #     testbench_exe_filepath=base_path / "testbench",
            #     testbench_inputs_filepath=base_path / "testbench_inputs.txt",
            #     testbench_stdout_log_filepath=base_path / "testbench_stdout.log",
            #     testbench_stderr_log_filepath=base_path / "testbench_stderr.log",
            #     makefile_filepath=base_path / "Makefile",
            #     output_signal="out",
            #     include_dirs=[
            #         "/home/acheung8/lakeroad-evaluation/lakeroad-private/DSP48E2"
            #     ],
            #     extra_args=[
            #         "-DXIL_XECLIB",
            #         "-Wno-UNOPTFLAT",
            #         "-Wno-LATCH",
            #         "-Wno-WIDTH",
            #         "-Wno-STMTDLY",
            #         "-Wno-CASEX",
            #         "-Wno-TIMESCALEMOD",
            #         "-Wno-PINMISSING",
            #     ],
            #     max_num_tests=10000,
            # )

            # yosys synthesis for xilinx backend
            base_path = (
                utils.output_dir()
                / "robustness_experiments"
                / entry["module_name"]
                / "yosys_xilinx_ultrascale_plus"
            )
            (
                task,
                (json_filepath, _, _),
            ) = hardware_compilation.make_xilinx_ultrascale_plus_yosys_synthesis_task(
                input_filepath=entry["filepath"],
                output_dirpath=base_path,
                module_name=entry["module_name"],
                name=f"{entry['module_name']}:yosys_xilinx_ultrascale_plus",
                extra_summary_fields={
                    "identifier": entry["module_name"],
                    "architecture": "xilinx-ultrascale-plus",
                    "tool": "yosys",
                },
            )
            yield task
            collected_data_output_filepaths.append(json_filepath)

        # if "lattice" in backends:
        #     # diamond-lattice, lakeroad-lattice, yosys-lattice
        #     base_path = (
        #         utils.output_dir()
        #         / "robustness_experiments"
        #         / entry["module_name"]
        #         / "diamond"
        #     )
        #     yield hardware_compilation.make_lattice_ecp5_diamond_synthesis_task(
        #         input_filepath=entry["filepath"],
        #         output_dirpath=base_path,
        #         module_name=entry["module_name"],
        #         name=f"{entry['module_name']}:diamond"
        #     )
        #     # TODO(@vcanumalla): ADD lattice backend dsp check
        #     yield {
        #         "name": f"{entry['module_name']}:diamond:dsp_check",
        #         "actions": [
        #             (
        #                 check_dsp_usage,
        #                 [],
        #                 {
        #                     "resource_utilization_json_filepath": (
        #                         base_path / f"{Path(entry['filepath']).stem}_resource_utilization.json"
        #                     ),
        #                     "module_name": entry["module_name"],
        #                     "tool_name": "diamond",
        #                 },
        #             )
        #         ],
        #         "file_dep": [(base_path / f"{Path(entry['filepath']).stem}_resource_utilization.json")],
        #     }

        #     base_path = (
        #         utils.output_dir()
        #         / "robustness_experiments"
        #         / entry["module_name"]
        #         / "lakeroad_lattice_ecp5"
        #     )
        #     task = lakeroad.make_lakeroad_task(
        #         iteration=0,
        #         identifier=entry["module_name"],
        #         collected_data_output_filepath=base_path / "collected_data.json",
        #         template="dsp",
        #         out_module_name="output",
        #         out_filepath=base_path / "output.v",
        #         architecture="lattice-ecp5",
        #         time_filepath=base_path / "out.time",
        #         json_filepath=base_path / "out.json",
        #         verilog_module_filepath=entry["filepath"],
        #         top_module_name=entry["module_name"],
        #         clock_name="clk",
        #         name=entry["module_name"] + ":lakeroad-lattice",
        #         initiation_interval=entry["stages"],
        #         inputs=entry["inputs"],
        #         verilog_module_out_signal=("out", entry["bitwidth"]),
        #     )
        #     yield task

        #     yield {
        #         "name": f"{entry['module_name']}:lakeroad-lattice:dsp_check",
        #         "actions": [
        #             (
        #                 check_dsp_usage,
        #                 [],
        #                 {
        #                     "resource_utilization_json_filepath": base_path
        #                     / "collected_data.json",
        #                     "module_name": entry["module_name"],
        #                     "tool_name": "lakeroad-lattice",
        #                 },
        #             )
        #         ],
        #         "file_dep": [base_path / "collected_data.json"],
        #     }

        #     # TODO(@vcanumalla): ADD dsp check and verilator sim
        #     base_path = (
        #         utils.output_dir()
        #         / "robustness_experiments"
        #         / entry["module_name"]
        #         / "yosys_lattice_ecp5"
        #     )
        #     # yosys for diamond backend
        #     yield hardware_compilation.make_lattice_ecp5_yosys_synthesis_task(
        #         input_filepath=entry["filepath"],
        #         output_dirpath=(
        #             utils.output_dir()
        #             / "robustness_experiments"
        #             / entry["module_name"]
        #             / "yosys_lattice_ecp5"
        #         ),
        #         module_name=entry["module_name"],
        #         name=f"{entry['module_name']}:yosys_lattice_ecp5",
        #     )
        #     resources_filepath = (
        #         base_path / f"{entry['module_name']}_resource_utilization.json"
        #     )

        #     yield {
        #         "name": f"{entry['module_name']}:yosys_lattice_ecp5:dsp_check",
        #         "actions": [
        #             (
        #                 check_dsp_usage,
        #                 [],
        #                 {
        #                     "resource_utilization_json_filepath": resources_filepath,
        #                     "module_name": entry["module_name"],
        #                     "tool_name": "yosys-lattice",
        #                 },
        #             )
        #         ],
        #         "file_dep": [resources_filepath],
        #     }

        # if "intel" in backends:
        #     base_path = (
        #         utils.output_dir()
        #         / "robustness_experiments"
        #         / entry["module_name"]
        #         / "quartus_intel"
        #     )
        #     yield quartus.make_quartus_task(
        #         identifier = entry["module_name"],
        #         top_module_name = entry["module_name"],
        #         source_input_filepath = entry["filepath"],
        #         summary_output_filepath = base_path / "summary.map.summary",
        #         json_output_filepath = base_path / f"{entry['module_name']}_resource_utilization.json",
        #         time_output_filepath = base_path / "out.time",
        #         collected_data_output_filepath = base_path / "collected_data.json",
        #         iteration = 0,
        #         task_name = f"{entry['module_name']}:quartus_intel"
        #     )
        #     base_path = (
        #         utils.output_dir()
        #         / "robustness_experiments"
        #         / entry["module_name"]
        #         / "lakeroad_intel"
        #     )
        #     # TODO(@vcanumalla): Add rest of quartus (yosys)
        #     yield lakeroad.make_lakeroad_task(
        #         iteration=0,
        #         identifier=entry["module_name"],
        #         collected_data_output_filepath=base_path / "collected_data.json",
        #         template="dsp",
        #         out_module_name="output",
        #         out_filepath=base_path / "output.v",
        #         architecture="intel",
        #         time_filepath=base_path / "out.time",
        #         json_filepath=base_path / "out.json",
        #         verilog_module_filepath=entry["filepath"],
        #         top_module_name=entry["module_name"],
        #         clock_name="clk",
        #         name=entry["module_name"] + ":lakeroad-intel",
        #         initiation_interval=entry["stages"],
        #         inputs=entry["inputs"],
        #         verilog_module_out_signal=("out", entry["bitwidth"]),
        #     )
        #     yield {
        #         "name": f"{entry['module_name']}:lakeroad-intel:dsp_check",
        #         "actions": [
        #             (
        #                 check_dsp_usage,
        #                 [],
        #                 {
        #                     "resource_utilization_json_filepath": base_path
        #                     / "collected_data.json",
        #                     "module_name": entry["module_name"],
        #                     "tool_name": "lakeroad-intel",
        #                 },
        #             )
        #         ],
        #         "file_dep": [base_path / "collected_data.json"],
        #     }
        #     yield quartus.make_intel_yosys_synthesis_task(
        #         input_filepath=entry["filepath"],
        #         output_dirpath=(
        #             utils.output_dir()
        #             / "robustness_experiments"
        #             / entry["module_name"]
        #             / "yosys_intel"
        #         ),
        #         module_name=entry["module_name"],
        #         name=f"{entry['module_name']}:yosys_intel",

        #     )
        #     yield {
        #         "name": f"{entry['module_name']}:yosys_intel:dsp_check",
        #         "actions": [
        #             (
        #                 check_dsp_usage,
        #                 [],
        #                 {
        #                     "resource_utilization_json_filepath": resources_filepath,
        #                     "module_name": entry["module_name"],
        #                 },
        #             )
        #         ],
        #         "file_dep": [resources_filepath],
        #     }
    base_path = utils.output_dir() / "robustness_experiments_csv"
    csv_output = base_path / "all_results" / "all_results_collected.csv"
    yield {
        "name": "collect_data",
        # To generate the CSV with incomplete data, you can comment out the following line.
        "file_dep": collected_data_output_filepaths,
        "targets": [csv_output],
        "actions": [
            (
                _collect_robustness_benchmark_data,
                [],
                {
                    "filepaths": collected_data_output_filepaths,
                    "output_filepath": csv_output,
                },
            )
        ],
    }

    yield {
        "name": "visualize_succeeded_vs_failed",
        "file_dep": [csv_output],
        "actions": [
            (
                _visualize_succeeded_vs_failed,
                [],
                {
                    "csv_filepath": csv_output,
                    "plot_output_filepath": (
                        utils.output_dir() / "figures" / "succeeded_vs_failed.png"
                    ),
                },
            )
        ],
    }
