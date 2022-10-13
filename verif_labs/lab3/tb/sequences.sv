`include "uvm_macros.svh"
package sequences;

    import uvm_pkg::*;

    class alu_transaction_in extends uvm_sequence_item;
        // TODO: Register the  alu_transaction_in object. Hint: Look at other classes to find out what is missing.
        //***
        `uvm_object_utils(alu_transaction_in)
        ///***
        rand logic [31:0] A;
        rand logic [31:0] B;
        rand logic [4:0] opcode;
        rand logic rst;
        rand logic CIN;

        //TODO: Add constraints here
        //***
        constraint rst_en{
            rst == 0;
        };
        constraint opcode_1{
            opcode[4:3] inside {2'b00, 2'b01, 2'b10, 2'b11};
        };
        constraint opcode_2{
            if(opcode[4:3] == 2'b00){
                opcode[2:0] inside {3'b000, 3'b011, 3'b101, 3'b111};
            }
            else if(opcode[4:3] == 2'b01){
                opcode[2:0] inside {3'b100, 3'b001, 3'b110, 3'b011, 3'b111, 3'b010};
            }
            else if(opcode[4:3] == 2'b10){
                opcode[2:0] inside {3'b101, 3'b001, 3'b100, 3'b000, 3'b111, 3'b110};
            }
            else if(opcode[4:3] == 2'b11){
                opcode[2:0] inside {3'b000, 3'b001, 3'b010, 3'b011, 3'b100, 3'b101};
            }
            solve opcode[4:3] before opcode [2:0];
        };

        //sub and subu, CIN should be 1
        constraint cin{
            if(opcode == 5'b10100 || opcode == 5'b10000)
                CIN == 1'b1;
        };
        //***


        function new(string name = "");
            super.new(name);
        endfunction: new

        function string convert2string;
            convert2string={$sformatf("Operand A = %b, Operand B = %b, Opcode = %b, CIN = %b",A,B,opcode,CIN)};
        endfunction: convert2string

    endclass: alu_transaction_in


    class alu_transaction_out extends uvm_sequence_item;
	    // TODO: Register the  alu_transaction_out object. Hint: Look at other classes to find out what is missing.
        //***
        `uvm_object_utils(alu_transaction_out)
        //***
        logic [31:0] OUT;
        logic COUT;
        logic VOUT;

        function new(string name = "");
            super.new(name);
        endfunction: new;
        
        function string convert2string;
            convert2string={$sformatf("OUT = %b, COUT = %b, VOUT = %b",OUT,COUT,VOUT)};
        endfunction: convert2string

    endclass: alu_transaction_out

    class simple_seq extends uvm_sequence #(alu_transaction_in);
        `uvm_object_utils(simple_seq)

        function new(string name = "");
            super.new(name);
        endfunction: new

        task body;
            repeat(100)
            begin
                alu_transaction_in tx;
                tx=alu_transaction_in::type_id::create("tx");
                start_item(tx);
                assert(tx.randomize());
                finish_item(tx);
            end
        endtask: body
    endclass: simple_seq

    ///////////////////////
    class simple_seq_logic extends uvm_sequence #(alu_transaction_in);
        `uvm_object_utils(simple_seq_logic)

        function new(string name = "");
            super.new(name);
        endfunction: new

        task body;
            repeat(100)
                begin
                alu_transaction_in tx;
                tx=alu_transaction_in::type_id::create("tx");
                start_item(tx);
                //***
                assert(tx.randomize() with {opcode  [4:3] == 2'b00; 
                                            //tx.A inside {[32'h00000000 : 32'hFFFFFFFF]}; 
                                            //tx.B inside {[32'h00000000 : 32'hFFFFFFFF]};
                                            //tx.A inside {32'h00000000, 32'hFFFFFFFF}; 
                                            //tx.B inside {32'h00000000, 32'hFFFFFFFF};
                                            tx.A == tx.B;});
                //***
                finish_item(tx);
                end
        endtask: body
    endclass: simple_seq_logic
    


    class simple_seq_compare extends uvm_sequence #(alu_transaction_in);
        `uvm_object_utils(simple_seq_compare)

        function new(string name = "");
            super.new(name);
        endfunction: new

        task body;
            repeat(100)
            begin
            alu_transaction_in tx;
            tx=alu_transaction_in::type_id::create("tx");
            start_item(tx);
            //***
                assert(tx.randomize() with {opcode  [4:3] == 2'b01; 
                                            //tx.A inside {[32'h00000000 : 32'hFFFFFFFF]}; 
                                            //tx.B inside {[32'h00000000 : 32'hFFFFFFFF]};
                                            //tx.A inside {32'h00000000, 32'hFFFFFFFF}; 
                                            //tx.B inside {32'h00000000, 32'hFFFFFFFF};
                                            tx.A == tx.B;});
            //***
            finish_item(tx);
            end
        endtask: body
    endclass: simple_seq_compare
    



    class simple_seq_arithmetic extends uvm_sequence #(alu_transaction_in);
        `uvm_object_utils(simple_seq_arithmetic)

        function new(string name = "");
            super.new(name);
        endfunction: new

        task body;
            repeat(100)
            begin
            alu_transaction_in tx;
            tx=alu_transaction_in::type_id::create("tx");
            start_item(tx);
            //***
                //assert(tx.randomize() with {opcode  [4:3] == 2'b10;
                //                            tx.A inside {32'h00000000, 32'hFFFFFFFF}; 
                 //                           tx.B inside {32'h00000000, 32'hFFFFFFFF};);
                 //                           //tx.A == tx.B;});
                assert(tx.randomize());/* with {opcode  [4:3] == 2'b10;
                                            //tx.A inside {[32'h00000000 : 32'hFFFFFFFF]}; 
                                            //tx.B inside {[32'h00000000 : 32'hFFFFFFFF]};
                                            //tx.A inside {32'h00000000, 32'hFFFFFFFF}; 
                                            //tx.B inside {32'h00000000, 32'hFFFFFFFF};
                                            /*tx.A == tx.B;});*/
            //***
            finish_item(tx);
            end
        endtask: body
    endclass: simple_seq_arithmetic

    

    
    class simple_seq_shift extends uvm_sequence #(alu_transaction_in);
        `uvm_object_utils(simple_seq_shift)

        function new(string name = "");
            super.new(name);
        endfunction: new

        task body;
            repeat(100)
            begin
            alu_transaction_in tx;
            tx=alu_transaction_in::type_id::create("tx");
            start_item(tx);
            //***
                assert(tx.randomize() );//with {opcode  [4:3] == 2'b11; 
                                            //tx.A inside {32'h00000000, 32'hFFFFFFFF}; 
                                            //tx.B inside {32'h00000000, 32'hFFFFFFFF};
                                        //    tx.A == tx.B;});
            //***
            finish_item(tx);
            end
        endtask: body
    endclass: simple_seq_shift
    ///////////////////////


    class seq_of_commands extends uvm_sequence #(alu_transaction_in);
        `uvm_object_utils(seq_of_commands)
        `uvm_declare_p_sequencer(uvm_sequencer#(alu_transaction_in))

        function new (string name = "");
            super.new(name);
        endfunction: new

        task body;
            repeat(100)
            begin
                simple_seq seq;
                seq = simple_seq::type_id::create("seq");
                assert( seq.randomize() );
                seq.start(p_sequencer);
            end
        endtask: body

    endclass: seq_of_commands

endpackage: sequences
