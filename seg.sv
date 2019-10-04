/*
Robert (Skipper) Gonzalez
sgonzalez@g.hmc.edu
09/12/2018
seg module

Below is the module for translating DIP switch
configurations into 7-segment display configurations
for various labs. Not a top-level module.

Inputs:
	s[3:0]:  	the four DIP switch signals

Outputs:
	seg[6:0]:	the segment signals of a common-anode 7-segment display. Recall that
	giving a segment a low value makes the actual display light up
*/



module seg(input logic [3:0] hexVal,
			  output logic [6:0] seg);
		
	// set seg to display the equivalent hex value of s
	always_comb
		case(hexVal)
			4'h0: seg = 7'b1000000;
			4'h1: seg = 7'b1111001;
			4'h2: seg = 7'b0100100;
			4'h3: seg = 7'b0110000;
			4'h4: seg = 7'b0011001;
			4'h5: seg = 7'b0010010;
			4'h6: seg = 7'b0000010;
			4'h7: seg = 7'b1111000;
			4'h8: seg = 7'b0000000;
			4'h9: seg = 7'b0011000;
			4'hA: seg = 7'b0001000;
			4'hB: seg = 7'b0000011;
			4'hC: seg = 7'b1000110;
			4'hD: seg = 7'b0100001;
			4'hE: seg = 7'b0000110;
			4'hF: seg = 7'b0001110;
		endcase
		
	
endmodule 