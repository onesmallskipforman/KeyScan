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



module rcToHex(input logic [7:0] rcBits,
				   output logic [3:0] hexVal);
		
	// set seg to display the equivalent hex value of s
	always_comb
		case(rcBits)
			8'b10000010: hexVal = 4'h0;
			8'b00010001: hexVal = 4'h1;
			8'b00010010: hexVal = 4'h2;
			8'b00010100: hexVal = 4'h3;
			8'b00100001: hexVal = 4'h4;
			8'b00100010: hexVal = 4'h5;
			8'b00100100: hexVal = 4'h6;
			8'b01000001: hexVal = 4'h7;
			8'b01000010: hexVal = 4'h8;
			8'b01000100: hexVal = 4'h9;
			8'b00011000: hexVal = 4'hA;
			8'b00101000: hexVal = 4'hB;
			8'b01001000: hexVal = 4'hC;
			8'b10001000: hexVal = 4'hD;
			8'b10000001: hexVal = 4'hE;
			8'b10000100: hexVal = 4'hF;
			default:		 hexVal = 4'h0;
		endcase
endmodule 