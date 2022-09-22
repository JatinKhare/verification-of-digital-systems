module module4SVA (
input i_clk, input i_wb_ack, input extra_write_r, input [2:0] wishbone_st);

import FSMProperties::*;

// states recreated
localparam [3:0] WB_IDLE            = 3'd0,
                 WB_BURST1          = 3'd1,
                 WB_BURST2          = 3'd2,
                 WB_BURST3          = 3'd3,
                 WB_WAIT_ACK        = 3'd4;


/*place your properties here*/

//property1(clk, cur_state_cond, cond, wishbone_st_cond);
//property2(clk, cur_state_cond, output_cond);
//property3(clk, cur_state_cond);

a1:assert property (property1(i_clk, (wishbone_st==WB_IDLE), 1, ((wishbone_st == WB_IDLE)||(wishbone_st == WB_BURST1)||(wishbone_st == WB_WAIT_ACK))));
a2:assert property (property1(i_clk, (wishbone_st==WB_BURST1), i_wb_ack, (wishbone_st == WB_BURST2)));
a3:assert property (property1(i_clk, (wishbone_st==WB_BURST2), i_wb_ack, (wishbone_st == WB_BURST3)));
a4:assert property (property1(i_clk, (wishbone_st==WB_BURST3), i_wb_ack, (wishbone_st == WB_WAIT_ACK)));
a5:assert property (property1(i_clk, (wishbone_st==WB_WAIT_ACK), (extra_write_r || !i_wb_ack), (wishbone_st == WB_WAIT_ACK)));
a6:assert property (property1(i_clk, (wishbone_st==WB_WAIT_ACK), (!extra_write_r && i_wb_ack), (wishbone_st == WB_IDLE)));
a7:assert property (property3(i_clk, (wishbone_st==WB_IDLE), 1000));
endmodule

module Wrapper ;

bind a25_wishbone module4SVA wrp (
	.i_clk(tb.u_system.u_amber.u_wishbone.i_clk),
        .i_wb_ack(tb.u_system.u_amber.u_wishbone.i_wb_ack),
        .extra_write_r(tb.u_system.u_amber.u_wishbone.extra_write_r),
        .wishbone_st(tb.u_system.u_amber.u_wishbone.wishbone_st)

);

endmodule
