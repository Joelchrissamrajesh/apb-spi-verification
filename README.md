# APB3 SPI Master – RTL Design & Verification

APB-SPI protocol verification project using SystemVerilog, UVM methodology, assertions (SVA), and functional coverage.

## Overview
This project implements a synthesizable SPI Master controller compliant with the AMBA APB3 protocol. It demonstrates RTL design and functional verification using SystemVerilog and assertions.

## Key Features
- AMBA APB3 compliant SPI Master
- Modular and synthesizable Verilog RTL
- Configurable baud rate generator
- MOSI/MISO data transfer support
- Slave select control logic
- Assertion-based protocol checking (SVA)

## Design Architecture
The design consists of:
- APB Slave Interface
- Control FSM
- Baud Rate Generator
- SPI Shift Register
- Slave Select Generator

## Verification
- Directed testbench for APB read/write operations
- SPI data transfer and timing verification
- SystemVerilog Assertions (SVA) for protocol checking
- Lint checks for synthesizable RTL

## Results
- Successfully verified APB read/write transactions
- Correct SPI data transmission observed in simulation
- Assertions passed without failures

## Tools & Technologies
- Verilog, SystemVerilog
- SystemVerilog Assertions (SVA)
- Synopsys VCS / QuestaSim
- SpyGlass (Lint)
- Synopsys Design Compiler

## Repository Structure
apb-spi-verification/
│
├── rtl/                         # RTL Design + Interfaces
│   ├── apb_defs.v
│   ├── apb_intf.sv              # APB interface (with SVA)
│   ├── apb_slave.v
│   ├── baud_generator.v
│   ├── shifter.v
│   ├── spi_core.v
│   ├── spi_intf.sv              # SPI interface (with SVA)
│   ├── spi_slave_select.v
│   ├── timescale.v
│
├── agents/                      # UVM Agents
│   ├── apb_agent/
│   │   ├── apb_agent.sv
│   │   ├── apb_agt_config.sv
│   │   ├── apb_agt_top.sv
│   │   ├── apb_driver.sv
│   │   ├── apb_monitor.sv
│   │   ├── apb_sequencer.sv
│   │   ├── apb_seqs.sv
│   │   ├── apb_xtn.sv
│   │
│   ├── spi_agent/
│   │   ├── spi_agent.sv
│   │   ├── spi_agt_config.sv
│   │   ├── spi_agt_top.sv
│   │   ├── spi_driver.sv
│   │   ├── spi_monitor.sv
│   │   ├── spi_sequencer.sv
│   │   ├── spi_seqs.sv
│   │   ├── spi_xtn.sv
│
├── tb/                          # Testbench (Environment)
│   ├── env.sv
│   ├── env_config.sv
│   ├── scoreboard.sv
│   ├── top.sv
│
├── tests/                       # Testcases
│   ├── test.sv
│   ├── test_pkg.sv
│
├── sim/                         # Simulation
│   ├── Makefile
│
├── docs/                        # Documentation (optional but recommended)
│   ├── block_diagram.png
│   ├── notes.md
│
└── README.md

## Future Enhancements
- UVM-based constrained random verification
- Functional and code coverage integration
- Support for multiple SPI modes (CPOL/CPHA)
- Extension to APB4 protocol

## Author
Joel Chris Sam Rajesh S  
VLSI Design & Verification Trainee – Maven Silicon
