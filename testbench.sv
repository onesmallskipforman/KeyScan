module testbench();

	// inputs
	logic clk, reset;
	logic [3:0] r;
	
	// outputs 
	logic [3:0] c;
	logic [6:0] seg; 
	logic [1:0] anode;
					
					
	// instantiate device under test
	// inputs are a, b, cin.
	// outputs are s and cout
	lab3_sg dut(clk, reset, r, c, seg, anode);
	
	
	always
		begin
			clk=1; #1; clk=0; #1;
		end
	
	
	initial begin
		reset = 1; #10; reset = 0;
		r = 4'b1000; #200;
		r = 4'b0000; #200;
		
		r = 4'b0100; #200;
		r = 4'b0000; #200;
		
		r = 4'b0010; #200;
		r = 4'b0000; #200;
		
		r = 4'b0001; #200;
		r = 4'b0000; #200;
		
	end


endmodule 