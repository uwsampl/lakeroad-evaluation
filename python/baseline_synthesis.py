"""File defining hardware compilation tasks using the DoIt framework."""

from pathlib import Path
from hardware_compilation import *
import doit
import utils


@doit.task_params(
    [
        {
            "name": "baseline_instructions_dir",
            "default": str(utils.lakeroad_evaluation_dir() / "instructions" / "src"),
            "type": str,
        },
    ]
)
def task_baseline_synthesis(baseline_instructions_dir: str):
    """DoIt task creator for creating baseline synthesis tasks for instructions."""

    output_dir_base = utils.output_dir() / "baseline"

    for instruction_file in Path(baseline_instructions_dir).glob("*"):
        vivado_baseline_synthesis_task = (
            make_xilinx_ultrascale_plus_vivado_synthesis_task_opt(
                input_filepath=instruction_file,
                output_dirpath=output_dir_base / "vivado" / instruction_file.stem,
                module_name=instruction_file.stem,
            )
        )
        vivado_baseline_synthesis_task["name"] = f"vivado_{instruction_file.stem}"
        yield vivado_baseline_synthesis_task

        yosys_lattice_baseline_synthesis_task = make_lattice_ecp5_yosys_synthesis_task(
            input_filepath=instruction_file,
            output_dirpath=output_dir_base
            / "yosys_lattice_ecp5"
            / instruction_file.stem,
            module_name=instruction_file.stem,
        )
        yosys_lattice_baseline_synthesis_task[
            "name"
        ] = f"yosys_lattice_ecp5_{instruction_file.stem}"
        yield yosys_lattice_baseline_synthesis_task

        yosys_xilinx_ultrascale_plus_baseline_synthesis_task = (
            make_xilinx_ultrascale_plus_yosys_synthesis_task(
                input_filepath=instruction_file,
                output_dirpath=output_dir_base
                / "yosys_xilinx_ultrascale_plus"
                / instruction_file.stem,
                module_name=instruction_file.stem,
            )
        )
        yosys_xilinx_ultrascale_plus_baseline_synthesis_task[
            "name"
        ] = f"xilinx_ultrascale_plus_ecp5_{instruction_file.stem}"
        yield yosys_xilinx_ultrascale_plus_baseline_synthesis_task

        diamond_baseline_synthesis_task = make_lattice_ecp5_diamond_synthesis_task(
            input_filepath=instruction_file,
            output_dirpath=output_dir_base / "diamond" / instruction_file.stem,
            module_name=instruction_file.stem,
        )
        diamond_baseline_synthesis_task["name"] = f"diamond_{instruction_file.stem}"
        yield diamond_baseline_synthesis_task
