# ====================================================================
# Cadence Genus Synthesis Script for PicoRV32 (Nangate 45nm)
# ====================================================================

# 1. Define Paths
set PDK_LIB "../pdk/Nangate45/stdcells.lib"
set RTL_FILE "../rtl/picorv32.v"
set OUT_DIR "../outputs"

# 2. Load the Technology Library (Using legacy attribute)
set_attribute library $PDK_LIB /

# 3. Read and Elaborate RTL
read_hdl $RTL_FILE
elaborate picorv32

# 4. Apply Timing Constraints (SDC)
create_clock -name clk -period 2.0 [get_ports clk]
set_input_delay -clock clk 0.4 [all_inputs]
set_output_delay -clock clk 0.4 [all_outputs]

# 5. Synthesis Execution
puts "Starting Generic Synthesis..."
syn_generic

puts "Starting Tech Mapping..."
syn_map

puts "Starting Optimization..."
syn_opt

# 6. Export Outputs for Innovus (PnR)
write_hdl > ${OUT_DIR}/netlists/picorv32_synth.v
write_sdc > ${OUT_DIR}/reports/picorv32_synth.sdc

# 7. Generate PPA Reports (Power, Performance, Area)
report_timing > ${OUT_DIR}/reports/timing_synth.rpt
report_power > ${OUT_DIR}/reports/power_synth.rpt
report_area > ${OUT_DIR}/reports/area_synth.rpt

puts "================================================="
puts "Synthesis Complete! Check the /outputs directory."
puts "================================================="
exit
