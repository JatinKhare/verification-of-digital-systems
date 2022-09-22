// Write you SystemVerilog Assertions here !

//adding timescale for the time parameters
`timescale  1 ps / 1 ps

module my_tb (input i_clk, input quick_n_reset, input [31:0] i_wb_dat, input [31:0] o_wb_dat, input [31:0] o_wb_adr, input o_wb_we, input o_wb_stb, input o_wb_cyc, input i_wb_ack);

sequence wb_stb_unknown;
	$isunknown (o_wb_stb);
endsequence

sequence o_wb_cyc_unknown;
	$isunknown (o_wb_cyc);
endsequence

//parametrized sequence
sequence param_unknown(my_signal);
	$isunknown (my_signal);
endsequence

//Take a look at the timing diagrams in Figures 2 and 3. Can you
//identify the conditions for which the signals o wb adr, o wb dat,
//and i wb dat must be valid?

//validity of o_wb_adr -> when o_wb_stb and o_wb_cyc is 1. (common for read and write)
//validity of o_wb_dat -> when o_wb_stb and o_wb_we and o_wb_we is 1 and ##1 i_wb_ack = 1.
//validity of i_wb_dat -> when o_wb_stb and o_wb_we is 1 and o_wb_we is 0 and i_wb_ack = 1.


//Write a parametrized property to check if a condition holds, then
//a bus has a valid value at the same time. Hint: Try using
//$isunknown.

property check_validity(condition_check, bus_value);
	@(posedge i_clk) disable iff (!quick_n_reset) (condition_check) |-> !$isunknown(bus_value);
endproperty

//sequences 

sequence addr_out_cond;
	o_wb_cyc && o_wb_stb;
endsequence

sequence data_out_cond;
	o_wb_cyc && o_wb_stb && o_wb_we;
endsequence

sequence data_in_cond;
	o_wb_cyc && o_wb_stb && !o_wb_we && i_wb_ack;
endsequence

//asserting the properties

ap1: assert property (check_validity(addr_out_cond, o_wb_adr));
ap2: assert property (check_validity(data_out_cond, o_wb_dat));
ap3: assert property (check_validity(data_in_cond, i_wb_dat));

//Use your parametrized property to check that data and address
//bits are valid during read and write cycles. You should write
//three properties for o wb dat, i wb dat, and o wb adr.

//describe the request-acknowledge sequence for the write and read
//cycles. Hint: Try using $rose.
//Note: When i_wb_ack condition is met, then i_wb_ack will be high
//sometimes after 1 clock cycle

//sequences
sequence w_ack_cond;
	o_wb_cyc && o_wb_stb && o_wb_we;
endsequence

sequence r_ack_cond;
	o_wb_cyc && o_wb_stb && !o_wb_we;
endsequence

property ack_property(condition_check);
	@(posedge i_clk) disable iff (!quick_n_reset) (condition_check) |-> (##[1:$] $rose(i_wb_ack));
endproperty

//asserting the properties
ap4: assert property (ack_property(w_ack_cond));
ap5: assert property (ack_property(r_ack_cond));

//reset condition

reg reset_n;
always @(quick_n_reset) begin
	#1
	reset_n = quick_n_reset;
end

property reset_check(signal_value);
	@(negedge reset_n)
	(!quick_n_reset) |-> (signal_value==0);
endproperty

//asserting the reset condition
ap6: assert property (reset_check(o_wb_stb));
ap7: assert property (reset_check(o_wb_cyc));


endmodule

