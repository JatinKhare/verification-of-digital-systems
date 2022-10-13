`include "uvm_macros.svh"
package coverage;
import sequences::*;
import uvm_pkg::*;

class alu_subscriber_in extends uvm_subscriber #(alu_transaction_in);
    `uvm_component_utils(alu_subscriber_in)

    //TODO: Declare the transaction object to facilitate sampling and create covergroup and its corresponding coverpoints
    //Make sure to instantiate the covergroup inside the new function
        //***
        alu_transaction_in tx; 
        /*covergroup cov_grp;
            cov_p1: coverpoint a;
        endgroup
        cov_grp cov_inst = new();
        @(abc) cov_inst.sample();*/
            
        covergroup alu_covergroup_in;
        cov_opcode: coverpoint tx.opcode{
            bins or_opcode = {5'b00111};
            bins xor_opcode = {5'b00011};
            bins not_opcode = {5'b00000};
            bins and_opcode = {5'b00101};
            ////
            bins sle_opcode = {5'b01100};
            bins slt_opcode = {5'b01001};
            bins sge_opcode = {5'b01110};
            bins sgt_opcode = {5'b01011};
            bins seq_opcode = {5'b01111};
            bins sne_opcode = {5'b01010};
            ////
            bins add_opcode = {5'b10101};
            bins addu_opcode = {5'b10001};
            bins sub_opcode = {5'b10100};
            bins subu_opcode = {5'b10000};
            bins inc_opcode = {5'b10111};
            bins dec_opcode = {5'b10110};
            ////
            bins sll_opcode = {5'b11010};
            bins srl_opcode = {5'b11011};
            bins sla_opcode = {5'b11100};
            bins sra_opcode = {5'b11101};
            bins slr_opcode = {5'b11000};
            bins srr_opcode = {5'b11001};
        }   
        cov_A: coverpoint tx.A{
            bins zero_operand = {32'h00000000};
            bins max_operand = {32'hFFFFFFFF};
            bins middle_operand = {[32'h00000001 : 32'hFFFFFFFE]};
        }   
        cov_B: coverpoint tx.B{
            bins zero_operand = {32'h00000000};
            bins max_operand = {32'hFFFFFFFF};
           bins middle_operand = {[32'h00000001 : 32'hFFFFFFFE]};                                                                                                                                                                                                                                         
        }   

        cross_opcode_x_A_x_B: cross cov_opcode, cov_A, cov_B;

        endgroup:alu_covergroup_in 
        //***
    function new(string name, uvm_component parent);
        super.new(name,parent);
        //***
        alu_covergroup_in = new();
        //***
    endfunction: new

    function void write(alu_transaction_in t);
        //TODO: Sample the created covergroup with the proper transaction object 
        //***
        $cast(tx, t);
        alu_covergroup_in.sample();
        //***
    endfunction: write

endclass: alu_subscriber_in

class alu_subscriber_out extends uvm_subscriber #(alu_transaction_out);
    `uvm_component_utils(alu_subscriber_out)

    //TODO: Declare the transaction object to facilitate sampling and create covergroup and its corresponding coverpoints
    //Make sure to instantiate the covergroup inside the new function
    alu_transaction_out tx;
    covergroup alu_covergroup_out;
    
    cov_OUT: coverpoint tx.OUT{
        bins zero_operand = {32'h00000000};
        bins max_operand = {32'hFFFFFFFF};
        bins middle_operand = {[32'h00000001:32'hFFFFFFFE]};
    }
    cov_COUT: coverpoint tx.COUT{
        bins zero_cout = {1'b0};
        bins one_cout = {1'b1};
    }
    cov_VOUT: coverpoint tx.VOUT{
        bins zero_vout = {1'b0};
        bins one_vout = {1'b1};
    }
    endgroup: alu_covergroup_out
   
function new(string name, uvm_component parent);
    super.new(name,parent);
    //***
    alu_covergroup_out = new();
    //***
endfunction: new

    function void write(alu_transaction_out t);
        //TODO: Sample the created covergroup with the proper transaction object 
        //***
        $cast(tx, t);
        alu_covergroup_out.sample();
        //***
    endfunction: write

endclass: alu_subscriber_out

endpackage: coverage
