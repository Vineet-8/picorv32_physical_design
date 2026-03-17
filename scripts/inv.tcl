# ====================================================================
# Cadence Innovus Initialization & Floorplanning
# ====================================================================

# 1. Tool Initialization
set init_gnd_net VSS
set init_pwr_net VDD
set init_verilog ../outputs/netlists/picorv32_synth.v
set init_design_netlisttype Verilog
set init_design_settop 1
set init_top_cell picorv32
set init_lef_file {../pdk/Nangate45/rtk-tech.lef ../pdk/Nangate45/stdcells.lef}
set init_mmmc_file ../scripts/mmmc.tcl

puts "Initializing Design..."
init_design

# 2. Floorplanning (Aspect Ratio 1.0, 70% Utilization, 10um margins)
puts "Creating Floorplan..."
floorPlan -r 1.0 0.7 10 10 10 10

# 3. Global Net Connections (Tie VDD/VSS to the physical pins)
puts "Connecting Global Nets..."
globalNetConnect VDD -type pgpin -pin VDD -inst *
globalNetConnect VSS -type pgpin -pin VSS -inst *

# 4. Power Ring Creation (Surrounding the core)
puts "Building Power Rings..."
addRing -nets {VDD VSS} -type core_rings -width 2.0 -spacing 1.0 -layer {top metal5 bottom metal5 left metal6 right metal6}

puts "================================================="
puts "Floorplan and Power Rings Created Successfully!"
puts "================================================="
