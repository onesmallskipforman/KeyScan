
/*
  Robert "Skipper" Gonzalez
  sgonzalez@g.hmc.edu
  09/12/2018
  generalized M-input, N-bit time multiplexer module

  Below is a generalizd time multiplexing module. With each rising edge
  of the clock, this module rotates to the next N-bits in the MN-long input.
  Additionally, a single bit is rotated around an M-bit variable. The i-th bit
  is high when the output is the i-th N-bit element of the input.

  Parameters:
    N: Number of bits in each of the mux inputs. Defaults to 1.
    M: The number of N-bit objects in the input. Defaults to 2

  Inputs:
    clk: clock signal
    reset: reset signal
    d: MN-bit input signal containing the M number of N-bit inputs

  Outputs:
    y[N-1:0]: N-bit output chosen from the M inputs in d
    b[M-1:0]: M-bit output where only the i-th bit is high when y is the i-th bit of d

  Internal Vars:
    i: The current index of out and b. Increments with each time step.
*/

module timeMux #(parameter N=1,
                 parameter M=2)
                (input  logic           clk,
                 input  logic           reset,
                 input  logic [M*N-1:0] d,
                 output logic [N-1:0]   y,
                 output logic [M-1:0]   b);

  logic [$clog2(M)-1:0] i;

  always_ff @(posedge clk)
    if (reset)
      begin
        b <= 1;
        i <= 0;
      end
    else
      begin
        b <= {b[M-2:0], b[M-1]};
        if (i+1 > M-1) i <= 0; else i <= i+1;
      end

  assign y = d[i*N +: N];

endmodule
