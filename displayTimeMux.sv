

module displayTimeMux(input logic [3:0] hexL,
							 input logic [3:0] hexR,
							 input logic clk,
							 input logic reset,
							 output logic [3:0] hexFinal,
							 output logic [1:0] anode);
							 
		
	typedef enum logic {S0, S1} statetype;
	statetype state, nextstate;
	
	always_ff @(posedge clk, posedge reset)
		if (reset)	state <= S0;
		else			state <= nextstate;
		
	always_comb
		case(state)
			S0: 
				begin 
					nextstate = S1;
					hexFinal = hexL;
				end
			S1:
				begin 
					nextstate = S0;
					hexFinal = hexR;
				end
		endcase
			
	assign anode = { ~(state == S0) , ~(state == S1) };
endmodule 	