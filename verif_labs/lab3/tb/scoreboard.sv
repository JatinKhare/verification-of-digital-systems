`include "uvm_macros.svh"
package scoreboard; 
import uvm_pkg::*;
import sequences::*;

class alu_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(alu_scoreboard)

    uvm_analysis_export #(alu_transaction_in) sb_in;
    uvm_analysis_export #(alu_transaction_out) sb_out;

    uvm_tlm_analysis_fifo #(alu_transaction_in) fifo_in;
    uvm_tlm_analysis_fifo #(alu_transaction_out) fifo_out;

    alu_transaction_in tx_in;
    alu_transaction_out tx_out;

    function new(string name, uvm_component parent);
        super.new(name,parent);
        tx_in=new("tx_in");
        tx_out=new("tx_out");
    endfunction: new

    function void build_phase(uvm_phase phase);
        sb_in=new("sb_in",this);
        sb_out=new("sb_out",this);
        fifo_in=new("fifo_in",this);
        fifo_out=new("fifo_out",this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        sb_in.connect(fifo_in.analysis_export);
        sb_out.connect(fifo_out.analysis_export);
    endfunction: connect_phase

    task run();
        forever begin
            fifo_in.get(tx_in);
            fifo_out.get(tx_out);
            compare();
        end
    endtask: run

    extern virtual function [33:0] getresult; 
    extern virtual function void compare; 
        
endclass: alu_scoreboard

function void alu_scoreboard::compare;
    //TODO: Write this function to check whether the output of the DUT matches
    //the spec.
    //Use the getresult() function to get the spec output.
    //Consider using `uvm_info(ID,MSG,VERBOSITY) in this function to print the
    //results of the comparison which passed
    //and `uvm_error(ID,MSG) for the failed cases.
    //The debugging statements can have a higher verbosity level
    //You can use tx_in.convert2string() and tx_out.convert2string() for
    //debugging purposes
    
    //***

    logic [33:0] result;
    string str;
    begin
        result = getresult();
        if(tx_out.COUT != result[32])
            begin
`uvm_error("my_score", $psprintf(" 
            Wrong value of COUT, for inputs A = 0x%0x, B = 0x%0x, CIN = 0x%0x, and Opcode = 0x%0x; Expected COUT = 0x%0x, Actual COUT = 0x%0x",
            tx_in.A, tx_in.B, tx_in.CIN, tx_in.opcode, result[32], tx_out.COUT))
            end
        if(tx_out.VOUT != result[33])
            begin
`uvm_error("my_score", $psprintf("
            Wrong value of VOUT, for inputs A = 0x%0x, B = 0x%0x, CIN = 0x%0x, and Opcode = 0x%0x; Expected VOUT = 0x%0x, Actual VOUT = 0x%0x",
            tx_in.A, tx_in.B, tx_in.CIN, tx_in.opcode, result[33], tx_out.VOUT))
            end
        
        if(tx_out.OUT != result[31:0])
            begin
`uvm_error("my_score", $psprintf("
            Wrong value of OUT, for inputs A = 0x%0x, B = 0x%0x, CIN = 0x%0x, and Opcode = 0x%0x; Expected OUT = 0x%0x, Actual OUT = 0x%0x",
            tx_in.A, tx_in.B, tx_in.CIN, tx_in.opcode, result[31:0], tx_out.OUT[31:0]))
            end
    end
    //***
    
endfunction

function [33:0] alu_scoreboard::getresult;
    //TODO: Write this function to return a 34-bit result {VOUT, COUT,OUT[31:0]} which is
    //consistent with the given spec.
    
    //***
    logic VOUT;
    logic [32:0] OUT;
    VOUT = 0;
    OUT = 0;

    case(tx_in.opcode[4:3])
                
                2'b00: //LOGICAL

                    begin
                        case(tx_in.opcode[2:0])

                            3'b000:     //NOT
                                begin
                                    OUT[31:0] = ~tx_in.A;
                                end                

                            3'b011:     //XOR
                                begin
                                    OUT[31:0] = tx_in.A ^ tx_in.B;
                                end                

                            3'b101:     //AND
                                begin
                                    OUT[31:0] = tx_in.A & tx_in.B;
                                end                

                            3'b111:     //OR    
                                begin
                                    OUT[31:0] = tx_in.A | tx_in.B;
                                end                

                            default:
                                begin
                                    `uvm_warning("my_score", "Invalid opcode logical :( ")
                                end 
                        endcase               
                    end

                2'b01: //COMPARE

                    begin
                        case(tx_in.opcode[2:0])

                            3'b001:     //SLT       if A < B, OUT = 1
                                begin
                                    if(tx_in.A[31] == 1'b1) //A is negative number
                                        begin
                                            if(tx_in.B[31] != 1'b1) //B is positive number
                                                OUT = 33'b1;
                                            else if(tx_in.A[30:0] < tx_in.B[30:0])
                                                OUT = 33'b1;
                                        end
                                    else
                                        begin
                                            if(tx_in.B[31] == 1'b1) //B is positive number
                                                OUT = 33'b0;
                                            else if(tx_in.A[30:0] < tx_in.B[30:0])
                                                OUT = 33'b1;
                                        end
                                end                    

                            3'b010:     //SNE
                                begin
                                    if(tx_in.A != tx_in.B)
                                        begin
                                            OUT = 32'b1;
                                        end 
                                end                    

                            3'b011:     //SGT    
                                begin   
                                    if(tx_in.A[31] == 1'b1) //A is negative number
                                        begin
                                            if(tx_in.B[31] != 1'b1) //B is positive number
                                                OUT = 33'b0;
                                            else if(tx_in.A[30:0] > tx_in.B[30:0])
                                                OUT = 33'b1;
                                        end
                                    else
                                        begin
                                            if(tx_in.B[31] == 1'b1) //B is negative number
                                                OUT = 33'b1;
                                            else if(tx_in.A[30:0] > tx_in.B[30:0])
                                                OUT = 33'b1;
                                        end
            
                                end                    

                            3'b100:     //SLE
                                begin
                                    if(tx_in.A[31] == 1'b1) //A is negative number
                                        begin
                                            if(tx_in.B[31] != 1'b1) //B is positive number
                                                OUT = 33'b1;
                                            else if(tx_in.A[30:0] <= tx_in.B[30:0])
                                                OUT = 33'b1;
                                        end
                                    else
                                        begin
                                            if(tx_in.B[31] == 1'b1) //B is negative number
                                                OUT = 33'b0;
                                            else if(tx_in.A[30:0] <= tx_in.B[30:0])
                                                OUT = 33'b1;
                                        end
            
                                end                    

                            3'b110:     //SGE
                                begin
                                    if(tx_in.A[31] == 1'b1) //A is negative number
                                        begin
                                            if(tx_in.B[31] != 1'b1) //B is positive number
                                                OUT = 33'b0;
                                            else if(tx_in.A[30:0] >= tx_in.B[30:0])
                                                OUT = 33'b1;
                                        end
                                    else
                                        begin
                                            if(tx_in.B[31] == 1'b1) //B is negative number
                                                OUT = 33'b1;
                                            else if(tx_in.A[30:0] >= tx_in.B[30:0])
                                                OUT = 33'b1;
                                        end
            
                                end                    

                            3'b111:     //SEQ
                                begin
                                    if(tx_in.A == tx_in.B)
                                        begin
                                            OUT = 32'b1;
                                        end 
                                end                    
                            default:
                                begin
                                    `uvm_warning("my_score", "Invalid opcode compare :( ")
                                end
                        endcase                    
                    end

                2'b10: //ARITHMETIC
                    begin
                        case(tx_in.opcode[2:0])

                            3'b000:     //SUBU
                                begin
                                   OUT = tx_in.A - tx_in.B;
                                   VOUT = 0;
                                   OUT[32] = (tx_in.A < tx_in.B) ? 0 : 1;
                                   VOUT = (tx_in.A[31] ^ tx_in.B[31]) & (tx_in.A[31] ^ OUT[31]);
                                end                    

                            3'b001:     //ADDU
                                begin
                                   OUT = tx_in.A + tx_in.B + tx_in.CIN;
                                   VOUT = tx_in.A[31]^tx_in.B[31] ? 0 : OUT[31]^tx_in.A[31];
                                end                    

                            3'b100:     //SUB                
                                begin   //break into negative positive cases
                                    if(tx_in.A[31] == 1'b1 && tx_in.B[31] == 1'b1) 
                                        begin
                                            OUT = (tx_in.A[31:0]) + ~(tx_in.B[31:0]) + 1 ;
                                            VOUT = 0;
                                            OUT[32] = ~OUT[32];
                                        end 
                                    else if(tx_in.A[31] == 1'b0 && tx_in.B[31] == 1'b0) 
                                        begin
                                            OUT = (tx_in.A[31:0]) + ~(tx_in.B[31:0]) + 1 ;
                                            OUT[32] = ~OUT[32];
                                            VOUT = 0;
                                        end
                                    else if(tx_in.A[31] == 1'b1 && tx_in.B[31] == 1'b0) 
                                        begin
                                            OUT = (tx_in.A[31:0]) + ~(tx_in.B[31:0]) + 1 ;
                                            OUT[32] = ~OUT[32];
                                            VOUT = tx_in.A[31] ^ OUT[31];
                                        end 
                                    else if(tx_in.A[31] == 1'b0 && tx_in.B[31] == 1'b1) 
                                        begin
                                            OUT = (tx_in.A[31:0]) + ~(tx_in.B[31:0]) + 1 ;
                                            OUT[32] = ~OUT[32];
                                            VOUT = tx_in.A[31] ^ OUT[31];
                                        end 
                                end

                            3'b101:     //ADD                
                                begin   //break into negative positive cases
                                        if(tx_in.A[31] == 1'b1 && tx_in.B[31] == 1'b1) 
                                            begin
                                                    OUT = tx_in.A[31:0] + tx_in.B[31:0] + tx_in.CIN;
                                                    if(OUT[31] == 1'b0) 
                                                        begin
                                                            VOUT = 1;
                                                        end
                                                    else 
                                                        begin
                                                            VOUT = 0;
                                                        end
                                            end 
                                        else if(tx_in.A[31] == 1'b0 && tx_in.B[31] == 1'b0) 
                                            begin
                                                    OUT = tx_in.A[31:0] + tx_in.B[31:0] + tx_in.CIN;
                                                    if(OUT[31] == 1'b1) 
                                                        begin
                                                            VOUT = 1;
                                                        end
                                                    else 
                                                        begin
                                                            VOUT = 0;
                                                        end
                                            end
                                        else if(tx_in.A[31] == 1'b1 && tx_in.B[31] == 1'b0) 
                                            begin
                                                    OUT = tx_in.A[31:0] + tx_in.B[31:0] + tx_in.CIN;
                                                    VOUT = 0;
                                            end 
                                        else if(tx_in.A[31] == 1'b0 && tx_in.B[31] == 1'b1) 
                                            begin
                                                    OUT = tx_in.A[31:0] + tx_in.B[31:0] + tx_in.CIN;
                                                    VOUT = 0;
                                            end 
                                end

                            3'b110:     //DEC
                                begin
                                    OUT = tx_in.A - 1;
                                    VOUT = ((tx_in.A[31] != 0) & (tx_in.A[31] != OUT[31]));                                                                       
                                    if(tx_in.A != 0)
                                        begin
                                            OUT[32] = 1;
                                        end
                                    else
                                        begin
                                            OUT[32] = 0;
                                        end
                                    
                                    if(tx_in.A == 32'h80000000)
                                        begin
                                            VOUT = 1;
                                        end
                                    else
                                        begin
                                            VOUT = 0;
                                        end
                                end                    

                            3'b111:     //INC
                                begin
                                    OUT = tx_in.A + 1;
                                end                    
                            default:
                                begin
                                    `uvm_warning("my_score", "Invalid opcode arithmetic :( ")
                                end 
                        endcase                   
                    end

                2'b11: //SHIFTING

                    begin
                        case(tx_in.opcode[2:0])
                            3'b000:     //SLR
                                begin
                                    OUT = tx_in.A;
                                    repeat(tx_in.B[4:0]) 
                                        begin
                                            OUT = {OUT[30:0],OUT[31]};
                                        end
                                    OUT[32] = 1'b0;
                                    VOUT = 1'b0;
                                end                    

                            3'b001:     //SRR
                                begin
                                    OUT = tx_in.A;
                                    repeat(tx_in.B[4:0]) 
                                        begin
                                            OUT = {OUT[0],OUT[31:1]};
                                        end
                                    OUT[32] = 1'b0;
                                    VOUT = 1'b0;
            
                                end                    

                            3'b010:     //SLL
                                begin
                                    OUT = tx_in.A << (tx_in.B[4:0]);
                                    OUT[32] = 1'b0;
                                    VOUT = 1'b0;
                                end                    

                            3'b011:     //SRL
                                begin
                                    OUT = tx_in.A >> (tx_in.B[4:0]);
                                    OUT[32] = 1'b0;
                                    VOUT = 1'b0;
            
                                end                    

                            3'b100:     //SLA
                                begin
                                    reg [31:0] saved;
                                    OUT = tx_in.A << (tx_in.B[4:0]);
                                    OUT[32] = 1'b0;

                                    if(tx_in.B[4:0]==0)
                                    begin
                                        saved =0;
                                    end
                                    else 
                                        begin
                                            for(int i=1 ; i < (32-tx_in.B[4:0]) ; i++)
                                                begin
                                                    saved[i-1] = tx_in.A[31-i]^tx_in.A[31-i-1];
                                                end
                                        end
                                    VOUT = (saved) != 0 ;
                                    VOUT = (tx_in.A[31]^OUT[31]) ? 1'b1 : VOUT;
                                end                    

                            3'b101:     //SRA
                                begin
                                    reg [31:0] saved;
                                    if(tx_in.A[31]==1)
                                        OUT = (tx_in.A >> (tx_in.B[4:0])) | (32'hffffffff << (32 - (tx_in.B[4:0])));
                                    else
                                        OUT = (tx_in.A >>> (tx_in.B[4:0]));
                                    saved = (1 << tx_in.B[4:0]) - 1;
                                    OUT[32] = 1'b0;
                                    VOUT = (tx_in.A & saved) != 0 ;
                                end                    

                            default:
                                begin
                                    `uvm_warning("my_score", "Invalid opcode shifting :( ")
                                end                    
                        endcase
                    end
            endcase
    return {VOUT, OUT[32:0]};
    //***
endfunction

endpackage: scoreboard
