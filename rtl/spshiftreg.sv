
/*
  Robert "Skipper" Gonzalez
  sgonzalez@g.hmc.edu
  09/12/2018
  generalized enabled serial-to-parallel shift register

  Belong is a generalized "serial"-to-parallel shift register. Loading is
  technically not serial as N-bits are shifted in at a time. When enabled,
  Groups of N bits are loaded sequentially with each tick, while all
  the bits of the register are output in parallel as q. Output q can
  hold M many N-bit values, so q is MN bits long.

  Parameters:
    N: Number of bits shifted in. Defaults to 4.
    M: Number of N-bit elements q can hold. Corresponds to NM bits total. Defaults to 2.

  Inputs:
    clk:        clock signal
    reset:      reset signal
    en:         enable signal
    sin[N-1:0]: N-bits shifted into q

  Outputs:
    q[M*N-1:0]: MN-bit output consisting of M shifted-in N-bit values

*/

module spshiftreg #(parameter N = 4,
                    parameter M = 2)
                   (input  logic           clk,
                    input  logic           reset,
                    input  logic           en,
                    input  logic [N-1:0]   sin,
                    output logic [N*M-1:0] q);


  always_ff @(posedge clk)
    if      (reset) q <= 0;
    else if (en)    q <= {q[(M-1)*N-1:0], sin};

endmodule
