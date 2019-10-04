
module segHexVals (input logic clk,
						 input logic en,
						 input logic reset,
						 input logic [3:0] hexVal,
						 output logic [3:0] hexL,
						 output logic [3:0] hexR);
						 
						 
	always_ff @(posedge clk, posedge reset)
		if (reset) 
			begin
				hexL <= 0;
				hexR <= 0;
			end
		else if (en) 
			begin
				hexL <= hexVal;
				hexR <= hexL;
			end
		else 
			begin
				hexL <= hexL;
				hexR <= hexR;
			end
endmodule 
			