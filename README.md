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
