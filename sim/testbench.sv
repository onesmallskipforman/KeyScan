
/*
  Robert (Skipper) Gonzalez
  sgonzalez@g.hmc.edu
  09/12/2018
  keypad scanner testbench module

  Below is the testbench module for a keypad scanner and segment display. This
  module runs the keypad scanner, and cycles through all possible possible inputs
  to the keypad.

  Parameters:
    M:           number of common-anode 7-segment displays
    delay:       wait time for press and unpress in test

  Internal Variables:
    clk:        clock signal
    reset:      reset signal
    r[3:0]:     asynchronous row pit signals from keypad
    c[3:0]:     keypad column pin signals
    seg[6:0]:   the cathodes of a common-anode 7-segment display, ordered gfedcba
    anode[1:0]: anodes of the two 7-segment displays
    rdes[3:0]:  test desired r pin values
    cdes[3:0]:  test desired c pin values
*/

module testbench();

  logic clk, reset;
  logic [3:0] r, rdes, c, cdes;
  logic [6:0] seg;
  logic [1:0] anode;
  parameter M = 2;
  parameter delay = 200;

  // instantiate device under test
  keyscan #(M) dut(clk, reset, r, c, seg, anode);

  always begin
    clk=1; #1; clk=0; #1;
  end

  // reset, then cycle through all possible keypad inputs
  initial begin
    reset = 1; #10; reset = 0;

    for (i = 0; i < 4; i++) begin
      rdes    = 4'b0000;
      rdes[i] = 1;
      for (j = 0; j < 4; j++) begin
        cdes    = 4'b0000; #delay;
        cdes[i] = 1;       #delay;
      end
    end

  end

  assign r = (c == cdes)? rdes : 4'b0;

endmodule
