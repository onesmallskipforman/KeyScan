/*
Robert (Skipper) Gonzalez
sgonzalez@g.hmc.edu
09/12/2018
lab1_sg module

Below is the top level module for lab 1. This module sets the values for led and seg,
which control the board's led strip and 7-segment display, respectively. 

Inputs:
	clk: 			the 40 MHz clock
	s[3:0]:  	the four DIP switches

Outputs:
	led[7:0]:	the 8 lights on the LED bar
	seg[6:0]:	the segments of a common-anode 7-segment display. The display should
	show the equivalen hex representation of s.
*/


// TODO: consider different switch names
module lab3_sg(input logic clk,
					input logic reset,
					input logic [3:0] rAsync,
					output logic [3:0] cHigh,
					output logic [6:0] seg, 
					output logic [1:0] anode);
	
	// set number of bits needed for ~1000 Hz pin out
	parameter countBits = 5'd16;
	
	//parameter countBits = 2'd5;

	// hex value determined to be translated from keypad
	logic [3:0] hexVal, hexL, hexR, hexFinal, r;
	logic [7:0] rcbits;
	logic enableNew;
	
	// value that will be incremented by counter
	logic [countBits-1:0] q;
	
	// increment q via counter module.
	// reset = 0 since there is no top level reset
	counter #(countBits) mycount(clk, reset, q);
	
	sync #(4) mysync(rAsync, q[countBits-1], reset, r);
	
	// row and column set and eval FSM
	rcEval rce(r, q[countBits-1], reset, cHigh, rcbits);
	
	// determine whether or not to enable hex value updating
	updateEval uev(rcbits, q[countBits-1], reset, enableNew);
	
	// convert row and column data to hex 
	rcToHex rch(rcbits, hexVal);
	
	// use enable to produce left and right segment configurations
	segHexVals shv(q[countBits-1], enableNew, reset, hexVal, hexL, hexR);
	
	// use anode switching FSM to pick segment output and the anode configuration for display
	displayTimeMux dtm(hexL, hexR, q[countBits-1], reset, hexFinal, anode);
	
	// set the segment display based on the hex value
	seg myseg(hexFinal, seg);
	
endmodule 