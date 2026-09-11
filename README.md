An 8-bit, 3-stage pipelined RISC processor designed in **Verilog HDL** and implemented on **AMD Xilinx Vivado**, targeting a **Spartan-7 FPGA**.

The design covers instruction fetch, decode, ALU execution, pipeline registers, register file operations, RAW hazard detection with stalling, pipeline flush on `HALT`, and stable LED output — verified through simulation, RTL elaboration, synthesis, and hardware implementation.

## Features

- 8-bit processor datapath, 3-stage pipeline (IF → ID → EX)
- 8-bit ALU
- 8 × 8-bit register file
- Instruction memory
- Pipeline registers (IF/ID, ID/EX)
- Stall-based RAW hazard detection
- Pipeline flush on `HALT`
- Behavioral simulation (Vivado XSim)
- RTL and synthesized schematics
- FPGA implementation with stable LED output

## Instruction Set

| Instruction | Operation        |
| ----------- | ---------------- |
| ADD         | `Rd = Rd + Rs`   |
| ADDI        | `Rd = Rd + Imm`  |
| SUB         | `Rd = Rd - Rs`   |
| SLL         | `Rd = Rd << Imm` |
| HALT        | Stop processor   |

## Architecture

```
PC
 │
 ▼
Instruction Memory
 │
 ▼
IF/ID Register
 │
 ▼
Control + Register File
 │
 ▼
ID/EX Register
 │
 ▼
ALU
 │
 ▼
Result / LED Output
```

## Repository Structure

```
pipelined_processor/
├── README.md
├── LICENSE
├── Pipelined_Processor_Project_Report.pdf
├── pipelined_processor.zip        # full Vivado project (cache, runs, checkpoints)
│
├── src/                           # Verilog RTL source
│   ├── top.v
│   ├── alu.v
│   ├── control.v
│   ├── pc.v
│   ├── reg_file.v
│   ├── if_id_reg.v
│   ├── id_ex_reg.v
│   └── instr_mem.v
│
├── sim/                           # Testbench
│   └── tb_top.v
│
├── constrs/                       # Pin / clock constraints
│   └── constraints.xdc
│
└── Outputs/
    ├── RTL_Schematic.pdf
    ├── Synthesized_Schematic.pdf
    └── Waveform.png
```

The `src/`, `sim/`, and `constrs/` folders contain the raw Verilog source so the design can be browsed directly on GitHub. `pipelined_processor.zip` contains the complete Vivado project (including build artifacts) for anyone who wants to open it directly in Vivado.

## Simulation Waveform

![Simulation Waveform](Outputs/Waveform.png)

Behavioral simulation in Vivado XSim, showing `clk`, `rst`, `led[7:0]`, and `halt_flag`. The processor executes the instruction stream and correctly asserts `halt_flag` on reaching `HALT`.

## RTL Schematic

Output can be viewed in the output folder in zip file

## Synthesized Schematic

Output can be viewed in the output folder in zip file

## Tools Used

- Verilog HDL
- AMD Xilinx Vivado
- Vivado XSim
- FPGA synthesis and implementation flow (Spartan-7)

## How to Run

1. Clone this repository, or download `pipelined_processor.zip` for the full Vivado project.
2. If using the zip: extract it and open `pipelined_processor.xpr` in Vivado.
3. Run **Behavioral Simulation** to view the waveform.
4. Run **Synthesis** and **Implementation** to view the schematics and generate the bitstream.
5. Program the Spartan-7 FPGA to observe the LED output.

## Result

The processor was successfully simulated, synthesized, and implemented on a Spartan-7 FPGA, with RTL and synthesized schematics confirming the intended pipeline architecture, and the LED output reflecting correct instruction execution.

## Author

**Nigam Mehta**
[GitHub](https://github.com/nigam-30) · [LinkedIn](https://linkedin.com/in/nigam-mehta-83830528b)

## License

This project is licensed under the MIT License — see [LICENSE](LICENSE) for details.
