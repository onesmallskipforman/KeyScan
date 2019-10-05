
/*
  Robert "Skipper" Gonzalez
  sgonzalez@g.hmc.edu
  09/12/2018
  generalized M-input, N-bit shift register module

  Below is a generalizd shift register module. With each rising edge
  of the clock and en enabled, this module shifts in the N-bits of sin into
  d, and shifts out the most significant N bits of d.

  Parameters:
    N: Number of bits in each of the elements of d. Defaults to 4.
    M: The number of N-bit elements in d. Defaults to 2.

  Inputs:
    clk:        clock signal
    reset:      reset signal
    en:         enable signal
    sin[N-1:0]: N-bit input shifted into d

  Outputs:
    sout[N-1:0]: most significant N bits of d

  Internal Vars:
    d: MN-bit input signal containing the M number of N-bit objects
*/

module shiftreg #(parameter N = 4,
                  parameter M = 2)
					       (input  logic           clk,
						      input  logic           reset,
                  input  logic           en,
						      input  logic [N-1:0]   sin,
                  output logic [N*M-1:0] sout);

    logic [N*M-1:0] d;

    always_ff @(posedge clk)
    if      (reset) d <= 0;
    else if (en)    d <= {d[M*N-N-1:0], sin};

    assign sout = d[N*M-1:M*N-N];

endmodule
