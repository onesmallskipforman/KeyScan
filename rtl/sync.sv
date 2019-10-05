/*
  Robert "Skipper" Gonzalez
  sgonzalez@g.hmc.edu
  09/12/2018
  synchronizer module

  Below is a synchronizer module with syncrhonous reset.
  This module synchronizes an N-bit input. Values are passed
  along upon the rising edge of the clock. It takes two rising
  edges to pass an input through.

  Parameters:
    N: The number of bits in the ansynchronous input signal

  Inputs:
    clk:        clock signat
    reset:      reset signal
    d[N-1:0]:   asynchronous N-bit input signal
    q:          amount to increment counter by

  Outputs:
    q[N-1:0]: synchronized N-bit signal

  Internal Variables:
    n1: intermediate value between the two registers
*/

module sync #(parameter N=8)
             (input  logic         clk,
              input  logic         reset,
              input  logic [N-1:0] d,
              output logic [N-1:0] q);

  logic [N-1:0] n1;

  always_ff @(posedge clk, posedge reset)
    if (reset)
      begin
        n1 <= 0;
        q  <= 0;
      end
    else
      begin
        n1 <= d;
        q  <= n1;
      end

endmodule
