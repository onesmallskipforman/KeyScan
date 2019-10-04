module rcEval(input logic [3:0] r, 
				  input logic clk,
				  input logic reset,
				  output logic [3:0] cHigh,
				  output logic [7:0] rcbits);
				  
				  
	typedef enum logic [1:0] {S0, S1, S2, S3} statetype;
	statetype state, nextstate;
	
	always_ff @(posedge clk, posedge reset)
		if (reset)	state <= S0;
		else			state <= nextstate;
		
		
	always_comb
		case(state)
			S0: 
				begin
					cHigh = 4'b1000;
					nextstate = S1;
					rcbits = {r, 4'b0010};
				end
			S1: 
				begin
					cHigh = 4'b0100;
					nextstate = S2;
					rcbits = {r, 4'b0001};
				end
			S2: 
				begin
					cHigh = 4'b0010;
					nextstate = S3;
					rcbits = {r, 4'b1000};
				end
			S3: 
				begin
					cHigh = 4'b0001;
					nextstate = S0;
					rcbits = {r, 4'b0100};
				end
		endcase
			
endmodule		