package FSMProperties;
// FSMValidTransition
// Function: Checks that a FSM changes from a state to a nextState if
//           the condition is true
//
// Inputs: 
// clk - Sample clock signal
// currentState - Boolean (State == currentState)
// condition - Boolean (Transition condition)
// nextState - Boolean (State == nextState)

/*place your property here*/

property property1(i_clk, currentState, condition, nextState);
	@(posedge i_clk) ((currentState)&&(condition)) |-> ##1 (nextState);
endproperty


// FSMOutputValid
// Function: Checks that FSM outputs have the right value for a given state
//
// Inputs:
// clk - Sample clock signal
// currentState - Boolean (State == currentState)
// outputCondition - Boolean (Outcome of boolean formula to describe output behavior


/*place your property here*/

property prpoerty2(i_clk, cur_state_cond, output_cond);
	@(posedge i_clk) (currentState) |-> (outputCondition);
endproperty

// FSMTimeOut
// Function: Checks that a FSM changes state within a timeout window
//
// Inputs:
// clk - Sample clock signal
// currentState - signal - current state of the FSM
// timeOutVal - integer - Number of clocks before the FSM is deemed to have locked up

/*place your property here*/

property property3(i_clk, currentState, timeOutVal);
	reg [3:0] local_reg;
	@(posedge i_clk) ($changed(currentState), local_reg = currentState) |-> ##[1:timeOutVal] (currentState!=local_reg);
endproperty

endpackage: FSMProperties
