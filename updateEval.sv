
module updateEval(input [7:0] rcBits,
						input logic clk,
						input logic reset,
						output logic enableNew);
						
						
	logic [3:0] lastC, newLastC;

	typedef enum logic {S0, S1} statetype;
	statetype state, nextstate;
	
	always_ff @(posedge clk, posedge reset)
		if (reset)	begin
							state <= S0;
							lastC <= 4'b0;
						end
		else			
						begin 
							state <= nextstate;
							lastC <= newLastC;
						end
		
	always_comb
		case(state)
			S0: 
				begin
					newLastC = rcBits[3:0];
					if (|rcBits[7:4]) nextstate = S1;
					else 					nextstate = S0;
				end
			S1: 
				begin
					newLastC = lastC;
					if ( (~ (|rcBits[7:4]) ) && (lastC == rcBits[3:0]) ) 	nextstate = S0;
					else 																	nextstate = S1;
				end
			default: 
				begin 
					nextstate = S0; 
					newLastC = 4'b0; 
				end
		endcase

			
	assign enableNew = (state == S0 && (|rcBits[7:4]) );
endmodule 	