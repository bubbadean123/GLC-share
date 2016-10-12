// Program Counter for KT8
// CAK 2016
// 8 bit counter with reset. Can also jump up or down
// 0-16 counts.

module pc(clk_i,
          rst_i,
          jump_up_i,
          jump_down_i,
          jump_distance_i,
          count_o );
  input clk_i, rst_i, jump_up_i, jump_down_i;
  input [3:0] jump_distance_i;
  output [7:0] count_o;
  reg [7:0] count_o;
					   
  always @(posedge clk_i, posedge rst_i)
    if (rst_i) count_o<=0;
    else if (jump_up_i) count_o<=count_o+jump_distance_i;
    else if (jump_down_i) count_o<=count_o-jump_distance_i;
    else count_o<=count_o+1;

endmodule


