
/*
  Robert "Skipper" Gonzalez
  sgonzalez@g.hmc.edu
  09/12/2018
  update module

  Below is a module for determining whether or not to update a 7-segment
  display. This module ensures that held down presses only count as a
  single update. A state machine stays in state 1 as long as a button is pressed.

  Inputs:
    clk:         clock signal
    reset:       reset signal
    rcBits[7:0]: row and column bits

  Outputs:
    update: update signal

  Internal Vars:
    cols: saved column bits from last valid press
*/

module update(input  logic       clk,
              input  logic       reset,
              input  logic [7:0] rcBits.
              output logic       update);

  logic [3:0] cols, nextcols;

  typedef enum logic {S0, S1} statetype;
  statetype state, nextstate;

  always_ff @(posedge clk)
    if (reset)  begin
      state      <= S0;
      cols       <= 4'b0;
    end else begin
      state      <= nextstate;
      cols       <= nextcols;
    end

  always_comb
    case(state)
      S0: if (|rcBits[7:4])                           nextstate = S1;
          else                                        nextstate = S0;
      S1: if (~|rcBits[7:4] && (cols == rcBits[3:0])) nextstate = S0;
          else                                        nextstate = S1;
      default:                                        nextstate = S0;
    endcase

  assign update   = ((state == S0) & (nextstate == S1));
  assign nextcols = (update)? rcbits[3:0] : cols;

endmodule
