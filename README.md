# 📡 Matlab code for Co-Simulation of Passive resonators and Optimization:

Passive resonators have been widely used in MRI to manipulate RF field distributions. However, optimizing these structures using full-wave electromagnetic (EM) simulations is computationally prohibitive. This repository extends co-simulation methodology to passive resonator design for the first time, enabling fast, accurate, and scalable optimization. The approach significantly reduces computational burden while preserving full-wave accuracy. The methods are fully described in this [publication](.......)

## ⚡ Co-Simulation:

This repository demonstrates an **ultrafast electromagnetic and RF circuit co-simulation** workflow for MRI applications at 3T (128 MHz).  
### Key Steps
1. ├── main.m **Load S-parameters**  
2. ├── load_data_7p.m **Import EM field data** 
3. ├── main.m **Set capacitance values**
4. ├── cosim_7p.m **Run co-simulation**
5. ├── field_transform.m **Transform fields** 
6. ├── plot_2p.m **Visualize results** 

## ⚡ Optimization:

The mian.m includes an example of **fast optimization** for passive resonator capacitances in a 3T MRI (128 MHz) setup.  
The goal is to improve B1⁺ performance in a defined region of interest (ROI) while reducing field in the rest region.
### Variables
- Design variables: capacitance values `cc = [C_A, C_B]` (pF).  
- Boundaries: `1e-3 ≤ cc ≤ 50`.
### Algorithm
- Optimizer: MATLAB **Genetic Algorithm** (`ga` from Global Optimization Toolbox).

## 🚀 Getting Started

### Requirements
- The code was tested with MATLAB 2023b
- `.fld` files under /Data

### Running the Demo
1. Open MATLAB in the repo root.  
2. Run:
   >> main
