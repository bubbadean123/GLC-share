// Data Register for KT8. used for A,B, and R
// CAK 2016
// 8 bit register with reset and enable

module datareg(clk_i,
                     rst_i,
                     en_i,
                     in_i,
                     out_o );
  input clk_i, rst_i, en_i;
  input [7:0] in_i;
  output [7:0] out_o;

  reg [7:0] out_o;
					   
  always @(posedge clk_i, posedge rst_i)
    if (rst_i) out_o<=0;
    else if (en_i) out_o<=in_i;

endmodule

