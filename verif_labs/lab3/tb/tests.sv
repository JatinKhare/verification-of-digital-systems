package tests;
`include "uvm_macros.svh"
import modules_pkg::*;
import uvm_pkg::*;
import sequences::*;
import scoreboard::*;

class test1 extends alu_test;
    `uvm_component_utils(test1)

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction: new
    
    task run_phase(uvm_phase phase);
	seq_of_commands seq;
	seq = seq_of_commands::type_id::create("seq");
	assert( seq.randomize() );
	phase.raise_objection(this);
	seq.start(alu_env_h.alu_agent_in_h.alu_sequencer_in_h);
	phase.drop_objection(this);
    endtask: run_phase     
endclass: test1

//TODO: Add More Tests

//***
class test2 extends alu_test;
    `uvm_component_utils(test2)

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction: new
    
    task run_phase(uvm_phase phase);
	simple_seq_logic seq;
	seq = simple_seq_logic::type_id::create("seq");
	assert( seq.randomize() );
	phase.raise_objection(this);
	seq.start(alu_env_h.alu_agent_in_h.alu_sequencer_in_h);
	phase.drop_objection(this);
    endtask: run_phase     
endclass: test2

class test3 extends alu_test;
    `uvm_component_utils(test3)

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction: new
    
    task run_phase(uvm_phase phase);
	simple_seq_compare seq;
	seq = simple_seq_compare::type_id::create("seq");
	assert( seq.randomize() );
	phase.raise_objection(this);
	seq.start(alu_env_h.alu_agent_in_h.alu_sequencer_in_h);
	phase.drop_objection(this);
    endtask: run_phase     
endclass: test3

class test4 extends alu_test;
    `uvm_component_utils(test4)

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction: new
    
    task run_phase(uvm_phase phase);
	simple_seq_arithmetic seq;
	seq = simple_seq_arithmetic::type_id::create("seq");
	assert( seq.randomize() );
	phase.raise_objection(this);
	seq.start(alu_env_h.alu_agent_in_h.alu_sequencer_in_h);
	phase.drop_objection(this);
    endtask: run_phase     
endclass: test4

class test5 extends alu_test;
    `uvm_component_utils(test5)

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction: new
    
    task run_phase(uvm_phase phase);
	simple_seq_shift seq;
	seq = simple_seq_shift::type_id::create("seq");
	assert( seq.randomize() );
	phase.raise_objection(this);
	seq.start(alu_env_h.alu_agent_in_h.alu_sequencer_in_h);
	phase.drop_objection(this);
    endtask: run_phase     
endclass: test5
//***
endpackage: tests
