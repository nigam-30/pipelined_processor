# Pipelined Processor

An 8-bit pipelined processor designed and implemented using **Verilog HDL** and **AMD Xilinx Vivado**.

The project demonstrates instruction fetching, decoding, ALU execution, pipeline registers, register operations, hazard detection, stalling, flushing, and HALT handling.

## Features

- 8-bit processor datapath
- Pipelined architecture
- 8-bit ALU
- 8 × 8-bit register file
- Instruction memory
- Pipeline registers
- Data hazard detection and stall logic
- Pipeline flush mechanism
- HALT instruction
- Behavioral simulation
- RTL and synthesized schematics

## Architecture

```text
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

## Instruction Set

| Instruction | Operation |
|---|---|
| ADD | `Rd = Rd + Rs` |
| ADDI | `Rd = Rd + Imm` |
| SUB | `Rd = Rd - Rs` |
| SLL | `Rd = Rd << Imm` |
| HALT | Stop processor |

## Project Structure

```text
Pipelined-Processor/
│
├── README.md
├── pipelined_processor.zip
│
└── docs/
    ├── rtl_schematic.png
    ├── synthesized_schematic.png
    └── simulation_waveform.png
```

The complete Vivado project is provided as `pipelined_processor.zip`.

After extraction:

```text
pipelined_processor/
├── pipelined_processor.cache/
├── pipelined_processor.hw/
├── pipelined_processor.ip_user_files/
├── pipelined_processor.runs/
├── pipelined_processor.sim/
├── pipelined_processor.srcs/
└── pipelined_processor.xpr
```

## Simulation

The design was verified using **Vivado XSim** with a Verilog testbench.

The simulation verifies instruction execution, ALU operations, pipeline behavior, hazard handling, and HALT operation.

### Simulation Waveform

The simulation waveform is included in the project ZIP file for reference and verification.

## RTL Schematic

The RTL schematic is included in the project ZIP file.

## Synthesized Schematic

The synthesized schematic is included in the project ZIP file.



## Tools Used

- Verilog HDL
- AMD Xilinx Vivado
- Vivado XSim
- FPGA synthesis and implementation flow

## How to Run

1. Download `pipelined_processor.zip`.
2. Extract the ZIP.
3. Open `pipelined_processor.xpr` in Vivado.
4. Run **Behavioral Simulation**.
5. Run **Synthesis** to view the synthesized design.

## Result

The processor was successfully simulated and synthesized, with the RTL and synthesized schematics confirming the implemented processor architecture.

## Author

**Nigam Mehta**
**mehtanigam3024@gmail.com**
