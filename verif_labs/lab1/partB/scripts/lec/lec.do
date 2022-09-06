// STEP 0: (completed) The dofile must be in 'tclmode'
tclmode

// STEP 1: Set the log file. This is helpful to debug the setup.
set_log_file my_log_file.log -replace

// STEP 2: Set the undefined cells as black boxes for both golden and revised designs.
set_undefined_cell -noascend black_box -both

// STEP 3: Load the libraries
read_library -Both -Replace  -sensitive    -Verilog /home/ecelrc/students/jkhare/verif_labs/lab1/partB/verilog/lib/generic_iobuf.v -nooptimize   

// STEP 4: Load the golden design.
// Before loading, add the search path to include all the sub-folders in '../../verilog',
// so that, the files called-in an RTL file with `inlcude directive can be located.

add_search_path verilog/amber25
add_search_path verilog/system
add_search_path verilog/tb
add_search_path verilog/ethmac
add_search_path verilog/lib

source scripts/common/rtl.list

read_design $RTL_LIST -Verilog -Golden   -sensitive -continuousassignment Bidirectional   -nokeep_unreach   -nosupply 

// STEP 5: Load the revised design: The netlist '../rc/system_cg_scan_netlist.v'

read_design /home/ecelrc/students/jkhare/verif_labs/lab1/partB/scripts/rc/system_cg_scan_netlist.v -Verilog -Revised   -sensitive         -continuousassignment Bidirectional   -nokeep_unreach   -nosupply 

// STEP 6: Add the pin constraints

add_pin_constraints 0 scan_cg_en -both
add_pin_constraints 0 scan_en -both
//add_pin_constraints 0 test_si* -revised

// STEP 7: (completed) Setting the options for analysis
set_flatten_model -seq_constant -seq_constant_x_to 0
set_flatten_model -gated_clock
set_analyze_option -auto

// STEP 8: Set the system mode to lec

// STEP 9: The unmapped memory macros in golden and revised designs must be mapped.
// Use the add_mapped_points command to map the RAMs.

// STEP 10: Add the compared points and compare

// If the script is correctly written, the code below will display 
// zero diff, abort and unknown points.
puts "Num of compare points = [get_compare_points -count]"
puts "Num of diff points    = [get_compare_points -NONequivalent -count]"
puts "Num of abort points   = [get_compare_points -abort -count]"
puts "Num of unknown points = [get_compare_points -unknown -count]"

