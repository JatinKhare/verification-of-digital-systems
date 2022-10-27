#tcl variable to switch to SEQ app mode
set_fml_appmode SEQ

#to compile spec and impl design
analyze -format sverilog -vcs "../design/rtl1cg_bad.v"
elaborate_seq -spectop mul -impltop mul -same_design

#reate assert properties for top module outputs,
#blackbox inputs, abstracted points and assume properties for top module inputs, blackbox
#outputs, undriven nets.
map_by_name -exclude "cgc_disable"

create_clock spec.clk -period 100
create_reset spect.rst -sense low 

sim_run -stable 
sim_save_reset

seq_config -map_uninit -map_x zero
fvassume asm_spec_cgc_disable_on -expr "spec.cgc_disable==1'b1"
fvassume asm_impl_cgc_disbale_off -expr "impl.cgc_disable==1'b0"


