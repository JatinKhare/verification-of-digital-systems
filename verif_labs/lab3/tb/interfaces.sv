interface dut_in;
    logic           clk, rst;
    logic           CIN;
    logic   [4:0]   opcode;
    logic   [31:0]  A, B;
endinterface: dut_in


interface dut_out;
    //TODO: Complete the dut_out interface
    //***
    logic COUT;
    logic VOUT;
    logic [31:0] OUT;
    logic clk;
    //***
endinterface: dut_out
