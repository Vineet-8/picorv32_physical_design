# ====================================================================
# MMMC Setup for Innovus (Nangate 45nm)
# ====================================================================

# 1. Define Library and Timing Constraints
create_library_set -name typical_lib -timing {../pdk/Nangate45/stdcells.lib}
create_constraint_mode -name my_constraints -sdc_files {../outputs/reports/picorv32_synth.sdc}

# 2. Define RC Extraction and Delay Corners (Standard 25C temp)
create_rc_corner -name typical_rc -T 25
create_delay_corner -name typical_delay -library_set typical_lib -rc_corner typical_rc

# 3. Create and Set the Analysis View
create_analysis_view -name typical_view -constraint_mode my_constraints -delay_corner typical_delay
set_analysis_view -setup {typical_view} -hold {typical_view}
