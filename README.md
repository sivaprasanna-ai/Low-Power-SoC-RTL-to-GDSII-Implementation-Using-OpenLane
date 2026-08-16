# Low-Power SoC RTL-to-GDSII Implementation Using OpenLane

A complete RTL-to-GDSII implementation of a small low-power
System-on-Chip (SoC) using Verilog RTL, OpenLane, SKY130A, and an
OpenROAD-based physical-design flow.

The project demonstrates the complete digital ASIC implementation
process from RTL design and simulation to synthesis, floorplanning,
placement, clock-tree synthesis, routing, timing and power analysis,
physical verification, and final GDSII generation.

---

## 1. Project Overview

The design implemented in this project is a small SoC named
`lowpower_soc`.

The SoC integrates the following functional blocks:

- **Simple CPU** for processing and control
- **256 × 8-bit RAM** for data storage
- **8-bit GPIO interface** for external output
- **Timer / Counter**
- **Sleep-controlled low-power enable mechanism**

The low-power mechanism is implemented at RTL using:

```verilog
assign system_enable = ~sleep;
```
When sleep is asserted, system_enable becomes inactive and the
main sequential logic stops its normal state updates.

The project was developed as a practical study of the complete
RTL-to-GDSII digital implementation flow using open-source tools.

## 2. RTL Architecture

The top-level lowpower_soc module integrates the CPU, RAM, GPIO,
and timer blocks.

| File                | Description               |
| ------------------- | ------------------------- |
| `lowpower_soc.v`    | Top-level SoC integration |
| `simple_cpu.v`      | CPU and control logic     |
| `simple_ram.v`      | 256 × 8-bit RAM           |
| `gpio_interface.v`  | 8-bit GPIO interface      |
| `timer.v`           | Timer / counter logic     |
| `lowpower_soc_tb.v` | RTL simulation testbench  |

RTL Source Files
File	Description
lowpower_soc.v	Top-level SoC integration
simple_cpu.v	CPU and control logic
simple_ram.v	256 × 8-bit RAM
gpio_interface.v	8-bit GPIO interface
timer.v	Timer / counter logic
lowpower_soc_tb.v	RTL simulation testbench

## 3. RTL-to-GDSII Flow

                      Verilog RTL
                           │
                           ▼
                    RTL Simulation
                           │
                           ▼
                    Logic Synthesis
                           │
                           ▼
                      Floorplanning
                           │
                           ▼
                  Standard-Cell Placement
                           │
                           ▼
                Clock Tree Synthesis (CTS)
                           │
                           ▼
                    Timing Optimization
                           │
                           ▼
                         Routing
                           │
                           ▼
                Power & Timing Analysis
                           │
                           ▼
                    DRC / LVS Signoff
                           │
                           ▼
                      Final GDSII

## 4. Technology and Tools

| Category                      | Tool / Technology   |
| ----------------------------- | ------------------- |
| Hardware Description Language | Verilog             |
| RTL-to-GDSII Flow             | OpenLane            |
| Physical Design Framework     | OpenROAD-based flow |
| Process Technology            | SKY130A             |
| Standard-Cell Library         | `sky130_fd_sc_hd`   |
| Logic Synthesis               | Yosys               |
| Layout Inspection             | KLayout             |
| Physical Verification         | DRC / LVS           |

## 5. Implementation Results
### 5.1 Area and Physical Implementation

The synthesis and floorplanning stages produced the following
results:

| Metric                     |            Result |
| -------------------------- | ----------------: |
| Synthesized standard cells |           **117** |
| Synthesized cell area      | **1350.0448 µm²** |
| Core area                  | **≈ 2662.55 µm²** |
| Core area                  | **≈ 0.00266 mm²** |
| Die width                  |         **63 µm** |
| Die height                 |      **73.72 µm** |
| Die dimensions             | **63 × 73.72 µm** |
| Die area                   | **≈ 4644.36 µm²** |
| Die area                   | **≈ 0.00464 mm²** |

The synthesized cell area represents the area of the
technology-mapped standard-cell logic. The larger core and die
areas include the physical space required for placement, routing,
clock distribution, and other implementation resources.

### 5.2 Power Analysis

Power analysis was performed at the Typical Corner.

| Power Component |        Value |
| --------------- | -----------: |
| Internal power  |   **140 µW** |
| Switching power |  **11.9 µW** |
| Leakage power   | **0.509 nW** |
| **Total power** |   **152 µW** |

Leakage Power

The reported leakage power is:
5.09 × 10⁻¹⁰ W = 0.509 nW

Power Summary

Internal Power     = 140 µW
Switching Power    = 11.9 µW
Leakage Power      = 0.509 nW
--------------------------------
## Total Power        ≈ 152 µW

### 5.3 Timing Analysis

Timing was evaluated at multiple stages of the physical-design
flow.

| Implementation Stage          |  Setup Slack |   Hold Slack |
| ----------------------------- | -----------: | -----------: |
| Global Placement (GPL)        | **+6.13 ns** | **+0.21 ns** |
| Detailed Placement (DPL)      | **+6.18 ns** | **+0.20 ns** |
| Clock Tree Synthesis (CTS)    | **+6.45 ns** | **+0.18 ns** |
| Resizer / Timing Optimization | **+6.31 ns** | **+0.31 ns** |
| Global Routing (GRT)          | **+6.41 ns** | **+0.27 ns** |

### Final Post-Route Timing

Worst Setup Slack = +6.41 ns
Worst Hold Slack  = +0.27 ns
TNS                = 0
WNS                = 0

The positive setup and hold slack values indicate that no reported
setup or hold timing violations were present in the analyzed
post-route implementation.

### 5.4 Physical Verification

The final physical implementation was checked using Design Rule
Checking (DRC) and Layout Versus Schematic (LVS).

| Verification Check  | Result |
| ------------------- | -----: |
| DRC violations      |  **0** |
| LVS errors          |  **0** |
| Net mismatches      |  **0** |
| Device mismatches   |  **0** |
| Pin mismatches      |  **0** |
| Property mismatches |  **0** |

### DRC

DRC Violations = 0

No reported design-rule violations were found in the analyzed final
layout.

### LVS

LVS Errors = 0

No net, device, pin, or property mismatches were reported between
the extracted layout and the intended circuit representation.

## 6. Final Results Summary

| Category              |            Result |
| --------------------- | ----------------: |
| Standard cells        |           **117** |
| Synthesized cell area | **1350.0448 µm²** |
| Core area             | **≈ 2662.55 µm²** |
| Die size              | **63 × 73.72 µm** |
| Die area              | **≈ 4644.36 µm²** |
| Internal power        |        **140 µW** |
| Switching power       |       **11.9 µW** |
| Leakage power         |      **0.509 nW** |
| **Total power**       |        **152 µW** |
| **Setup slack**       |      **+6.41 ns** |
| **Hold slack**        |      **+0.27 ns** |
| TNS                   |             **0** |
| WNS                   |             **0** |
| **DRC violations**    |             **0** |
| **LVS errors**        |             **0** |

## 7. Implementation Outputs
### RTL Simulation

The RTL testbench was used to verify the functional behavior of the
design before synthesis and physical implementation.

### Floorplan

The floorplanning stage established the physical die and core
regions used by the subsequent placement and routing stages.

### Standard-Cell Placement

The synthesized standard cells were placed within the defined core
region.

### Routing

The routing stage established the physical metal interconnections
between the implemented standard cells.

### Final GDSII

The final GDSII layout was generated after physical implementation
and verification and was inspected using KLayout.

## 8. OpenLane Implementation

The design was implemented using OpenLane with the SKY130A process
technology.

Example flow command:
./flow.tcl -design lowpower_soc -tag lowpower_soc_v3

The implementation was evaluated through the following stages:

Synthesis
   ↓
Floorplanning
   ↓
Placement
   ↓
Clock Tree Synthesis
   ↓
Timing Optimization
   ↓
Routing
   ↓
Timing Analysis
   ↓
Power Analysis
   ↓
DRC / LVS
   ↓
GDSII

## 9. Key Learning Outcomes

This project provided practical experience with:

- Verilog RTL design
- RTL simulation and debugging
- Logic synthesis
- Standard-cell based ASIC implementation
- Floorplanning
- Standard-cell placement
- Clock-tree synthesis
- Timing optimization
- Physical routing
- Static timing analysis
- Power estimation
- Leakage-power analysis
- DRC and LVS verification
- GDSII generation
- KLayout-based physical inspection

The project also provided practical understanding of how RTL
decisions and physical implementation stages affect area, power,
timing, and final layout quality.

## 10. Repository Structure
```text
Low-Power-SoC-RTL-to-GDSII-Implementation-Using-OpenLane/
│
├── README.md
│
├── rtl/
│   ├── lowpower_soc.v
│   ├── simple_cpu.v
│   ├── simple_ram.v
│   ├── gpio_interface.v
│   ├── timer.v
│   └── lowpower_soc_tb.v
│
├── openlane/
│   └── config.json
│
├── outputs/
│   ├── simulation/
│   │   └── lowpower_soc_tb_output.png
│   │
│   └── physical/
│       ├── floorplan.png
│       ├── placement.png
│       ├── routing.png
│       └── gdsii.png
│
├── gds/
│   └── lowpower_soc.gds
│
└── docs/
    └── lowpower_soc_report.pdf
```

The repository intentionally contains the key source files,
configuration, visual implementation outputs, final GDSII, and
technical report rather than the complete set of raw OpenLane
intermediate reports.

## 11. Project Report

The complete technical report documents the RTL design, OpenLane
implementation flow, physical implementation, area, power, timing,
DRC/LVS verification, and final GDSII layout.

## 12. Author

### M. SIVA PRASANNA

B. Tech Electronics and Communication Engineering

2026

## Project Focus

Verilog RTL
     ↓
OpenLane
     ↓
SKY130A
     ↓
Physical Design
     ↓
Timing / Power
     ↓
DRC / LVS
     ↓
Final GDSII

