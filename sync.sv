
module sync#(parameter N=8)
				(input logic [N-1:0] in,
				input logic clk,
				input logic reset,
				output logic [N-1:0] out);
				
	logic [N-1:0] intermediate;
				
	always_ff @(posedge clk, posedge reset)
		if (reset) 
			begin
				intermediate <= 0;
				out <= 0;
			end 
		else
			begin
				intermediate <= in;
				out <= intermediate;
			end
endmodule 