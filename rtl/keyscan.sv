
/*
  Robert (Skipper) Gonzalez
  sgonzalez@g.hmc.edu
  09/12/2018
  keypad scanner module

  Below is the top-level module for a keypad scanner and segment display. This
  module register keypad input, and updates an M-digit 7-segment disolay with the
  most recently pressed value on from the keypad. New values appear on the rightmost
  segment, shifting all digits to the left.

  Parameters:
    M:           number of common-anode 7-segment displays
    sfreq:       necessary frequency to ensure button bounce is ignored
    mfreq:       necessary frequency to have each dsiplay flash as 1100Hz

  Inputs:
    clk:         clock signal
    reset:       reset signal
    rAsync[3:0]: asynchronous row pit signals from keypad

  Outputs:
    cHigh[3:0]:  keypad column pin signals
    seg[6:0]:    the cathodes of a common-anode 7-segment display, ordered gfedcba
    anode[1:0]:  anodes of the two 7-segment displays

  Internal Variables:
    rcbits[7:0]: row-column pin configuration
    hex[3:0]:    hex translation of rcbits
    digits[3:0]: hex values for all the display digits
    hout[3:0]:   hex value to display next on time-muxed display
    r[3:0]:      synchronized row pin signals
    update:      display update signal
    sclk:        debouncing clock signal
    mclk:        time multiplexing clock signal
*/

module keyscan #(parameter M = 2)
                (input  logic         clk,
                 input  logic         reset,
                 input  logic [3:0]   rAsync,
                 output logic [3:0]   cHigh,
                 output logic [6:0]   seg,
                 output logic [M-1:0] anode);

  // faster frequencies for simulaiton
  // parameter mfreq = 5 * (10**6);
  // parameter sfreq = 5 * (10**6);

  parameter mfreq = 1100*M;
  parameter sfreq = 1000;

  logic [7:0] rcbits;
  logic [3:0] hex, hout, r;
  logic [4*M-1:0] digits;
  logic update;
  logic sclk, mclk;

  clk_gen    #(sfreq) sc(clk, 1'b0, 1'b1, sclk);
  sync       #(4)     sy(sclk, reset, rAsync, r);           // synchronize row bits
  rcEval              rc(sclk, reset, r, cHigh, rcbits);    // row and column set and eval
  update              up(sclk, reset, rcbits, update);      // determine whether or not to update
  rcToHex             rh(rcbits, hex);                      // convert configuration to hex
  spshiftreg #(4, M)  sr(sclk, reset, update, hex, digits); // update display digits list

  clk_gen    #(mfreq) mc(clk, 1'b0, 1'b1, mclk);            // time mux clock gen
  timeMux    #(4, M)  tm(mclk, reset, digits, hout, anode); // time multiplex display digits
  seg                 sg(hout, seg);                        // translate hex to display pins

endmodule
