
/*
  Robert "Skipper" Gonzalez
  sgonzalez@g.hmc.edu
  09/12/2018
  row-column evaluation module

  Below is a module for controlling and evaluating keypad signals. This module
  has two primary functions: 1) setting different column pins of the
  keypad high, and 2) concatenating the synchronous row bits r with the column signal
  from back when the rows were read by the synchronizer. Since the synchronization
  takes two clock cycles, use cHigh from two clock cycles prior.

  Inputs:
    clk:         clock signal
    reset:       reset signal
    r[3:0]:      synchronized row bits

  Outputs:
    c[3:0]:      keypad column bits to be set high
    rcbits[7:0]: synchronized row bits concatenated with their corresponding column bits
*/

module rcEval(input  logic clk,
              input  logic reset,
              input  logic [3:0] r,
              output logic [3:0] cHigh,
              output logic [7:0] rcbits);

  always_ff @(posedge clk)
    if (reset) begin
      cHigh  <= 4'b1000;
      rcbits <= {4'b0000, 4'b0100};
    end else begin
      cHigh  <= {cHigh[0], cHigh[3:1]};
      rcbits <= {r, rcbits[0], rcbits[3:1]};
    end

endmodule
